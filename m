Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794924285;
	b=q7KbQxngHJOE5q49H/5Mqo7O0/Gpp/8fup/Gfi/25gsX/SQZXsMfvuLUMcH71gxdlt2j
	 h20SrRa8Nr8fyWMlpKm0NZRDxwC8YjeRm1GKa2zOO2cluIvq3IpaVkA2aJZsi4UtvsljT
	 wT1t51rYeUUoZgTjn3d7qdLHXL5+rYhm2+Z8Pbem81BqgaUxIOOpL2ytaFRvzZXTg7ymF
	 +opuMqkefm/SNkncptpvq3NKy9HKXLoydeS671Ac32oyWLEYf4WiolLEGlb8jvfR7+snl
	 0YeIuKOSJtltzlD4EPuDGfauODFlAchWBCIJKuRMqadoUbLTp5k1M2dcWZ0hH9wvTiA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794924285;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=Di6JFSgONXMtekzeBFRp4JLMTgABYf/4Sm0sPnWs7is=;
	b=qtRg4mJepFQntj1DEZGv5EwFmJI51AWXZi4cIQND35o/Bxy8QakUAe+f4xY90vZNkO8X
	 wshgLV80pBVKcMqmcgTzZ3jMixHnL1gMFyyeHHsEEszzUgDH+b2Zmk/wj/W+Nq/xBxQI/
	 C6q0krzlDoJuFlM5ZYt+Qr2eJXQEddWUfLsOqFP3hGOxcD91SM3qWcPVotWJARjXdnehp
	 4VPnVOrNf76viZYfcZ+YQYqzHiq7RG36noV+Ype6JRzGBzQG9qqsHKhPBX2gYvc9TSRu9
	 LaBu5G2eM8gm8ZhIT2fXy3hj4V2CtW7hehOON96CvTVr+KWOYq527xLA3IS4QnKBj4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="BVXWlR/A";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A988D606A335
	for <linux-omap@vger.kernel.org>; Tue, 17 Nov 2026 14:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BVXWlR/A
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D4491F000D4
	for <linux-omap@vger.kernel.org>; Tue, 17 Nov 2026 14:04:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794924285;
	bh=Di6JFSgONXMtekzeBFRp4JLMTgABYf/4Sm0sPnWs7is=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=BVXWlR/ABsnEeX0s/yKg5eSrHIUdZAwwuGEzZz0aF9nu1fwizuE5okDC1t0bG9W9X
	 o82WfE82VfVmYOr5g6tkEabL8iwVpsp3aaVFMCp4QU17B7nvrrIPJiwsFsuCyMMS0l
	 07A9TdwNvIWcgQcGzvVmjtYDCbQbY4btRxfwsF/D97tLU9cfRozPbBHm8de9VnZ6Eg
	 YJ9UFGeB3fDCq6fPsdmYlCHaxHrx6oi+ePFLOk8N8W3ay+wHYOv2fQFZ9gdddKHMQa
	 JUasTs0XH5I6VzXJWF+fjpkZ0YpfWUCS7kXnjmR2avG2u8u7rOzcGnvQqdkpSwXuil
	 l4y7FhzF+zzFA==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5c1593fd141so4443728e87.0
        for <linux-omap@vger.kernel.org>; Tue, 17 Nov 2026 06:04:45 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErGxJ+VTpJ/Hd8m8zIrIitngWWmSGoQ96ZAnDW7X0iEhVI7gKW2CYIGd2BD9fp1Jbfm7OB7nbN6XWDmg@vger.kernel.org
X-Gm-Message-State: APuU4Z86OZYzJbXzzw6/X+FKBtsq7PUnruE42zeS0P1+dGCqV7shW99L
	VBUoOlK8Il+he0On56fR5aFq/uxgQd1EjAo5H6ACnLqjx6FzbcTL8ZrDe+X55ZW7neDd23xyxLD
	y4qqnUEv1eMPIhlyfsKfJ2iP8STh67Wk=
X-Received: by 2002:a05:6512:3187:b0:5bf:f2ec:452a with SMTP id
 2adb3069b0e04-5c170774d54mr5047945e87.33.1794924284193; Tue, 17 Nov 2026
 06:04:44 -0800 (PST)
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Post: <mailto:linux-omap@vger.kernel.org>
List-Help: <mailto:linux-omap+help@vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-omap+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <tencent_B4F504456790E8BA3C4EAB80F4BFB6954E08@qq.com> <tencent_D8A4B6EE90931660EB6F586543FD58110E06@qq.com>
In-Reply-To: <tencent_D8A4B6EE90931660EB6F586543FD58110E06@qq.com>
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 17 Nov 2026 15:04:31 +0100
X-Gmail-Original-Message-ID: <CAD++jL=MDR1tHkKN18pN0cedDMjAyDExr0PHxa6rv_hR0-qbhA@mail.gmail.com>
X-Gm-Features: Aa3M54r6pEigKZfzJX1-qA9TZdTOYvDiX-BZ5dtOgDgC-_AJ1Iuv-Wjm-gRz0_Q
Message-ID: <CAD++jL=MDR1tHkKN18pN0cedDMjAyDExr0PHxa6rv_hR0-qbhA@mail.gmail.com>
Subject: Re: [PATCH v2] gpio: omap: handle debounce clock preparation failure
To: Jiawen Liu <1298662399@qq.com>
Cc: Grygorii Strashko <grygorii.strashko@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>, 
	Kevin Hilman <khilman@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, linux-omap@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Andreas Kemnade <andreas@kemnade.info>, Dan Carpenter <error27@gmail.com>, 
	Markus Elfring <Markus.Elfring@web.de>, kernel-janitors@vger.kernel.org, 
	Alexander Sverdlin <alexander.sverdlin@siemens.com>, Matti Vaittinen <mazziesaccount@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 9, 2026 at 2:42=E2=80=AFPM Jiawen Liu <1298662399@qq.com> wrote=
:

> omap_gpio_probe() ignores the return value of clk_prepare() for the
> debounce clock. If preparation fails, the driver still treats debounce as
> available and may use or unprepare a clock that was not prepared.
>
> Use devm_clk_get_prepared() and disable debounce if the clock cannot be
> obtained or prepared. This keeps the existing behavior for clock lookup
> failures. Remove both manual clk_unprepare() calls because the managed
> clock is released on probe failure and device removal.
>
> An earlier managed-clock conversion was dropped after a reported boot
> failure. A follow-up removing the two manual unprepare calls was reported
> to restore boot. This change also removes those calls.
> Built gpio-omap.o with ARM multi_v7_defconfig and Clang 19; the current
> patch has not been tested on OMAP hardware.
>
> The original report was generated using BMC-Agent; source review and
> maintainer feedback informed this revision.
>
> Fixes: 5d9452e7c52a ("gpio: omap: fix clk_prepare/unprepare usage")
> Suggested-by: Andreas Kemnade <andreas@kemnade.info>
> Link: https://lore.kernel.org/r/tencent_B4F504456790E8BA3C4EAB80F4BFB6954=
E08@qq.com
> Link: https://lkml.rescloud.iu.edu/hypermail/linux/kernel/2412.2/00414.ht=
ml
> Signed-off-by: Jiawen Liu <1298662399@qq.com>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
