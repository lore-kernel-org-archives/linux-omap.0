From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 5/8] OMAP4 : DSS2 : HDMI: HDMI driver addition in the
 DSS drivers interface
Date: Mon, 28 Feb 2011 08:27:03 +0200
Message-ID: <1298874423.2096.11.camel@deskari>
References: <1298643715-21540-1-git-send-email-mythripk@ti.com>
	 <1298643715-21540-6-git-send-email-mythripk@ti.com>
	 <1298801837.1977.63.camel@deskari>
	 <AANLkTimiQ2pdvzP0OAnq5YqzkWq_91XLMWSq1K5M_3VH@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:44447 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751591Ab1B1G1G (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 28 Feb 2011 01:27:06 -0500
Received: from dlep34.itg.ti.com ([157.170.170.115])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id p1S6R68f024676
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 28 Feb 2011 00:27:06 -0600
Received: from dlep26.itg.ti.com (localhost [127.0.0.1])
	by dlep34.itg.ti.com (8.13.7/8.13.7) with ESMTP id p1S6R51Z016199
	for <linux-omap@vger.kernel.org>; Mon, 28 Feb 2011 00:27:05 -0600 (CST)
In-Reply-To: <AANLkTimiQ2pdvzP0OAnq5YqzkWq_91XLMWSq1K5M_3VH@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "K, Mythri P" <mythripk@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Mon, 2011-02-28 at 00:11 -0600, K, Mythri P wrote:
> Hi Tomi,
> 
> On Sun, Feb 27, 2011 at 3:47 PM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:

> >> + * HDMI interface DSS driver setting for TI's OMAP4 family of processor.
> >> + * Copyright (C) 2010-2011 Texas Instruments Incorporated - http://www.ti.com/
> >> + * Authors: Yong Zhi
> >
> > Who is Yong Zhi and where's his signed-off-by?
> Yong zhi had written some of the functions in this file , which was in
> a library.He no longer works on the driver though .

Ok. Generally there should be a signed-off-by from everybody who has
written the code. It's like "I have written this code and I have
permission to send it upstream" etc.

His signed-off would be good for this too, but if the code is just based
on his work, and doesn't really resemble it anymore, perhaps you could
then say "Based on code by Yong Zhi", or similar.

> >> +
> >> +static inline int hdmi_wait_for_bit_change(const struct hdmi_reg idx,
> >> +                               int b2, int b1, u32 val)
> >> +{
> >> +       u32 t = 0;
> >> +       while (val != FLD_GET(hdmi_read_reg(idx), b2, b1)) {
> >
> > There's REG_GET macro used in other DSS files to read bits from the
> > registers.
> Hmm i see that in dsi.c REG_GET is defined to do the same,
> #define REG_GET(idx, start, end) \
>         FLD_GET(dsi_read_reg(idx), start, end)
> So should this be fine of should i define a new REG_GET ?

REG_GET() uses the private dsi_read_reg() function, so it has to be
defined again in each interface file. So for HDMI, define REG_REG
similarly with hdmi_read_reg().

> >> +       /* HACK : DDC needs time to stablize */
> >> +       mdelay(10);
> >
> > So what is the reason for this? It's a sleep that for unknown reason
> > make the code work? Or is there an idea why this is needed?
> This is the time it needs to stabilize DDC, else most of the time it
> reads a 0 or
> wrong shifted values , so i have prefixed with a HACK.

Ok. I'm fine with the hack for now, but I'm just interested: Is the 10ms
just something that happens to work? This sleep is not discussed in any
documentation? Has this been discussed with HW people?

> >> +static inline void print_omap_video_timings(struct omap_video_timings *timings)
> >
> > Why is this inline?
> Its only a print function , called many times by the driver. Do you
> see any reason not to make it inline?

Well, generally you shouldn't use inline. I think that's the basic rule.
Compiler usually makes better choices than humans. I have used them for
xxx_read_reg() and xxx_write_reg(), although I'm not quite sure if even
that is needed.

And in this case the function is quite long. I'm guessing here, but most
likely the code runs faster if it's _not_ inlined, because not inlining
reduces the size of the code. Also, print functions are on the slower
side anyway, so the overhead of calling this function is probably
negligible compared to the contents of the function. 

 Tomi


