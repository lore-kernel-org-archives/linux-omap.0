Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.171
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793115034;
	b=B/Ph4on1ZALoToqsSBwPaBZYex+vo4MwQty6q7leOnUmfIxX0Whi3ouhWZYvklLQdhpL
	 +ipxDcdBlz/3BwxZxXguMyHMmmRRwtiFZoNvigTH2Y4wMQ1dp82R9UigCWcu6smeKwL+D
	 WHT9lw/EyaSHHYIwnH83AFeDjRfo5N8PrfFtVMRveYV+VegsdMnoV45qPHENsP3ei+7q7
	 sjofe0X5jGQXPmrRqtu8LfPY5L56gb6/cIvOFHXczsKf4g4unQG2ajXa0hHlX8WcfGOaK
	 2Pww+F/P+kyedW4cTNWVbY0d9gYWveCRMI9/y15wPYQZm8sY8PWr7JfuGxUpSEneI/A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793115034;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=eoQNto8aMlxcB3SSXSPPkAQPmnjM1b+yzf4VeGep8zg=;
	b=EZc+VRpB/dgstIlYQlCiwY+bdxb4gC18rdmMOqyMBm5oRxOh1tV9wb5a7zuicV4XjDz7
	 olMpRqYniQfeB6sTZE05E1Z6l0dEoRATiRAUT0c07+HwvyHMFTPY8dGRkx+Aoy0h73fn4
	 PJDiZlN911RezKWcZPZ8nz5hRLuCHmX992vpVMONFpdYi8sitnmjKqrMTWE1shiPirYRw
	 PB7tByMf8UsSe33d8RCABXIYbzYUDlQcGJ/UOoOjQ/ikrs0Nm0WazgeoA4d1XhprLQmmw
	 bmQzZNENqlqH2E11bhIu1iFNksdOXO4pWhjZnFju60dn+tPzA+8zUtuZ0nKwEQZLDDA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tENdtYBw;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.171
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F65606A31A
	for <linux-omap@vger.kernel.org>; Tue, 27 Oct 2026 15:30:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E3F65606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tENdtYBw
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-33bf40b0c8bso754982eec.0
        for <linux-omap@vger.kernel.org>; Tue, 27 Oct 2026 08:30:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793115033; cv=none;
        d=google.com; s=arc-20260327;
        b=GqxSPG7NOmAQdJscBuO8zIWNoKnN8GJdeMHHKPez1V27giPc6AUBga2oz3ZwXyYDgp
         lOT6DDufRqt3zEhBaCcIJXuP3zAFPqQFg0NZoSMFeLElUV0JLqZIC96xbhEQSd3IHtzj
         c0GF51rUnNdwuOWevsmbgGdTLI0TtrxfzFM7f5s0FYLSmCV5TU1Atg4C3CF/XQVlwyGD
         x+JRyO/JqFuEevWKAdWMzcdJbK+IHCkmdbwDs9Gu60LZ3KUN3UagrDbSdlLQEL5L+fOL
         s0oQqUj9Ihg+lcglEosNz7qfseuam+QpDt+7tTKCxuB75NXeBAgKsjjGSPFe8vvFgEf7
         XGDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eoQNto8aMlxcB3SSXSPPkAQPmnjM1b+yzf4VeGep8zg=;
        fh=eHSrHds84JsH1Y2Wkj5QKPXYRR+H8o/k/esOLri4vGQ=;
        b=B0XxbUZgED1qEuMDCibxeGlGRmztIt836eRcOT1b5Tv/0rAzEqj88SVvx8aEkZGs8B
         Vl4zkwzlZ0LaZfS/NPbh8Ol2+RTvO/Q69VID8vzlvIxPXYpdCOS5BrNCP23REFNaJmE0
         NIWbZluACRKsEyn9mvjuD7wBiMMeNeHQ2+kIEhcc3YrjDUkhbj6/sFkf0L9bzmkAexGK
         WyBOsoeUGnzWeweki5YwS4CsaGeOISCFbD8fNii3Jx2mKi/+3wsxWqANs/luDSfu82on
         8cK+GouSZLqf4oSNzezTc77IV/pA856ZJR2mlEEp+J5FfLByKPNrFKfq9kRX4qKZwyzd
         rbjQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793115033; x=1793719833; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=eoQNto8aMlxcB3SSXSPPkAQPmnjM1b+yzf4VeGep8zg=;
        b=tENdtYBwTDrLLm96VeGjbw3srQrKg9tCLkMK+rJI3vdDKppfXe2h6IokY4g+ASeFI1
         NrsO8M2m5xnxEFeO8rvbtHr1L9eV757DfQb2VDlXOIMseh5dj521l7iPbrTliEe1Y+ZX
         sYxMZJGVqfKLOJHjho8akmPi6k0trllSn4raxgmrGBm307DdiffRYBncn2dSvfBtltPx
         hAxa0qGrC2ksDcauqktfRyGq7D9j8YgwVvsDTVAwPwmzHzPMKIDj+YYCo1O30SOntaS3
         ZVh0zVi2nRIw+IB4vi3948c1xyb7qpaNRGYX9siQ/Kh2yRAhLTduHA5fvPq941sh0LQ3
         YMoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793115033; x=1793719833;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eoQNto8aMlxcB3SSXSPPkAQPmnjM1b+yzf4VeGep8zg=;
        b=2vrbJIr8mhuRgb/lBWDbq8uqxgNkfU+ByTY2ZITmT06zeXzmtLn//q2hPvoZQKOiZR
         CmNevhOumS0zynUvKAOnYtgW6Uo431epDmvu2X0UY3EnRVnZHGSHOrjS2itrnN56aR7c
         ps1/62u3pBTmI/Adb9P9curnBrplsU6zlWR+IJjIliEEAQ+J0y60T70OEilkfDmMj0CZ
         98rYzPLgG99r3o0gp30o40a68rnSOsB0cwrwiFaS2Aezlw/GcjBSDHxe/7bxmZrccrgA
         v+ddVokeziQM9623SM0DsZHTJdx7qySuAqqCaEG6JSX9nXvI+LuiTA+YGfmcyt+TOOMv
         QOCA==
X-Forwarded-Encrypted: i=1; AKwUvBxJxxSG12MpbcYqrX9CLXqsI4TYnBO1rVsNcfNtXJwqy1D0RrQtYdS6+J5I0A/1iIpTUbdsAsXIS3BC@vger.kernel.org
X-Gm-Message-State: AFq9FYKXWnOf/MYkwUq25JolGCBR2dmWTanPcbpDJDGy7CIGimvMB9Zk
	xkNTS57l53Z6MWy3tKaj8g3JE+RDvfWQGrcec+Qi7n5h1pQltqsrmWrL3wooSvODrdjrsVipAbf
	MbCxooI4Oa+5Nj3r7/XFgFlslqhcA2wk=
X-Gm-Gg: AYBFou3+jnJd30qxcm7tzVKXY4uSGN7e/hHg/8CP6ASEKg5T+MKZ2IOTpodFlGw+1/r
	4s5+DePtI3rYngrkf48vlgsHGW1/GNnOXL/OEQTewsRiUyHH54ySyC4N8/ucK4LKWCsTA7vCKU2
	3j9eq5xZfLvlX+fX8gaVnxW0SSusykdmZgQ2Tfwl9N4kde4zFPQHiof89Ym+dYh8t+xJwHoui3c
	IX8Ngg+zLiGmedEBEX8VACeN4aDLpmcB+uipE1Kevo47iWhhjwloQaed1HrjXqLtPP10nPGGJol
	+/6aXTworGkJhYJKuJJu31s+iuhP8W980S2eNKbpyt8CcNps+VBkLY1MoO+piLG+AxZu3KscBzN
	YFTsf5cx3bI3ZTmN75XOuW7GLzzm5IRqCLe0KcIPfMIVyFve2pyGImqxRGHCAzwz1f1TzdQ==
X-Received: by 2002:a05:7301:78c:b0:36a:16f:c550 with SMTP id
 5a478bee46e88-36a016fc6b5mr8139945eec.15.1793115033016; Tue, 27 Oct 2026
 08:30:33 -0700 (PDT)
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Post: <mailto:linux-omap@vger.kernel.org>
List-Help: <mailto:linux-omap+help@vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-omap+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261015102320.23760-1-clamor95@gmail.com> <20261015102320.23760-3-clamor95@gmail.com>
 <179206474862.1869456.3359147212046371469@kernel.org>
In-Reply-To: <179206474862.1869456.3359147212046371469@kernel.org>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Tue, 27 Oct 2026 17:30:21 +0200
X-Gm-Features: AclHuK8Zlu34WY5VMtUQgRpQc9IteaYIlIoPPVl1LsqWovajge3AsVoa0lEfyQI
Message-ID: <CAPVz0n3uWJQ6oMTq_0y8djfO4v=D_EDYbWfXqWhXxZJbJydTog@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] mfd: tps65910: Add restart handler
To: Lee Jones <lee@kernel.org>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, Andreas Kemnade <andreas@kemnade.info>, 
	Kevin Hilman <khilman@baylibre.com>, Roger Quadros <rogerq@kernel.org>, 
	Tony Lindgren <tony@atomide.com>, Dmitry Osipenko <digetx@gmail.com>, linux-omap@vger.kernel.org, 
	mfd@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=B2=D1=82, 27 =D0=B6=D0=BE=D0=B2=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 16:3=
1 Lee Jones <lee@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> --- checkpatch.pl: clean (0 issues) ---
>
> On Thu, 15 Oct 2026, Svyatoslav Ryhel wrote:
>
> > From: Dmitry Osipenko <digetx@gmail.com>
> >
> > Add restart handler to reset hardware properly on system reboot.
> >
> > Tested-by: Svyatoslav Ryhel <clamor95@gmail.com> # ASUS TF201
> > Tested-by: Maxim Schwalm <maxim.schwalm@gmail.com> # ASUS TF700T
> > Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > ---
> >  drivers/mfd/tps65910.c | 22 ++++++++++++++++++++++
> >  1 file changed, 22 insertions(+)
> >

Thank you! Your suggestions are valid and were applied in v2 here:
https://lore.kernel.org/lkml/20261027152423.194794-1-clamor95@gmail.com/T/#=
t
