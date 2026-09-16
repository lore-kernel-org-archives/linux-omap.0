Received: from mail-wr2-f28.google.com (mail-wr2-f28.google.com [74.125.225.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A2F549550B
	for <linux-omap@vger.kernel.org>; Wed, 16 Sep 2026 09:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789549357; cv=none; b=Adm3p8tjj9DOUE8lnX0TuuMbp1oJDulOFUuLEKYeeMWtR58ndY0WEmNIDiQVCdFwCszt1za5PxnNk8S6QS1tFSS0JOu2rhUlf9DagZoHkV9RMDiS/IRSuliVrtqX9oLiW4f4nTTux/x86Xhd72LAXTroxWHnyu3zQu1eg3i7Ito=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789549357; c=relaxed/simple;
	bh=u3prVhhjxauBWG8qfoe+eEDvbRKE6KXSyVNyWaZNvTE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=JpWyVtPULyuN0hIrlVsoa0LTkYM+fkdaLTzECvJPVLtbNhGC8Ho4wzvhMiDKu1o6B+oUy3DiEIys5TrEGS88sgKMHv7ubThxeXFMmUQYWjrhxZqtMZxttEqj5sO+GHWPSR080b0ngjuj+vi5p40tYQ165bkFqPiD0NAjP7e6Fbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=aHkH1iZO; arc=none smtp.client-ip=74.125.225.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="aHkH1iZO"
Received: by mail-wr2-f28.google.com with SMTP id ffacd0b85a97d-485b1d2874aso448143f8f.1
        for <linux-omap@vger.kernel.org>; Wed, 16 Sep 2026 02:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1789549341; x=1790154141; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:mime-version:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=u3prVhhjxauBWG8qfoe+eEDvbRKE6KXSyVNyWaZNvTE=;
        b=aHkH1iZOGRzkkq0iecytn4Efv2nGG3tqbIf3paCTHb89k9+yfRp7Zqac0vPqgUuNr0
         5PwjwSwbN+1t7eA/c7mZr7FKJjO+QkFM5+nKL8YTC5J0rSbLTFj0UlOFzCfkh/7eMgUl
         jEfiSSf7SJtMT+ZN7OBwQksbHk5TzvUtMEAwn9sF6aQqAYIyB6jvq6WSrsb9tOY64NPy
         /qxldqN6ryLilI4EZFE31XZf3qr2VQ++nlRvZHMz5ix5/BAboTjdLj3deyk6XhdQzT/K
         zm1RZ1wAfQzyOVjb0PDkqk3ORcv8LLMhfIuj3RYeHArtmyLd+HfwfG0uFH9Yy4J5iP32
         I0Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789549341; x=1790154141;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=u3prVhhjxauBWG8qfoe+eEDvbRKE6KXSyVNyWaZNvTE=;
        b=TUqxAc7VKEsHaL5gCWeqn+cvOl+H8bL4lkqomkKihWzKbuJUeIXzWQ61MOvOfHd9hD
         4uAjOLDVO0n+OzvueGtjl53Cf4LyMORjXolqMLyD1C4KJ3+gC3Um4IVWSG/1jZFZp9nu
         7GTjbIzadffUdjHa962ovi7zGUgBSEozs8jCu9dP4dv9ZCZWsUXNyTwQujs9DFPuWFEo
         3IcmHgcynVWqfg3SBhpZh6sLF1XeJx/jsNsApF2WOyswE1Gy7ZaCPNbK/dAqnYd3qBZi
         LsXRxPTrqnne3l8xx1OMxonjLZDgZcKqAS310vCN9wKdSjoj7JtWOC0tkoHuVvB0ga69
         vIyg==
X-Forwarded-Encrypted: i=1; AKwUvByaapHp+fxhp5TQjDpx03XaxKV3hmjWKXsbiK+PUfHvEiBrt5IPfpvnNbsqEih7CSk/7+6UZb+gBMMw@vger.kernel.org
X-Gm-Message-State: AFuF++lRlQ74bu+ZK5psouvHIWG5X1hNIdoO8ohEpzJSDBaiayjaxk9q
	PrI0EinysBInFG2lPFLY3rVQZqCKkR+7qgXCkUoBzMshaGi/EpkPaNpvtlWdoP0JZoE=
X-Gm-Gg: AYBFou0fs7fNi7bIkVKpfzFhEb3RBgk6cwxmXaGZWSo4bhVohBlp47OSxA9K7LZsu4D
	zqJ8F9yyTdQOx5KRJI/nLgPrJNDa+GLYAAftDMQxcXp3zIN2sUqOOBHDBTdpqbtqKxVgWm+BBIa
	Up84+AUnIPDmDe3SH3ElQrWDZ/4S71nK5GLEoC+or2XdkD0c0uV6jNG2/pLBdI9NSPUHAG6oI8+
	Q77u5udW4jFXnfhPTlu9qYGkxsJNUZ7Pibv0gxTELGdkGdK4a4yAuEQlglEhkO/l7Qf3vw8KOlQ
	rK8uMpgqrh/Rd5FRxHFuB22g7AyfRYLKyIHYw9oXK/zPSvivdR1ANIK6tIISdXZ1ca/Fj7JZMWc
	Z5MmA+udkyZzwuPYwg5bvTKTHxnqG+RYBY81ooCv7i1oBKJxQ8u/PIhr2Z4pBb3/iyIdd4XwF5v
	TwM9+hauV63XYDR5d2h+mO8foKD+yAQckWXyqZE5agD2egdhPiPJ6WYLfFN7sENLaO3g==
X-Received: by 2002:a05:6000:40cc:b0:487:403:f2eb with SMTP id ffacd0b85a97d-4870d0452d3mr4199288f8f.17.1789549341185;
        Wed, 16 Sep 2026 02:02:21 -0700 (PDT)
Received: from localhost ([2001:4091:a245:8029:665d:b7b:5fa4:7ad0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4870bf33e01sm6702324f8f.23.2026.09.16.02.02.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 02:02:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=0a03f14af8c74b8b8ae71ef6964c726a8430f5297d9c30f5afc655f5a6b4;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Wed, 16 Sep 2026 11:02:15 +0200
Message-Id: <DLGMAND8UBI6.394OZTY3JSLDX@baylibre.com>
Subject: Re: [PATCH] clocksource/drivers/timer-ti-dm: Register
 clocksource/event only for am654
From: "Markus Schneider-Pargmann" <msp@baylibre.com>
To: "H. Nikolaus Schaller" <hns@goldelico.com>, "Markus Schneider-Pargmann
 (TI)" <msp@baylibre.com>
Cc: "Andreas Kemnade" <andreas@kemnade.info>, "Daniel Lezcano"
 <daniel.lezcano@kernel.org>, "Thomas Gleixner" <tglx@kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-omap@vger.kernel.org>, <letux-kernel@openphoenux.org>
X-Mailer: aerc 0.21.0-146-gb5c16ebe1835
References: <20260828-v7-3-next-topic-ti-timer-dm-clocksource-omap-fix-v1-1-85f0e4dc6f9f@baylibre.com> <20260828230445.3c2510b9@kemnade.info> <E27F05E3-DE4F-4C77-95E3-1701B3410E93@goldelico.com>
In-Reply-To: <E27F05E3-DE4F-4C77-95E3-1701B3410E93@goldelico.com>

--0a03f14af8c74b8b8ae71ef6964c726a8430f5297d9c30f5afc655f5a6b4
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Sat Aug 29, 2026 at 9:23 AM CEST, H. Nikolaus Schaller wrote:
>
>> Am 28.08.2026 um 23:04 schrieb Andreas Kemnade <andreas@kemnade.info>:
>>=20
>> On Fri, 28 Aug 2026 20:47:45 +0200
>> "Markus Schneider-Pargmann (TI)" <msp@baylibre.com> wrote:
>>=20
>>> Registering clocksource/clockevent for the older platforms breaks
>>> booting them. The older platforms have their own implementation in earl=
y
>>> boot that is used to register clocksource/clockevent in
>>> timer-ti-dm-systimer.c.
>>>=20
>>> With am654, the timer is much more complex with more dependencies so
>>> doing this in early boot with the other driver is very difficult and
>>> gets ugly. Instead it is implemented in the platform driver for am654.
>>> However the old platforms may not register clocksource/clockevent in
>>> this driver as that would break the boot.
>>>=20
>>> Add a system_timer_capable flag that is only set for am654-timer that
>>> gates the clocksource/clockevent registration.
>>>=20
>>> Reported-by: H. Nikolaus Schaller <hns@goldelico.com>
>>> Closes: https://lore.kernel.org/r/2013A99A-0502-4128-ACFA-B04886224393@=
goldelico.com
>>> Fixes: b8eeeca55456 ("clocksource/drivers/timer-ti-dm: Add clocksource =
support")
>>> Signed-off-by: Markus Schneider-Pargmann (TI) <msp@baylibre.com>
>>=20
>> Tested-by: Andreas Kemnade <andreas@kemnade.info> # OMAP3 GTA04
>
> Tested-by: H. Nikolaus Schaller <hns@goldelico.com> # OMAP3 OpenPandora
>
> BR and thanks,
> Nikolaus
>
> PS: I would suggest that patches for omap-dm-timer are also routed to lin=
ux-omap@vger.kernel.org

I agree, it should be added to the MAINTAINERS file.

Best
Markus

--0a03f14af8c74b8b8ae71ef6964c726a8430f5297d9c30f5afc655f5a6b4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKMEABYKAEsWIQSJYVVm/x+5xmOiprOFwVZpkBVKUwUCaqpbFxsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMiwyLDIRHG1zcEBiYXlsaWJyZS5jb20ACgkQhcFWaZAVSlOC
6AEAy1JS2SlpxrlOQuQLSOsZO+CBah23b1Dff4+ir0VdUhYBAOU9suaTsiifYV/k
vBrj8QHXWS0SbgbXDKjzES1Abp0O
=kqWV
-----END PGP SIGNATURE-----

--0a03f14af8c74b8b8ae71ef6964c726a8430f5297d9c30f5afc655f5a6b4--
