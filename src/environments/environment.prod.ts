declare const process: {
  env: {
    API_URL: string;
  };
};

export const environment = {
  production: true,
  api_url: process.env.API_URL || "http://localhost:8000/api",
};
