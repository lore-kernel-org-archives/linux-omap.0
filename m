From: Tony Lindgren <tony@atomide.com>
Subject: Re: arm-soc + rmk's tree boot failure on OMAP4430SDP
Date: Mon, 19 Mar 2012 12:21:09 -0700
Message-ID: <20120319192108.GC9859@atomide.com>
References: <20120316231158.GA9970@n2100.arm.linux.org.uk>
 <20120317004706.GF7276@atomide.com>
 <20120317211505.GA4720@n2100.arm.linux.org.uk>
 <1332149601.2144.15.camel@deskari>
 <20120319123006.GC16389@n2100.arm.linux.org.uk>
 <1332160864.2144.66.camel@deskari>
 <1332162163.2144.77.camel@deskari>
 <1332165550.2144.85.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:25524 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756065Ab2CSTVN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 19 Mar 2012 15:21:13 -0400
Content-Disposition: inline
In-Reply-To: <1332165550.2144.85.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>

* Tomi Valkeinen <tomi.valkeinen@ti.com> [120319 07:01]:
> On Mon, 2012-03-19 at 15:02 +0200, Tomi Valkeinen wrote:
> 
> > I'll see if I can make a single patch that fixes the issue. The patch
> > series I mentioned earlier does lots of things, but I think just moving
> > the driver registration out of the probe function should be enough to
> > avoid the problem.
> 
> Here's a patch that fixes the issue for me. Tested on OMAP4 Blaze with
> omapdss both as module and built-in. I'll queue this up after testing it
> a bit more.

OK works for me too.
 
> This still leaves the issue of initialization order, but I think that's
> not a big issue at the moment. It doesn't happen in practice, as the
> current driver framework will probe the devices at driver registration
> time. I'll fix this for the next merge window.

Yes that's something that needs fixing.

Regards,

Tony
