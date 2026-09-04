Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 674923EAC71
	for <linux-omap@vger.kernel.org>; Fri,  4 Sep 2026 08:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788510126; cv=none; b=mEaVbdM5ouAdDjXebsB3PF7ibX5vchm4lGWq14P9Yi0SJnw3RN+W9qhnqk4tAgIVsX0c78pm6Si2ACr29GVpTQJR1VAmTaUzC1BWfB1FBgn96uh26akNpeARzb0nHptnEEfF2BQkaKOnM6akjXb9VjS2+bUssN0t32pKLRTPX/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788510126; c=relaxed/simple;
	bh=oyDxmpF/0rXv8EzH2b2HV9ktlFAjPfgd1vY1EFEf3Cc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A6rUkFR0ZtWMYoNAAGSw3+F4/8xaCljTBtcC+ViJm9BILI+ppZ2Kog0ekn5ml7A4/eKs9+dbD2Wy8uIx/Wqq0VikL+YusHvSIWf5SA/Vyx/mVpONVRoeAlc3Rq+0NoMNTzA2fG+EaT1QNQ9js//EZ+gFeYzeQKW7shR24+xrX7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-46add2afca9so404485fac.1
        for <linux-omap@vger.kernel.org>; Fri, 04 Sep 2026 01:22:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788510124; x=1789114924;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=8Hg5enr8UVGmoY4IFaKJm1CFD+8hJCgKWPLT+95rrjA=;
        b=K4ZVpoUj0gR1YVxrTRFwRoqQq3R3NfOkuQRgWB+aDHq+n6hm4mvQUQYCBvxpWrql6N
         a9myWfmFpRlM4DcxikGKScBtyFJQWp4v2VTMsdlB1D9oBho7ESixOukX1AefVHmT7tUG
         ItuVZEV/wuHhuJVvHuUe6pK2GND4X9B3q+8+6bxDHvA5v0k6mjUevQNJZUSXBmFuLcZq
         zbRLu2FY0/MWuXP6TRcThkMINRU89NFkct1WG/YiaKRR1yC1/mHsO1s857QYDM79Usqt
         43O12qW787e45J3kQRC9h7eSjDzpFLnqIS405xRTe41mS1usWPlFs+yqsyMrlRdrNMGs
         VEEQ==
X-Forwarded-Encrypted: i=1; AKwUvBw60Fk/JNUtd0ogYIQBCTULk/csZtPtw3yHM+LC8btRh5LF49OcUbhQ+pA4Qh6lblYWB9S8rpNEOjOS@vger.kernel.org
X-Gm-Message-State: AFuF++kZLrSJEkELFJ12GlFnWCd16L7hW9NBEnZCTftzmEQkDx7uiOKy
	av9Zb3Srmgl3Qgn9tmHjGa4HDkdsQ7qcWYunerDn9Q8j319iDiIYgk5iFjifeoSozv4=
X-Gm-Gg: AYBFou0oP9OaFBv7i7TvH9XqtuPmOfdQDrDDJ/Wq/o76P3ZQBVisd8FxEfDph3NlJO0
	1pbiIsHV3qYL9r3iLz/dcWX4HW8qybjU2WIWr4TUhVBi4UMv2bvvxxzo4+BpX7v3O4mWfdolce3
	hKvlREjTyBf5oHrkxSIY4yDO64Whr99pRJQmWXNAcM9K18H8JiOHKZLaHJUym0BB0SoPbYn7Z6p
	rkZc79es83tYPQnSGmyeOYi7FXlOHT5a3byiS0mPy9oUBgMwL7ewYTMKXoCbvLjKuh6ndx8+HWU
	soIL42BlkW04J3cWmttciSN3QrQQzkyUs6AU919V/iAo7EV7HLBFAOGsa7jfrX6vi5ynNTK/J+r
	ul9gus+W9/susmwhkUDNVu0wVPVyjzJeCjCNdWHoPGI49z4E/XgR0rUzBs1MwhzJpAx4cz1E2dA
	zXmwg9Lq8Q6ZEd2ExdtbRCFSXY4R6YvqdTgtopsSmjBN85C6Qj1bFEmJ2WdziD3UGic03+zk7Of
	fzgR3kD6loN+5RxY+1tThXecY3iCqIqxMwdKmqs
X-Received: by 2002:a05:6870:c245:b0:465:2bde:8b5e with SMTP id 586e51a60fabf-4754f496d93mr4415502fac.1.1788510123934;
        Fri, 04 Sep 2026 01:22:03 -0700 (PDT)
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com. [209.85.167.172])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4755493580fsm1719561fac.13.2026.09.04.01.22.03
        for <linux-omap@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Sep 2026 01:22:03 -0700 (PDT)
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-495c49f8eccso711597b6e.3
        for <linux-omap@vger.kernel.org>; Fri, 04 Sep 2026 01:22:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvByNE6kGJEV93kWSD8slmTWEsu9IJS7haALpzTmhD/o3tWgjz34tC2hWuJgJE0WkeDv/iAV7aSxgFfXY@vger.kernel.org
X-Received: by 2002:a05:6102:534e:b0:77f:fb50:8822 with SMTP id
 ada2fe7eead31-78a4a9106f4mr984477137.7.1788509665014; Fri, 04 Sep 2026
 01:14:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260904043724.2955444-1-s-vadapalli@ti.com> <20260904043724.2955444-23-s-vadapalli@ti.com>
In-Reply-To: <20260904043724.2955444-23-s-vadapalli@ti.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 4 Sep 2026 10:14:13 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVXHwWKu_oqNQBR=hytL0JQVzMsnVWyBueds5PHDJWmWg@mail.gmail.com>
X-Gm-Features: AcwNN1UYeUOEoTpTj0vmkU4IKRIpHFGa-g95RrL_FdgZr5R39yo0yU6G4UOZ8vE
Message-ID: <CAMuHMdVXHwWKu_oqNQBR=hytL0JQVzMsnVWyBueds5PHDJWmWg@mail.gmail.com>
Subject: Re: [PATCH net-next 22/33] net: dsa: rzn1_a5psw: Remove comma after
 sentinel-entry in match-table
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: dario.binacchi@amarulasolutions.com, mkl@pengutronix.de, 
	mailhol@kernel.org, msp@baylibre.com, florian.fainelli@broadcom.com, 
	jonas.gorski@gmail.com, andrew@lunn.ch, olteanv@gmail.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	kurt@linutronix.de, hauke@hauke-m.de, chester.a.unal@arinc9.com, 
	daniel@makrotopia.org, matthias.bgg@gmail.com, 
	angelogioacchino.delregno@collabora.com, ansuelsmth@gmail.com, 
	linusw@kernel.org, luizluca@gmail.com, alvin.sipraga@analog.com, 
	clement.leger@bootlin.com, justin.chen@broadcom.com, dlan@kernel.org, 
	rogerq@kernel.org, hkallweit1@gmail.com, linux@armlinux.org.uk, 
	rjui@broadcom.com, sbranden@broadcom.com, 
	bcm-kernel-feedback-list@broadcom.com, opendmb@gmail.com, 
	andrei.botila@oss.nxp.com, wangruikang@iscas.ac.cn, amadeus@jmu.edu.cn, 
	kees@kernel.org, tmshlvck@gmail.com, c-vankar@ti.com, horms@kernel.org, 
	vadim.fedorenko@linux.dev, daniel.zahka@gmail.com, 
	nora.schiffer@ew.tq-group.com, v-singh1@ti.com, oss@vassilevski.com, 
	haokexin@gmail.com, alex@sverdlin.org, aleksandr.loktionov@intel.com, 
	lgs201920130244@gmail.com, linux-can@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, linux-renesas-soc@vger.kernel.org, 
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev, 
	linux-omap@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 4 Sept 2026 at 06:41, Siddharth Vadapalli <s-vadapalli@ti.com> wrote:
> Since sentinel is the last entry and we do not expect further entries
> following it, remove the comma.
>
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
