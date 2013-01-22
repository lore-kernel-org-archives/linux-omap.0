From: Ezequiel Garcia <elezegarcia@gmail.com>
Subject: Re: [PATCH v2 3/3] arm: omap2: gpmc: add DT bindings for OneNAND
Date: Tue, 22 Jan 2013 15:13:45 -0300
Message-ID: <CALF0-+WvfyygnV5A=E8UGc=zp9pab79FzJRe1KywjPw-B4UGZA@mail.gmail.com>
References: <1358634477-25868-1-git-send-email-ezequiel.garcia@free-electrons.com>
	<1358634477-25868-3-git-send-email-ezequiel.garcia@free-electrons.com>
	<20130121123020.GI15707@e106331-lin.cambridge.arm.com>
	<CALF0-+VOxtsfQLZCGujvjMrsGacbfVTMytRUX=CfKa3+FgnU1w@mail.gmail.com>
	<20130121183348.GI22517@atomide.com>
	<af696cd0-8a7f-4839-9600-87d5b9172585@email.android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ie0-f180.google.com ([209.85.223.180]:45658 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751459Ab3AVSNs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Jan 2013 13:13:48 -0500
Received: by mail-ie0-f180.google.com with SMTP id c10so11968396ieb.39
        for <linux-omap@vger.kernel.org>; Tue, 22 Jan 2013 10:13:47 -0800 (PST)
In-Reply-To: <af696cd0-8a7f-4839-9600-87d5b9172585@email.android.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Daniel Mack <zonque@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, Mark Rutland <mark.rutland@arm.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "martinez.javier@gmail.com" <martinez.javier@gmail.com>, "matthias.bgg@googlemail.com" <matthias.bgg@googlemail.com>, "eballetbo@gmail.com" <eballetbo@gmail.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Mon, Jan 21, 2013 at 10:32 PM, Daniel Mack <zonque@gmail.com> wrote:
> Hi Tony, Mark, Ezequiel,
>
> Tony Lindgren <tony@atomide.com> wrote:
>
>>* Ezequiel Garcia <elezegarcia@gmail.com> [130121 09:00]:
>>> Hi Mark,
>>>
>>> On Mon, Jan 21, 2013 at 9:30 AM, Mark Rutland <mark.rutland@arm.com>
>>wrote:
>>> > [...]
>>> >
>>> >> diff --git a/arch/arm/mach-omap2/gpmc.c
>>b/arch/arm/mach-omap2/gpmc.c
>>> >> index 01ce462..f7de9eb 100644
>>> >> --- a/arch/arm/mach-omap2/gpmc.c
>>> >> +++ b/arch/arm/mach-omap2/gpmc.c
>>> >> @@ -39,6 +39,7 @@
>>> >>  #include "omap_device.h"
>>> >>  #include "gpmc.h"
>>> >>  #include "gpmc-nand.h"
>>> >> +#include "gpmc-onenand.h"
>>> >>
>>> >>  #define      DEVICE_NAME             "omap-gpmc"
>>> >>
>>> >> @@ -1259,6 +1260,43 @@ static int gpmc_probe_nand_child(struct
>>platform_device *pdev,
>>> >>  }
>>> >>  #endif
>>> >>
>>> >> +#ifdef CONFIG_MTD_ONENAND
>>> >> +static int gpmc_probe_onenand_child(struct platform_device *pdev,
>>> >> +                              struct device_node *child)
>>> >> +{
>>> >> +     u32 val;
>>> >> +     struct omap_onenand_platform_data *gpmc_onenand_data;
>>> >> +
>>> >> +     if (of_property_read_u32(child, "reg", &val) < 0) {
>>> >> +             dev_err(&pdev->dev, "%s has no 'reg' property\n",
>>> >> +                     child->full_name);
>>> >> +             return -ENODEV;
>>> >> +     }
>>> >> +
>>> >> +     gpmc_onenand_data = devm_kzalloc(&pdev->dev,
>>sizeof(*gpmc_onenand_data),
>>> >> +                                      GFP_KERNEL);
>>> >> +     if (!gpmc_onenand_data)
>>> >> +             return -ENOMEM;
>>> >> +
>>> >> +     gpmc_onenand_data->cs = val;
>>> >> +     gpmc_onenand_data->of_node = child;
>>> >> +     gpmc_onenand_data->dma_channel = -1;
>>> >> +
>>> >> +     if (!of_property_read_u32(child, "dma-channel", &val))
>>> >> +             gpmc_onenand_data->dma_channel = val;
>>> >> +
>>> >> +     gpmc_onenand_init(gpmc_onenand_data);
>>> >> +
>>> >> +     return 0;
>>> >> +}
>>> >> +#else
>>> >> +static int gpmc_probe_onenand_child(struct platform_device *pdev,
>>> >> +                                 struct device_node *child)
>>> >> +{
>>> >> +     return 0;
>>> >> +}
>>> >> +#endif
>>> >> +
>>> >>  static int gpmc_probe_dt(struct platform_device *pdev)
>>> >>  {
>>> >>       int ret;
>>> >> @@ -1276,6 +1314,12 @@ static int gpmc_probe_dt(struct
>>platform_device *pdev)
>>> >>                       return ret;
>>> >>       }
>>> >>
>>> >
>>> > This doesn't look right to me:
>>> >
>>> >> +     for_each_node_by_name(child, "onenand") {
>>> >> +             ret = gpmc_probe_onenand_child(pdev, child);
>>> >> +             of_node_put(child);
>>> >> +             if (ret < 0)
>>> >> +                     return ret;
>>> >> +     }
>>> >
>>> > for_each_node_by_name automatically calls of_node_put on each node
>>once passed,
>>> > and as far as I can tell, gpmc_probe_onenand_child doesn't do
>>anything that'd
>>> > increment a node's refcount.
>>> >
>>> > As far as I can see, you only need the of_node_put in the error
>>case:
>>> >
>>> > for_each_node_by_name(child, "onenand") {
>>> >         ret = gpmc_probe_onenand_child(pdev, child);
>>> >         if (ret < 0) {
>>> >                 of_node_put(child);
>>> >                 return ret;
>>> >         }
>>> > }
>>> >
>>> > Have I missed something here?
>>> >
>>>
>>> Mmm... perhaps I've overlooked that code.
>>>
>>> After some digging through source and reading for_each_node_by_name()
>>> it seems to me you're right.
>>>
>>> @Daniel: It seems this would also apply to the NAND binding.
>>> What do you think?
>>
>>Would prefer this done as a fix against the omap-for-v3.9/gpmc
>>branch before we apply Ezequiel's patches.
>
> I'm currently far away from my computer and can't prepare a patch for this, sorry. But I think you are right, so please just submit a patch for that, anyone :-)
>

Ok, I'll try to submit a patch as soon as possible. If anyone wants to
do it instead, fine by me.

-- 
    Ezequiel
