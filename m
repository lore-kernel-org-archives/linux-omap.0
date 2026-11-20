Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795165053;
	b=Hs27YUdwMgHCQV0g6EaAqjhAAWBfhn7xCIFweq1uNfU9Nu1on+NFvnfKvZK3emxDiv7y
	 +YiMz+O3mWne0pxNmlaBJZgd6nCFcRxkUFj5vRGg4J3uPA6jtH9Tic4Lt3mUxSjDfk7Os
	 vJJiqV2Z2+q+iyt7QRbIKR4NCiCzh5c9uO4mTiXE3Wl2qpJkHSSfuCrkcg3FQJKV+7j53
	 iDOd/BGghMneqq0RiaO4sR7ld4Z76Rr5K50hcOKNI55CW/ufhRFWoUmxZNNCHEcfpFa2s
	 FFekm/KuLwxeEJZbvzha09gjngqZ6+Ayn4/0mzB7477Vl4LhCA2KnojpboUJhV1ECFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795165053;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:
	 X-Forwarded-Encrypted:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=slnLzkdmpwFbnxdOJOf8j6Mw1PiHOu2DMR+OPWGMV3g=;
	b=CQVLdBLyMpR/B0WGjnSvXSgv9hNMFLNsYCC6qAPOY65zkVUvcoEyvx9c0/1ifAHoueVu
	 VEA2MCB16qlRv+zVKqgEfwXoBrwbfaif6cjqD384vzcJhDCXlNutMsMfvI5Yjj4rNQP78
	 WnXMAAS0QynHWFJgpTBkcNnKraB/L2alNFk1o9Os6xB1PllmVVnBzQGgkj7DhHRYLaA1t
	 GRT5YC528V6WJROWj4Ong8PuEZxxY6W0puMtwbs8O866e+YBlgXHlKkNfBOS2PyCfC3lf
	 oXnFagDUQ299fRQ7fyicqAL8kARMYHsVUlS0QRgHsICJ83WAxlc7Q+rDgghxnVAW4Ig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=linux-m68k.org;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.160.173
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 352BD606A325
	for <linux-omap@vger.kernel.org>; Fri, 20 Nov 2026 08:57:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 352BD606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-55d03bfd477so8052381cf.1
        for <linux-omap@vger.kernel.org>; Fri, 20 Nov 2026 00:57:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795165052; x=1795769852;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=slnLzkdmpwFbnxdOJOf8j6Mw1PiHOu2DMR+OPWGMV3g=;
        b=vq8RHXGu1Qud9eTVbymC8eg5RF2tlA3m0SD9H/VIpfRI9bkB5N4vc/sNImWvGtrV+U
         C5wSKpxQWlBdRpNl8XIfmjxNMJ76VSx/Ymft4dRCRd3s8WpjamYgVDD/XAJ9bfMe0qTr
         CJT+3IyYGeJfm2dyiKVirIUnJ1RAUNRqTaSwwphSm2AVtIGnusigiJkzlFyDsRpzzLk0
         2esKXmIOl7dZVfeGbjjMrIlBqe4aCJ0oz552fzHOUjE647DxXaQ/dLLwLZGnXXZbalHo
         MOxvzL1mznCceIRWoj96TifwgCiQpRbB4OmS9XWfIvTPIMjclGKFCP1yrYkGCHw2rd6m
         qj1w==
X-Forwarded-Encrypted: i=1; AL+hErF28BU7Slkf83Wc/Zc+JxjeUg9l8k96YgjcZzjtA+WkslDEsg1UfADdbHlPH6Q76kTR0HvQNM/381SM@vger.kernel.org
X-Gm-Message-State: APuU4Z+5gShsXW9jDGVDEGtHHAhbMuKLwYVDJ+Q/FwU/QAv/5QYpLmSH
	cz0WNuP84n5y8XO9w5uSKsiFuGk2ZCSzGg0b2A0vak6aa3NSHKe7XVvWBKbR08j6
X-Gm-Gg: AYBFou2aGthRf12SHHUiIysqf1h8a2pCvr1sHC1M/xF4rhGN/9BGuehPZMsLE2Mj+6p
	qFMkKFXQgBhPk9mEhjmimqD+yVp2h41picXn/RuIhNhe/BDW+gZH+G7pe0GdqILMKGWu78UH7Q/
	30CVJ3HPk2zbbRa5dak1CFb5mVwcWBX7uI+4CCKlFSv//6nbbIcXE/ga4WL4hvwiCSxfLeikhRt
	fFs2YzXcg3GUJbAuP8IMPILSqJKckiScikd9SZju9U2Y+KcngLrHVmZcsutkn3/gNoozwW95gJ/
	TMm6+wrsTYNxJjJGi8VjffeRN/Fg0mMbiECr2n1JcSjLv0Dw3tWkfqy9XfcPav4j1TxiSnBfOMk
	H8L0aJPG4pYbJhDNcyeILRTwpEXDrbks0ooTHz35QJd9c8DgPgWst1K5aRV3lYtghqvCs7vW+Fh
	GQ/0K9sUB6l2LIQ5gUUxoh9gUh1wPVBkes6dqrdY/sMzuzJTVppgFc8lvp2H47Z++WM27UZ7rPN
	FeRlSlLRcQt3YpcVU8cvW1YXp1465tgsJOEJuIjCuDGuM2JYUHmpmnJC1K4Odl+AzmRo9rv6ZgN
	tgHcuXGiDWd/5VKcHyWo+CNSj5Ih7fNRQPbrhoO4TNC3n9/0PyAAW4trK0BedoMiqXyXk1Q=
X-Received: by 2002:a05:620a:4555:b0:93f:3163:3e25 with SMTP id af79cd13be357-949ba955764mr361115285a.24.1795165052084;
        Fri, 20 Nov 2026 00:57:32 -0800 (PST)
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com. [209.85.160.174])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-949bb407c00sm146255585a.34.2026.11.20.00.57.31
        for <linux-omap@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Nov 2026 00:57:31 -0800 (PST)
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-536717a4d83so5580851cf.2
        for <linux-omap@vger.kernel.org>; Fri, 20 Nov 2026 00:57:31 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErGLhB+nMUp/G9AOL8iO14oq2r3mdsCKmWlvXlOJX0tDckXBiJll7aXrgwP2k+0XLLuTS6ZefiDDeF7g@vger.kernel.org
X-Received: by 2002:a05:6102:a49:b0:7c3:7286:c291 with SMTP id
 ada2fe7eead31-7d739587805mr971622137.19.1795164590827; Fri, 20 Nov 2026
 00:49:50 -0800 (PST)
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
 <20261119225017.15a7b5cc@kemnade.info> <CAMuHMdVbgGV_6yjOip4xT3YhBgaOveHzSRbw9e_cHen9NRZqmw@mail.gmail.com>
 <20261120094320.442d064b@kemnade.info>
In-Reply-To: <20261120094320.442d064b@kemnade.info>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 20 Nov 2026 09:49:39 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWiCODz6RC9Q9-xMM5_k3grHztiLuR+-ikOZYoBawVvZg@mail.gmail.com>
X-Gm-Features: Aa3M54pnWIgbseGoLAFGMXWb1P8DBLFzk6LU-uNSdaE_BgKhwLT8uPsc_3uFT5k
Message-ID: <CAMuHMdWiCODz6RC9Q9-xMM5_k3grHztiLuR+-ikOZYoBawVvZg@mail.gmail.com>
Subject: Re: [PATCH 5/6] [RFT] ARM: OMAP2+: Convert to dev_clk_get_from_provider()
To: Andreas Kemnade <andreas@kemnade.info>
Cc: ettore.chimenti@linaro.org, Aaro Koskinen <aaro.koskinen@iki.fi>, 
	Kevin Hilman <khilman@baylibre.com>, Roger Quadros <rogerq@kernel.org>, 
	Tony Lindgren <tony@atomide.com>, Russell King <linux@armlinux.org.uk>, Paul Walmsley <paul@pwsan.com>, 
	Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, 
	Jerome Brunet <jbrunet+clk@baylibre.com>, Sandy Huang <hjc@rock-chips.com>, 
	=?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, Andy Yan <andyshrk@163.com>, 
	Ulf Hansson <ulfh@kernel.org>, linux-clk@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-rockchip@lists.infradead.org, 
	linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	dri-devel@lists.freedesktop.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Andreas,

On Fri, 20 Nov 2026 at 09:44, Andreas Kemnade <andreas@kemnade.info> wrote:
> On Fri, 20 Nov 2026 08:49:05 +0100
> Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Thu, 19 Nov 2026 at 22:50, Andreas Kemnade <andreas@kemnade.info> wrote:
> > > On Thu, 19 Nov 2026 14:40:38 +0100
> > > Geert Uytterhoeven <geert+renesas@glider.be> wrote:
> > >
> > > > OMAP2+ clock handling uses of_clk_get_from_provider() to obtain clocks
> > > > used for power management, so the latter show up as "deviceless" in the
> > > > consumer column of the clk_summary file in debugfs.
> > > >
> > > > Fix this by using dev_clk_get_from_provider() instead, letting us pass
> > > > the consumer device, too.
> > > >
> > > > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > > > ---
> > > > Compile-tested only.
> > > >
> > > > The first change is probably OK.  The second change may fail if anything
> > > > in the oh->od->pdev->dev chain is not available yet at this point.
> > >
> > > Test on OMAP3:
> >
> > Thanks for testing!
> >
> > > --- clk-old     2026-11-19 22:44:59.810807920 +0100
> > > +++ clk-new     2026-11-19 22:26:52.862531880 +0100
> > > @@ -1,17 +1,17 @@
> > >                                   enable  prepare  protect                                duty  hardware                            connection
> > >     clock                          count    count    count        rate   accuracy phase  cycle    enable   consumer                         id
> > >  ---------------------------------------------------------------------------------------------------------------------------------------------
> > > - oscillator                          0       0        0        26000000    0          0     50000      Y   deviceless                      of_clk_get_from_provider
> > > + oscillator                          0       0        0        26000000    0          0     50000      Y   deviceless                      dev_clk_get_from_provider
> > >                                                                                                             deviceless                      no_connection_id

                                deviceless
mcbsp_clks
> >
> > Hmm, so the passed device is always NULL, and thus there is no point
> > in making the change.
> > Do you know if these come from the first or second change in my patch
> > (I guess the second)?
> >
> From the first change, The second piece is nowadys only used by the dm81*
> devices.

Interesting.  So that means all/some of the existing use of
&od->pdev->dev in _add_clkdev() is futile, as it may be NULL?

> I would prefer to have this tested on dm81* too.

Agreed.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
