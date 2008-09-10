From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: 3430: can't find mmc debounce clock
Date: Wed, 10 Sep 2008 08:02:55 -0500
Message-ID: <13B9B4C6EF24D648824FF11BE896716203655BDE26@dlee02.ent.ti.com>
References: <57314e840809080618x1f0cd0aen74b1a03351dc8ef7@mail.gmail.com>
 <alpine.DEB.1.00.0809100641010.20446@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:34785 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752155AbYIJNDG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Sep 2008 09:03:06 -0400
In-Reply-To: <alpine.DEB.1.00.0809100641010.20446@utopia.booyaka.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>, Budhee Jamaich <budheej@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


> > I read that the mmc has 3 clocks: fixed functional clock (MMCi_FCLK),
> > interface clock (MMCi_ICLK) and debounce clock (MMCi_32).
> >
> > But, when I look in clock34xx.h, I can only see two of those - there
> > is the "mmchs_fck" and "mmchs_ick". There is no struct clk for the
> > debounce clock. Only when I look in older kernels I can see also the
> > "mmchsdb2_fck".
> >
> > So where is the debounce clock struct ? (I want to 'get' and 'enable'
> it...)
>
> The debounce clocks are controlled by gpio[1-6]_fck.  Perhaps we should
> rename them, but that's what the current tree uses.

With out looking, that's a bit confusing to me.  Perhaps it's a porting wonder...

2430 did have a separate MMC denounce clock which is controllable at the PRCM level.  This is the name you mention above (2430 name).  I don't think 3430 provides the same control.  A 32K clock is fed into the MMC block, but it is probably controlled locally in MMC block not through clock API at PRCM level.

Maybe you just need an ifdef or is_cpu_ call.

Regards,
Richard W.
