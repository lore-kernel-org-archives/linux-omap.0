Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795160958;
	b=4vQnN2XrPgfbZlNJtFHy77aERqPEx4eDH028bYCHlWBrO/u6JclpoSGkm84fe5dkFUwb
	 hsfVr5v6XI87k8TQEYXyo7aq65Mh1qsOCupr5zYfImKx3DufCFHiR8wP9yJJHWuCC4/DD
	 nAa3WJ4ftEvKCKqTmAzpmyxwsbQwzEbMXNh7ytGX/vUTMFTXxKTUKT9+i8CpP9pX4xBQr
	 CGs+BmO1zLjvb349RfBYTcfH//xw/3oECo/IH2Yr4MMa0a22JiGhHhy4fZ0OUftE9JxTK
	 gGPb4JVkczFSvfDb1pAfWmAL0IqQcSxnsw1alAWUffNKlE+aPIcUBC4OXqq/6awGD2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795160958;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:
	 X-Forwarded-Encrypted:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=xKnU/TldM314xEN7UqLDGvv/eDTZSOGz68aX0N6/qi4=;
	b=WZdNvsKLoQZhC8EK7VSaY+pqIFF38w4MOusSUQhk48AVr8Uoh8JnT9C8j/kGJXUdlDtz
	 UNjMSp9JIBy/GM30f2DZs1cYsbEPwRkNYvwWvaTzW/ClKkS5m12Gs1inmi3bTIml+KHxG
	 cve7GwcDNdfes2knxnlSLjZeeLzz4La4XJGM+tqQd6pTNt9CMP/0rcOnre/JYdELdNxv9
	 i08AKb/9g1PoK4qdSXNc53d+mxG4ErQ51C65eFO9RBwbsrgyq4tyFpxHOj6ZNZkZFqQBX
	 2t/WCvMoYSFE5OAurZpOFlM8VPnAF/VrTalsaqBaCy52nao18MZlRzy6jr+TMYZvjEA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=linux-m68k.org;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.221.175
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7515606A32A
	for <linux-omap@vger.kernel.org>; Fri, 20 Nov 2026 07:49:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D7515606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-5eafaeb8684so173760e0c.3
        for <linux-omap@vger.kernel.org>; Thu, 19 Nov 2026 23:49:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795160957; x=1795765757;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=xKnU/TldM314xEN7UqLDGvv/eDTZSOGz68aX0N6/qi4=;
        b=1nC7JYnKrGDNOQIGOsF6eTkoMgPIFYCSz/i2J3x4ZqU0uG8xHrcjYFxKEcV5U+slAo
         5mjFiR0jrG0uaCvDPU7XksoJuwHBnnkdb1bn2p0rC+i+knMCn+zHngCHrHWvcGtVopyh
         vvhop5ut3uBEXz4uVyS8o04NV8qOouFJUAIkAFLdO3FdMwDFFOtVNMf8VDN97fFNzP2x
         T7Fqyl/U4ZNJ/EFZ+g76iA+W8KB7Xa+x0Mxx/YhYLm6XY3DHrKDtKb4unEXJueCNzwc6
         8eL5QOZipywlaroCJtQdlUyQTRCAhNytEGaPniuuFAQ9KHFUiiF/8yEMscvAYZfXhWyK
         Z/UA==
X-Forwarded-Encrypted: i=1; AL+hErHadJTpbJxAG+DB/GRxYl30JxgrKYon4XWfhnDCbSoovlSXfHjNwA9+gtWuR77af9Gc6DyvQVIHmU2e@vger.kernel.org
X-Gm-Message-State: APuU4Z/7CPw5aMRA67BpcG8CVz3eveHNthC26VmBn/UhI+LQXx9dJ0Od
	D+Hrl3WSxT2Z9XGwtQtV/Xie72RbIECtodH52AnJNZi8xUizOJ22/YpLULRZl9SO
X-Gm-Gg: AZFdTZd4BVMWi8hZoVaKA7rxccuhoq4fEa/wQI5+yvFjivZQ6++XwUCPSRdurJynN5I
	5fBfwniQjvHHkXOBOr119tlENbbDOp+YOhi2ilPW3MKiaEir8wyp551+aMbICKkSUIyjFgGCSox
	3TxY8fWO9GvLZeSztjhBpiqz+0R1GWFxLhhn9171HfNj25cUiWAf5ZHiGXNHAovBC3O7UMhn/Sk
	hnnLXamOowWNWWd1+xnSAULr2+YfJkYx2YwSEfLYn8w/7jtnM5KKMt7Z1JX4GSXdV9ifPrWDYjX
	Ab6PndfHtlxFAwpjKTsWPHvqMHalezYpLXJljbCRg/a9UvbUKdlNLm/TWkgMlOJXsWx2wBPMY8/
	q6Ai0wXTg7+9OshlgX3ltdWde+iICt3vak73VVy8/Kwth2dloWTNHxv8PTWgRSs/F7yn7IdFzsN
	Rtb/WAfNRieKs35qRDEQh9sm7NZOkum1fhPAHCXvN80zGnKDWLGAGLi4D7E4t5twZ37qBSz46Xh
	lcWy76oAe1DZycih5rYFG+8uSAleC7XLc2Ac6HbpkjV+hPcZHssjkQ8aLw6ZbHUtgIygdlZL8ur
	7hPo53cDeD4UcvN3uANuMiSP15fcap6yxuOXQowuclSuVrmEUw6Ix7RWCSKql6VQwF4=
X-Received: by 2002:a05:6122:421c:b0:5d6:7f46:b8dc with SMTP id 71dfb90a1353d-5ee8af5f40dmr1037203e0c.21.1795160956737;
        Thu, 19 Nov 2026 23:49:16 -0800 (PST)
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com. [209.85.222.43])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ee8b4335e1sm1903102e0c.1.2026.11.19.23.49.16
        for <linux-omap@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Nov 2026 23:49:16 -0800 (PST)
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-99b49d6a5caso188483241.2
        for <linux-omap@vger.kernel.org>; Thu, 19 Nov 2026 23:49:16 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErGqT4F+Tvhtjr1SgveGJvVSkpzESZjfHooyWe2h+zrhU71nJW5QbKIzZJy434fvvw8eRvfsghddAwJ6@vger.kernel.org
X-Received: by 2002:a05:6102:6c4:b0:7b3:8f0a:f76c with SMTP id
 ada2fe7eead31-7d7393caab1mr683612137.13.1795160956421; Thu, 19 Nov 2026
 23:49:16 -0800 (PST)
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Post: <mailto:linux-omap@vger.kernel.org>
List-Help: <mailto:linux-omap+help@vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-omap+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <cover.1795094688.git.geert+renesas@glider.be> <683b5b189409e5ee04100044fb615b01cb877f3d.1795094688.git.geert+renesas@glider.be>
 <20261119225017.15a7b5cc@kemnade.info>
In-Reply-To: <20261119225017.15a7b5cc@kemnade.info>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 20 Nov 2026 08:49:05 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVbgGV_6yjOip4xT3YhBgaOveHzSRbw9e_cHen9NRZqmw@mail.gmail.com>
X-Gm-Features: Aa3M54rfGlA3UrmhLbFF7B0m1MfxoFvw1pyboKcP24dUngkkG_fWLkpDdrOnbn8
Message-ID: <CAMuHMdVbgGV_6yjOip4xT3YhBgaOveHzSRbw9e_cHen9NRZqmw@mail.gmail.com>
Subject: Re: [PATCH 5/6] [RFT] ARM: OMAP2+: Convert to dev_clk_get_from_provider()
To: Andreas Kemnade <andreas@kemnade.info>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, Kevin Hilman <khilman@baylibre.com>, 
	Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>, 
	Russell King <linux@armlinux.org.uk>, Paul Walmsley <paul@pwsan.com>, Stephen Boyd <sboyd@kernel.org>, 
	Brian Masney <bmasney+clk@redhat.com>, Jerome Brunet <jbrunet+clk@baylibre.com>, 
	Sandy Huang <hjc@rock-chips.com>, =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
	Andy Yan <andyshrk@163.com>, Ulf Hansson <ulfh@kernel.org>, linux-clk@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-rockchip@lists.infradead.org, 
	linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	dri-devel@lists.freedesktop.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Andreas,

On Thu, 19 Nov 2026 at 22:50, Andreas Kemnade <andreas@kemnade.info> wrote:
> On Thu, 19 Nov 2026 14:40:38 +0100
> Geert Uytterhoeven <geert+renesas@glider.be> wrote:
>
> > OMAP2+ clock handling uses of_clk_get_from_provider() to obtain clocks
> > used for power management, so the latter show up as "deviceless" in the
> > consumer column of the clk_summary file in debugfs.
> >
> > Fix this by using dev_clk_get_from_provider() instead, letting us pass
> > the consumer device, too.
> >
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > ---
> > Compile-tested only.
> >
> > The first change is probably OK.  The second change may fail if anything
> > in the oh->od->pdev->dev chain is not available yet at this point.
>
> Test on OMAP3:

Thanks for testing!

> --- clk-old     2026-11-19 22:44:59.810807920 +0100
> +++ clk-new     2026-11-19 22:26:52.862531880 +0100
> @@ -1,17 +1,17 @@
>                                   enable  prepare  protect                                duty  hardware                            connection
>     clock                          count    count    count        rate   accuracy phase  cycle    enable   consumer                         id
>  ---------------------------------------------------------------------------------------------------------------------------------------------
> - oscillator                          0       0        0        26000000    0          0     50000      Y   deviceless                      of_clk_get_from_provider
> + oscillator                          0       0        0        26000000    0          0     50000      Y   deviceless                      dev_clk_get_from_provider
>                                                                                                             deviceless                      no_connection_id
> - secure_32k_fck                      0       1        0        32768       0          0     50000      Y   deviceless                      of_clk_get_from_provider
> + secure_32k_fck                      0       1        0        32768       0          0     50000      Y   deviceless                      dev_clk_get_from_provider
>                                                                                                             deviceless                      no_connection_id
> -    wdt1_fck                         0       0        0        32768       0          0     50000      Y      deviceless                      of_clk_get_from_provider
> +    wdt1_fck                         0       0        0        32768       0          0     50000      Y      deviceless                      dev_clk_get_from_provider
>                                                                                                                deviceless                      no_connection_id
>      gpt12_fck                        0       1        0        32768       0          0     50000      Y      48304000.timer                  fck
>                                                                                                                48304000.target-module          fck
> -                                                                                                              deviceless                      of_clk_get_from_provider
> +                                                                                                              deviceless                      dev_clk_get_from_provider
>                                                                                                                deviceless                      no_connection_id
> - dummy_ck                            0       0        0        0           0          0     50000      Y   deviceless                      of_clk_get_from_provider
> + dummy_ck                            0       0        0        0           0          0     50000      Y   deviceless                      dev_clk_get_from_provider
>                                                                                                             deviceless                      no_connection_id
>   mcbsp_clks                          0       5        0        0           0          0     50000      Y   deviceless                      mcbsp_clks
>                                                                                                             deviceless                      mcbsp_clks

Hmm, so the passed device is always NULL, and thus there is no point
in making the change.
Do you know if these come from the first or second change in my patch
(I guess the second)?

Thanks again!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
