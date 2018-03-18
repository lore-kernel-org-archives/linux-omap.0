From: Martin Blumenstingl <martin.blumenstingl-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Subject: Re: [PATCH usb-next v10 3/8] usb: core: add a wrapper for the USB
 PHYs on the HCD
Date: Sun, 18 Mar 2018 23:29:17 +0100
Message-ID: <CAFBinCAOG9Yj5PQo4wsxH2Ev6WOwFge+jBMprRiOgxKuA_z8wA@mail.gmail.com>
References: <20180218184504.3331-1-martin.blumenstingl@googlemail.com>
 <20180218184504.3331-4-martin.blumenstingl@googlemail.com>
 <7f511a6f-f3a2-2002-f601-5ce1742f4539@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <7f511a6f-f3a2-2002-f601-5ce1742f4539-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mediatek/>
List-Post: <mailto:linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-mediatek" <linux-mediatek-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>, Chunfeng Yun <chunfeng.yun-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Cc: mark.rutland-5wv7dgnIgG8@public.gmane.org, Peter.Chen-3arQi8VN3Tc@public.gmane.org, Neil Armstrong <narmstrong-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, KISHON VIJAY ABRAHAM <kishon-l0cyMroinI0@public.gmane.org>, linux-ci5G2KO2hbZ+pU9mqzGVBQ@public.gmane.org, felipe.balbi-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, yixun.lan-LpR1jeaWuhtBDgjK7y7TUQ@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-amlogic-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, "Gerlach,
 Dave" <d-gerlach-l0cyMroinI0@public.gmane.org>, Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, mathias.nyman-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi Roger,

On Fri, Mar 16, 2018 at 3:32 PM, Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org> wrote:
> +some TI folks
>
> Hi Martin,
>
> On 18/02/18 20:44, Martin Blumenstingl wrote:
>> Many SoC platforms have separate devices for the USB PHY which are
>> registered through the generic PHY framework. These PHYs have to be
>> enabled to make the USB controller actually work. They also have to be
>> disabled again on shutdown/suspend.
>>
>> Currently (at least) the following HCI platform drivers are using custom
>> code to obtain all PHYs via devicetree for the roothub/controller and
>> disable/enable them when required:
>> - ehci-platform.c has ehci_platform_power_{on,off}
>> - xhci-mtk.c has xhci_mtk_phy_{init,exit,power_on,power_off}
>> - ohci-platform.c has ohci_platform_power_{on,off}
>>
>> With this new wrapper the USB PHYs can be specified directly in the
>> USB controller's devicetree node (just like on the drivers listed
>> above). This allows SoCs like the Amlogic Meson GXL family to operate
>> correctly once this is wired up correctly. These SoCs use a dwc3
>> controller and require all USB PHYs to be initialized (if one of the USB
>> PHYs it not initialized then none of USB port works at all).
>>
>> Signed-off-by: Martin Blumenstingl <martin.blumenstingl-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
>> Tested-by: Yixun Lan <yixun.lan-LpR1jeaWuhtBDgjK7y7TUQ@public.gmane.org>
>> Cc: Neil Armstrong <narmstrong-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
>> Cc: Chunfeng Yun <chunfeng.yun-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
>
> This patch is breaking low power cases on TI SoCs when USB is in host mode.
> I'll explain why below.
based on your explanation and reading the TI PHY drivers I am assuming
that the affected SoCs are using the "phy-omap-usb2" driver

>> ---
>>  drivers/usb/core/Makefile |   2 +-
>>  drivers/usb/core/phy.c    | 158 ++++++++++++++++++++++++++++++++++++++++++++++
>>  drivers/usb/core/phy.h    |   7 ++
>>  3 files changed, 166 insertions(+), 1 deletion(-)
>>  create mode 100644 drivers/usb/core/phy.c
>>  create mode 100644 drivers/usb/core/phy.h
>>
>> diff --git a/drivers/usb/core/Makefile b/drivers/usb/core/Makefile
>> index 92c9cefb4317..18e874b0441e 100644
>> --- a/drivers/usb/core/Makefile
>> +++ b/drivers/usb/core/Makefile
>> @@ -6,7 +6,7 @@
>>  usbcore-y := usb.o hub.o hcd.o urb.o message.o driver.o
>>  usbcore-y += config.o file.o buffer.o sysfs.o endpoint.o
>>  usbcore-y += devio.o notify.o generic.o quirks.o devices.o
>> -usbcore-y += port.o
>> +usbcore-y += phy.o port.o
>>
>>  usbcore-$(CONFIG_OF)         += of.o
>>  usbcore-$(CONFIG_USB_PCI)            += hcd-pci.o
>> diff --git a/drivers/usb/core/phy.c b/drivers/usb/core/phy.c
>> new file mode 100644
>> index 000000000000..09b7c43c0ea4
>> --- /dev/null
>> +++ b/drivers/usb/core/phy.c
>> @@ -0,0 +1,158 @@
>> +// SPDX-License-Identifier: GPL-2.0+
>> +/*
>> + * A wrapper for multiple PHYs which passes all phy_* function calls to
>> + * multiple (actual) PHY devices. This is comes handy when initializing
>> + * all PHYs on a HCD and to keep them all in the same state.
>> + *
>> + * Copyright (C) 2018 Martin Blumenstingl <martin.blumenstingl-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
>> + */
>> +
>> +#include <linux/device.h>
>> +#include <linux/list.h>
>> +#include <linux/phy/phy.h>
>> +#include <linux/of.h>
>> +
>> +#include "phy.h"
>> +
>> +struct usb_phy_roothub {
>> +     struct phy              *phy;
>> +     struct list_head        list;
>> +};
>> +
>> +static struct usb_phy_roothub *usb_phy_roothub_alloc(struct device *dev)
>> +{
>> +     struct usb_phy_roothub *roothub_entry;
>> +
>> +     roothub_entry = devm_kzalloc(dev, sizeof(*roothub_entry), GFP_KERNEL);
>> +     if (!roothub_entry)
>> +             return ERR_PTR(-ENOMEM);
>> +
>> +     INIT_LIST_HEAD(&roothub_entry->list);
>> +
>> +     return roothub_entry;
>> +}
>> +
>> +static int usb_phy_roothub_add_phy(struct device *dev, int index,
>> +                                struct list_head *list)
>> +{
>> +     struct usb_phy_roothub *roothub_entry;
>> +     struct phy *phy = devm_of_phy_get_by_index(dev, dev->of_node, index);
>> +
>> +     if (IS_ERR_OR_NULL(phy)) {
>> +             if (!phy || PTR_ERR(phy) == -ENODEV)
>> +                     return 0;
>> +             else
>> +                     return PTR_ERR(phy);
>> +     }
>> +
>> +     roothub_entry = usb_phy_roothub_alloc(dev);
>> +     if (IS_ERR(roothub_entry))
>> +             return PTR_ERR(roothub_entry);
>> +
>> +     roothub_entry->phy = phy;
>> +
>> +     list_add_tail(&roothub_entry->list, list);
>> +
>> +     return 0;
>> +}
>> +
>> +struct usb_phy_roothub *usb_phy_roothub_init(struct device *dev)
>> +{
>> +     struct usb_phy_roothub *phy_roothub;
>> +     struct usb_phy_roothub *roothub_entry;
>> +     struct list_head *head;
>> +     int i, num_phys, err;
>> +
>> +     num_phys = of_count_phandle_with_args(dev->of_node, "phys",
>> +                                           "#phy-cells");
>> +     if (num_phys <= 0)
>> +             return NULL;
>> +
>> +     phy_roothub = usb_phy_roothub_alloc(dev);
>> +     if (IS_ERR(phy_roothub))
>> +             return phy_roothub;
>> +
>> +     for (i = 0; i < num_phys; i++) {
>> +             err = usb_phy_roothub_add_phy(dev, i, &phy_roothub->list);
>> +             if (err)
>> +                     goto err_out;
>> +     }
>> +
>> +     head = &phy_roothub->list;
>> +
>> +     list_for_each_entry(roothub_entry, head, list) {
>> +             err = phy_init(roothub_entry->phy);
>
> The phy_init() function actually enables the PHY clocks.
> It should be moved to the usb_phy_roothub_exit() routine just before calling phy_power_on().
do you mean that phy_init should be moved to usb_phy_roothub_power_on
(just before phy_power_on is called within usb_phy_roothub_power_on)?

an earlier version of my patch did exactly this, but it caused
problems during a suspend/resume cycle on Mediatek devices
Chunfeng Yun reported that issue here [0], quote from that mail for
easier reading:
"In order to keep link state on mt8173, we just power off all phys(not
exit) when system enter suspend, then power on them again (needn't
init, otherwise device will be disconnected) when system resume, this
can avoid re-enumerating device."

>> +             if (err)
>> +                     goto err_exit_phys;
>> +     }
>> +
>> +     return phy_roothub;
>> +
>> +err_exit_phys:
>> +     list_for_each_entry_continue_reverse(roothub_entry, head, list)
>> +             phy_exit(roothub_entry->phy);
>> +
>> +err_out:
>> +     return ERR_PTR(err);
>> +}
>> +EXPORT_SYMBOL_GPL(usb_phy_roothub_init);
>> +
>> +int usb_phy_roothub_exit(struct usb_phy_roothub *phy_roothub)
>> +{
>> +     struct usb_phy_roothub *roothub_entry;
>> +     struct list_head *head;
>> +     int err, ret = 0;
>> +
>> +     if (!phy_roothub)
>> +             return 0;
>> +
>> +     head = &phy_roothub->list;
>> +
>> +     list_for_each_entry(roothub_entry, head, list) {
>> +             err = phy_exit(roothub_entry->phy);
>> +             if (err)
>> +                     ret = ret;
>> +     }
>
> phy_exit() should be moved to usb_phy_roothub_poweroff() just after calling phy_power_off().
if I understood Chunfeng Yun correctly this will require
re-enumeration of the USB devices after a suspend/resume cycle on
Mediatek SoCs

> With that there is nothing else being done here. Shouldn't we be doing the equivalent of
> usb_phy_roothub_del_phy() and usb_phy_roothub_free() here?
>
>> +
>> +     return ret;
>> +}
>> +EXPORT_SYMBOL_GPL(usb_phy_roothub_exit);
>> +
>> +int usb_phy_roothub_power_on(struct usb_phy_roothub *phy_roothub)
>> +{
>> +     struct usb_phy_roothub *roothub_entry;
>> +     struct list_head *head;
>> +     int err;
>> +
>> +     if (!phy_roothub)
>> +             return 0;
>> +
>> +     head = &phy_roothub->list;
>> +
>> +     list_for_each_entry(roothub_entry, head, list) {
>> +             err = phy_power_on(roothub_entry->phy);
>> +             if (err)
>> +                     goto err_out;
>> +     }
>> +
>> +     return 0;
>> +
>> +err_out:
>> +     list_for_each_entry_continue_reverse(roothub_entry, head, list)
>> +             phy_power_off(roothub_entry->phy);
>> +
>> +     return err;
>> +}
>> +EXPORT_SYMBOL_GPL(usb_phy_roothub_power_on);
>> +
>> +void usb_phy_roothub_power_off(struct usb_phy_roothub *phy_roothub)
>> +{
>> +     struct usb_phy_roothub *roothub_entry;
>> +
>> +     if (!phy_roothub)
>> +             return;
>> +
>> +     list_for_each_entry_reverse(roothub_entry, &phy_roothub->list, list)
>> +             phy_power_off(roothub_entry->phy);
>
> Not doing the phy_exit() here leaves the clocks enabled on our SoC and
> we're no longer able to reach low power states on system suspend.
I'm not sure where this problem should be solved:
- set skip_phy_initialization in struct usb_hcd to 1 for the affected
TI platforms
- fix this in the usb_phy_roothub code
- fix this in the PHY driver
- somewhere else

>> +}
>> +EXPORT_SYMBOL_GPL(usb_phy_roothub_power_off);
>> diff --git a/drivers/usb/core/phy.h b/drivers/usb/core/phy.h
>> new file mode 100644
>> index 000000000000..6fde59bfbff8
>> --- /dev/null
>> +++ b/drivers/usb/core/phy.h
>> @@ -0,0 +1,7 @@
>> +struct usb_phy_roothub;
>> +
>> +struct usb_phy_roothub *usb_phy_roothub_init(struct device *dev);
>> +int usb_phy_roothub_exit(struct usb_phy_roothub *phy_roothub);
>> +
>> +int usb_phy_roothub_power_on(struct usb_phy_roothub *phy_roothub);
>> +void usb_phy_roothub_power_off(struct usb_phy_roothub *phy_roothub);
>>
>
> The following patch fixes the issue for me. Let me know what you think and I can post it officially.
Chunfeng: could you please test whether this patch breaks the
suspend/resume cycle on your Mediatek platforms? see [0] where I used
a similar approach with a much older version of the "initialize
multiple PHYs per HCD" patch

> diff --git a/drivers/usb/core/phy.c b/drivers/usb/core/phy.c
> index 09b7c43..23232d3 100644
> --- a/drivers/usb/core/phy.c
> +++ b/drivers/usb/core/phy.c
> @@ -59,8 +59,6 @@ static int usb_phy_roothub_add_phy(struct device *dev, int index,
>  struct usb_phy_roothub *usb_phy_roothub_init(struct device *dev)
>  {
>         struct usb_phy_roothub *phy_roothub;
> -       struct usb_phy_roothub *roothub_entry;
> -       struct list_head *head;
>         int i, num_phys, err;
>
>         num_phys = of_count_phandle_with_args(dev->of_node, "phys",
> @@ -75,25 +73,10 @@ struct usb_phy_roothub *usb_phy_roothub_init(struct device *dev)
>         for (i = 0; i < num_phys; i++) {
>                 err = usb_phy_roothub_add_phy(dev, i, &phy_roothub->list);
>                 if (err)
> -                       goto err_out;
> -       }
> -
> -       head = &phy_roothub->list;
> -
> -       list_for_each_entry(roothub_entry, head, list) {
> -               err = phy_init(roothub_entry->phy);
> -               if (err)
> -                       goto err_exit_phys;
> +                       return ERR_PTR(err);
>         }
>
>         return phy_roothub;
> -
> -err_exit_phys:
> -       list_for_each_entry_continue_reverse(roothub_entry, head, list)
> -               phy_exit(roothub_entry->phy);
> -
> -err_out:
> -       return ERR_PTR(err);
>  }
>  EXPORT_SYMBOL_GPL(usb_phy_roothub_init);
>
> @@ -106,13 +89,8 @@ int usb_phy_roothub_exit(struct usb_phy_roothub *phy_roothub)
>         if (!phy_roothub)
>                 return 0;
>
> -       head = &phy_roothub->list;
> -
> -       list_for_each_entry(roothub_entry, head, list) {
> -               err = phy_exit(roothub_entry->phy);
> -               if (err)
> -                       ret = ret;
> -       }
> +       /* TODO: usb_phy_roothub_del_phy */
> +       /* TODO: usb_phy_roothub_free */
>
>         return ret;
>  }
> @@ -130,16 +108,23 @@ int usb_phy_roothub_power_on(struct usb_phy_roothub *phy_roothub)
>         head = &phy_roothub->list;
>
>         list_for_each_entry(roothub_entry, head, list) {
> -               err = phy_power_on(roothub_entry->phy);
> +               err = phy_init(roothub_entry->phy);
>                 if (err)
>                         goto err_out;
> +               err = phy_power_on(roothub_entry->phy);
> +               if (err) {
> +                       phy_exit(roothub_entry->phy);
> +                       goto err_out;
> +               }
>         }
>
>         return 0;
>
>  err_out:
> -       list_for_each_entry_continue_reverse(roothub_entry, head, list)
> +       list_for_each_entry_continue_reverse(roothub_entry, head, list) {
>                 phy_power_off(roothub_entry->phy);
> +               phy_exit(roothub_entry->phy);
> +       }
>
>         return err;
>  }
> @@ -152,7 +137,9 @@ void usb_phy_roothub_power_off(struct usb_phy_roothub *phy_roothub)
>         if (!phy_roothub)
>                 return;
>
> -       list_for_each_entry_reverse(roothub_entry, &phy_roothub->list, list)
> +       list_for_each_entry_reverse(roothub_entry, &phy_roothub->list, list) {
>                 phy_power_off(roothub_entry->phy);
> +               phy_exit(roothub_entry->phy);
> +       }
>  }
>  EXPORT_SYMBOL_GPL(usb_phy_roothub_power_off);
>
>
> --
> cheers,
> -roger
>
> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki


Regards
Martin


[0] http://lists.infradead.org/pipermail/linux-amlogic/2017-July/004374.html
