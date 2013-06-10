From: Suman Anna <s-anna@ti.com>
Subject: Re: [PATCH 5/7] ARM: OMAP2+: mbox: remove dependencies with soc.h
Date: Mon, 10 Jun 2013 12:10:06 -0500
Message-ID: <51B6086E.5040006@ti.com>
References: <1370656683-41355-1-git-send-email-s-anna@ti.com> <CA+Bv8Xa55ht9OBEhYv_TNe0nkopi_DRtQPZDKU07dAzKx2uRtw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:38583 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750887Ab3FJRPn (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 10 Jun 2013 13:15:43 -0400
In-Reply-To: <CA+Bv8Xa55ht9OBEhYv_TNe0nkopi_DRtQPZDKU07dAzKx2uRtw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russ Dill <Russ.Dill@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, Ohad Ben-Cohen <ohad@wizery.com>, Omar Ramirez Luna <omar.ramirez@copitl.com>, Jassi Brar <jaswinder.singh@linaro.org>, Loic Pallardy <loic.pallardy@st.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Russ,

On 06/08/2013 02:16 PM, Russ Dill wrote:
> On Fri, Jun 7, 2013 at 6:58 PM, Suman Anna <s-anna@ti.com> wrote:
>> The OMAP mailbox platform driver code has been cleaned up to
>> remove the dependencies with soc.h in preparation for moving
>> the mailbox code to drivers folder.
>>
>> The code relied on cpu_is_xxx/soc_is_xxx macros previously to
>> pick the the right set of mailbox devices and register with the
>> mailbox driver. This data is now represented in a concise format
>> and moved to the respective omap_hwmod data files and published
>> to the driver through the platform data.
> 
> I have some comments on how the cpu_is_xxx/soc_is_xxx was done. In its
> current form, intr_type is just a sub for cpu_is_omap44xx(). I'd like
> to see the scope of that parameter reduced a bit and have the changes
> match the model of gpio-omap.c a little better (see 4e962e89 for an
> example). Comments inline.

I have looked up the gpio-omap.c and the usage style is different. The
purpose here is similar, the interrupt programming is different between
OMAP4+ and OMAP3-. For gpio, all the registers are supplied through
platform data (published differently for DT and non-DT). The knowledge
of the registers is with the driver for mailbox (in both DT and non-DT),
with only the bare minimum data passed through pdata (for non-DT) with
this patch. The only variation in mailbox registers is the interrupt
type configuration, the number of valid registers are dictated by number
of fifos and number of target processors, and I have added these to the
platform data in Patch6. The main purpose of this patch is to remove the
cpu_is_xxx macro dependencies which are currently used for defining the
different mboxes as well as the register programming. I didn't want to
separate out the mailbox device creation into a separate file with all
the additional data that this patch is removing, we do not want to
create a new file in mach-omap2 at this point. The omap_mbox_init will
essentially vanish for DT, and so would be the dev_attrs being added to
the hwmod data files.

> 
>> Cc: Paul Walmsley <paul@pwsan.com>
>> Signed-off-by: Suman Anna <s-anna@ti.com>
>> ---
>>  arch/arm/mach-omap2/devices.c              |   9 +-
>>  arch/arm/mach-omap2/mailbox.c              | 250 ++++++++++-------------------
>>  arch/arm/mach-omap2/omap_hwmod_2420_data.c |  12 ++
>>  arch/arm/mach-omap2/omap_hwmod_2430_data.c |  11 ++
>>  arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |  11 ++
>>  arch/arm/mach-omap2/omap_hwmod_44xx_data.c |  13 ++
>>  arch/arm/plat-omap/include/plat/mailbox.h  |   2 +-
>>  include/linux/platform_data/mailbox-omap.h |  53 ++++++
>>  8 files changed, 198 insertions(+), 163 deletions(-)
>>  create mode 100644 include/linux/platform_data/mailbox-omap.h
>>
>> diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
>> index 4269fc1..4c97a86 100644
>> --- a/arch/arm/mach-omap2/devices.c
>> +++ b/arch/arm/mach-omap2/devices.c
>> @@ -20,6 +20,7 @@
>>  #include <linux/pinctrl/machine.h>
>>  #include <linux/platform_data/omap4-keypad.h>
>>  #include <linux/platform_data/omap_ocp2scp.h>
>> +#include <linux/platform_data/mailbox-omap.h>
>>  #include <linux/usb/omap_control_usb.h>
>>
>>  #include <asm/mach-types.h>
>> @@ -332,14 +333,20 @@ static inline void __init omap_init_mbox(void)
>>  {
>>         struct omap_hwmod *oh;
>>         struct platform_device *pdev;
>> +       struct omap_mbox_pdata *pdata;
>>
>>         oh = omap_hwmod_lookup("mailbox");
>>         if (!oh) {
>>                 pr_err("%s: unable to find hwmod\n", __func__);
>>                 return;
>>         }
>> +       if (!oh->dev_attr) {
>> +               pr_err("%s: hwmod doesn't have valid attrs\n", __func__);
>> +               return;
>> +       }
>>
>> -       pdev = omap_device_build("omap-mailbox", -1, oh, NULL, 0);
>> +       pdata = (struct omap_mbox_pdata *)oh->dev_attr;
>> +       pdev = omap_device_build("omap-mailbox", -1, oh, pdata, sizeof(*pdata));
>>         WARN(IS_ERR(pdev), "%s: could not build device, err %ld\n",
>>                                                 __func__, PTR_ERR(pdev));
>>  }
>> diff --git a/arch/arm/mach-omap2/mailbox.c b/arch/arm/mach-omap2/mailbox.c
>> index b01aae6..fcb425c 100644
>> --- a/arch/arm/mach-omap2/mailbox.c
>> +++ b/arch/arm/mach-omap2/mailbox.c
>> @@ -11,16 +11,16 @@
>>   */
>>
>>  #include <linux/module.h>
>> +#include <linux/slab.h>
>>  #include <linux/clk.h>
>>  #include <linux/err.h>
>>  #include <linux/platform_device.h>
>>  #include <linux/io.h>
>>  #include <linux/pm_runtime.h>
>> +#include <linux/platform_data/mailbox-omap.h>
>>
>>  #include <plat/mailbox.h>
>>
>> -#include "soc.h"
>> -
>>  #define MAILBOX_REVISION               0x000
>>  #define MAILBOX_MESSAGE(m)             (0x040 + 4 * (m))
>>  #define MAILBOX_FIFOSTATUS(m)          (0x080 + 4 * (m))
>> @@ -59,6 +59,7 @@ struct omap_mbox2_priv {
>>         u32 notfull_bit;
>>         u32 ctx[OMAP4_MBOX_NR_REGS];
>>         unsigned long irqdisable;
>> +       u32 intr_type;
>>  };
>>
>>  static inline unsigned int mbox_read_reg(size_t ofs)
>> @@ -136,7 +137,7 @@ static void omap2_mbox_disable_irq(struct omap_mbox *mbox, omap_mbox_irq_t irq)
>>         struct omap_mbox2_priv *p = mbox->priv;
>>         u32 bit = (irq == IRQ_TX) ? p->notfull_bit : p->newmsg_bit;
>>
>> -       if (!cpu_is_omap44xx())
>> +       if (!p->intr_type)
>>                 bit = mbox_read_reg(p->irqdisable) & ~bit;
> 
> This part here should really be the scope of intr_type. Is there any
> way to name it better though? An indication of what it's actually
> doing?

I can add a comment, if that makes it clear.

> 
>>         mbox_write_reg(bit, p->irqdisable);
>> @@ -168,7 +169,8 @@ static void omap2_mbox_save_ctx(struct omap_mbox *mbox)
>>         int i;
>>         struct omap_mbox2_priv *p = mbox->priv;
>>         int nr_regs;
>> -       if (cpu_is_omap44xx())
>> +
>> +       if (p->intr_type)
>>                 nr_regs = OMAP4_MBOX_NR_REGS;
>>         else
>>                 nr_regs = MBOX_NR_REGS;
> 
> Here it would seem to be better to put nr_regs in pdata.

The current usage of nr_regs is for save and restore, and the logic
needs fixing. The next patch (ARM: OMAP2+: add user and fifo info to
mailbox platform data) which adds the user and fifo info will be used to
determine how many registers that need to be saved. The number of useful
registers are determined by the above and intr_type even though the
mailbox IP is the same on different SoCs. I will be fixing this in a
subsequent patch and the nr_regs would be eliminated. This patch is
merely getting rid of the cpu_is_xxx macro.

> 
>> @@ -185,7 +187,8 @@ static void omap2_mbox_restore_ctx(struct omap_mbox *mbox)
>>         int i;
>>         struct omap_mbox2_priv *p = mbox->priv;
>>         int nr_regs;
>> -       if (cpu_is_omap44xx())
>> +
>> +       if (p->intr_type)
>>                 nr_regs = OMAP4_MBOX_NR_REGS;
>>         else
>>                 nr_regs = MBOX_NR_REGS;
> 
> Same here.
> 
>> @@ -213,188 +216,113 @@ static struct omap_mbox_ops omap2_mbox_ops = {
>>         .restore_ctx    = omap2_mbox_restore_ctx,
>>  };
>>

[snip]

>> -
>>  static int omap2_mbox_probe(struct platform_device *pdev)
>>  {
>>         struct resource *mem;
>>         int ret;
>> -       struct omap_mbox **list;
>> -
>> -       if (false)
>> -               ;
>> -#if defined(CONFIG_ARCH_OMAP3)
>> -       else if (cpu_is_omap34xx()) {
>> -               list = omap3_mboxes;
>> +       struct omap_mbox **list, *mbox, *mboxblk;
>> +       struct omap_mbox2_priv *priv, *privblk;
>> +       struct omap_mbox_pdata *pdata = pdev->dev.platform_data;
>> +       struct omap_mbox_dev_info *info;
>> +       int i;
>>
>> -               list[0]->irq = platform_get_irq(pdev, 0);
>> +       if (!pdata || !pdata->info_cnt || !pdata->info) {
>> +               pr_err("%s: platform not supported\n", __func__);
>> +               return -ENODEV;
>>         }
>> -#endif
>> -#if defined(CONFIG_ARCH_OMAP2)
>> -       else if (cpu_is_omap2430()) {
>> -               list = omap2_mboxes;
>>
>> -               list[0]->irq = platform_get_irq(pdev, 0);
>> -       } else if (cpu_is_omap2420()) {
>> -               list = omap2_mboxes;
>> +       /* allocate one extra for marking end of list */
>> +       list = kzalloc((pdata->info_cnt + 1) * sizeof(*list), GFP_KERNEL);
>> +       if (!list)
>> +               return -ENOMEM;
>>
>> -               list[0]->irq = platform_get_irq_byname(pdev, "dsp");
>> -               list[1]->irq = platform_get_irq_byname(pdev, "iva");
>> +       mboxblk = mbox = kzalloc(pdata->info_cnt * sizeof(*mbox), GFP_KERNEL);
>> +       if (!mboxblk) {
>> +               ret = -ENOMEM;
>> +               goto free_list;
>>         }
>> -#endif
>> -#if defined(CONFIG_ARCH_OMAP4)
>> -       else if (cpu_is_omap44xx()) {
>> -               list = omap4_mboxes;
>>
>> -               list[0]->irq = list[1]->irq = platform_get_irq(pdev, 0);
>> +       privblk = priv = kzalloc(pdata->info_cnt * sizeof(*priv), GFP_KERNEL);
>> +       if (!privblk) {
>> +               ret = -ENOMEM;
>> +               goto free_mboxblk;
>>         }
>> -#endif
>> -       else {
>> -               pr_err("%s: platform not supported\n", __func__);
>> -               return -ENODEV;
>> +
>> +       info = pdata->info;
>> +       for (i = 0; i < pdata->info_cnt; i++, info++, priv++) {
>> +               priv->tx_fifo.msg = MAILBOX_MESSAGE(info->tx_id);
>> +               priv->tx_fifo.fifo_stat = MAILBOX_FIFOSTATUS(info->tx_id);
>> +               priv->rx_fifo.msg =  MAILBOX_MESSAGE(info->rx_id);
>> +               priv->rx_fifo.msg_stat =  MAILBOX_MSGSTATUS(info->rx_id);
>> +               priv->notfull_bit = MAILBOX_IRQ_NOTFULL(info->tx_id);
>> +               priv->newmsg_bit = MAILBOX_IRQ_NEWMSG(info->rx_id);
>> +               if (pdata->intr_type) {
>> +                       priv->irqenable = OMAP4_MAILBOX_IRQENABLE(info->usr_id);
>> +                       priv->irqstatus = OMAP4_MAILBOX_IRQSTATUS(info->usr_id);
>> +                       priv->irqdisable =
>> +                               OMAP4_MAILBOX_IRQENABLE_CLR(info->usr_id);
>> +               } else {
>> +                       priv->irqenable = MAILBOX_IRQENABLE(info->usr_id);
>> +                       priv->irqstatus = MAILBOX_IRQSTATUS(info->usr_id);
>> +                       priv->irqdisable = MAILBOX_IRQENABLE(info->usr_id);
>> +               }
> 
> And here it would be better to put these three registers in pdata.

The priv structure is per omap_mbox within the actual platform device,
and is already constructed using the minimal data from pdata. Your
argument is probably from the omap-gpio usage style, but there is
nothing much to be bought by moving all the registers to pdata and it
actually makes it more cumbersome. The same data will also be
represented in the DT-binding, so want to keep the minimum possible
information there.

> 
>> +               priv->intr_type = pdata->intr_type;
>> +
>> +               mbox->priv = priv;
>> +               mbox->name = info->name;
>> +               mbox->ops = &omap2_mbox_ops;
>> +               mbox->irq = platform_get_irq(pdev, info->irq_id);
>> +               if (mbox->irq < 0) {
>> +                       ret = mbox->irq;
>> +                       goto free_privblk;
>> +               }
>> +               list[i] = mbox++;
>>         }
>>
>>         mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> -       if (!mem)
>> -               return -ENOENT;
>> +       if (!mem) {
>> +               ret = -ENOENT;
>> +               goto free_privblk;
>> +       }
>>
>>         mbox_base = ioremap(mem->start, resource_size(mem));
>> -       if (!mbox_base)
>> -               return -ENOMEM;
>> +       if (!mbox_base) {
>> +               ret = -ENOMEM;
>> +               goto free_privblk;
>> +       }
>>
>>         ret = omap_mbox_register(&pdev->dev, list);
>> -       if (ret) {
>> -               iounmap(mbox_base);
>> -               return ret;
>> -       }
>> +       if (ret)
>> +               goto unmap_mbox;
>> +       platform_set_drvdata(pdev, list);
>>
>>         return 0;
>> +
>> +unmap_mbox:
>> +       iounmap(mbox_base);
>> +free_privblk:
>> +       kfree(privblk);
>> +free_mboxblk:
>> +       kfree(mboxblk);
>> +free_list:
>> +       kfree(list);
>> +       return ret;
>>  }

[snip]

>>  /*
>> diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
>> index 848b6dc..4065962 100644
>> --- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
>> +++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
>> @@ -29,6 +29,7 @@
>>  #include <linux/platform_data/spi-omap2-mcspi.h>
>>  #include <linux/platform_data/asoc-ti-mcbsp.h>
>>  #include <linux/platform_data/iommu-omap.h>
>> +#include <linux/platform_data/mailbox-omap.h>
>>  #include <plat/dmtimer.h>
>>
>>  #include "omap_hwmod.h"
>> @@ -1861,6 +1862,17 @@ static struct omap_hwmod_class omap44xx_mailbox_hwmod_class = {
>>  };
>>
>>  /* mailbox */
>> +static struct omap_mbox_dev_info omap44xx_mailbox_info[] = {
>> +       { .name = "mbox-ipu", .tx_id = 0, .rx_id = 1 },
>> +       { .name = "mbox-dsp", .tx_id = 3, .rx_id = 2 },
>> +};
>> +
>> +static struct omap_mbox_pdata omap44xx_mailbox_attrs = {
>> +       .intr_type      = MBOX_INTR_CFG_TYPE2,
>> +       .info_cnt       = ARRAY_SIZE(omap44xx_mailbox_info),
>> +       .info           = omap44xx_mailbox_info,
>> +};
>> +
>>  static struct omap_hwmod_irq_info omap44xx_mailbox_irqs[] = {
>>         { .irq = 26 + OMAP44XX_IRQ_GIC_START },
>>         { .irq = -1 }
>> @@ -1877,6 +1889,7 @@ static struct omap_hwmod omap44xx_mailbox_hwmod = {
>>                         .context_offs = OMAP4_RM_L4CFG_MAILBOX_CONTEXT_OFFSET,
>>                 },
>>         },
>> +       .dev_attr       = &omap44xx_mailbox_attrs,
>>  };
>>

Tony,
Sricharan's removal of IRQ lines as part of the OMAP4 hwmod cleanup
would cause the mailbox probe to fail. So, let me know if I need to
drop the changes from the OMAP4 hwmod file. Even for DT boot, we can
instanstiate the mailboxes if the IRQ line is present. I expect these to
be not present once the DT conversion is complete.

regards
Suman
