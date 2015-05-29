From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] fix n900 dts file to work around 4.1 touchscreen
 regression on n900
Date: Fri, 29 May 2015 13:29:54 -0700
Message-ID: <20150529202954.GA26494@localhost>
References: <20150527133311.GJ30798@pali>
 <20150527143722.GA28108@amd>
 <20150527145837.GA13223@earth>
 <20150529190816.GA20232@amd>
 <20150529192505.GA28987@amd>
 <20150529193211.GA7599@amd>
 <20150529194955.GV2026@saruman.tx.rr.com>
 <20150529195629.GA9811@amd>
 <20150529201745.GC17267@lukather>
 <20150529202123.GY2026@saruman.tx.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ig0-f181.google.com ([209.85.213.181]:35139 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757148AbbE2U37 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 29 May 2015 16:29:59 -0400
Content-Disposition: inline
In-Reply-To: <20150529202123.GY2026@saruman.tx.rr.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>, Pavel Machek <pavel@ucw.cz>, Sebastian Reichel <sre@kernel.org>, kernel list <linux-kernel@vger.kernel.org>, pali.rohar@gmail.com, sre@debian.org, sre@ring0.de, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com

On Fri, May 29, 2015 at 03:21:23PM -0500, Felipe Balbi wrote:
> On Fri, May 29, 2015 at 10:17:45PM +0200, Maxime Ripard wrote:
> > On Fri, May 29, 2015 at 09:56:29PM +0200, Pavel Machek wrote:
> > > On Fri 2015-05-29 14:49:55, Felipe Balbi wrote:
> > > > Hi,
> > > > 
> > > > On Fri, May 29, 2015 at 09:32:11PM +0200, Pavel Machek wrote:
> > > > > Fix dts to match what the Linux kernel expects. This works around
> > > > > touchscreen problems in 4.1 linux on Nokia n900.
> > > > >     
> > > > > Signed-off-by: Pavel Machek <pavel@ucw.cz>
> > > > > 
> > > > > diff --git a/Documentation/devicetree/bindings/input/touchscreen/tsc2005.txt b/Documentation/devicetree/bindings/input/touchscreen/tsc2005.txt
> > > > > index 4b641c7..09089a6 100644
> > > > > --- a/Documentation/devicetree/bindings/input/touchscreen/tsc2005.txt
> > > > > +++ b/Documentation/devicetree/bindings/input/touchscreen/tsc2005.txt
> > > > > @@ -32,8 +32,8 @@ Example:
> > > > >  		touchscreen-fuzz-x = <4>;
> > > > >  		touchscreen-fuzz-y = <7>;
> > > > >  		touchscreen-fuzz-pressure = <2>;
> > > > > -		touchscreen-max-x = <4096>;
> > > > > -		touchscreen-max-y = <4096>;
> > > > > +		touchscreen-size-x = <4096>;
> > > > > +		touchscreen-size-y = <4096>;
> > > > 
> > > > IMHO, the older binding needs to be supported as well. It's fine to
> > > > update the DTS for the new binding, but even Documentation says
> > > > touchscreen-max-[xy] and if the driver changed that, the driver should
> > > > be fixed too. Besides, it seems like this has been in tree since
> > > > v3.16:
> > > 
> > > Agreed. In parent email, I have list of two commits that should be
> > > reverted.
> > 
> > So, if we sums things up. You introduce in some documentation example
> > some property, that you never document, that you still use in one
> 
> it was Documented in DT bindings document for this particular driver.
> What are you talking about ?

It was documented in "example", not in the documentation that says:

 - properties defined in touchscreen.txt

which says nothing about touchscreen-max-x. And _noone_ has ever parsed this
property, so adding support for it does not make any sense.

> 
> > single DT, you don't even use that property in your driver, and now
> > that you realise you meant something else, you want the code that
> 
> not Pali, Sebastian.
> 
> > actually parse the *right* property and does the right thing, that all
> > other DT agree (and depend on) to be reverted?
> 
> We shouldn't revert, that I agree. But both properties should be parsed.

No. If the property is wrong, and nobody parsed it, I do not see any reason to
start now.


-- 
Dmitry
