From: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Subject: RE: [PATCH][DSPBRIDGE] Add the device after driver initialization
Date: Tue, 28 Apr 2009 10:38:48 -0500
Message-ID: <27F9C60D11D683428E133F85D2BB4A53040B5C9BE5@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:44453 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753762AbZD1PjD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 28 Apr 2009 11:39:03 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ameya Palande <ameya.palande@nokia.com>
Cc: "Kanigeri, Hari" <h-kanigeri2@ti.com>, linux-omap <linux-omap@vger.kernel.org>

Hi, 

Ameya Palande wrote:
> From: Ameya Palande <ameya.palande@nokia.com>
>
> This prevents a panic caused by an IOCTL call before driver completes its
> initialization.
>
> Signed-off-by: Ameya Palande <ameya.palande@nokia.com>
> ---
>  drivers/dsp/bridge/rmgr/drv_interface.c |   29 +++++++++++++----------------
>  1 files changed, 13 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/dsp/bridge/rmgr/drv_interface.c b/drivers/dsp/bridge/rmgr/drv_interface.c
> index 9466409..79f75c9 100755
> --- a/drivers/dsp/bridge/rmgr/drv_interface.c
> +++ b/drivers/dsp/bridge/rmgr/drv_interface.c
> @@ -298,14 +298,6 @@ static int __devinit omap34xx_bridge_probe(struct platform_device *pdev)
>        bridge_device->cdev.owner = THIS_MODULE;
>        bridge_device->cdev.ops = &bridge_fops;
>
> -       status = cdev_add(&bridge_device->cdev, dev, 1);
> -
> -       if (status) {
> -               GT_0trace(driverTrace, GT_7CLASS,
> -                               "Failed to add the bridge device \n");
> -               return status;
> -       }
> -
>        /* udev support */
>        bridge_class = class_create(THIS_MODULE, "ti_bridge");
>
> @@ -328,14 +320,6 @@ static int __devinit omap34xx_bridge_probe(struct platform_device *pdev)
>
>        GT_0trace(driverTrace, GT_ENTER, "-> driver_init\n");
>
> -#ifdef CONFIG_PM
> -       /* Initialize the wait queue */
> -       if (!status) {
> -               bridge_suspend_data.suspended = 0;
> -               init_waitqueue_head(&bridge_suspend_data.suspend_wq);
> -       }
> -#endif
> -
>        SERVICES_Init();
>
>        /*  Autostart flag.  This should be set to true if the DSP image should
> @@ -429,6 +413,19 @@ static int __devinit omap34xx_bridge_probe(struct platform_device *pdev)
>                } else {
>                        GT_0trace(driverTrace, GT_5CLASS,
>                                        "DSP/BIOS Bridge driver loaded\n");
> +                       /* Announce to kernel that we are ready */
> +                       status = cdev_add(&bridge_device->cdev, dev, 1);
> +                       if (status) {
> +                               GT_0trace(driverTrace, GT_7CLASS,
> +                               "Failed to add the bridge device \n");
> +                       }
> +                       else {

Checkpatch: else should follow close brace '}'

> +                               #ifdef CONFIG_PM

Moving this #ifdef & #endif to the start of the line will make it a bit easier to read.

> +                               /* Initialize the wait queue */
> +                               bridge_suspend_data.suspended = 0;
> +                               init_waitqueue_head(&bridge_suspend_data.suspend_wq);
> +                               #endif
> +                       }

Line over 80 characters.

What if you replace "if (DSP_SUCCEEDED(initStatus)) {" on line 403 for a goto and a failure comment, then you can remove one level of indentation.

>                }
>        }
>
> --
> 1.6.2.4

- omar
