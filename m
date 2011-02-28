From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 5/8] OMAP4 : DSS2 : HDMI: HDMI driver addition in the
 DSS drivers interface
Date: Mon, 28 Feb 2011 08:51:39 +0200
Message-ID: <1298875899.2096.34.camel@deskari>
References: <1298643715-21540-1-git-send-email-mythripk@ti.com>
	 <1298643715-21540-6-git-send-email-mythripk@ti.com>
	 <1298801837.1977.63.camel@deskari>
	 <AANLkTimiQ2pdvzP0OAnq5YqzkWq_91XLMWSq1K5M_3VH@mail.gmail.com>
	 <1298874423.2096.11.camel@deskari>
	 <AANLkTim9Nwst-2cLu5-8Yx9B-fnWO=xeDdMwuh=4pvgJ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:51779 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751061Ab1B1Gvn (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 28 Feb 2011 01:51:43 -0500
Received: from dlep36.itg.ti.com ([157.170.170.91])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id p1S6pgnX021519
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 28 Feb 2011 00:51:42 -0600
Received: from dlep26.itg.ti.com (localhost [127.0.0.1])
	by dlep36.itg.ti.com (8.13.8/8.13.8) with ESMTP id p1S6pgk7024551
	for <linux-omap@vger.kernel.org>; Mon, 28 Feb 2011 00:51:42 -0600 (CST)
In-Reply-To: <AANLkTim9Nwst-2cLu5-8Yx9B-fnWO=xeDdMwuh=4pvgJ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "K, Mythri P" <mythripk@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Mon, 2011-02-28 at 00:30 -0600, K, Mythri P wrote:
> Hi Tomi,
> 
> On Mon, Feb 28, 2011 at 11:57 AM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> > On Mon, 2011-02-28 at 00:11 -0600, K, Mythri P wrote:
> >> Hi Tomi,
> >>
> >> On Sun, Feb 27, 2011 at 3:47 PM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> >
> >> >> + * HDMI interface DSS driver setting for TI's OMAP4 family of processor.
> >> >> + * Copyright (C) 2010-2011 Texas Instruments Incorporated - http://www.ti.com/
> >> >> + * Authors: Yong Zhi
> >> >
> >> > Who is Yong Zhi and where's his signed-off-by?
> >> Yong zhi had written some of the functions in this file , which was in
> >> a library.He no longer works on the driver though .
> >
> > Ok. Generally there should be a signed-off-by from everybody who has
> > written the code. It's like "I have written this code and I have
> > permission to send it upstream" etc.
> >
> > His signed-off would be good for this too, but if the code is just based
> > on his work, and doesn't really resemble it anymore, perhaps you could
> > then say "Based on code by Yong Zhi", or similar.
> >
> sure i shall check with him to add his sign-off.
> >> >> +
> >> >> +static inline int hdmi_wait_for_bit_change(const struct hdmi_reg idx,
> >> >> +                               int b2, int b1, u32 val)
> >> >> +{
> >> >> +       u32 t = 0;
> >> >> +       while (val != FLD_GET(hdmi_read_reg(idx), b2, b1)) {
> >> >
> >> > There's REG_GET macro used in other DSS files to read bits from the
> >> > registers.
> >> Hmm i see that in dsi.c REG_GET is defined to do the same,
> >> #define REG_GET(idx, start, end) \
> >>         FLD_GET(dsi_read_reg(idx), start, end)
> >> So should this be fine of should i define a new REG_GET ?
> >
> > REG_GET() uses the private dsi_read_reg() function, so it has to be
> > defined again in each interface file. So for HDMI, define REG_REG
> > similarly with hdmi_read_reg().
> >
> But it is used in only one function here , so is it really needed :) ?

There are more than one FLD_GET(hdmi_read_reg()) patterns in hdmi.c,
which could be replaced with REG_FLD_GET(). But granted, there are still
not many of them now that I checked. Well, up to you if you want to add
that or not.

> >> >> +       /* HACK : DDC needs time to stablize */
> >> >> +       mdelay(10);
> >> >
> >> > So what is the reason for this? It's a sleep that for unknown reason
> >> > make the code work? Or is there an idea why this is needed?
> >> This is the time it needs to stabilize DDC, else most of the time it
> >> reads a 0 or
> >> wrong shifted values , so i have prefixed with a HACK.
> >
> > Ok. I'm fine with the hack for now, but I'm just interested: Is the 10ms
> > just something that happens to work? This sleep is not discussed in any
> > documentation? Has this been discussed with HW people?
> 
> yes i have checked with the silicon validation.

Hmm. So, it's a HW feature or a HW bug? In either case, it's not a hack
then. If it's a normal HW feature, you just need to sleep there, simple
as that. If it's a HW bug, then this is a work-around, and it should be
mentioned.

Generally code like this should have a bit more explanation whether it's
a HW bug, HW feature, SW hack that magically makes it work, SW hack made
to get difficult thing done quickly and to be replaced later, etc. The
reader should understand what's going on here, and what can be done for
the code.

Also, I only now noticed that it's a mdelay, not msleep. 10ms mdelay
sounds very bad, don't do that. Use msleep. mdelay is basically a 10ms
busy loop.

 Tomi


