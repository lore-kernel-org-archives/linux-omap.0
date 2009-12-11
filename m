From: <kalle.jokiniemi@nokia.com>
Subject: RE: [PATCH] OMAP: I2C: Add mpu wake up latency constraint in i2c
Date: Fri, 11 Dec 2009 11:46:48 +0100
Message-ID: <E839BB5467CE1640B3CC2F90F647A52C274AEA8509@NOK-EUMSG-02.mgdnok.nokia.com>
References: <1259172229-25386-1-git-send-email-kalle.jokiniemi@nokia.com>
 <E839BB5467CE1640B3CC2F90F647A52C274A0E73AB@NOK-EUMSG-02.mgdnok.nokia.com>
 <alpine.DEB.2.00.0911300023120.17083@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:53034 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760928AbZLKKrE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 Dec 2009 05:47:04 -0500
In-Reply-To: <alpine.DEB.2.00.0911300023120.17083@utopia.booyaka.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com, ben-linux@fluff.org
Cc: linux-i2c@vger.kernel.org, linux-omap@vger.kernel.org, peter.ujfalusi@nokia.com, jouni.hogander@nokia.com, khilman@deeprootsystems.com, kalle.jokiniemi@digia.com, m-sonasath@ti.com, jhnikula@gmail.com, nm@ti.com

Hi Ben,

What's the status on this one? Have you had time to check it out?

- Kalle


> -----Original Message-----
> From: ext Paul Walmsley [mailto:paul@pwsan.com] 
> Sent: 30. marraskuuta 2009 9:24
> To: Jokiniemi Kalle (Nokia-D/Tampere)
> Cc: ben-linux@fluff.org; linux-i2c@vger.kernel.org; 
> linux-omap@vger.kernel.org; Ujfalusi Peter (Nokia-D/Tampere); 
> Hogander Jouni (Nokia-D/Tampere); 
> khilman@deeprootsystems.com; kalle.jokiniemi@digia.com; 
> m-sonasath@ti.com; jhnikula@gmail.com; nm@ti.com
> Subject: RE: [PATCH] OMAP: I2C: Add mpu wake up latency 
> constraint in i2c
> 
> Hi Ben, Kalle,
> 
> On Thu, 26 Nov 2009, kalle.jokiniemi@nokia.com wrote:
> 
> > Could you take this patch to i2c tree? The patch has been 
> discussed in linux-omap list, and this version was the one 
> that was agreed to pushed forward.
> > 
> > http://marc.info/?l=linux-omap&m=125907598412786&w=2
> > 
> > 
> > I tried it on top of linus' tree and it applied fine. 
> 
> Reviewed-by: Paul Walmsley <paul@pwsan.com>
> 
> Looks good to me.
> 
> - Paul
> 
> 
> > 
> > - Kalle
> > 
> > 
> > > -----Original Message-----
> > > From: linux-omap-owner@vger.kernel.org 
> > > [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Jokiniemi 
> > > Kalle (Nokia-D/Tampere)
> > > Sent: 25. marraskuuta 2009 20:04
> > > To: ben-linux@fluff.org; linux-i2c@vger.kernel.org
> > > Cc: linux-omap@vger.kernel.org; Ujfalusi Peter (Nokia-D/Tampere); 
> > > Hogander Jouni (Nokia-D/Tampere); 
> khilman@deeprootsystems.com; ext 
> > > Kalle Jokiniemi; Moiz Sonasath; Jarkko Nikula; Paul Walmsley; 
> > > Nishanth Menon
> > > Subject: [PATCH] OMAP: I2C: Add mpu wake up latency constraint in 
> > > i2c
> > > 
> > > From: ext Kalle Jokiniemi <kalle.jokiniemi@digia.com>
> > > 
> > > While waiting for completion of the i2c transfer, the MPU 
> could hit 
> > > OFF mode and cause several msecs of delay that made i2c transfers 
> > > fail more often. The extra delays and subsequent re-trys 
> cause i2c 
> > > clocks to be active more often.
> > > This has also an negative effect on power consumption.
> > > 
> > > Created a mechanism for passing and using the constraint setting 
> > > function in driver code. The used mpu wake up latency constraints 
> > > are now set individually per bus, and they are calculated 
> based on 
> > > clock rate and fifo size.
> > > 
> > > Thanks to Jarkko Nikula, Moiz Sonasath, Paul Walmsley, 
> and Nishanth 
> > > Menon for tuning out the details of this patch.
> > > 
> > > Cc: Moiz Sonasath <m-sonasath@ti.com>
> > > Cc: Jarkko Nikula <jhnikula@gmail.com>
> > > Cc: Paul Walmsley <paul@pwsan.com>
> > > Cc: Nishanth Menon <nm@ti.com>
> > > Signed-off-by: Kalle Jokiniemi <kalle.jokiniemi@digia.com>
> > > ---
> > >  arch/arm/plat-omap/i2c.c      |   54 
> > > +++++++++++++++++++++++++++++++---------
> > >  drivers/i2c/busses/i2c-omap.c |   25 ++++++++++++++++---
> > >  include/linux/i2c-omap.h      |    9 +++++++
> > >  3 files changed, 72 insertions(+), 16 deletions(-)  create mode 
> > > 100644 include/linux/i2c-omap.h
> > > 
> > > diff --git a/arch/arm/plat-omap/i2c.c b/arch/arm/plat-omap/i2c.c 
> > > index 8b84839..3c122cd 100644
> > > --- a/arch/arm/plat-omap/i2c.c
> > > +++ b/arch/arm/plat-omap/i2c.c
> > > @@ -26,8 +26,10 @@
> > >  #include <linux/kernel.h>
> > >  #include <linux/platform_device.h>
> > >  #include <linux/i2c.h>
> > > +#include <linux/i2c-omap.h>
> > >  #include <mach/irqs.h>
> > >  #include <mach/mux.h>
> > > +#include <mach/omap-pm.h>
> > >  
> > >  #define OMAP_I2C_SIZE		0x3f
> > >  #define OMAP1_I2C_BASE		0xfffb3800
> > > @@ -69,14 +71,14 @@ static struct resource i2c_resources[][2] = {
> > >  		},					\
> > >  	}
> > >  
> > > -static u32 i2c_rate[ARRAY_SIZE(i2c_resources)];
> > > +static struct omap_i2c_bus_platform_data 
> > > +i2c_pdata[ARRAY_SIZE(i2c_resources)];
> > >  static struct platform_device omap_i2c_devices[] = {
> > > -	I2C_DEV_BUILDER(1, i2c_resources[0], &i2c_rate[0]),
> > > +	I2C_DEV_BUILDER(1, i2c_resources[0], &i2c_pdata[0]),
> > >  #if	defined(CONFIG_ARCH_OMAP24XX) || 
> defined(CONFIG_ARCH_OMAP34XX)
> > > -	I2C_DEV_BUILDER(2, i2c_resources[1], &i2c_rate[1]),
> > > +	I2C_DEV_BUILDER(2, i2c_resources[1], &i2c_pdata[1]),
> > >  #endif
> > >  #if	defined(CONFIG_ARCH_OMAP34XX)
> > > -	I2C_DEV_BUILDER(3, i2c_resources[2], &i2c_rate[2]),
> > > +	I2C_DEV_BUILDER(3, i2c_resources[2], &i2c_pdata[2]),
> > >  #endif
> > >  };
> > >  
> > > @@ -100,6 +102,31 @@ static const int omap34xx_pins[][2] = {};
> > >  
> > >  #define OMAP_I2C_CMDLINE_SETUP	(BIT(31))
> > >  
> > > +#ifdef CONFIG_ARCH_OMAP34XX
> > > +/*
> > > + * omap_i2c_set_wfc_mpu_wkup_lat - sets mpu wake up constraint
> > > + * @dev:	i2c bus device pointer
> > > + * @val:	latency constraint to set, -1 to disable constraint
> > > + *
> > > + * When waiting for completion of a i2c transfer, we need to
> > > set a wake
> > > +up
> > > + * latency constraint for the MPU. This is to ensure 
> quick enough 
> > > +wakeup from
> > > + * idle, when transfer completes.
> > > + */
> > > +static void omap_i2c_set_wfc_mpu_wkup_lat(struct device
> > > *dev, int val)
> > > +{
> > > +	omap_pm_set_max_mpu_wakeup_lat(dev, val); } #endif
> > > +
> > > +static void __init omap_set_i2c_constraint_func(
> > > +				struct omap_i2c_bus_platform_data *pd) {
> > > +	if (cpu_is_omap34xx())
> > > +		pd->set_mpu_wkup_lat = omap_i2c_set_wfc_mpu_wkup_lat;
> > > +	else
> > > +		pd->set_mpu_wkup_lat = NULL;
> > > +}
> > > +
> > >  static void __init omap_i2c_mux_pins(int bus)  {
> > >  	int scl, sda;
> > > @@ -180,8 +207,8 @@ static int __init 
> omap_i2c_bus_setup(char *str)
> > >  	get_options(str, 3, ints);
> > >  	if (ints[0] < 2 || ints[1] < 1 || ints[1] > ports)
> > >  		return 0;
> > > -	i2c_rate[ints[1] - 1] = ints[2];
> > > -	i2c_rate[ints[1] - 1] |= OMAP_I2C_CMDLINE_SETUP;
> > > +	i2c_pdata[ints[1] - 1].clkrate = ints[2];
> > > +	i2c_pdata[ints[1] - 1].clkrate |= OMAP_I2C_CMDLINE_SETUP;
> > >  
> > >  	return 1;
> > >  }
> > > @@ -195,9 +222,10 @@ static int __init
> > > omap_register_i2c_bus_cmdline(void)
> > >  {
> > >  	int i, err = 0;
> > >  
> > > -	for (i = 0; i < ARRAY_SIZE(i2c_rate); i++)
> > > -		if (i2c_rate[i] & OMAP_I2C_CMDLINE_SETUP) {
> > > -			i2c_rate[i] &= ~OMAP_I2C_CMDLINE_SETUP;
> > > +	for (i = 0; i < ARRAY_SIZE(i2c_pdata); i++)
> > > +		if (i2c_pdata[i].clkrate & OMAP_I2C_CMDLINE_SETUP) {
> > > +			i2c_pdata[i].clkrate &= ~OMAP_I2C_CMDLINE_SETUP;
> > > +			omap_set_i2c_constraint_func(&i2c_pdata[i]);
> > >  			err = omap_i2c_add_bus(i + 1);
> > >  			if (err)
> > >  				goto out;
> > > @@ -231,9 +259,11 @@ int __init omap_register_i2c_bus(int bus_id, 
> > > u32 clkrate,
> > >  			return err;
> > >  	}
> > >  
> > > -	if (!i2c_rate[bus_id - 1])
> > > -		i2c_rate[bus_id - 1] = clkrate;
> > > -	i2c_rate[bus_id - 1] &= ~OMAP_I2C_CMDLINE_SETUP;
> > > +	if (!i2c_pdata[bus_id - 1].clkrate)
> > > +		i2c_pdata[bus_id - 1].clkrate = clkrate;
> > > +
> > > +	omap_set_i2c_constraint_func(&i2c_pdata[bus_id - 1]);
> > > +	i2c_pdata[bus_id - 1].clkrate &= ~OMAP_I2C_CMDLINE_SETUP;
> > >  
> > >  	return omap_i2c_add_bus(bus_id);
> > >  }
> > > diff --git a/drivers/i2c/busses/i2c-omap.c 
> > > b/drivers/i2c/busses/i2c-omap.c index 827da08..ac0bfd2 100644
> > > --- a/drivers/i2c/busses/i2c-omap.c
> > > +++ b/drivers/i2c/busses/i2c-omap.c
> > > @@ -37,6 +37,7 @@
> > >  #include <linux/platform_device.h>
> > >  #include <linux/clk.h>
> > >  #include <linux/io.h>
> > > +#include <linux/i2c-omap.h>
> > >  
> > >  /* I2C controller revisions */
> > >  #define OMAP_I2C_REV_2			0x20
> > > @@ -165,6 +166,9 @@ struct omap_i2c_dev {
> > >  	struct clk		*fclk;		/* Functional clock */
> > >  	struct completion	cmd_complete;
> > >  	struct resource		*ioarea;
> > > +	u32			latency;	/* maximum mpu 
> > > wkup latency */
> > > +	void			(*set_mpu_wkup_lat)(struct device *dev,
> > > +						    int latency);
> > >  	u32			speed;		/* Speed of bus 
> > > in Khz */
> > >  	u16			cmd_err;
> > >  	u8			*buf;
> > > @@ -508,8 +512,12 @@ static int omap_i2c_xfer_msg(struct 
> i2c_adapter 
> > > *adap,
> > >  	 * REVISIT: We should abort the transfer on signals, 
> but the bus 
> > > goes
> > >  	 * into arbitration and we're currently unable to 
> recover from it.
> > >  	 */
> > > +	if (dev->set_mpu_wkup_lat != NULL)
> > > +		dev->set_mpu_wkup_lat(dev->dev, dev->latency);
> > >  	r = wait_for_completion_timeout(&dev->cmd_complete,
> > >  					OMAP_I2C_TIMEOUT);
> > > +	if (dev->set_mpu_wkup_lat != NULL)
> > > +		dev->set_mpu_wkup_lat(dev->dev, -1);
> > >  	dev->buf_len = 0;
> > >  	if (r < 0)
> > >  		return r;
> > > @@ -826,6 +834,7 @@ omap_i2c_probe(struct platform_device *pdev)
> > >  	struct omap_i2c_dev	*dev;
> > >  	struct i2c_adapter	*adap;
> > >  	struct resource		*mem, *irq, *ioarea;
> > > +	struct omap_i2c_bus_platform_data *pdata =
> > > pdev->dev.platform_data;
> > >  	irq_handler_t isr;
> > >  	int r;
> > >  	u32 speed = 0;
> > > @@ -855,10 +864,13 @@ omap_i2c_probe(struct platform_device *pdev)
> > >  		goto err_release_region;
> > >  	}
> > >  
> > > -	if (pdev->dev.platform_data != NULL)
> > > -		speed = *(u32 *)pdev->dev.platform_data;
> > > -	else
> > > -		speed = 100;	/* Defualt speed */
> > > +	if (pdata != NULL) {
> > > +		speed = pdata->clkrate;
> > > +		dev->set_mpu_wkup_lat = pdata->set_mpu_wkup_lat;
> > > +	} else {
> > > +		speed = 100;	/* Default speed */
> > > +		dev->set_mpu_wkup_lat = NULL;
> > > +	}
> > >  
> > >  	dev->speed = speed;
> > >  	dev->idle = 1;
> > > @@ -893,6 +905,11 @@ omap_i2c_probe(struct platform_device *pdev)
> > >  		 */
> > >  		dev->fifo_size = (dev->fifo_size / 2);
> > >  		dev->b_hw = 1; /* Enable hardware fixes */
> > > +
> > > +		/* calculate wakeup latency constraint for MPU */
> > > +		if (dev->set_mpu_wkup_lat != NULL)
> > > +			dev->latency = (1000000 * dev->fifo_size) /
> > > +				       (1000 * speed / 8);
> > >  	}
> > >  
> > >  	/* reset ASAP, clearing any IRQs */ diff --git 
> > > a/include/linux/i2c-omap.h b/include/linux/i2c-omap.h new 
> file mode 
> > > 100644 index 0000000..1362fba
> > > --- /dev/null
> > > +++ b/include/linux/i2c-omap.h
> > > @@ -0,0 +1,9 @@
> > > +#ifndef __I2C_OMAP_H__
> > > +#define __I2C_OMAP_H__
> > > +
> > > +struct omap_i2c_bus_platform_data {
> > > +	u32		clkrate;
> > > +	void		(*set_mpu_wkup_lat)(struct device *dev, 
> > > int set);
> > > +};
> > > +
> > > +#endif
> > > --
> > > 1.6.3.3
> > > 
> > > --
> > > To unsubscribe from this list: send the line "unsubscribe 
> > > linux-omap" in the body of a message to majordomo@vger.kernel.org 
> > > More majordomo info at http://vger.kernel.org/majordomo-info.html
> > > 
> 
> 
> - Paul
> 