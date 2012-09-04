From: "AnilKumar, Chimata" <anilkumar@ti.com>
Subject: RE: [PATCH 3/4] ARM: AM33XX: board-generic: Add of_dev_auxdata to
 pass d_can raminit
Date: Tue, 4 Sep 2012 06:26:56 +0000
Message-ID: <331ABD5ECB02734CA317220B2BBEABC13EA26346@DBDE01.ent.ti.com>
References: <1346673139-14540-1-git-send-email-anilkumar@ti.com>
 <1346673139-14540-4-git-send-email-anilkumar@ti.com>
 <50450EE2.3000107@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <50450EE2.3000107@pengutronix.de>
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
To: Marc Kleine-Budde <mkl@pengutronix.de>, "tony@atomide.com" <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "wg@grandegger.com" <wg@grandegger.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Tue, Sep 04, 2012 at 01:41:14, Marc Kleine-Budde wrote:
> On 09/03/2012 01:52 PM, AnilKumar Ch wrote:
> > Add of_dev_auxdata to pass d_can raminit callback APIs to initialize
> > d_can RAM. D_CAN RAM initialization bits are present in CONTROL module
> > address space, which can be accessed by platform specific code. So
> > callback functions are added to serve this purpose, this can done by
> > using of_dev_auxdata.
> > 
> > Callback API is added to of_dev_auxdata with different instance numbers
> > for two instances of D_CAN IP. These callback functions are used to
> > enable/disable D_CAN RAM from CAN driver.
> > 
> > Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
> 
> This will be a more complicated. This patch will go over the arm tree,
> but needs a header going via net.
> 

Marc,

I agree this is a bit complicated but this has to go along with
this patch series otherwise build will break. If there are no
changes required I will request Tony to ack it.

Tony,

If there are no changes required, could you please ack this patch
so that this will go to linux-can tree.

Thanks
AnilKumar

> 
> > ---
> >  arch/arm/mach-omap2/board-generic.c |   40 ++++++++++++++++++++++++++++++++++-
> >  arch/arm/mach-omap2/control.h       |    4 ++++
> >  2 files changed, 43 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm/mach-omap2/board-generic.c b/arch/arm/mach-omap2/board-generic.c
> > index 6f93a20..b68e642 100644
> > --- a/arch/arm/mach-omap2/board-generic.c
> > +++ b/arch/arm/mach-omap2/board-generic.c
> > @@ -15,6 +15,7 @@
> >  #include <linux/of_irq.h>
> >  #include <linux/of_platform.h>
> >  #include <linux/irqdomain.h>
> > +#include <linux/can/platform/c_can.h>
> >  
> >  #include <mach/hardware.h>
> >  #include <asm/hardware/gic.h>
> > @@ -22,6 +23,8 @@
> >  
> >  #include <plat/board.h>
> >  #include "common.h"
> > +#include "control.h"
> > +#include "iomap.h"
> >  #include "common-board-devices.h"
> >  
> >  #if !(defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3))
> > @@ -37,11 +40,46 @@ static struct of_device_id omap_dt_match_table[] __initdata = {
> >  	{ }
> >  };
> >  
> > +void d_can_hw_raminit(unsigned int instance, bool enable)
> > +{
> > +	u32 val;
> > +
> > +	val = readl(AM33XX_CTRL_REGADDR(AM33XX_CONTROL_DCAN_RAMINIT));
> > +	if (enable) {
> > +		val &= ~AM33XX_DCAN_RAMINIT_START_MASK(instance);
> > +		val |= AM33XX_DCAN_RAMINIT_START_MASK(instance);
> > +		writel(val, AM33XX_CTRL_REGADDR(AM33XX_CONTROL_DCAN_RAMINIT));
> > +	} else {
> > +		val &= ~AM33XX_DCAN_RAMINIT_START_MASK(instance);
> > +		writel(val, AM33XX_CTRL_REGADDR(AM33XX_CONTROL_DCAN_RAMINIT));
> > +	}
> > +}
> > +
> > +static struct c_can_platform_data d_can0_pdata = {
> > +	.ram_init	= d_can_hw_raminit,
> > +	.instance	= 0,
> > +};
> > +
> > +static struct c_can_platform_data d_can1_pdata = {
> > +	.ram_init	= d_can_hw_raminit,
> > +	.instance	= 1,
> > +};
> > +
> > +static const struct of_dev_auxdata am33xx_auxdata_lookup[] __initconst = {
> > +	OF_DEV_AUXDATA("bosch,d_can", 0x481cc000, NULL, &d_can0_pdata),
> > +	OF_DEV_AUXDATA("bosch,d_can", 0x481d0000, NULL, &d_can1_pdata),
> > +	{ },
> > +};
> > +
> >  static void __init omap_generic_init(void)
> >  {
> >  	omap_sdrc_init(NULL, NULL);
> >  
> > -	of_platform_populate(NULL, omap_dt_match_table, NULL, NULL);
> > +	if (of_machine_is_compatible("ti,am33xx"))
> > +		of_platform_populate(NULL, omap_dt_match_table,
> > +				am33xx_auxdata_lookup, NULL);
> > +	else
> > +		of_platform_populate(NULL, omap_dt_match_table, NULL, NULL);
> >  }
> >  
> >  #ifdef CONFIG_SOC_OMAP2420
> > diff --git a/arch/arm/mach-omap2/control.h b/arch/arm/mach-omap2/control.h
> > index b8cdc85..afd189b 100644
> > --- a/arch/arm/mach-omap2/control.h
> > +++ b/arch/arm/mach-omap2/control.h
> > @@ -356,6 +356,10 @@
> >  #define AM33XX_CONTROL_STATUS_SYSBOOT1_SHIFT		22
> >  #define AM33XX_CONTROL_STATUS_SYSBOOT1_MASK		(0x3 << 22)
> >  
> > +/* AM33XX DCAN bitfields */
> > +#define AM33XX_CONTROL_DCAN_RAMINIT		0x644
> > +#define AM33XX_DCAN_RAMINIT_START_MASK(i)	(1 << (i))
> > +
> >  /* CONTROL OMAP STATUS register to identify OMAP3 features */
> >  #define OMAP3_CONTROL_OMAP_STATUS	0x044c
> >  
> > 
> 
> 
> -- 
> Pengutronix e.K.                  | Marc Kleine-Budde           |
> Industrial Linux Solutions        | Phone: +49-231-2826-924     |
> Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
> Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |
> 
> 
