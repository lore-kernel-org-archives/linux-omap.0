From: Tony Lindgren <tony@atomide.com>
Subject: Re: [patch 2.6.28-rc2] isp1301_omap build fixes
Date: Fri, 31 Oct 2008 09:54:13 -0700
Message-ID: <20081031165411.GG13227@atomide.com>
References: <200810301120.51529.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:57060 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751831AbYJaQyR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 31 Oct 2008 12:54:17 -0400
Content-Disposition: inline
In-Reply-To: <200810301120.51529.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: i2c@lm-sensors.org, linux-omap@vger.kernel.org

Hi,

* David Brownell <david-b@pacbell.net> [081030 11:27]:
> From: David Brownell <dbrownell@users.sourceforge.net>
> 
> Build fixes for isp1301_omap; no behavior changes:
> 
>   - fix incorrect probe() signature (it changed many months ago)
>   - provide missing functions on H3 and H4 boards
>   - "sparse" fixes (static, NULL-vs-0)
> 
> The H3 build bits subset some of the stuff that was previously in
> the OMAP tree but never went to mainline.

The i2c list address has changed to linux-i2c@vger which you probably
know by now :)

Tony


> Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
> ---
>  drivers/i2c/chips/isp1301_omap.c |   65 ++++++++++++++++++++++++++-----------
>  1 file changed, 47 insertions(+), 18 deletions(-)
> 
> --- a/drivers/i2c/chips/isp1301_omap.c
> +++ b/drivers/i2c/chips/isp1301_omap.c
> @@ -25,6 +25,7 @@
>  #include <linux/slab.h>
>  #include <linux/interrupt.h>
>  #include <linux/platform_device.h>
> +#include <linux/gpio.h>
>  #include <linux/usb/ch9.h>
>  #include <linux/usb/gadget.h>
>  #include <linux/usb.h>
> @@ -34,7 +35,10 @@
>  #include <linux/io.h>
>  
>  #include <asm/irq.h>
> +#include <asm/mach-types.h>
> +
>  #include <mach/usb.h>
> +#include <mach/mux.h>
>  
>  
>  #ifndef	DEBUG
> @@ -89,14 +93,9 @@ struct isp1301 {
>  
>  /*-------------------------------------------------------------------------*/
>  
> -#ifdef	CONFIG_MACH_OMAP_H2
> -
>  /* board-specific PM hooks */
>  
> -#include <asm/gpio.h>
> -#include <mach/mux.h>
> -#include <asm/mach-types.h>
> -
> +#if defined(CONFIG_MACH_OMAP_H2) || defined(CONFIG_MACH_OMAP_H3)
>  
>  #if	defined(CONFIG_TPS65010) || defined(CONFIG_TPS65010_MODULE)
>  
> @@ -136,6 +135,33 @@ static inline void notresponding(struct 
>  
>  #endif
>  
> +#if defined(CONFIG_MACH_OMAP_H4)
> +
> +static void enable_vbus_draw(struct isp1301 *isp, unsigned mA)
> +{
> +	/* H4 controls this by DIP switch S2.4; no soft control.
> +	 * ON means the charger is always enabled.  Leave it OFF
> +	 * unless the OTG port is used only in B-peripheral mode.
> +	 */
> +}
> +
> +static void enable_vbus_source(struct isp1301 *isp)
> +{
> +	/* this board won't supply more than 8mA vbus power.
> +	 * some boards can switch a 100ma "unit load" (or more).
> +	 */
> +}
> +
> +
> +/* products will deliver OTG messages with LEDs, GUI, etc */
> +static inline void notresponding(struct isp1301 *isp)
> +{
> +	printk(KERN_NOTICE "OTG device not responding.\n");
> +}
> +
> +
> +#endif
> +
>  /*-------------------------------------------------------------------------*/
>  
>  static struct i2c_driver isp1301_driver;
> @@ -335,8 +361,7 @@ static int gadget_suspend(struct isp1301
>   * NOTE: guaranteeing certain response times might mean we shouldn't
>   * share keventd's work queue; a realtime task might be safest.
>   */
> -void
> -isp1301_defer_work(struct isp1301 *isp, int work)
> +static void isp1301_defer_work(struct isp1301 *isp, int work)
>  {
>  	int status;
>  
> @@ -513,7 +538,6 @@ static void update_otg1(struct isp1301 *
>  	otg_ctrl &= ~OTG_XCEIV_INPUTS;
>  	otg_ctrl &= ~(OTG_ID|OTG_ASESSVLD|OTG_VBUSVLD);
>  
> -
>  	if (int_src & INTR_SESS_VLD)
>  		otg_ctrl |= OTG_ASESSVLD;
>  	else if (isp->otg.state == OTG_STATE_A_WAIT_VFALL) {
> @@ -887,11 +911,11 @@ static int otg_probe(struct platform_dev
>  
>  static int otg_remove(struct platform_device *dev)
>  {
> -	otg_dev = 0;
> +	otg_dev = NULL;
>  	return 0;
>  }
>  
> -struct platform_driver omap_otg_driver = {
> +static struct platform_driver omap_otg_driver = {
>  	.probe		= otg_probe,
>  	.remove		= otg_remove,
>  	.driver		= {
> @@ -1213,6 +1237,8 @@ static void isp1301_release(struct devic
>  
>  	isp = dev_get_drvdata(dev);
>  
> +	/* FIXME -- not with a "new style" driver, it doesn't!! */
> +
>  	/* ugly -- i2c hijacks our memory hook to wait_for_completion() */
>  	if (isp->i2c_release)
>  		isp->i2c_release(dev);
> @@ -1234,7 +1260,7 @@ static int __exit isp1301_remove(struct 
>  	otg_unbind(isp);
>  #endif
>  	if (machine_is_omap_h2())
> -		omap_free_gpio(2);
> +		gpio_free(2);
>  
>  	isp->timer.data = 0;
>  	set_bit(WORK_STOP, &isp->todo);
> @@ -1242,7 +1268,7 @@ static int __exit isp1301_remove(struct 
>  	flush_scheduled_work();
>  
>  	put_device(&i2c->dev);
> -	the_transceiver = 0;
> +	the_transceiver = NULL;
>  
>  	return 0;
>  }
> @@ -1296,7 +1322,7 @@ isp1301_set_host(struct otg_transceiver 
>  	if (!host) {
>  		omap_writew(0, OTG_IRQ_EN);
>  		power_down(isp);
> -		isp->otg.host = 0;
> +		isp->otg.host = NULL;
>  		return 0;
>  	}
>  
> @@ -1345,7 +1371,9 @@ static int
>  isp1301_set_peripheral(struct otg_transceiver *otg, struct usb_gadget *gadget)
>  {
>  	struct isp1301	*isp = container_of(otg, struct isp1301, otg);
> +#ifndef	CONFIG_USB_OTG
>  	u32 l;
> +#endif
>  
>  	if (!otg || isp != the_transceiver)
>  		return -ENODEV;
> @@ -1355,7 +1383,7 @@ isp1301_set_peripheral(struct otg_transc
>  		if (!isp->otg.default_a)
>  			enable_vbus_draw(isp, 0);
>  		usb_gadget_vbus_disconnect(isp->otg.gadget);
> -		isp->otg.gadget = 0;
> +		isp->otg.gadget = NULL;
>  		power_down(isp);
>  		return 0;
>  	}
> @@ -1380,7 +1408,7 @@ isp1301_set_peripheral(struct otg_transc
>  	power_up(isp);
>  	isp->otg.state = OTG_STATE_B_IDLE;
>  
> -	if (machine_is_omap_h2())
> +	if (machine_is_omap_h2() || machine_is_omap_h3())
>  		isp1301_set_bits(isp, ISP1301_MODE_CONTROL_1, MC1_DAT_SE0);
>  
>  	isp1301_set_bits(isp, ISP1301_INTERRUPT_RISING,
> @@ -1500,7 +1528,8 @@ isp1301_start_hnp(struct otg_transceiver
>  
>  /*-------------------------------------------------------------------------*/
>  
> -static int __init isp1301_probe(struct i2c_client *i2c)
> +static int __init
> +isp1301_probe(struct i2c_client *i2c, const struct i2c_device_id *id)
>  {
>  	int			status;
>  	struct isp1301		*isp;
> @@ -1648,7 +1677,7 @@ module_init(isp_init);
>  static void __exit isp_exit(void)
>  {
>  	if (the_transceiver)
> -		otg_set_transceiver(0);
> +		otg_set_transceiver(NULL);
>  	i2c_del_driver(&isp1301_driver);
>  }
>  module_exit(isp_exit);
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
