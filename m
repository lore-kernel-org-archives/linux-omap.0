Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A16B746DFF7
	for <linux-omap@vger.kernel.org>; Fri, 28 Aug 2026 13:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787925049; cv=none; b=T3dUOiPizxuUFa0wTfsoXJbBGKp0s3vYbox/oc2fZ9uxLKp8l7zseZlPVVpq+WpdhGCSmY1BV9LMOznIRMBDXegjVAPWmMQKkbMT3lm6R7YMuY+7yWRZqFgfnVmJeMa0u/CksLD579EsXWC3zY+8G8fK26x7kbX3XbnLfBHcSIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787925049; c=relaxed/simple;
	bh=RJHfGXMgNXQPB3ROkizQtnGbx4GKsI/Ym/GD2uZwjKc=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=JFC5CtUIO9tGYGYGdty7P1E1mg1nifh22uUF1kMuGvcTNswaPFvR9LaBGc5ySKDRurreqzMxWiMOJqJAlMW9jCRlJ+8CrYRRauck9eebPSvHe0Mk1vTVJ+8pJCGS1qRPCG7F/+1FaozT5P+ZA4bJ1ci5jBEU5j+Yw7HcwzZlWdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=AiTif5Uc; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="AiTif5Uc"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4995b0343c1so8853865e9.3
        for <linux-omap@vger.kernel.org>; Fri, 28 Aug 2026 06:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1787925046; x=1788529846; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:mime-version:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=gVqcZ6+gECK7UdiJSAVLCAiRAq9LtXJGwIyE/KiuV5s=;
        b=AiTif5UcxPTUk38jOXEaIrOjBpaPGsNDwMB0Wbt+An6bN1yd+g2VX8yQ9dODMJuQNo
         opSGHRLhZGq1KDQ+I5yo+2dFIroz69hVW3C2AYKUxxUe0vjnYLqVCMqS9K71k/uJgSix
         kLG5l1ep2wsogslEgJhhCF+3pCYHq4wea7y9r0ttgZpkTqoeaKhUhuNCwCPDOD1YtC4j
         KZR9QIO4HRl/ne89cgdc63dW4zKeBZsQzuM5BaUN5KlTP0TKMBN3/qXlAZ1baE6LIfjA
         6+AFBUx0l0WVchGgKAKX86sicydfEXKG0Fo3xjtDqlnUFk5erhlo4MYLd0nPDPQdU3J0
         pisQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787925046; x=1788529846;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=gVqcZ6+gECK7UdiJSAVLCAiRAq9LtXJGwIyE/KiuV5s=;
        b=Wu/0y+ZtLhP7247tLfh26FAnNPStHl/ZrJZ4R9a6sj/VaFhUcditFg9tP8e37Y/t98
         4jwPIrcUO9GtSl8XZvnaspmZD0jmeL0+keKSkDWr9tRlg99+I8HXLnLkeHJc2LX7M5Yk
         Bm6tSULWVbScfALawOpxt/0OS0muRg7ODeiimX6xZU87ZUoF53+uorRiZHhS3rqv9TlV
         dkW2/74rUQWgIu4a+7DdlABluw8mAnSJ6DxC3UU+HjO3lTV9dXFHPbpdfeXzJ2ej4LMt
         V9dYD1Yq2Nqe9s1c3SNR1fkNtsHM2HiUlrwT5/sXyO8x4n/coLv1GCPzdEJ1uuEgcVTT
         TmXQ==
X-Gm-Message-State: AFuF++m3NuoQp07gDNe8nyYH2VITsVfHw00VQeW+d3ugN66Q8y92H+YS
	ooKM7nfGZ79wpIrCrGC6jVkvXEpNuWqM8aoJuun1pzEKajUifUM+mMnHYvaixUZDJb0=
X-Gm-Gg: AR+sD10PHz+DLPcT4nyh0lW9b7LGDPFNAyXyP4gLVD3+eoF2QnxFX80btYtqV5w6Ey/
	Ehj38LGWzeq2NDl7o3RM8UkNBgEVlfnxYYHRYy6JV3GDooN84kqIgUXTiItiVRGHnmh4Ff/sPyY
	v+pYUSt+H8bDFOuM2+iZO0+gTptA4EdEIOg83I3+91l8Rcz0iAat1mLfKOoVO5zd1E2Z9fgjmnY
	D3PUm2ADfpLSDjTy1BOOVGc3uWU3RJqAbgpTJG1AdMUKpWq0d9Pe5GotMeSJwCICJ5qeNBhiq4y
	it714o8nDvLdYBRAqGuTehVW5gZ6hxNqVMYm5+OkjIOp+p1tyjdWldhkEYUWmHtsVVxQeEO98YZ
	ht+Mx59qG0lb1X463x+gS6PJxy0alh+hJa2lknjUUH8u0Ky6n8L/wtN75YDLgm028KxBRcarQk9
	e/WjSjoD9+OMsLKYKuVyKhjZnsf2BE0inrWvYibSS6ik5q5bil9VmyiX13
X-Received: by 2002:a05:600c:a403:b0:49b:924e:9a28 with SMTP id 5b1f17b1804b1-49b924e9b14mr89881845e9.1.1787925045748;
        Fri, 28 Aug 2026 06:50:45 -0700 (PDT)
Received: from localhost ([2001:4090:a244:80d4:489b:7642:1b32:84d6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49b955e7906sm43176955e9.1.2026.08.28.06.50.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2026 06:50:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=130b19770e787f0ec56abe4062c3593d0b0b259124c35d3dc8132e673162;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Fri, 28 Aug 2026 15:50:36 +0200
Message-Id: <DL0MJ2ULPZL2.20ET2TL52T7HI@baylibre.com>
Cc: <linux-omap@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-kernel@vger.kernel.org>, "Andreas Kemnade" <akemnade@kernel.org>,
 <letux-kernel@openphoenux.org>
Subject: Re: [REGRESSION] OpenPandora (OMAP3) fails to boot since v7.2-rc1,
 bisected to b8eeeca5545659
From: "Markus Schneider-Pargmann" <msp@baylibre.com>
To: "H. Nikolaus Schaller" <hns@goldelico.com>, "Markus Schneider-Pargmann
 (TI)" <msp@baylibre.com>, "Daniel Lezcano" <daniel.lezcano@kernel.org>,
 "Thomas Gleixner" <tglx@linutronix.de>, "Tony Lindgren" <tony@atomide.com>
X-Mailer: aerc 0.21.0-146-gb5c16ebe1835
References: <2013A99A-0502-4128-ACFA-B04886224393@goldelico.com>
In-Reply-To: <2013A99A-0502-4128-ACFA-B04886224393@goldelico.com>

--130b19770e787f0ec56abe4062c3593d0b0b259124c35d3dc8132e673162
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi Nikolaus,

On Fri Aug 28, 2026 at 2:49 PM CEST, H. Nikolaus Schaller wrote:
> Hi,
> I am seeing a boot regression on OpenPandora (OMAP3) since v7.2-rc1.
>
> A git bisect identified:
>
> b8eeeca5545659 ("clocksource/drivers/timer-ti-dm: Add clocksource support=
")
>
> as the first bad commit.

Thanks for reporting, I am sorry for the regression.

>
> Reverting this commit restores normal boot operation.
>
> The regression is fully reproducible:
> * v7.1: boots normally
> * v7.2-rc1 and later: hangs during early boot after about 3 seconds
>   after reporting
> [    3.631072] sched_clock: 32 bits at 33kHz, resolution 30517ns, wraps e=
very 65535999984741ns
> [    3.643341] clocksource: omap_dm_timer: mask: 0xffffffff max_cycles: 0=
xffffffff, max_idle_ns: 58327039986419 ns
> [    3.660430] clocksource: Switched to clocksource omap_dm_timer
> * v7.2-rc1 + revert of b8eeeca5545659: boots normally again
>
> What caught my attention is that OMAP already has an existing DMTimer
> clocksource implementation in timer-ti-dm-systimer.c, introduced by:
>
> 52762fbd1c4778 ("Add support for using the TI Dual-Mode Timer as a clocks=
ource")

Yes, this is the implementation for the old platforms omap, am33 etc. It
runs in early boot.

>
> while b8eeeca5545659 adds another clocksource implementation to
> timer-ti-dm.c.

Yes K3 am6* is much more complex and has more dependencies, that's why I
added it to the platform driver.

>
> The commit message and patch series state that the driver automatically
> selects the first timer marked with the "ti,timer-alwon" DT property and
> registers it as a clocksource/sched_clock.
>
> I have not determined the failure mechanism, but the bisect result and
> successful revert strongly suggest that the new DMTimer clocksource path
> conflicts with the existing OMAP3 timer setup.
>
> Therefore, I would like to ask:
> * Is the new timer-ti-dm clocksource intended to coexist with the
>   existing timer-ti-dm-systimer clocksource implementation on OMAP3?

The implementation is intended to coexist but they shouldn't both setup
the clocksource/clockevent for the same device.

> * Is b8eeeca5545659 expected to be active on OMAP3 systems?

No, it should not work on that.

> * Has this combination been tested on OMAP3 hardware?

No, my testhardware was am62. Sorry for missing this bug.

> * What is the solution?

I can create a patch probably early next week that gates the clocksource
clockevent registration to only run for am654-timer.

Best
Markus

--130b19770e787f0ec56abe4062c3593d0b0b259124c35d3dc8132e673162
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKMEABYKAEsWIQSJYVVm/x+5xmOiprOFwVZpkBVKUwUCapGSLRsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMiwyLDIRHG1zcEBiYXlsaWJyZS5jb20ACgkQhcFWaZAVSlM9
/gEAnktWVuwC5R1ZeT01TGPkBnos6X5QRQAPU3SGK1NrzxUA/ilWRihV90+G2v1p
Vs9dDH/wV/9/C2/WgpqhyfA/Iw8G
=UzTa
-----END PGP SIGNATURE-----

--130b19770e787f0ec56abe4062c3593d0b0b259124c35d3dc8132e673162--
