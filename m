From: Tony Lindgren <tony@atomide.com>
Subject: Re: Fwd: [PATCH 2/5] ARM: OMAP3+: hwmod: Add AM33XX HWMOD data for
 davinci_mdio
Date: Fri, 19 Oct 2012 09:00:41 -0700
Message-ID: <20121019160041.GB4730@atomide.com>
References: <20121017181354.GA2412@netboy.at.omicron.at>
 <alpine.DEB.2.00.1210172337170.30902@utopia.booyaka.com>
 <20121017235045.GB30550@atomide.com>
 <20121018030654.GE2867@netboy.at.omicron.at>
 <alpine.DEB.2.00.1210180313360.6893@utopia.booyaka.com>
 <20121018184443.GD2350@netboy.at.omicron.at>
 <50806B1D.9040504@ti.com>
 <20121019061630.GB2983@netboy.at.omicron.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:26059 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1759127Ab2JSQAq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 19 Oct 2012 12:00:46 -0400
Content-Disposition: inline
In-Reply-To: <20121019061630.GB2983@netboy.at.omicron.at>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Richard Cochran <richardcochran@gmail.com>
Cc: Vaibhav Hiremath <hvaibhav@ti.com>, Paul Walmsley <paul@pwsan.com>, Mugunthan V N <mugunthanvnm@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Richard Cochran <richardcochran@gmail.com> [121018 23:18]:
> On Fri, Oct 19, 2012 at 02:18:29AM +0530, Vaibhav Hiremath wrote:
> > 
> > Another important point is, this driver is also required and used for
> > Davinci family of devices (arch/mach/mach-davinci/).
> 
> That is really beside the point. If the code isn't ready yet, then
> don't merge it.
> 
> When I asked about the beaglebone, I was given the impression that it
> will be ready for v3.7-rc1.  But, as I know realize, at the current
> rate, it might not even be ready for v3.8.
> 
> I don't mind waiting, but please make sure that whatever lands into a
> release is really, truly working.

Indeed. This has been a problem with many of the TI patches in
general. People are working on separate product trees and then produce
patches for the mainline kernel that are poorly tested.

The requirement should be: Do your patch on an omap board then send the
patch from your omap board after booting your board with the patch :)

Regards,

Tony
