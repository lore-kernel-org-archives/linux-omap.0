From: "Sonasath, Moiz" <m-sonasath@ti.com>
Subject: RE: [PATCH 1/2] omap: Disable TWL4030/5030 I2C1/I2C4 internal
 pull-ups
Date: Wed, 17 Feb 2010 11:01:45 -0600
Message-ID: <CD8CC2B65FEE304DA95744A5472698F202D367A7B5@dlee06.ent.ti.com>
References: <1266368241-10459-1-git-send-email-m-sonasath@ti.com>
 <1266368241-10459-2-git-send-email-m-sonasath@ti.com>
 <20100217074539.GA22459@esdhcp037198.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:40458 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752835Ab0BQRBV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 17 Feb 2010 12:01:21 -0500
In-Reply-To: <20100217074539.GA22459@esdhcp037198.research.nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "eduardo.valentin@nokia.com" <eduardo.valentin@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "sameo@linux.intel.com" <sameo@linux.intel.com>, "tony@atomide.com" <tony@atomide.com>, "Pais, Allen" <allen.pais@ti.com>

Hello Eduardo,

> -----Original Message-----
> From: Eduardo Valentin [mailto:eduardo.valentin@nokia.com]
> Sent: Wednesday, February 17, 2010 1:46 AM
> To: Sonasath, Moiz
> Cc: linux-omap@vger.kernel.org; sameo@linux.intel.com; tony@atomide.com;
> Pais, Allen
> Subject: Re: [PATCH 1/2] omap: Disable TWL4030/5030 I2C1/I2C4 internal
> pull-ups
> 
> Hello Moiz,
> 
> On Wed, Feb 17, 2010 at 01:57:21AM +0100, ext Moiz Sonasath wrote:
> > This patch disables TWL4030/5030 I2C1 adn I2C4(SR) internal pull-up, to
> > use only the external HW resistor >=470 Ohm for the assured
> > functionality in HS mode.
> >
> > While testing the I2C in High Speed mode, it was discovered that
> > without a proper pull-up resistor, there is data corruption during
> > multi-byte transfer. RTC(time_set) test case was used for testing.
> 
> Nice findings!
> 
> >
> > >From the analysis done, it was concluded that ideally we need a
> > pull-up of 1.6k Ohm(recomended) or atleast 470 Ohm or greater for
> > assured performance in HS mode.
> >
> > Signed-off-by: Moiz Sonasath <m-sonasath@ti.com>
> > Signed-off-by: Allen Pais <allen.pais@ti.com>
> > ---
> >  drivers/mfd/twl-core.c  |   13 +++++++++++++
> >  include/linux/i2c/twl.h |   15 +++++++++++++++
> >  2 files changed, 28 insertions(+), 0 deletions(-)
> >
> > diff --git a/drivers/mfd/twl-core.c b/drivers/mfd/twl-core.c
> > index 2a76065..35ae2ee 100644
> > --- a/drivers/mfd/twl-core.c
> > +++ b/drivers/mfd/twl-core.c
> > @@ -965,6 +965,7 @@ twl_probe(struct i2c_client *client, const struct
> i2c_device_id *id)
> >  	int				status;
> >  	unsigned			i;
> >  	struct twl4030_platform_data	*pdata = client->dev.platform_data;
> > +	u8 temp;
> >
> >  	if (!pdata) {
> >  		dev_dbg(&client->dev, "no platform data?\n");
> > @@ -1032,6 +1033,18 @@ twl_probe(struct i2c_client *client, const struct
> i2c_device_id *id)
> >  			goto fail;
> >  	}
> >
> > +	/* Disable TWL4030/TWL5030 I2C Pull-up on I2C1 and I2C4(SR)
> interface.
> > +	 * Program I2C_SCL_CTRL_PU(bit 0)=0, I2C_SDA_CTRL_PU (bit 2)=0,
> > +	 * SR_I2C_SCL_CTRL_PU(bit 4)=0 and SR_I2C_SDA_CTRL_PU(bit 6)=0.
> > +	 */
> > +
> > +	if (twl_class_is_4030()) {
> 
> Is this run time check sufficient enough to determine if this fix must be
> applied?
> From what you have described on you patch description, looks like it is
> supposed to be
> only for HS mode. I don't know, maybe if you bind this to a platform /
> board configuration
> flag would it be better? I mean, you create a flag inside the platform
> data to determine
> if this fix must be applied or not. At least for me, having an external pu
> resistor
> seams to be very board dependent.
> 

>From what I observed, having a smaller pull-up (<470 OHM) resistor is affecting HS mode operation. Moreover, irrespective of whatever external pull-up value we have, if we have internal pull-up enabled, it comes in parallel to the external pull-up and thereby reduces the effective pull-up on the line. So it's safe to have a higher pull-up value instead rather than having the internal pull-up enabled (irrespective of whatever the external value is). Also, for all the OMAP boards that we have I think we always have an external pull-up typically 470 ohm and hence if we just depend on that external resistor without involving any of the internal pull-ups, HS/FS/LS should just work fine. That was the whole idea.

> 
> > +		twl_i2c_read_u8(TWL4030_MODULE_INTBR, &temp, REG_GPPUPDCTR1);
> > +		temp &= ~(SR_I2C_SDA_CTRL_PU | SR_I2C_SCL_CTRL_PU | \
> > +		I2C_SDA_CTRL_PU | I2C_SCL_CTRL_PU);
> > +		twl_i2c_write_u8(TWL4030_MODULE_INTBR, temp, REG_GPPUPDCTR1);
> > +	}
> > +
> >  	status = add_children(pdata, id->driver_data);
> >  fail:
> >  	if (status < 0)
> > diff --git a/include/linux/i2c/twl.h b/include/linux/i2c/twl.h
> > index bf1c5be..fd95eca 100644
> > --- a/include/linux/i2c/twl.h
> > +++ b/include/linux/i2c/twl.h
> > @@ -239,6 +239,21 @@ int twl6030_interrupt_mask(u8 bit_mask, u8 offset);
> >
> >  /*---------------------------------------------------------------------
> -*/
> >
> > +/*Interface Bit Register (INTBR) offsets
> > + *(Use TWL_4030_MODULE_INTBR)
> > + */
> > +
> > +#define REG_GPPUPDCTR1			0x0F
> > +
> > +/*I2C1 and I2C4(SR) SDA/SCL pull-up control bits */
> > +
> > +#define I2C_SCL_CTRL_PU			BIT(0)
> > +#define I2C_SDA_CTRL_PU			BIT(2)
> > +#define SR_I2C_SCL_CTRL_PU		BIT(4)
> > +#define SR_I2C_SDA_CTRL_PU		BIT(6)
> > +
> > +/*---------------------------------------------------------------------
> -*/
> > +
> >  /*
> >   * Keypad register offsets (use TWL4030_MODULE_KEYPAD)
> >   * ... SIH/interrupt only
> > --
> > 1.5.6.3
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> --
> Eduardo Valentin
