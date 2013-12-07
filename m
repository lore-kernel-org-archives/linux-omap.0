From: Tony Lindgren <tony@atomide.com>
Subject: Re: runtime check for omap-aes bus access permission (was: Re:
 3.13-rc3 (commit 7ce93f3) breaks Nokia N900 DT boot)
Date: Sat, 7 Dec 2013 15:22:06 -0800
Message-ID: <20131207232205.GS26766@atomide.com>
References: <20131206213613.GA19648@earth.universe>
 <201312070918.32471@pali>
 <20131207134818.GA933@earth.universe>
 <201312071457.38836@pali>
 <20131207165104.GD11015@atomide.com>
 <20131207184958.GB3704@earth.universe>
 <20131207211137.GR26766@atomide.com>
 <20131207230305.GA9103@earth.universe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:11612 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754259Ab3LGXWJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 7 Dec 2013 18:22:09 -0500
Content-Disposition: inline
In-Reply-To: <20131207230305.GA9103@earth.universe>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>, linux-omap@vger.kernel.org, Aaro Koskinen <aaro.koskinen@iki.fi>, Joel Fernandes <joelf@ti.com>

* Sebastian Reichel <sre@ring0.de> [131207 15:04]:
> On Sat, Dec 07, 2013 at 01:11:37PM -0800, Tony Lindgren wrote:
> > > I asked Pali to send me his copy of the updated NOLO bootloader,
> > > so that I can test this. I just checked the omap documentation
> > > (I only have access to the public one) and crypto related stuff
> > > is not documented for the L3_PM_READ_PERMISSION register. There
> > > are a couple of reserved bits, which may be used for this, though.
> > > 
> > > I also CC'd Joel Fernandes, since he worked on the driver before and
> > > may have access to the documentation.
> > 
> > Looks like at least the 36xx public version referenced here has them:
> > 
> > http://www.spinics.net/lists/linux-omap/msg21857.html
> > 
> > I'd assume the registers are the same for 34xx since we don't have
> > them defined separately in the kernel.
> 
> I can't find it in the omap36xx documentation either. Maybe I search
> at the wrong position. I tried to find something crypto related in
> 
> Table 9-89. L3_PM_READ_PERMISSION_i

Hmm maybe it's done based on the address in L3_PM_ADDR_MATCH_k?

I guess the thing to do would be to compare the register output between
the two different firmware versions.

Regards,

Tony
