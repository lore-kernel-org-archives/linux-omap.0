From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC PATCH 1/5] arm:omap1/2/3/4:Convert 32k-Sync clocksource
 driver to platform_driver
Date: Thu, 19 Jan 2012 05:09:26 -0800
Message-ID: <20120119130926.GF22818@atomide.com>
References: <1326886086-27313-1-git-send-email-hvaibhav@ti.com>
 <1326886086-27313-2-git-send-email-hvaibhav@ti.com>
 <20120118115952.GM16726@n2100.arm.linux.org.uk>
 <79CD15C6BA57404B839C016229A409A8317A9AA2@DBDE01.ent.ti.com>
 <20120118141147.GN16726@n2100.arm.linux.org.uk>
 <4F16D66F.2000602@arm.com>
 <79CD15C6BA57404B839C016229A409A8317A9C39@DBDE01.ent.ti.com>
 <4F16DB10.8060806@arm.com>
 <20120118145032.GO16726@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:21779 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752782Ab2ASNJj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 19 Jan 2012 08:09:39 -0500
Content-Disposition: inline
In-Reply-To: <20120118145032.GO16726@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Marc Zyngier <marc.zyngier@arm.com>, "Hiremath, Vaibhav" <hvaibhav@ti.com>, "Hilman, Kevin" <khilman@ti.com>, "paul@pwsan.com" <paul@pwsan.com>, "Cousson, Benoit" <b-cousson@ti.com>, "johnstul@us.ibm.com" <johnstul@us.ibm.com>, "Balbi, Felipe" <balbi@ti.com>, "tglx@linutronix.de" <tglx@linutronix.de>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

* Russell King - ARM Linux <linux@arm.linux.org.uk> [120118 06:18]:
> On Wed, Jan 18, 2012 at 02:45:36PM +0000, Marc Zyngier wrote:
> > Can't you instead use the ARM sched_clock framework?
> 
> OMAP does, and has done for quite some time.  The problem is these
> patches are against an old kernel.

Additionally we're already handling the 32k timer or not case already
on omap1 as it does not exist on 1510, so there should only minimal
patching needed AFAIK.

Tony
