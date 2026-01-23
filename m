Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E8D32ECD32;
	Fri, 23 Jan 2026 13:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769176670; cv=none; b=APmtZNkExug0Fvy1+GRp5y0tssu3bQaylklea2dq/7qIjhxF2TvNl+zWC+q5ksMoKdntyT5kRg6u/NcEIKKEzuo5BlauHdLhmYwd7UyXJm2t4ynGt4CQhTBGdRTh4zGoO0xv2nqMbUfZDNS1PM1PiW234eoUQx5ecUWjntIr45g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769176670; c=relaxed/simple;
	bh=9h2AAnFgsM77tqVVHQnC2lu40hXPGlXwB+i9tCIxZ5k=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=ZF5ymwxMZdP1GifjPQqEy1gHNe/p0OInUFKaaW0YMSCXJHAzNTV5Rpz8JzBnklf/S9pIW67d+v0z0seXvPwwIpx9+7AQGYc7XyudeaUjRPn1yzdWE2ETfmE11CqV5zyEn0t1nOj1QZbnp4MufktTV0vO5Z4F55MJSYBYETUeGTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eiWRA7R7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eiWRA7R7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72957C4CEF1;
	Fri, 23 Jan 2026 13:57:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769176670;
	bh=9h2AAnFgsM77tqVVHQnC2lu40hXPGlXwB+i9tCIxZ5k=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=eiWRA7R7yL5xnCQCFI7Xp9+L3Z0Kr8HbOH3/N8EtQtzKvTCR665NbzqCGLz409LWj
	 kK//4ravJ/+uEtqRsbFGXETsPwUlGxIK4hT4acVDjT51c5K89Hcr8kXTG4zGAtBBNs
	 2qPuflDTkbdE3jx9XpZ9jTjvuRrBOMxC0GBiQiQ9sMiQfL2xL572FvOXFGmbHRE04q
	 Z90b7Uu43sbmWt1fSFLLRxGRjaUnNdyWlKadnxqKVYwFioYW5jBV8SoqLLj0mtdwPD
	 TtDKc6rN3copoQLcvnzmrl1uYgGrgUiTAhy29PyvmMz2/z6bsWCEy8M8JGckTlTHKP
	 9nxsztOEmyNuw==
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 23 Jan 2026 14:57:45 +0100
Message-Id: <DFW0SC4QG4W8.C7BRHX02W3IK@kernel.org>
Subject: Re: [PATCH] gpio: omap: do not register driver in probe()
Cc: <driver-core@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <linux-omap@vger.kernel.org>, <linux-gpio@vger.kernel.org>, "Danilo
 Krummrich" <dakr@kernel.org>
To: <gregkh@linuxfoundation.org>, <rafael@kernel.org>, <broonie@kernel.org>,
 <will@kernel.org>, <grygorii.strashko@ti.com>, <ssantosh@kernel.org>,
 <khilman@kernel.org>, <linusw@kernel.org>, <brgl@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260123133614.72586-1-dakr@kernel.org>
In-Reply-To: <20260123133614.72586-1-dakr@kernel.org>

On Fri Jan 23, 2026 at 2:31 PM CET, Danilo Krummrich wrote:
> diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
> index e136e81794df..8db71a2db9ff 100644
> --- a/drivers/gpio/gpio-omap.c
> +++ b/drivers/gpio/gpio-omap.c
> @@ -800,9 +800,7 @@ static struct platform_device omap_mpuio_device =3D {
>  static inline void omap_mpuio_init(struct gpio_bank *bank)
>  {
>  	platform_set_drvdata(&omap_mpuio_device, bank);
> -
> -	if (platform_driver_register(&omap_mpuio_driver) =3D=3D 0)
> -		(void) platform_device_register(&omap_mpuio_device);
> +	(void)platform_device_register(&omap_mpuio_device);
>  }

On a second look, it recognize that this did abuse the fact that
platform_driver_register() fails when attempting to register a driver multi=
ple
times to avoid registering the same static device multiple times.

So, I guess this has to be changed to:

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index 8db71a2db9ff..3e1ac34994fb 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -799,8 +799,13 @@ static struct platform_device omap_mpuio_device =3D {

 static inline void omap_mpuio_init(struct gpio_bank *bank)
 {
+       static bool registered =3D false;
+
        platform_set_drvdata(&omap_mpuio_device, bank);
-       (void)platform_device_register(&omap_mpuio_device);
+       if (!registered) {
+               (void)platform_device_register(&omap_mpuio_device);
+               registered =3D true;
+       }
 }

 /*---------------------------------------------------------------------*/

