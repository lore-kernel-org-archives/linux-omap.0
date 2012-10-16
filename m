From: Tony Lindgren <tony@atomide.com>
Subject: Re: Errors at boot time from OMAP4430SDP (and a whinge about
 serial stuff)
Date: Tue, 16 Oct 2012 11:12:53 -0700
Message-ID: <20121016181252.GE15569@atomide.com>
References: <20121012155434.GO28061@n2100.arm.linux.org.uk>
 <20121012162452.GD30339@atomide.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E9FCAAF@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:18157 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755367Ab2JPSM4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Oct 2012 14:12:56 -0400
Content-Disposition: inline
In-Reply-To: <C8443D0743D26F4388EA172BF4E2A7A93E9FCAAF@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Mohammed, Afzal" <afzal@ti.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>, "Hilman, Kevin" <khilman@ti.com>, Ohad Ben-Cohen <ohad@wizery.com>, "Ujfalusi, Peter" <peter.ujfalusi@ti.com>

* Mohammed, Afzal <afzal@ti.com> [121014 23:00]:
> Hi,
> 
> On Fri, Oct 12, 2012 at 21:54:52, Tony Lindgren wrote:
> > * Russell King - ARM Linux <linux@arm.linux.org.uk> [121012 08:56]:
> 
> > > omap-gpmc omap-gpmc: error: clk_get
> > > omap-gpmc: probe of omap-gpmc failed with error -2
> > 
> > I think Afzal posted something about this already? Looks
> > like this too could be sparse IRQ related regression..
> 
> Patch has been posted to resolve the issue,
> "ARM: OMAP4: hwmod data: gpmc main clk".

OK thanks I'll pick that up.

Regards,

Tony
