Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA48C3ACF1E
	for <linux-omap@vger.kernel.org>; Fri, 29 May 2026 08:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780041750; cv=pass; b=nkjWZ/Yhw8KNsM5OsPpcCD5JqWvMrxEt6EmTjI/IxsAsaSAHnFRr6oowrLRFbj2+5BbnLiuHG7iFmlTT3BpNeo72PQmMvS4t+q1W0n+GH2cJAwQSIZ2Hz43oP6bbkLuHJPgY7YL46Ukey3x+PXqti/Mbfax9LRP88Kor4SMvPeg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780041750; c=relaxed/simple;
	bh=XT6w4vc0Qoe3DQquv1ih38xI5xPmjmTxa5U+zj2Fats=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dKtZz7Hfh8g7qMyAZgz+E4qbD3qJXmLPIQjTdd077YjgGgt1Q1jhRhJmFjqNua9Mgwx20LmZqCsbdwPIWpSxMPVezbEM6CwsMpCJwT/h0XSCWdKucrIvLeTamWsxBnyKi+2EUdmfpSMTcoaa4eAGpnIVn/R5jXLYdHJCxHn2qr0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DyzZTbtr; arc=pass smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DyzZTbtr"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2b458ca2296so102659635ad.0
        for <linux-omap@vger.kernel.org>; Fri, 29 May 2026 01:02:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780041749; cv=none;
        d=google.com; s=arc-20240605;
        b=IVC/uQXPBp0/oxmlifVe2fXA/Mqgcja+vaJKIzVcBGrbs5un4+bt3pJSStCRRoEQNh
         uc/WZOK3p+33cMiAUkzQoUUR8i07B1eztjRNWygIJwygsTIbFRIC5nd7mP9Fyra6RPFA
         PMDJlLwPHzx7W79ENOZ/6D7PWAy6ckB6WWiITVPSsKR8AjO7UaRLVlptLfDqAQANJJkZ
         07bv3oN6GjrHY+r3iEszU1rsfXMslOlXQc64RtrpskNXquTMGwEcL6QpFG0Ml39h4K4p
         2Rg2ikcGNFhmebTa+MDn3HgOBqz9fvO+Yj6opf+rjEhiCYjnhJDN7LjV4qWjZ5lKNx9r
         eAkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XT6w4vc0Qoe3DQquv1ih38xI5xPmjmTxa5U+zj2Fats=;
        fh=ZnXVkbxrg39QUVFFv3wD94AXAgQoMreCqPoaDiYlimc=;
        b=Rb2SMD/U3ZeDCR2y8LWhhf9sYvd8EI6ln98riZiPojEWwZeDM1NXwvVehsY/hdiW7w
         Z3SVJoSlKPgH+8Ishno2My76k6BiZ8lm7MtDvILGYOGdRV3gQAA2AI2xliJ8gEgOEsuh
         pzxsm2wc9T7fL9GQC8VJIftr5EOTxGMfgZNZcaShrnc6LtSLosvYGkfdK7+RGsipaMWx
         VH00FO9gpfDVpsfT1FBFmGTJG4VuhoqxyQZT+PpG+GSJX246Khm+9AaCGsdVeGhgbVo6
         OLfODOqp1vmsYuIF31hCRxAm/rSgarBnRSZVE1FStSszNcs0BfSEYIqR9ril2g7ktg1g
         ph4A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780041749; x=1780646549; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XT6w4vc0Qoe3DQquv1ih38xI5xPmjmTxa5U+zj2Fats=;
        b=DyzZTbtrZ1n2pUax8yd/K5VlIptCfq8x17Y1bBwWhPrIij0QTiJOPUXga9Wk1PStt/
         Z/UX82Dpe1ItakllYC6viWCR6Nre9Fnb6f60qOEMga+MfWzZ9OF6lLU5CPCWDvZacO+0
         KvFL6AHvHXA7EM47EcHtijw8SuWz3liQi0gcdlWIi47OWjg8JDj0BULD+kZ29dnPnP4k
         vUtHvuLIgjrRORImdUB7i4bk7qjvA5BoJixLH8dryHWOir77N0KT8m147f2PoC5TxDye
         KSSpFvXYuOOLLoFaA59M593VjSX5/qQmA2vbWvJTivlCCErGxgg5GEUYH9Qkc/j/nQ+5
         Ycpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780041749; x=1780646549;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XT6w4vc0Qoe3DQquv1ih38xI5xPmjmTxa5U+zj2Fats=;
        b=oDNPDWnKj5nKAvVwZCRF+BZ1AHGdlaEN+P28uzCKHvuthjRPDsbEnoQIUSeiGpnuve
         HIbhf6d8KUo2GqEu0+D/ZxPnIh57qNS8gKdOtRggJZISa3NU2R1EP01Ke0BUKnoWCi92
         n0MO5qDrpXBQRXyO4vw/VF8AwOjs9cwUboVIbC877ZDuyv0YxiTTcDsSO6CB+ykyDpqb
         F6qPgHILuKy83zmPJtTJHZp2zMSdHLcvzF1sPkVtOlMfsLou3hAC1q9gVZnq9RT4F+yk
         kIoGvXcwIHyb+2a/vOKp/pR+krFsHcOqzaUizdgFVNLDOdv0ua1s3JyF1pq/C2ZX2abM
         K6rQ==
X-Forwarded-Encrypted: i=1; AFNElJ/RL1lg6mk2qTo/Mdw0f4SHvkFS177GvFDwjaSyVbcOTOhmKpVvxDFPLoNTm5oiPw/VP9Pnw2v8WXYl@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5wV/8kT0b05mR0llB1rz5Io07gE0DlC3kKBOxfk2eYsEiTRKl
	u2saTG0mq8WUV9Yhhlzd7UPbBHoYoV5oND03r4hAwWDHHd+JzDdg52OkQyQazztwb86y65P6Yqi
	cT3ZZ8Ios7nQr3fO5DTOeSm1A3yx2pJY=
X-Gm-Gg: Acq92OF6x8+z86HjmaLhhlMYuYhnlNdPGXvcfot1X96/4JCnYNflgBWP1Vp4vrurSpA
	+L4hwqxY4sxzfLe6B/eanp/eGP4k0mC1/o/wSl4xmYH9IfQifM9br5p4ZvJR8lrSn7Yh4c+CVxp
	hiYBJi4lBnkA5X2O4xBVU946VsPwBH58f3IFKdf5CJSf3SXrpMTsQWfwpabphc6uOVAaB2+5CFr
	vFPMdTKC2hxv2qG+pPZuIcTe80hBkgUKj8Hb00YEOdBWICeNTOB41FmyFzpVewDZIdVDo67GTyV
	64GSpcbz39JHEpGVaPo=
X-Received: by 2002:a17:903:fa5:b0:2ba:6ca2:be0 with SMTP id
 d9443c01a7336-2bf2053340bmr25566605ad.4.1780041749021; Fri, 29 May 2026
 01:02:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1779878004.git.u.kleine-koenig@baylibre.com> <d02f55dfd5bdd743ae5cd76f2a5af0d346226a68.1779878004.git.u.kleine-koenig@baylibre.com>
In-Reply-To: <d02f55dfd5bdd743ae5cd76f2a5af0d346226a68.1779878004.git.u.kleine-koenig@baylibre.com>
From: Matti Vaittinen <mazziesaccount@gmail.com>
Date: Fri, 29 May 2026 11:02:17 +0300
X-Gm-Features: AVHnY4KLQby2GKgYCaNbHrRuPj0X0-ETK3PqgCK0q7F1iL-UnUKeln5tOfAvRio
Message-ID: <CANhJrGNyB7aqMhR5DiLXd6OPmsE4Vox=K7UwMPZ1ZZc2-Ciw3w@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] regulator: Use named initializers for
 platform_device_id arrays
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Karel Balej <balejk@matfyz.cz>, Marek Vasut <marek.vasut+renesas@gmail.com>, 
	Chanwoo Choi <cw00.choi@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Samuel Kayode <samkay014@gmail.com>, =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
	Aaro Koskinen <aaro.koskinen@iki.fi>, Andreas Kemnade <andreas@kemnade.info>, 
	Kevin Hilman <khilman@baylibre.com>, Roger Quadros <rogerq@kernel.org>, 
	Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, imx@lists.linux.dev, 
	linux-arm-msm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
	linux-omap@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

ke 27.5.2026 klo 13.48 Uwe Kleine-K=C3=B6nig (The Capable Hub)
(u.kleine-koenig@baylibre.com) kirjoitti:
>
> Named initializers are better readable and more robust to changes of the
> struct definition. This robustness is relevant for a planned change to
> struct platform_device_id replacing .driver_data by an anonymous unit.
>
> While touching these arrays unify spacing and usage of commas.
>
> Signed-off-by: Uwe Kleine-K=C3=B6nig (The Capable Hub) <u.kleine-koenig@b=
aylibre.com>
Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>

--=20

Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

Discuss - Estimate - Plan - Report and finally accomplish this:
void do_work(int time) __attribute__ ((const));
