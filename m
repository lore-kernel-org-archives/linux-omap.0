From: Nicolas Pitre <nicolas.pitre@linaro.org>
Subject: Re: N900 v3.19-rc5 arm atags_to_fdt.c is broken
Date: Tue, 27 Jan 2015 10:16:24 -0500 (EST)
Message-ID: <alpine.LFD.2.11.1501271014160.1322@knanqh.ubzr>
References: <201501232239.55801@pali> <201501232336.36187@pali> <20150126161454.GE28663@atomide.com> <201501261723.10505@pali> <20150126170323.GF28663@atomide.com> <alpine.LFD.2.11.1501261318590.1322@knanqh.ubzr> <20150127133739.GB25306@amd>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qc0-f170.google.com ([209.85.216.170]:44516 "EHLO
	mail-qc0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751888AbbA0PQ2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 27 Jan 2015 10:16:28 -0500
Received: by mail-qc0-f170.google.com with SMTP id p6so12388098qcv.1
        for <linux-omap@vger.kernel.org>; Tue, 27 Jan 2015 07:16:27 -0800 (PST)
In-Reply-To: <20150127133739.GB25306@amd>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Tony Lindgren <tony@atomide.com>, =?ISO-8859-15?Q?Pali_Roh=E1r?= <pali.rohar@gmail.com>, linux-omap <linux-omap@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Aaro Koskinen <aaro.koskinen@iki.fi>, Sebastian Reichel <sre@kernel.org>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Russell King <linux@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org, Laura Abbott <lauraa@codeaurora.org>

On Tue, 27 Jan 2015, Pavel Machek wrote:

> 
> > > > I would say, problem is because omap3-n900 binary DT is too large
> > 
> > I agree.
> > 
> > > OK if that's the case, then your patch makes sense to me. It also
> > > seems we can have the temporary stack be larger than the initial
> > > stack just for atags_to_fdt.
> > 
> > The stack size isn't the issue, but rather its location.  We need to 
> > position it away from the DT data.  The DT size is known and we could 
> > use that, plus some room for the insertion of new data coming from the
> > ATAG conversion.
> > 
> > Something like the following would be a more robust solution:
> 
> Tested-by: Pavel Machek <pavel@ucw.cz>
> 
> (Note, that in 3.19 dts for n900 got too big, so we are actually
> triggering old bugs. That means that this is a regression fix, and
> should go in ASAP).

It is queued here:
http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=8294/1


Nicolas
