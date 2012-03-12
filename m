From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH 1/3] ARM: OMAP2+: 32k-counter: Use hwmod lookup to check
 presence of 32k timer
Date: Mon, 12 Mar 2012 09:48:20 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A831810E32@DBDE01.ent.ti.com>
References: <1326983304-14619-1-git-send-email-hvaibhav@ti.com>
 <1326983304-14619-2-git-send-email-hvaibhav@ti.com>
 <20120305225530.GJ12083@atomide.com>
 <79CD15C6BA57404B839C016229A409A83180F73D@DBDE01.ent.ti.com>
 <20120312093921.GA5375@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:49867 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750781Ab2CLJs5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 12 Mar 2012 05:48:57 -0400
In-Reply-To: <20120312093921.GA5375@legolas.emea.dhcp.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Balbi, Felipe" <balbi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "marc.zyngier@arm.com" <marc.zyngier@arm.com>, "johnstul@us.ibm.com" <johnstul@us.ibm.com>, "Cousson, Benoit" <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>, "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>

On Mon, Mar 12, 2012 at 15:09:24, Balbi, Felipe wrote:
> On Fri, Mar 09, 2012 at 05:58:00PM +0000, Hiremath, Vaibhav wrote:
> > On Tue, Mar 06, 2012 at 04:25:30, Tony Lindgren wrote:
> > > Hi,
> > > 
> > > * Vaibhav Hiremath <hvaibhav@ti.com> [120119 06:01]:
> > > > OMAP device has 32k-sync timer which is currently used as a
> > > > clocksource in the kernel (omap2plus_defconfig).
> > > > The current implementation uses compile time selection between
> > > > gp-timer and 32k-sync timer, which breaks multi-omap build for
> > > > the devices like AM33xx, where 32k-sync timer is not available.
> > > > 
> > > > So use hwmod database lookup mechanism, through which at run-time
> > > > we can identify availability of 32k-sync timer on the device,
> > > > else fall back to gp-timer.
> > > ...
> > > 
> > > > --- a/arch/arm/plat-omap/counter_32k.c
> > > > +++ b/arch/arm/plat-omap/counter_32k.c
> > > > @@ -69,52 +69,55 @@ void read_persistent_clock(struct timespec *ts)
> > > >  
> > > >  int __init omap_init_clocksource_32k(void)
> > > >  {
> > > > -	static char err[] __initdata = KERN_ERR
> > > > -			"%s: can't register clocksource!\n";
> > > > -
> > > > -	if (cpu_is_omap16xx() || cpu_class_is_omap2()) {
> > > > -		u32 pbase;
> > > > -		unsigned long size = SZ_4K;
> > > > -		void __iomem *base;
> > > > -		struct clk *sync_32k_ick;
> > > > -
> > > > -		if (cpu_is_omap16xx()) {
> > > > -			pbase = OMAP16XX_TIMER_32K_SYNCHRONIZED;
> > > > -			size = SZ_1K;
> > > > -		} else if (cpu_is_omap2420())
> > > > -			pbase = OMAP2420_32KSYNCT_BASE + 0x10;
> > > > -		else if (cpu_is_omap2430())
> > > > -			pbase = OMAP2430_32KSYNCT_BASE + 0x10;
> > > > -		else if (cpu_is_omap34xx())
> > > > -			pbase = OMAP3430_32KSYNCT_BASE + 0x10;
> > > > -		else if (cpu_is_omap44xx())
> > > > -			pbase = OMAP4430_32KSYNCT_BASE + 0x10;
> > > > -		else
> > > > +	u32 pbase;
> > > > +	unsigned long size = SZ_4K;
> > > > +	void __iomem *base;
> > > > +	struct clk *sync_32k_ick;
> > > > +
> > > > +	if (cpu_is_omap16xx()) {
> > > > +		pbase = OMAP16XX_TIMER_32K_SYNCHRONIZED;
> > > > +		size = SZ_1K;
> > > > +	} else if (cpu_class_is_omap2()) {
> > > > +		struct omap_hwmod *oh;
> > > > +		const char *oh_name = "counter_32k";
> > > > +
> > > > +		oh = omap_hwmod_lookup(oh_name);
> > > > +		if (!oh || oh->slaves_cnt == 0) {
> > > > +			pr_err("Could not lookup %s hwmod\n", oh_name);
> > > >  			return -ENODEV;
> > > > +		}
> > > > +		pbase = oh->slaves[0]->addr->pa_start + 0x10;
> > > > +	} else {
> > > > +		return -ENODEV;
> > > > +	}
> > > 
> > > How about have separate omap1 and omap2+ init functions that
> > > call a common function and passes the pbase as a parameter?
> > > 
> > > That way we can get rid of the cpu_is_omapxxxx tests here.
> > > 
> > 
> > Tony,
> > 
> > In the morning, I replied very soon, without much thinking...
> > 
> > Just now I started working on the patch, I was just reviewing the code, 
> > and I felt that, it is unnecessary to split the code between omap1 and 
> > omap2+.
> > 
> > The reason is,
> > 
> > Currently Only OMAP16xx base-address is hardcoded with
> > cpu_is_omap16xx() macro, For all other omap family of devices the
> > complete information is fetched from HWDMO api's/data.
> 
> In that case, why don't you create the platform_device by hand on
> arch/arm/mach-omap1/devices.c and move the omap2+ (which is based on
> hwmod) to arch/arm/mach-omap2/devices.c ?
> 

Balbi,

32k_counter code is not a platform_device/driver, we don't build the 
any device here. We only need hwmod data to fetch the basic information like, 
base-address, size, etc...

And I am note sure whether we really intend to make it 
platform_device/driver thing.

Thanks,
Vaibhav

> -- 
> balbi
> 

