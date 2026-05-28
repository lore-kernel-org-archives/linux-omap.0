Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB643A7F66
	for <linux-omap@vger.kernel.org>; Thu, 28 May 2026 10:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779962999; cv=none; b=hJZIVgefRv4Q8J4TQdkIT82uqwW+ZS7mXSF+q4HtxQ2tC8WB3VTfS5K/aRl9ZUjlXWYrGXOPBvuHwtfCDCETa5uJeMUwSeNanEQmQD2QNAehwrciWvEqhinhCaMHYgE/3tlYuuBzWatTb6Op2FsgXDNLed/Az564rvKG4WpTS90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779962999; c=relaxed/simple;
	bh=jDJJEw1aEW13FPk5Ox8KXXR1xi9c6g3zuF8G653rRWI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZuZMupAyHndrnWGwuKYQA5QSJdDv/OWXMN3zYm/XG6WJUpNJbvvRbxUvVJQ7cMvTZ7SnsAqsZj/Gh4MyWV/1Tv5gSZ7QkG30qvd+8Yqsm5ldytIp6B8PvMDOcUuOS+IBFybelIB9KIL9dQ/a671ieGgT4tNsziY9N5mONJNzOoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=TWmiC7Kk; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="TWmiC7Kk"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-45ee5cdbd28so315551f8f.1
        for <linux-omap@vger.kernel.org>; Thu, 28 May 2026 03:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1779962995; x=1780567795; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3dEoQrHmxD3QAsur3ni9bkWOs/bYRX+l4pg8imj6MVM=;
        b=TWmiC7KkHeNsMtwCTWIN3VCe/GwirsFCe2zvSi5w5+JZLcN4NkccRBluKiJ3pSsXu/
         TsPCVdzjvl1lMGBhcHQgbfJ5qN/JeSeWeZLqr7dDylCHDRTDEErHP9f6bW1Xa/BDshmk
         ndXUc2OOinGLn5tAQLROEgInaOhznbotS39yrSjkHndcyno7DF2VmPna/s+GLKTlQnzh
         mYEHQtVnHgc8ZIyDZDb5lTZIkdCIq3UKKUsfIxom/ZAuMRMKP/iTTiFAvNPZfRgv4n0M
         j/M8AEIjshWiM3pCyapa5jzoc3fx85DV9V157lQWM6xIioCR5ghd7mOe5nqYP8tv4Q1a
         wMag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779962995; x=1780567795;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3dEoQrHmxD3QAsur3ni9bkWOs/bYRX+l4pg8imj6MVM=;
        b=BjS6FCWMLEHCY1Fkq0KZ5bw0b4InM8VqEIZbsY7IU0a9Di+AQweuerBnCOncQSFyHW
         RilkNoAPCfyNpvKTFEE7+S7Ln2y6O7KKfyG+/abCLU3cWGB6efwx6PA3Mz5wAyyQfxfC
         wTKUlP1y9iImIaLdg1x/aSu0qc3kOEgAK4GOH4W1QSaclpsMtozqRNVN16mrPnDl0baI
         7RaCuO5l0NmQm9ZRUf91tdXTKAT/hl3XX4AbyRVi5W6PlKOhc8YGolJgc2ryjXNnaYs2
         G7D6hoW5C4n3TVNVUjjotCtxd8+gEnBU7UIb6lrSS9BuLsOOsqZdFqAVIzOFCAxO2C4p
         VjbA==
X-Forwarded-Encrypted: i=1; AFNElJ80vELTMAy8n3pVOIDT6Y6n/KvQrwp/I3uRhAkXJdoOyVNw41Dgf8d3PqEAPKIQkG/22oZRVawz5OPz@vger.kernel.org
X-Gm-Message-State: AOJu0Yxgvdj2MO6HGKLaz6pKySMXn7NriIUYp+C/LJvMRMQf3gdUkQfS
	X12FXKFo6mWN7l2rQ5HgqY/QVIkBvzbQ+W4JFoqoXRSNQnZnxOe+74FBlPZWCbKO9rU=
X-Gm-Gg: Acq92OGPp585IvTOyiH6w7bhp1OBde/BmxuDE04T0gWdThQlKcvy+yevJV+2DxaKfEv
	/abRI/IZmb6t++K22+aeTfVjb1zo3iK6RUD1LA33ofaP75F4buMWqc0WGGsO0CEV+p10HPUN4Kj
	W/VdvWv1yfMxKRsImDWXAWesQGKgycdM+Rd+nVZc/i0G5GHwTLcHmgrhJzgoQ/arjUDTs4o9UOy
	Y3NsGwXjUHYHvh/Rbq9nnAq2I82VCbHbkhhTQ4E2JXyvfYZ9HFbRKF3kOiNUPse6zVsyShOZ1zw
	2s9AwN1DVPIDBTUObvhuAMYLTTj0E5m83iVxyesOalmU+9MR47SuWVO3VthPBZfbJayRG9AmUuk
	aOnRhyqeD6QBPcbkevD3nKHqT2yjo5s4aDQMqp6Tnz0gK9a3htYbUq/hVRJgM4Gtnle2s4zpvM4
	YNWOh4nMPDdj93xZQzzfP9P21WNc0nlKMWXORUdrxAodM5GpSeN6ycLCREztnUDtlsXMJefQIoQ
	HOS/QUJyvDxdid+8DGp2KH/hg==
X-Received: by 2002:a05:600c:528c:b0:48a:79d8:a8d6 with SMTP id 5b1f17b1804b1-490947a4918mr14900895e9.7.1779962994786;
        Thu, 28 May 2026 03:09:54 -0700 (PDT)
Received: from localhost (p200300f65f47db04e95e43453a0d1648.dip0.t-ipconnect.de. [2003:f6:5f47:db04:e95e:4345:3a0d:1648])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-49092654e10sm28651945e9.7.2026.05.28.03.09.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 03:09:53 -0700 (PDT)
Date: Thu, 28 May 2026 12:09:53 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Linus Walleij <linusw@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, Benson Leung <bleung@chromium.org>, 
	Guenter Roeck <groeck@chromium.org>, linux-gpio@vger.kernel.org, chrome-platform@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	Matti Vaittinen <mazziesaccount@gmail.com>, Marek Vasut <marek.vasut+renesas@gmail.com>, 
	=?utf-8?B?QW5kcsOp?= Draszik <andre.draszik@linaro.org>, Robert Jarzmik <robert.jarzmik@free.fr>, 
	Aaro Koskinen <aaro.koskinen@iki.fi>, Andreas Kemnade <andreas@kemnade.info>, 
	Kevin Hilman <khilman@baylibre.com>, Roger Quadros <rogerq@kernel.org>, 
	Tony Lindgren <tony@atomide.com>, linux-pwm@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	linux-omap@vger.kernel.org
Subject: Re: [PATCH v1 0/3] gpio: Use named initializers for
 platform_device_id arrays
Message-ID: <ahgUGOsIxlFrf9mD@monoceros>
References: <cover.1779893336.git.u.kleine-koenig@baylibre.com>
 <177995803708.5037.5318741720946502441.b4-ty@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2z3wzt7537jwqmcu"
Content-Disposition: inline
In-Reply-To: <177995803708.5037.5318741720946502441.b4-ty@oss.qualcomm.com>


--2z3wzt7537jwqmcu
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v1 0/3] gpio: Use named initializers for
 platform_device_id arrays
MIME-Version: 1.0

Hello Bartosz,

On Thu, May 28, 2026 at 10:47:55AM +0200, Bartosz Golaszewski wrote:
> On Wed, 27 May 2026 16:57:26 +0200, Uwe Kleine-K=F6nig (The Capable Hub) =
wrote:
> > this series targets to use named initializers for platform_device_id
> > arrays. In general these are better readable for humans and more robust
> > to changes in the respective struct definition.
> >=20
> > This robustness is needed as I want to do
> >=20
> > 	diff --git a/include/linux/mod_devicetable.h b/include/linux/mod_devic=
etable.h
> > 	--- a/include/linux/mod_devicetable.h
> > 	+++ b/include/linux/mod_devicetable.h
> > 	@@ -610,4 +610,7 @@ struct dmi_system_id {
> > 	 struct platform_device_id {
> > 		char name[PLATFORM_NAME_SIZE];
> > 	-	kernel_ulong_t driver_data;
> > 	+	union {
> > 	+		kernel_ulong_t driver_data;
> > 	+		const void *driver_data_ptr;
> > 	+	};
> > 	 };
> >=20
> > [...]
>=20
> I fixed your SoB as requested and fixed up patch 2/3 as one of the driver=
s it
> touched no longer exists in my tree.

Right, I noticed that conflict when rebasing my stack to next-20260527
and assumed you'd cope for that.

Thanks!
Uwe

--2z3wzt7537jwqmcu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmoYFG4ACgkQj4D7WH0S
/k5FBQf+Ibzmukpa6UhZfcZUhGe0XaS6TZpmFiyy9QMJVqt3bKHdEafowQgl32yf
5w0pLkWFfORjHv+FEfH+wollsB7//hBHnEOT2nlVo2tI9s4lxfmJlJBAQYUSOPIs
vKiKxxRT5p4uRCRhV1JWg2TBVimsUw9GG2tTXHK9jOMI2SU3iYsKoSbmQLN9Rctw
k7N3zinvmqjGvYrYWYSdwN8ocBYa0b4JZGH2N3QabvS92i9doS2RMU46QIoCixGR
OLNW6wEonHxnaNjpK36WFWNH/6tXbxKMuWBDM9R3xtDtWoaLDHnMOQNCSsGVMqOI
9uMi39yy5eMdBL5EINcaVkZvXFD54A==
=ul7F
-----END PGP SIGNATURE-----

--2z3wzt7537jwqmcu--
