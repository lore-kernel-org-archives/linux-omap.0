From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: N8x0 display support (was: Re: The old omapfb support)
Date: Fri, 29 Apr 2011 16:33:39 +0300
Message-ID: <1304084019.5605.75.camel@deskari>
References: <1303215626.32281.70.camel@deskari>
	 <20110419123036.GF15620@atomide.com>  <1303216485.27432.7.camel@maggie>
	 <1303216889.32281.80.camel@deskari>  <1303217114.27432.9.camel@maggie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:39513 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751640Ab1D2Ndn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 29 Apr 2011 09:33:43 -0400
Received: by mail-ww0-f50.google.com with SMTP id 33so3671775wwc.19
        for <linux-omap@vger.kernel.org>; Fri, 29 Apr 2011 06:33:42 -0700 (PDT)
In-Reply-To: <1303217114.27432.9.camel@maggie>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Michael =?ISO-8859-1?Q?B=FCsch?= <m@bues.ch>, lo-ml <linux-omap@vger.kernel.org>
Cc: Tony Lindgren <tony@atomide.com>

On Tue, 2011-04-19 at 14:45 +0200, Michael B=C3=BCsch wrote:
> On Tue, 2011-04-19 at 15:41 +0300, Tomi Valkeinen wrote:=20
> > On Tue, 2011-04-19 at 14:34 +0200, Michael B=C3=BCsch wrote:
> > > On Tue, 2011-04-19 at 15:30 +0300, Tony Lindgren wrote:=20
> > > > > But this again reminded me of the mess of having two display =
drivers,
> > > > > the old omapfb and the new DSS2. Many of the OMAP2 boards usi=
ng the old
> > > > > driver should be quite easy to port to DSS2, with the excepti=
on of N800.
> > > > > DSS2 doesn't support OMAP1, so there's not much that can be d=
one with
> > > > > those boards currently.
> > >=20
> > > > Yeh we can just make old omapfb depends on ARCH_OMAP1.
> > >=20
> > > As he said, the old omapfb code is used on n8x0, which is OMAP2.
> >=20
> > But as I also said, the old OMAP2 panel drivers can be ported to th=
e new
> > DSS driver. I just mentioned N800 because the panel driver for N800=
 is
> > rather difficult to port and will require more work than the other =
OMAP2
> > panel drivers.
>=20
> So if you first port the stuff and then add the depends-on OMAP1, I'm
> fine with it.

I've now got a beta version of N800 display support for DSS2 ready, and
I can get a picture on the screen.

However, it's quite difficult to port all of the blizzard.c code, as th=
e
new DSS2 doesn't support some of the weird things there. Also, I don't
have N800 schematics and Blizzard documentation, so properly porting
everything needs reverse engineering the code.

There is some PLL code in the blizzard.c, purpose of which I don't
understand. The new driver seems to work fine without the PLL code.

Then blizzard seems to support YUV420 mode, and currently there's no
support for controller specific modes in the DSS2, so I've left that
out.

Blizzard driver also contains auto-update code, which adds a
considerable amount of code to it. I don't want to add that code to the
new driver, because my opinion is that manual update displays should be
used like manual update displays. N800's user space should handle it
properly, as far as I know, but it is not possible to use the
framebuffer console with only manual update mode.

I experimented a bit with FB framework's deferred IO support, which
indeed allows us to use fb console quite easily. However, a proper
support for deferred IO would need more code and careful thinking how t=
o
do it.

So, my question is: what are the uses of N800's display with the
mainline kernel? Are we happy with just having basic display
functionality, or do people need all the features in the older blizzard
driver? If latter, I wonder if there's somebody who wants to develop
this further?

If somebody wants to give it a try/look, my N800 development (based
on .39-rc3) branch can be found from:

git://gitorious.org/linux-omap-dss2/linux.git n800

I'll of course send proper patches when thing are more finalized.

 Tomi


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
