From: Yegor Yefremov <yegorslists@googlemail.com>
Subject: Re: [PATCH v2 3/3] can: ti_hecc: Add DT support for TI HECC module
Date: Tue, 17 Jan 2017 16:31:25 +0100
Message-ID: <CAGm1_ku4ZM+WfQ2NM6GFQh7FzBZQfp6Spo-0Zq5699z+C2bR7w@mail.gmail.com>
References: <1484143521-4898-1-git-send-email-yegorslists@googlemail.com>
 <1484143521-4898-4-git-send-email-yegorslists@googlemail.com> <CAGm1_kuZfrEKS+UVaP=A-LqA5Q7grZrd5iKAjXbqms42oiwEqQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-can-owner@vger.kernel.org>
In-Reply-To: <CAGm1_kuZfrEKS+UVaP=A-LqA5Q7grZrd5iKAjXbqms42oiwEqQ@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
To: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, devicetree@vger.kernel.org, robh+dt@kernel.org, Andrey Skvortsov <andrej.skvortzov@gmail.com>, hs@denx.de, Anton Glukhov <anton.a.glukhov@gmail.com>, Yegor Yefremov <yegorslists@googlemail.com>, Marc Kleine-Budde <mkl@pengutronix.de>
List-Id: linux-omap@vger.kernel.org

On Wed, Jan 11, 2017 at 3:24 PM, Yegor Yefremov
<yegorslists@googlemail.com> wrote:
> On Wed, Jan 11, 2017 at 3:05 PM,  <yegorslists@googlemail.com> wrote:
>> From: Anton Glukhov <anton.a.glukhov@gmail.com>
>>
>> These patch set adds device tree support for TI HECC module.
>>
>> Signed-off-by: Anton Glukhov <anton.a.glukhov@gmail.com>
>> Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
>> ---
>> Changes v1 -> v2:
>>         - change compatible to "ti,am3505"
>>         - remove CONFIG_OF
>>         - don't set int_line to 0 explicitly
>>
>>  drivers/net/can/ti_hecc.c | 54 +++++++++++++++++++++++++++++++++++++++++++----
>>  1 file changed, 50 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/net/can/ti_hecc.c b/drivers/net/can/ti_hecc.c
>> index 680d1ff..fd3d9fc 100644
>> --- a/drivers/net/can/ti_hecc.c
>> +++ b/drivers/net/can/ti_hecc.c
>> @@ -46,6 +46,8 @@
>>  #include <linux/platform_device.h>
>>  #include <linux/clk.h>
>>  #include <linux/io.h>
>> +#include <linux/of.h>
>> +#include <linux/of_device.h>
>>
>>  #include <linux/can/dev.h>
>>  #include <linux/can/error.h>
>> @@ -872,19 +874,62 @@ static const struct net_device_ops ti_hecc_netdev_ops = {
>>         .ndo_change_mtu         = can_change_mtu,
>>  };
>>
>> +static const struct of_device_id ti_hecc_dt_ids[] = {
>> +       {
>> +               .compatible = "ti,am3505",
>> +       },
>> +       { }
>> +};
>> +MODULE_DEVICE_TABLE(of, ti_hecc_dt_ids);
>> +
>> +static struct ti_hecc_platform_data *hecc_parse_dt(struct device *dev)
>> +{
>> +       struct ti_hecc_platform_data *pdata;
>> +       struct device_node *np = dev->of_node;
>> +
>> +       pdata = devm_kzalloc(dev, sizeof(struct ti_hecc_platform_data), GFP_KERNEL);
>> +       if (!pdata)
>> +               return ERR_PTR(-ENOMEM);
>> +
>> +       if (of_property_read_u32(np, "ti,scc-ram-offset", &pdata->scc_ram_offset)) {
>> +               dev_err(dev, "Missing scc-ram-offset property in the DT.\n");
>> +               return ERR_PTR(-EINVAL);
>> +       }
>> +
>> +       if (of_property_read_u32(np, "ti,hecc-ram-offset", &pdata->hecc_ram_offset)) {
>> +               dev_err(dev, "Missing hecc-ram-offset property in the DT.\n");
>> +               return ERR_PTR(-EINVAL);
>> +       }
>> +
>> +       if (of_property_read_u32(np, "ti,mbx-offset", &pdata->mbx_offset)) {
>> +               dev_err(dev, "Missing mbx-offset property in the DT.\n");
>> +               return ERR_PTR(-EINVAL);
>> +       }
>> +
>> +       of_property_read_u32(dev->of_node, "ti,int-line", &pdata->int_line);
>> +
>> +       return pdata;
>> +}
>> +
>>  static int ti_hecc_probe(struct platform_device *pdev)
>>  {
>>         struct net_device *ndev = (struct net_device *)0;
>>         struct ti_hecc_priv *priv;
>> -       struct ti_hecc_platform_data *pdata;
>> +       struct ti_hecc_platform_data *pdata = dev_get_platdata(&pdev->dev);
>> +       struct device_node *np = pdev->dev.of_node;
>>         struct resource *mem, *irq;
>>         void __iomem *addr;
>>         int err = -ENODEV;
>>
>> -       pdata = dev_get_platdata(&pdev->dev);
>> +       if (!pdata && np) {
>> +               pdata = hecc_parse_dt(&pdev->dev);
>> +               if (IS_ERR(pdata))
>> +                       return PTR_ERR(pdata);
>> +       }
>> +
>>         if (!pdata) {
>> -               dev_err(&pdev->dev, "No platform data\n");
>> -               goto probe_exit;
>> +               dev_err(&pdev->dev, "Platform data missing\n");
>> +               return -EINVAL;
>>         }
>>
>>         mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> @@ -1037,6 +1082,7 @@ static int ti_hecc_resume(struct platform_device *pdev)
>>  static struct platform_driver ti_hecc_driver = {
>>         .driver = {
>>                 .name    = DRV_NAME,
>> +               .of_match_table = ti_hecc_dt_ids,
>>         },
>>         .probe = ti_hecc_probe,
>>         .remove = ti_hecc_remove,
>> --
>> 2.1.4
>>
>
> So far the CAN interface will be registered, but I get following issue
> with clock for HECC:
>
> [    6.574174] CAN device driver interface
> [    6.663318] ------------[ cut here ]------------
> [    6.668220] WARNING: CPU: 0 PID: 115 at drivers/clk/clk.c:652
> clk_core_enable+0xdc/0x268
> [    6.676676] Modules linked in: ti_hecc(+) can_dev
> snd_soc_omap_mcbsp omap_wdt snd_soc_omap snd_soc_tlv320aic23_i2c
> snd_soc_tlv320aic23 snd_soc_core ehci_omap snd_pcm_dmaengine snd_pcm
> ehci_hcd snd_timer snd at24 soundcore nvmem_core gpio_pca953x usbcore
> [    6.700227] CPU: 0 PID: 115 Comm: udevd Not tainted 4.10.0-rc3 #2
> [    6.706595] Hardware name: Generic AM3517 (Flattened Device Tree)
> [    6.713000] [<c010fff8>] (unwind_backtrace) from [<c010c178>]
> (show_stack+0x10/0x14)
> [    6.721108] [<c010c178>] (show_stack) from [<c0518fcc>]
> (dump_stack+0xac/0xe0)
> [    6.728682] [<c0518fcc>] (dump_stack) from [<c0136d60>] (__warn+0xd8/0x104)
> [    6.735973] [<c0136d60>] (__warn) from [<c0136e38>]
> (warn_slowpath_null+0x20/0x28)
> [    6.743898] [<c0136e38>] (warn_slowpath_null) from [<c0595530>]
> (clk_core_enable+0xdc/0x268)
> [    6.752730] [<c0595530>] (clk_core_enable) from [<c05966d0>]
> (clk_core_enable_lock+0x18/0x2c)
> [    6.761670] [<c05966d0>] (clk_core_enable_lock) from [<bf17202c>]
> (ti_hecc_probe+0x188/0x3d0 [ti_hecc])
> [    6.771616] [<bf17202c>] (ti_hecc_probe [ti_hecc]) from
> [<c05f5930>] (platform_drv_probe+0x50/0xb0)
> [    6.781095] [<c05f5930>] (platform_drv_probe) from [<c05f3998>]
> (driver_probe_device+0x1f8/0x2cc)
> [    6.790379] [<c05f3998>] (driver_probe_device) from [<c05f3b2c>]
> (__driver_attach+0xc0/0xc4)
> [    6.799208] [<c05f3b2c>] (__driver_attach) from [<c05f1e3c>]
> (bus_for_each_dev+0x6c/0xa0)
> [    6.807763] [<c05f1e3c>] (bus_for_each_dev) from [<c05f2ef8>]
> (bus_add_driver+0x100/0x210)
> [    6.816410] [<c05f2ef8>] (bus_add_driver) from [<c05f4968>]
> (driver_register+0x78/0xf4)
> [    6.824785] [<c05f4968>] (driver_register) from [<c0101874>]
> (do_one_initcall+0x3c/0x170)
> [    6.833342] [<c0101874>] (do_one_initcall) from [<c023b4c8>]
> (do_init_module+0x5c/0x1b8)
> [    6.841818] [<c023b4c8>] (do_init_module) from [<c01d9a08>]
> (load_module+0x1d2c/0x23f8)
> [    6.850194] [<c01d9a08>] (load_module) from [<c01da2f0>]
> (SyS_finit_module+0xa4/0xb8)
> [    6.858392] [<c01da2f0>] (SyS_finit_module) from [<c0107760>]
> (ret_fast_syscall+0x0/0x1c)
> [    6.866939] ---[ end trace b502c707901327dc ]---
> [    6.875799] ti_hecc 5c050000.can: device registered
> (reg_base=d0b1c000, irq=40)
>
> Going to take a closer look at this.

I've fixed this issue. One needs to use clk_prepare_enable() instead
of clk_enable().

Can it be, that earlier all OMAP clocks were "prepared", so that one
could begin with clk_enable() right away?

Will make a separate patch.

Yegor
