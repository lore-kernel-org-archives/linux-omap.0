From: Christoph Fritz <chf.fritz@googlemail.com>
Subject: Re: [BUG] omap: mfd/regulator: twl/core: init order
Date: Mon, 15 Apr 2013 12:56:41 +0200
Message-ID: <1366023401.957.5.camel@mars>
References: <1365877659.3812.110.camel@mars>  <516BD479.2020904@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bk0-f54.google.com ([209.85.214.54]:48948 "EHLO
	mail-bk0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753448Ab3DOK4r (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 15 Apr 2013 06:56:47 -0400
Received: by mail-bk0-f54.google.com with SMTP id q16so2303043bkw.13
        for <linux-omap@vger.kernel.org>; Mon, 15 Apr 2013 03:56:45 -0700 (PDT)
In-Reply-To: <516BD479.2020904@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Javier Martinez Canillas <martinez.javier@gmail.com>, Liam Girdwood <lrg@ti.com>, =?ISO-8859-1?Q?Beno=EEt?= Cousson <b-cousson@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Alessandro Zummo <a.zummo@towertech.it>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Samuel Ortiz <sameo@linux.intel.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, devicetree-discuss@lists.ozlabs.org, Daniel Mack <daniel@zonque.org>, "Hans J. Koch" <hjk@hansjkoch.de>

On Mon, 2013-04-15 at 13:20 +0300, Grygorii Strashko wrote:
> On 04/13/2013 09:27 PM, Christoph Fritz wrote:
> > Hi
> >
> >   while testing an omap3 board with device tree support I stumbled upon a
> > bug which is due to wrong initialization order of twl-core and
> > twl-regulator (I suppose): In the boot process they get loaded way too
> > late so that a lot of drivers before where configured wrong or just
> > refuse to load.
> >
> > For example the real time clock driver: The RTC kicks in way before
> > twl_probe() and due to that it configures its register map wrong
> > (at this time twl_priv->twl_id isn't configured yet).
> >
> > Another example is the omap display subsystem. It (DSS) fails loading
> > while trying to register some not yet existent regulators and because it
> > lacks EPROBE_DEFER.
> >
> > USB and MMC is also not working and I'm suspicious of the same cause.
> >
> > Any ideas?
> Hi Christoph,
> 
> It happens, because I2C probes execution  have been deferred due to
> "pinctrl-single" driver (, which is not ready at i2c bus initialization 
> time:
> 
> [    0.525939] omap_i2c 48070000.i2c: could not find pctldev for node 
> /ocp/pinmux@4a100040/pinmux_i2c1_pins, deferring probe
> [    0.526000] platform 48070000.i2c: Driver omap_i2c requests probe 
> deferral
> [    0.526062] omap_i2c 48072000.i2c: could not find pctldev for node 
> /ocp/pinmux@4a100040/pinmux_i2c2_pins, deferring probe
> [    0.526092] platform 48072000.i2c: Driver omap_i2c requests probe 
> deferral
> [    0.526153] omap_i2c 48060000.i2c: could not find pctldev for node 
> /ocp/pinmux@4a100040/pinmux_i2c3_pins, deferring probe
> [    0.526184] platform 48060000.i2c: Driver omap_i2c requests probe 
> deferral
> [    0.526245] omap_i2c 48350000.i2c: could not find pctldev for node 
> /ocp/pinmux@4a100040/pinmux_i2c4_pins, deferring probe
> [    0.526275] platform 48350000.i2c: Driver omap_i2c requests probe 
> deferral
> 
> I think following change should fix it, could you try it, pls:
> diff --git a/drivers/pinctrl/pinctrl-single.c 
> b/drivers/pinctrl/pinctrl-single.c
> index 5c32e88..b2a9d4b 100644
> --- a/drivers/pinctrl/pinctrl-single.c
> +++ b/drivers/pinctrl/pinctrl-single.c
> @@ -1014,7 +1014,18 @@ static struct platform_driver pcs_driver = {
>          },
>   };
> 
> -module_platform_driver(pcs_driver);
> +static int __init pcs_driver_drv_init(void)
> +{
> +       return platform_driver_register(&pcs_driver);
> +}
> +postcore_initcall(pcs_driver_drv_init);
> +
> +static void __exit pcs_driver_drv_exit(void)
> +{
> +       platform_driver_unregister(&pcs_driver);
> +}
> +module_exit(pcs_driver_drv_exit);
> +

Hi Grygorii,
 thanks - indeed it does fix the problem. I checked at least the rtc
which is now configured right and working :-)

Do you consider the patch above as a hack or will it go mainline?

 Thanks
  -- Christoph



