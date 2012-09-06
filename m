From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH RESEND 3/4] ARM: AM33XX: board-generic: Add
 of_dev_auxdata to pass d_can raminit
Date: Thu, 6 Sep 2012 05:07:02 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A83EAAAE99@DBDE01.ent.ti.com>
References: <1346843564-25343-1-git-send-email-anilkumar@ti.com>
 <1346843564-25343-4-git-send-email-anilkumar@ti.com>
 <20120905231837.GI1303@atomide.com> <50481ED7.7050409@ti.com>
 <B5906170F1614E41A8A28DE3B8D121433EB63557@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <B5906170F1614E41A8A28DE3B8D121433EB63557@DBDE01.ent.ti.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "Bedia, Vaibhav" <vaibhav.bedia@ti.com>, Tony Lindgren <tony@atomide.com>
Cc: Paul Walmsley <paul@pwsan.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "mkl@pengutronix.de" <mkl@pengutronix.de>, "wg@grandegger.com" <wg@grandegger.com>, "AnilKumar,
 Chimata" <anilkumar@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Thu, Sep 06, 2012 at 10:33:32, Bedia, Vaibhav wrote:
> On Thu, Sep 06, 2012 at 09:26:07, Hiremath, Vaibhav wrote:
> > 
> > 
> > On 9/6/2012 4:48 AM, Tony Lindgren wrote:
> > > Hi,
> > > 
> > > * AnilKumar Ch <anilkumar@ti.com> [120905 04:14]:
> > >> Add of_dev_auxdata to pass d_can raminit callback APIs to initialize
> > >> d_can RAM. D_CAN RAM initialization bits are present in CONTROL module
> > >> address space, which can be accessed by platform specific code. So
> > >> callback functions are added to serve this purpose, this can done by
> > >> using of_dev_auxdata.
> > >>
> > >> Two callback APIs are added to of_dev_auxdata used by two instances of
> > >> D_CAN IP. These callback functions are used to enable/disable D_CAN RAM
> > >> from CAN driver.
> > > 
> > > I'd like to avoid the callbacks to the platform code where possible as
> > > that's the biggest pain we already have moving things to work with device
> > > tree for the existing drivers.
> > > 
> > > And I'm pretty convinced that whatever is done with callbacks should be
> > > done with some Linux generic framework from the driver that has it's own
> > > binding, such as clock framework, regulator framework, pinctrl framework,
> > > runtime PM etc.
> > > 
> > >> --- a/arch/arm/mach-omap2/board-generic.c
> > >> +++ b/arch/arm/mach-omap2/board-generic.c
> > >> @@ -37,11 +40,46 @@ static struct of_device_id omap_dt_match_table[] __initdata = {
> > >>  	{ }
> > >>  };
> > >>  
> > >> +void d_can_hw_raminit(unsigned int instance, bool enable)
> > >> +{
> > >> +	u32 val;
> > >> +
> > >> +	val = readl(AM33XX_CTRL_REGADDR(AM33XX_CONTROL_DCAN_RAMINIT));
> > >> +	if (enable) {
> > >> +		val &= ~AM33XX_DCAN_RAMINIT_START_MASK(instance);
> > >> +		val |= AM33XX_DCAN_RAMINIT_START_MASK(instance);
> > >> +		writel(val, AM33XX_CTRL_REGADDR(AM33XX_CONTROL_DCAN_RAMINIT));
> > >> +	} else {
> > >> +		val &= ~AM33XX_DCAN_RAMINIT_START_MASK(instance);
> > >> +		writel(val, AM33XX_CTRL_REGADDR(AM33XX_CONTROL_DCAN_RAMINIT));
> > >> +	}
> > >> +}
> > > 
> > > This part does not look good to me, this is tweaking the omap control
> > > module register bits directly. To me it seems that the above should
> > > be implemented in the omap/am33xx hwmod code that gets initialized when
> > > the dcan driver calls pm_runtime_enable()? Paul, got any other ideas?
> > > 
> > 
> > Technically yes, this is required during module enable/disable sequence.
> > But there is no way currently supported in hwmod layer. Also I am not
> > quite sure how many other modules/devices may use this.
> > 
> 
> It should be possible to do this by providing custom activate/deactivate
> functions similar to what was done for EMAC on AM35x [1].
> 

Still didn't make it to mainline :)

> However, right now on DT based systems omap_device_alloc() is called without
> any pm_lats
> 
> 	od = omap_device_alloc(pdev, hwmods, oh_cnt, NULL, 0);
> 
> The function pointers from the of_dev_auxdata somehow needs to be passed to
> omap_device_alloc().
> 

It is doable, and I believe it is the only option we have currently unless 
we add something newly.


Thanks,
Vaibhav
> Regards,
> Vaibhav B.
> 
> > Couple of more examples I have here,
> > 
> > In case of AM3517 we have similar SoC integration, where VPFE, MAC and
> > USB required clock control (handled by clock-tree) and interrupt status
> > (handled by callbacks) from control module.
> > So not sure whether we can get rid of callbacks until we have control
> > module MFD driver (on which Konstantin is working on)
> > 
> > Thanks,
> > Vaibhav
> > 
> > > Regards,
> > > 
> > > Tony
> > > 
> > > _______________________________________________
> > > linux-arm-kernel mailing list
> > > linux-arm-kernel@lists.infradead.org
> > > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> > > 
> > 
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> > 
> 
> 
