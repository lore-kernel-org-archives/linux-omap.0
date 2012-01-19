From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [RFC PATCH 1/5] arm:omap1/2/3/4:Convert 32k-Sync clocksource
 driver to platform_driver
Date: Thu, 19 Jan 2012 13:30:52 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A8317AB17D@DBDE01.ent.ti.com>
References: <1326886086-27313-1-git-send-email-hvaibhav@ti.com>
 <1326886086-27313-2-git-send-email-hvaibhav@ti.com>
 <20120118115952.GM16726@n2100.arm.linux.org.uk>
 <79CD15C6BA57404B839C016229A409A8317A9AA2@DBDE01.ent.ti.com>
 <20120118141147.GN16726@n2100.arm.linux.org.uk> <4F16D66F.2000602@arm.com>
 <79CD15C6BA57404B839C016229A409A8317A9C39@DBDE01.ent.ti.com>
 <4F16DB10.8060806@arm.com> <20120118145032.GO16726@n2100.arm.linux.org.uk>
 <20120119130926.GF22818@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:50474 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751193Ab2ASNbX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 19 Jan 2012 08:31:23 -0500
In-Reply-To: <20120119130926.GF22818@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Marc Zyngier <marc.zyngier@arm.com>, "Hilman, Kevin" <khilman@ti.com>, "paul@pwsan.com" <paul@pwsan.com>, "Cousson, Benoit" <b-cousson@ti.com>, "johnstul@us.ibm.com" <johnstul@us.ibm.com>, "Balbi, Felipe" <balbi@ti.com>, "tglx@linutronix.de" <tglx@linutronix.de>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Thu, Jan 19, 2012 at 18:39:26, Tony Lindgren wrote:
> * Russell King - ARM Linux <linux@arm.linux.org.uk> [120118 06:18]:
> > On Wed, Jan 18, 2012 at 02:45:36PM +0000, Marc Zyngier wrote:
> > > Can't you instead use the ARM sched_clock framework?
> > 
> > OMAP does, and has done for quite some time.  The problem is these
> > patches are against an old kernel.
> 
> Additionally we're already handling the 32k timer or not case already
> on omap1 as it does not exist on 1510, so there should only minimal
> patching needed AFAIK.
> 

Tony,

All this is handled using cpu_is_omapxxxx() checks, something like,

int __init omap_init_clocksource_32k(void) {
	...

	if (cpu_is_omap16xx() || cpu_class_is_omap2()) {
	...
	...
	...

	}
}

This will not help for omap2/3+ devices.

I have cleaned up the code and about to submit it, please review
it and provide the comments.

Submitting shortly...

Thanks,
Vaibhav
> Tony
> 

