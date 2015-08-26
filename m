From: Rob Herring <robherring2@gmail.com>
Subject: Re: [PATCH] of: device: fix NULL pointer dereference on driver removal
Date: Wed, 26 Aug 2015 08:14:36 -0500
Message-ID: <CAL_JsqJYwQhFyZBFL2eC5mwO-o9xf3K5nn7vgfus_ySBR7NMWA@mail.gmail.com>
References: <1440531290-17526-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1440531290-17526-1-git-send-email-balbi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Grant Likely <grant.likely@linaro.org>, Rob Herring <robh+dt@kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, stable <stable@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Tue, Aug 25, 2015 at 2:34 PM, Felipe Balbi <balbi@ti.com> wrote:
> If we don't insert resources into the resource tree,
> calls to of_platform_depopulate() will end up in NULL
> pointer dereferences because the resource parent will
> be set to NULL even though we still have more resources
> to go through.

Long standing problem. A fix is in -next now and will go into 4.3 (plus stable):

commit 11c63e4718acad3d8f04601c80fddd4b3d1455b1
Author: Grant Likely <grant.likely@linaro.org>
Date:   Sun Jun 7 15:20:11 2015 +0100

    drivercore: Fix unregistration path of platform devices

>
> Without this patch, the result is as follows:
>
> [   28.238158] Unable to handle kernel NULL pointer dereference at virtual address 00000008
> [   28.246646] pgd = ed3d8000
> [   28.249480] [00000008] *pgd=00000000
> [   28.253247] Internal error: Oops: 5 [#1] SMP ARM
> [   28.258072] Modules linked in: input_leds hid_generic usbkbd usbhid
> xhci_plat_hcd xhci_hcd usbcore joydev dwc3 udc_core usb_common m25p80 evdev spi_nor omapfb cfbfillrect cfbimg blt cpufreq_dt cfbcopyarea thermal_sys snd_soc_simple_card leds_gpio matrix_keypad pwm_bl hwmon led_class matrix_keymap panel_dpi snd_soc_tlv320aic3x snd_soc_davinci_mcasp snd_soc_edma snd_soc_omap snd_soc_core omapdss snd_compress snd_pcm_dmaengine snd_pcm dwc3_omap(-) extcon snd_timer pwm_tiecap snd lis3lv02d_i2c lis3lv02d soundcore input_polldev rtc_omap spi_ti_qspi tps65218_pwrbutton omap_wdt phy_omap_usb2 autofs4
> [   28.313186] CPU: 0 PID: 289 Comm: modprobe Not tainted 4.2.0-rc7-next-20150824-00002-g5681a109a938-dirty #1093
> [   28.323643] Hardware name: Generic AM43 (Flattened Device Tree)
> [   28.329836] task: ed39d180 ti: ed076000 task.ti: ed076000
> [   28.335496] PC is at __release_resource+0x30/0x13c
> [   28.340501] LR is at __release_resource+0x24/0x13c
> [   28.345501] pc : [<c00439e0>]    lr : [<c00439d4>]    psr: 600d0013
> [   28.345501] sp : ed077e98  ip : 00000007  fp : befb3e14
> [   28.357487] r10: 00000000  r9 : ed076000  r8 : c000f724
> [   28.362941] r7 : 00000000  r6 : ee6f9800  r5 : ed268d40  r4 : c094679c
> [   28.369755] r3 : 00000000  r2 : 000000f4  r1 : c0648b34  r0 : 00000045
> [   28.376560] Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM Segment user
> [   28.384008] Control: 10c5387d  Table: ad3d8059  DAC: 00000015
> [   28.390005] Process modprobe (pid: 289, stack limit = 0xed076218)
> [   28.396375] Stack: (0xed077e98 to 0xed078000)
> [   28.400924] 7e80: ed268d40 00000000
> [   28.409455] 7ea0: befb3e14 c0640838 00000001 c094679c ed268d40 ee6f9800 00000081 c0043b1c
> [   28.417996] 7ec0: 0000001c 00000001 ee6f9800 c03e2674 ee6f9800 00000000 c04d3f20 c03e26ac
> [   28.426537] 7ee0: ee6f9810 c04d3fac 00000000 c03dcf10 ee1592c0 ed268cf0 ee170010 ee170010
> [   28.435065] 7f00: ee170044 c04d3f08 ed268ed0 bf093208 ee170010 bf093c94 ee170044 c03e2754
> [   28.443607] 7f20: ee170010 bf093c94 ee170044 c03e095c ee170010 bf093c94 ee170044 c03e116c
> [   28.452150] 7f40: bf093c94 7f6232fc 00000800 c03e04e4 bf093d00 c00c8a80 00000000 33637764
> [   28.460703] 7f60: 616d6f5f b6f70070 ed39d180 00000000 ed076000 00000000 befb3e14 c005be74
> [   28.469241] 7f80: 00000000 ed076000 7f6232c0 7f6232c0 00000001 0000f67c 7f6232c0 7f6232c0
> [   28.477783] 7fa0: 00000001 c000f540 7f6232c0 7f6232c0 7f6232fc 00000800 66d19c00 00000000
> [   28.486341] 7fc0: 7f6232c0 7f6232c0 00000001 00000081 00000000 00000001 7f6232c0 befb3e14
> [   28.494903] 7fe0: b6f1c2e1 befb2a3c 7f60638f b6f1c2e6 800d0030 7f6232fc 00000000 00000000
> [   28.503476] [<c00439e0>] (__release_resource) from [<c0043b1c>] (release_resource+0x30/0x54)
> [   28.512299] [<c0043b1c>] (release_resource) from [<c03e2674>] (platform_device_del+0x70/0x9c)
> [   28.521218] [<c03e2674>] (platform_device_del) from [<c03e26ac>] (platform_device_unregister+0xc/0x20)
> [   28.530962] [<c03e26ac>] (platform_device_unregister) from [<c04d3fac>] (of_platform_device_destroy+0x8c/0x98)
> [   28.541425] [<c04d3fac>] (of_platform_device_destroy) from [<c03dcf10>] (device_for_each_child+0x50/0x7c)
> [   28.551430] [<c03dcf10>] (device_for_each_child) from [<c04d3f08>] (of_platform_depopulate+0x2c/0x44)
> [   28.561101] [<c04d3f08>] (of_platform_depopulate) from [<bf093208>] (dwc3_omap_remove+0x3c/0x5c [dwc3_omap])
> [   28.571390] [<bf093208>] (dwc3_omap_remove [dwc3_omap]) from [<c03e2754>] (platform_drv_remove+0x18/0x30)
> [   28.581387] [<c03e2754>] (platform_drv_remove) from [<c03e095c>] (__device_release_driver+0x88/0x114)
> [   28.591023] [<c03e095c>] (__device_release_driver) from [<c03e116c>] (driver_detach+0xb4/0xb8)
> [   28.600014] [<c03e116c>] (driver_detach) from [<c03e04e4>] (bus_remove_driver+0x4c/0xa0)
> [   28.608485] [<c03e04e4>] (bus_remove_driver) from [<c00c8a80>] (SyS_delete_module+0x11c/0x1e4)
> [   28.617518] [<c00c8a80>] (SyS_delete_module) from [<c000f540>] (ret_fast_syscall+0x0/0x54)
> [   28.626172] Code: eb0354bf e5957010 e3a020f4 e59f10f0 (e5973008)
> [   28.632722] ---[ end trace d2a21fc5d73a2dfd ]---
>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Felipe Balbi <balbi@ti.com>
> ---
>
> very easy to trigger with 'modprobe -r dwc3-omap' on any of TI's platform
> sporting dwc3
>
>  drivers/of/device.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>
> diff --git a/drivers/of/device.c b/drivers/of/device.c
> index 8b91ea241b10..c03600c08207 100644
> --- a/drivers/of/device.c
> +++ b/drivers/of/device.c
> @@ -53,6 +53,8 @@ EXPORT_SYMBOL(of_dev_put);
>
>  int of_device_add(struct platform_device *ofdev)
>  {
> +       int i;
> +
>         BUG_ON(ofdev->dev.of_node == NULL);
>
>         /* name and id have to be set so that the platform bus doesn't get
> @@ -66,6 +68,27 @@ int of_device_add(struct platform_device *ofdev)
>         if (!ofdev->dev.parent)
>                 set_dev_node(&ofdev->dev, of_node_to_nid(ofdev->dev.of_node));
>
> +       /* insert resources into the resource tree */
> +       for (i = 0; i < ofdev->num_resources; i++) {
> +               struct resource *p, *r = &ofdev->resource[i];
> +
> +               if (r->name == NULL)
> +                       r->name = dev_name(&ofdev->dev);
> +
> +               p = r->parent;
> +               if (!p) {
> +                       if (resource_type(r) == IORESOURCE_MEM)
> +                               p = &iomem_resource;
> +                       else if (resource_type(r) == IORESOURCE_IO)
> +                               p = &ioport_resource;
> +               }
> +
> +               if (p && insert_resource(p, r)) {
> +                       dev_err(&ofdev->dev, "failed to claim resource %d\n", i);
> +                       return -EBUSY;
> +               }
> +       }
> +
>         return device_add(&ofdev->dev);
>  }
>
> --
> 2.5.0
>
