From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v5 02/14] ARM: OMAP2+: gpmc: Adapt to HWMOD
Date: Fri, 15 Jun 2012 05:45:20 -0700
Message-ID: <20120615124520.GS12766@atomide.com>
References: <4FD64D6D.3020401@ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E997DD6@DBDE01.ent.ti.com>
 <4FD77EF1.8000600@ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E9987B2@DBDE01.ent.ti.com>
 <4FD8A906.8080202@ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E999582@DBDE01.ent.ti.com>
 <4FD9E5AF.6010201@ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E999CA6@DBDE01.ent.ti.com>
 <4FDA3464.4040704@ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E99A511@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:59047 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756725Ab2FOMpX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 15 Jun 2012 08:45:23 -0400
Content-Disposition: inline
In-Reply-To: <C8443D0743D26F4388EA172BF4E2A7A93E99A511@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Mohammed, Afzal" <afzal@ti.com>
Cc: "Hunter, Jon" <jon-hunter@ti.com>, "paul@pwsan.com" <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

* Mohammed, Afzal <afzal@ti.com> [120615 03:26]:
> Hi Jon,
> 
> On Fri, Jun 15, 2012 at 00:28:44, Hunter, Jon wrote:
> > On 06/14/2012 08:32 AM, Mohammed, Afzal wrote:
> > > On Thu, Jun 14, 2012 at 18:52:55, Hunter, Jon wrote:
> 
> > >> Why? You currently have a global variable storing the clock handle. It
> > >> can be quite common for drivers to know the clock frequencies of their
> > >> functional clocks. How else can drivers calculate timings?
> > > 
> > > 
> > > Please see Russell King's comments,
> > > 
> > > [1] http://permalink.gmane.org/gmane.linux.ports.ppc.embedded/27634
> > > [2] http://www.mail-archive.com/linux-samsung-soc@vger.kernel.org/msg05365.html
> > 
> > Thanks. So I still think you need to get rid of the global variable for
> > storing the gpmc fclk, that is really my point.
> > 
> > So if you look at commit [1] mentioned by Russell in the above thread,
> > the appropriate thing to do would be to create a gpmc clock alias for
> > all OMAP2+ devices and then you could simply call the following from the
> > gpmc probe ...
> > 
> > 	gpmc_fck = clk_get(&pdev->dev, "fck");
> > 
> > You could then store somewhere in one of the gpmc structures.
> 
> Here clock is required even before driver is probed, i.e for platform to
> calculate timings, that has to be passed through platform data.

Eventually we should be able to move the gpmc registration to the driver
probe, especially with device tree. There's no need to set up gpmc
before the driver probe runs for the device using gpmc. Just how the
gpmc init gets called from the driver probe is still a bit open though..
It may require some bus level hooks, or wrapper drivers for the generic
device drivers like smsc911x.
 
> I understand the necessity for clk rate information in driver, but seems
> unless we have a generic way to scale timings for all the kinds of
> peripheral, having it may not be of much help.

We should not need to pass clock handles around. It's better to
export some helper functions in the gpmc code for the calculation.

Regards,

Tony
