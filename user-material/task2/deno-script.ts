try {
    let resp = await fetch("http://numbersapi.com/42");
    console.log(await resp.text());
}
catch (error) {
    console.log(error.message);
    console.error("Could not fetch url");
    Deno.exit(1);
}
