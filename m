From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 6/7] OMAP3: board-dt: Add generic board file for DT
 support
Date: Fri, 2 Sep 2011 15:32:14 +0300
Message-ID: <20110902123213.GV3548@atomide.com>
References: <1314897912-18178-1-git-send-email-b-cousson@ti.com>
 <1314897912-18178-7-git-send-email-b-cousson@ti.com>
 <20110902080944.GP3548@atomide.com>
 <4E609800.9090402@ti.com>
 <20110902104330.GR3548@atomide.com>
 <4E60C174.50604@ti.com>
 <20110902115733.GU3548@atomide.com>
 <4E60C9FF.9050608@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:21317 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751047Ab1IBMcT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 2 Sep 2011 08:32:19 -0400
Content-Disposition: inline
In-Reply-To: <4E60C9FF.9050608@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: "grant.likely@secretlab.ca" <grant.likely@secretlab.ca>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "G, Manjunath Kondaiah" <manjugk@ti.com>

* Cousson, Benoit <b-cousson@ti.com> [110902 14:47]:
> >         .tap    = OMAP2_L4_IO_ADDRESS(0x4900a000),
> 
> BTW, how can we get rid of that OMAP2_L4_IO_ADDRESS?

That needs to be mapped early for SoC detection to work
for cpu_is_omapxxxx stuff :(
 
> In fact only the tap should be required at map_io time to get the
> DEVICE_ID, I guess that the others entries could be retrieve later?

Yes well whatever needs to be mapped early for the SoC
revision detection. It could be that we can map timers
and serial port only early, then set up the mappings for
the rest later on. That is if we can avoid SoC and revision
detection early.

Tony
