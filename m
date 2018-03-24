From: Martin Blumenstingl <martin.blumenstingl-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Subject: Re: [PATCH usb-next v10 3/8] usb: core: add a wrapper for the USB
 PHYs on the HCD
Date: Sat, 24 Mar 2018 12:23:18 +0100
Message-ID: <CAFBinCA_H1y6DhTaMRr1CnDwfARMGbhtwB=L15eX_KjPCvzTQw@mail.gmail.com>
References: <20180218184504.3331-1-martin.blumenstingl@googlemail.com>
 <20180218184504.3331-4-martin.blumenstingl@googlemail.com>
 <7f511a6f-f3a2-2002-f601-5ce1742f4539@ti.com>
 <CAFBinCAOG9Yj5PQo4wsxH2Ev6WOwFge+jBMprRiOgxKuA_z8wA@mail.gmail.com>
 <e723fe80-1ff3-6f47-fbbd-699dfcd0be4f@ti.com>
 <CAFBinCBB2eqHC-k9wN67ZehKb9eun=mPaLuqhrbR-J1C0Ldqtw@mail.gmail.com>
 <1521547467.3717.92.camel@mhfsdcap03>
 <CAFBinCC7X08oVt223FeZHSqmbCry9aKA8JXz+WmLuDRwwtr+gQ@mail.gmail.com>
 <613ebb74-6167-56bc-6fa0-2b3c9876ccaa@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <613ebb74-6167-56bc-6fa0-2b3c9876ccaa-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mediatek/>
List-Post: <mailto:linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-mediatek" <linux-mediatek-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Cc: mark.rutland-5wv7dgnIgG8@public.gmane.org, Peter.Chen-3arQi8VN3Tc@public.gmane.org, Neil Armstrong <narmstrong-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, KISHON VIJAY ABRAHAM <kishon-l0cyMroinI0@public.gmane.org>, linux-ci5G2KO2hbZ+pU9mqzGVBQ@public.gmane.org, felipe.balbi-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org, Chunfeng Yun <chunfeng.yun-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, yixun.lan-LpR1jeaWuhtBDgjK7y7TUQ@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-amlogic-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, "Gerlach,
 Dave" <d-gerlach-l0cyMroinI0@public.gmane.org>, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, mathias.nyman-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi Roger,

On Wed, Mar 21, 2018 at 12:30 PM, Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org> wrote:
> Martin,
>
> On 21/03/18 00:01, Martin Blumenstingl wrote:
>> Hi Roger, Hi Chunfeng,
>>
>> On Tue, Mar 20, 2018 at 1:04 PM, Chunfeng Yun <chunfeng.yun-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org> wrote:
>>> Hi Martin & Roger:
>>>
>>> On Mon, 2018-03-19 at 17:12 +0100, Martin Blumenstingl wrote:
>>>> Hi Roger,
>>>>
>>>> On Mon, Mar 19, 2018 at 9:49 AM, Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org> wrote:
>>>>> Hi,
>>>>>
>>>>> On 19/03/18 00:29, Martin Blumenstingl wrote:
>>>>>> Hi Roger,
>>>>>>
>>>>>> On Fri, Mar 16, 2018 at 3:32 PM, Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org> wrote:
>>>>>>> +some TI folks
>>>>>>>
>>>>>>> Hi Martin,
>>>>>>>
>>>>>>> On 18/02/18 20:44, Martin Blumenstingl wrote:
>>>>>>>> Many SoC platforms have separate devices for the USB PHY which are
>>>>>>>> registered through the generic PHY framework. These PHYs have to be
>>>>>>>> enabled to make the USB controller actually work. They also have to be
>>>>>>>> disabled again on shutdown/suspend.
>>>>>>>>
>>>>>>>> Currently (at least) the following HCI platform drivers are using custom
>>>>>>>> code to obtain all PHYs via devicetree for the roothub/controller and
>>>>>>>> disable/enable them when required:
>>>>>>>> - ehci-platform.c has ehci_platform_power_{on,off}
>>>>>>>> - xhci-mtk.c has xhci_mtk_phy_{init,exit,power_on,power_off}
>>>>>>>> - ohci-platform.c has ohci_platform_power_{on,off}
>>>>>>>>
>>>>>>>> With this new wrapper the USB PHYs can be specified directly in the
>>>>>>>> USB controller's devicetree node (just like on the drivers listed
>>>>>>>> above). This allows SoCs like the Amlogic Meson GXL family to operate
>>>>>>>> correctly once this is wired up correctly. These SoCs use a dwc3
>>>>>>>> controller and require all USB PHYs to be initialized (if one of the USB
>>>>>>>> PHYs it not initialized then none of USB port works at all).
>>>>>>>>
>>>>>>>> Signed-off-by: Martin Blumenstingl <martin.blumenstingl-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
>>>>>>>> Tested-by: Yixun Lan <yixun.lan-LpR1jeaWuhtBDgjK7y7TUQ@public.gmane.org>
>>>>>>>> Cc: Neil Armstrong <narmstrong-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
>>>>>>>> Cc: Chunfeng Yun <chunfeng.yun-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
>>>>>>>
>>>>>>> This patch is breaking low power cases on TI SoCs when USB is in host mode.
>>>>>>> I'll explain why below.
>>>>>> based on your explanation and reading the TI PHY drivers I am assuming
>>>>>> that the affected SoCs are using the "phy-omap-usb2" driver
>>>>>>
>>>>> yes and phy-ti-pipe3 as well i.e. "ti,phy-usb3" and "ti,omap-usb3"
>>>> I missed that, thanks
>>>>
>>>>>>>> ---
>>>>>>>>  drivers/usb/core/Makefile |   2 +-
>>>>>>>>  drivers/usb/core/phy.c    | 158 ++++++++++++++++++++++++++++++++++++++++++++++
>>>>>>>>  drivers/usb/core/phy.h    |   7 ++
>>>>>>>>  3 files changed, 166 insertions(+), 1 deletion(-)
>>>>>>>>  create mode 100644 drivers/usb/core/phy.c
>>>>>>>>  create mode 100644 drivers/usb/core/phy.h
>>>>>>>>
>>>>>>>> diff --git a/drivers/usb/core/Makefile b/drivers/usb/core/Makefile
>>>>>>>> index 92c9cefb4317..18e874b0441e 100644
>>>>>>>> --- a/drivers/usb/core/Makefile
>>>>>>>> +++ b/drivers/usb/core/Makefile
>>>>>>>> @@ -6,7 +6,7 @@
>>>>>>>>  usbcore-y := usb.o hub.o hcd.o urb.o message.o driver.o
>>>>>>>>  usbcore-y += config.o file.o buffer.o sysfs.o endpoint.o
>>>>>>>>  usbcore-y += devio.o notify.o generic.o quirks.o devices.o
>>>>>>>> -usbcore-y += port.o
>>>>>>>> +usbcore-y += phy.o port.o
>>>>>>>>
>>>>>>>>  usbcore-$(CONFIG_OF)         += of.o
>>>>>>>>  usbcore-$(CONFIG_USB_PCI)            += hcd-pci.o
>>>>>>>> diff --git a/drivers/usb/core/phy.c b/drivers/usb/core/phy.c
>>>>>>>> new file mode 100644
>>>>>>>> index 000000000000..09b7c43c0ea4
>>>>>>>> --- /dev/null
>>>>>>>> +++ b/drivers/usb/core/phy.c
>>>>>>>> @@ -0,0 +1,158 @@
>>>>>>>> +// SPDX-License-Identifier: GPL-2.0+
>>>>>>>> +/*
>>>>>>>> + * A wrapper for multiple PHYs which passes all phy_* function calls to
>>>>>>>> + * multiple (actual) PHY devices. This is comes handy when initializing
>>>>>>>> + * all PHYs on a HCD and to keep them all in the same state.
>>>>>>>> + *
>>>>>>>> + * Copyright (C) 2018 Martin Blumenstingl <martin.blumenstingl-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
>>>>>>>> + */
>>>>>>>> +
>>>>>>>> +#include <linux/device.h>
>>>>>>>> +#include <linux/list.h>
>>>>>>>> +#include <linux/phy/phy.h>
>>>>>>>> +#include <linux/of.h>
>>>>>>>> +
>>>>>>>> +#include "phy.h"
>>>>>>>> +
>>>>>>>> +struct usb_phy_roothub {
>>>>>>>> +     struct phy              *phy;
>>>>>>>> +     struct list_head        list;
>>>>>>>> +};
>>>>>>>> +
>>>>>>>> +static struct usb_phy_roothub *usb_phy_roothub_alloc(struct device *dev)
>>>>>>>> +{
>>>>>>>> +     struct usb_phy_roothub *roothub_entry;
>>>>>>>> +
>>>>>>>> +     roothub_entry = devm_kzalloc(dev, sizeof(*roothub_entry), GFP_KERNEL);
>>>>>>>> +     if (!roothub_entry)
>>>>>>>> +             return ERR_PTR(-ENOMEM);
>>>>>>>> +
>>>>>>>> +     INIT_LIST_HEAD(&roothub_entry->list);
>>>>>>>> +
>>>>>>>> +     return roothub_entry;
>>>>>>>> +}
>>>>>>>> +
>>>>>>>> +static int usb_phy_roothub_add_phy(struct device *dev, int index,
>>>>>>>> +                                struct list_head *list)
>>>>>>>> +{
>>>>>>>> +     struct usb_phy_roothub *roothub_entry;
>>>>>>>> +     struct phy *phy = devm_of_phy_get_by_index(dev, dev->of_node, index);
>>>>>>>> +
>>>>>>>> +     if (IS_ERR_OR_NULL(phy)) {
>>>>>>>> +             if (!phy || PTR_ERR(phy) == -ENODEV)
>>>>>>>> +                     return 0;
>>>>>>>> +             else
>>>>>>>> +                     return PTR_ERR(phy);
>>>>>>>> +     }
>>>>>>>> +
>>>>>>>> +     roothub_entry = usb_phy_roothub_alloc(dev);
>>>>>>>> +     if (IS_ERR(roothub_entry))
>>>>>>>> +             return PTR_ERR(roothub_entry);
>>>>>>>> +
>>>>>>>> +     roothub_entry->phy = phy;
>>>>>>>> +
>>>>>>>> +     list_add_tail(&roothub_entry->list, list);
>>>>>>>> +
>>>>>>>> +     return 0;
>>>>>>>> +}
>>>>>>>> +
>>>>>>>> +struct usb_phy_roothub *usb_phy_roothub_init(struct device *dev)
>>>>>>>> +{
>>>>>>>> +     struct usb_phy_roothub *phy_roothub;
>>>>>>>> +     struct usb_phy_roothub *roothub_entry;
>>>>>>>> +     struct list_head *head;
>>>>>>>> +     int i, num_phys, err;
>>>>>>>> +
>>>>>>>> +     num_phys = of_count_phandle_with_args(dev->of_node, "phys",
>>>>>>>> +                                           "#phy-cells");
>>>>>>>> +     if (num_phys <= 0)
>>>>>>>> +             return NULL;
>>>>>>>> +
>>>>>>>> +     phy_roothub = usb_phy_roothub_alloc(dev);
>>>>>>>> +     if (IS_ERR(phy_roothub))
>>>>>>>> +             return phy_roothub;
>>>>>>>> +
>>>>>>>> +     for (i = 0; i < num_phys; i++) {
>>>>>>>> +             err = usb_phy_roothub_add_phy(dev, i, &phy_roothub->list);
>>>>>>>> +             if (err)
>>>>>>>> +                     goto err_out;
>>>>>>>> +     }
>>>>>>>> +
>>>>>>>> +     head = &phy_roothub->list;
>>>>>>>> +
>>>>>>>> +     list_for_each_entry(roothub_entry, head, list) {
>>>>>>>> +             err = phy_init(roothub_entry->phy);
>>>>>>>
>>>>>>> The phy_init() function actually enables the PHY clocks.
>>>>>>> It should be moved to the usb_phy_roothub_exit() routine just before calling phy_power_on().
>>>>>> do you mean that phy_init should be moved to usb_phy_roothub_power_on
>>>>>> (just before phy_power_on is called within usb_phy_roothub_power_on)?
>>>>>>
>>>>>
>>>>> Yes.
>>>>>
>>>>>> an earlier version of my patch did exactly this, but it caused
>>>>>> problems during a suspend/resume cycle on Mediatek devices
>>>>>> Chunfeng Yun reported that issue here [0], quote from that mail for
>>>>>> easier reading:
>>>>>> "In order to keep link state on mt8173, we just power off all phys(not
>>>>>> exit) when system enter suspend, then power on them again (needn't
>>>>>> init, otherwise device will be disconnected) when system resume, this
>>>>>> can avoid re-enumerating device."
>>>>>>
>>>>>>>> +             if (err)
>>>>>>>> +                     goto err_exit_phys;
>>>>>>>> +     }
>>>>>>>> +
>>>>>>>> +     return phy_roothub;
>>>>>>>> +
>>>>>>>> +err_exit_phys:
>>>>>>>> +     list_for_each_entry_continue_reverse(roothub_entry, head, list)
>>>>>>>> +             phy_exit(roothub_entry->phy);
>>>>>>>> +
>>>>>>>> +err_out:
>>>>>>>> +     return ERR_PTR(err);
>>>>>>>> +}
>>>>>>>> +EXPORT_SYMBOL_GPL(usb_phy_roothub_init);
>>>>>>>> +
>>>>>>>> +int usb_phy_roothub_exit(struct usb_phy_roothub *phy_roothub)
>>>>>>>> +{
>>>>>>>> +     struct usb_phy_roothub *roothub_entry;
>>>>>>>> +     struct list_head *head;
>>>>>>>> +     int err, ret = 0;
>>>>>>>> +
>>>>>>>> +     if (!phy_roothub)
>>>>>>>> +             return 0;
>>>>>>>> +
>>>>>>>> +     head = &phy_roothub->list;
>>>>>>>> +
>>>>>>>> +     list_for_each_entry(roothub_entry, head, list) {
>>>>>>>> +             err = phy_exit(roothub_entry->phy);
>>>>>>>> +             if (err)
>>>>>>>> +                     ret = ret;
>>>>>>>> +     }
>>>>>>>
>>>>>>> phy_exit() should be moved to usb_phy_roothub_poweroff() just after calling phy_power_off().
>>>>>> if I understood Chunfeng Yun correctly this will require
>>>>>> re-enumeration of the USB devices after a suspend/resume cycle on
>>>>>> Mediatek SoCs
>>>>>>
>>>>>
>>>>> OK. I suppose that there are 2 cases
>>>>> 1) Mediatek's case: USB controller context retained across suspend/resume.
>>>>> Remote wakeup probably required.
>>>>> No re-enumeration preferred after resume. phy_exit()/phy_init() must not be called
>>>>> during suspend/resume to keep PHY link active.
>>>> Documentation/devicetree/bindings/usb/mediatek,mtu3.txt indeed shows
>>>> that the parent of the USB controller can be marked as "wakeup-source"
>>>>
>>>>> 2) TI's case: low power important: USB context is lost, OK to re-enumerate.
>>>>> phy_exit()/phy_init() must be called during suspend/resume.
>>>> ACK
>>>>
>>>>>>> With that there is nothing else being done here. Shouldn't we be doing the equivalent of
>>>>>>> usb_phy_roothub_del_phy() and usb_phy_roothub_free() here?
>>>>>>>
>>>>>>>> +
>>>>>>>> +     return ret;
>>>>>>>> +}
>>>>>>>> +EXPORT_SYMBOL_GPL(usb_phy_roothub_exit);
>>>>>>>> +
>>>>>>>> +int usb_phy_roothub_power_on(struct usb_phy_roothub *phy_roothub)
>>>>>>>> +{
>>>>>>>> +     struct usb_phy_roothub *roothub_entry;
>>>>>>>> +     struct list_head *head;
>>>>>>>> +     int err;
>>>>>>>> +
>>>>>>>> +     if (!phy_roothub)
>>>>>>>> +             return 0;
>>>>>>>> +
>>>>>>>> +     head = &phy_roothub->list;
>>>>>>>> +
>>>>>>>> +     list_for_each_entry(roothub_entry, head, list) {
>>>>>>>> +             err = phy_power_on(roothub_entry->phy);
>>>>>>>> +             if (err)
>>>>>>>> +                     goto err_out;
>>>>>>>> +     }
>>>>>>>> +
>>>>>>>> +     return 0;
>>>>>>>> +
>>>>>>>> +err_out:
>>>>>>>> +     list_for_each_entry_continue_reverse(roothub_entry, head, list)
>>>>>>>> +             phy_power_off(roothub_entry->phy);
>>>>>>>> +
>>>>>>>> +     return err;
>>>>>>>> +}
>>>>>>>> +EXPORT_SYMBOL_GPL(usb_phy_roothub_power_on);
>>>>>>>> +
>>>>>>>> +void usb_phy_roothub_power_off(struct usb_phy_roothub *phy_roothub)
>>>>>>>> +{
>>>>>>>> +     struct usb_phy_roothub *roothub_entry;
>>>>>>>> +
>>>>>>>> +     if (!phy_roothub)
>>>>>>>> +             return;
>>>>>>>> +
>>>>>>>> +     list_for_each_entry_reverse(roothub_entry, &phy_roothub->list, list)
>>>>>>>> +             phy_power_off(roothub_entry->phy);
>>>>>>>
>>>>>>> Not doing the phy_exit() here leaves the clocks enabled on our SoC and
>>>>>>> we're no longer able to reach low power states on system suspend.
>>>>>> I'm not sure where this problem should be solved:
>>>>>> - set skip_phy_initialization in struct usb_hcd to 1 for the affected
>>>>>> TI platforms
>>>>>
>>>>> Many TI platforms are affected, omap5*, dra7*, am43*
>>>>>
>>>>>> - fix this in the usb_phy_roothub code
>>>>>
>>>>> I'd vote for fixing it in the usb_phy_roothub code. How?
>>>>> How about using the device_can_wakeup() to decide if we should call phy_exit()/init() or not?
>>>>> If the USB device can't wakeup the system there is no point in keeping it powered/clocked right?
>>>> @Chunfeng: can you confirm Roger's idea that we could call phy_exit if
>>>> the controller is *NOT* marked as "wakeup-source"?
>>>> I am also not sure if it would work, since the "wakeup-source"
>>>> property is defined on the USB controller's parent node in case of the
>>>> Mediatek MTU3 (Mediatek USB3.0 DRD) controller
>>>>
>>> Very sorry, I forgot that MTU3 & xHCI drivers always set them as wakeup
>>> devices by device_init_wakeup(dev, true),but not dependent on
>>> "wakeup-source" property, so maybe we can use device_can_wakeup() to
>>> decide whether call phy_exit()/init() or not.
>> the 64-bit Amlogic Meson GXL/GXM SoCs don't support suspend/resume
>> yet, so I cannot test this
>> based on this suggestion I threw up two patches which are *compile
>> tested only* based on Greg's usb-next branch
>> you can find them here: [0] (as well as attached to this mail)
>>
>> @Chunfeng: can you please test this on one of your Mediatek SoCs?
>> @Roger: can you please test this on a TI SoC?
>>
>> (apologies in advance if these patches don't work)
>>
>> please note that I won't have access to my computer until Saturday.
>> if these patches need to be rewritten/replaced/etc. then feel free to
>> send your own version to the list
>
> Had to do the following to build
>
> diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
> index 6d4a419..2884607 100644
> --- a/drivers/usb/core/hcd.c
> +++ b/drivers/usb/core/hcd.c
> @@ -2262,7 +2262,7 @@ int hcd_bus_suspend(struct usb_device *rhdev, pm_message_t msg)
>                 hcd->state = HC_STATE_SUSPENDED;
>
>                 if (!PMSG_IS_AUTO(msg))
> -                       usb_phy_roothub_suspend(hcd->phy_roothub);
> +                       usb_phy_roothub_suspend(&rhdev->dev, hcd->phy_roothub);
>
>                 /* Did we race with a root-hub wakeup event? */
>                 if (rhdev->do_remote_wakeup) {
> @@ -2302,7 +2302,7 @@ int hcd_bus_resume(struct usb_device *rhdev, pm_message_t msg)
>         }
>
>         if (!PMSG_IS_AUTO(msg)) {
> -               status = usb_phy_roothub_resume(hcd->phy_roothub);
> +               status = usb_phy_roothub_resume(&rhdev->dev, hcd->phy_roothub);
>                 if (status)
>                         return status;
>         }
> @@ -2344,7 +2344,7 @@ int hcd_bus_resume(struct usb_device *rhdev, pm_message_t msg)
>                 }
>         } else {
>                 hcd->state = old_state;
> -               usb_phy_roothub_suspend(hcd->phy_roothub);
> +               usb_phy_roothub_suspend(&rhdev->dev, hcd->phy_roothub);
>                 dev_dbg(&rhdev->dev, "bus %s fail, err %d\n",
>                                 "resume", status);
>                 if (status != -ESHUTDOWN)
>
>
> And the following to fix runtime issues
>
> diff --git a/drivers/usb/core/phy.c b/drivers/usb/core/phy.c
> index 2eca371..8598906 100644
> --- a/drivers/usb/core/phy.c
> +++ b/drivers/usb/core/phy.c
> @@ -32,9 +32,9 @@ static int usb_phy_roothub_add_phy(struct device *dev, int index,
>                         return PTR_ERR(phy);
>         }
>
> -       roothub_entry = usb_phy_roothub_alloc(dev);
> -       if (IS_ERR(roothub_entry))
> -               return PTR_ERR(roothub_entry);
> +       roothub_entry = devm_kzalloc(dev, sizeof(*roothub_entry), GFP_KERNEL);
> +       if (!roothub_entry)
> +               return -ENOMEM;
>
>         roothub_entry->phy = phy;
>
> @@ -162,7 +162,7 @@ int usb_phy_roothub_suspend(struct device *dev,
>         usb_phy_roothub_power_off(phy_roothub);
>
>         /* keep the PHYs initialized so the device can wake up the system */
> -       if (device_can_wakeup(dev))
> +       if (device_may_wakeup(dev))
>                 return 0;
>
>         return usb_phy_roothub_exit(phy_roothub);
>
>
> Here are my obervations
> - if wakeup is disabled it works fine as expected, phy_exit() is called and I'm able to reach
> low power states.
>
> - if wakeup is enabled (/sys/bus/usb/device/usb2/power/wakeup), then hcd_bus_suspend() is never called
> and so phy_power_off won't be called either.
>
> This means that the device_may_wakeup() check is redundant. Sorry for suggesting this.
>
> This also means that wakeup is not enabled on Chunfeng's platform. Chunfeng, can you confirm this?
> What does /sys/bus/usb/device/usb<?>/power/wakeup say?
>
> Chunfeng sent a patch [1] to set shared_hcd->skip_phy_initialization for the mtk platform.
> Chunfeng, why did you need this patch?
>
> [1] - https://patchwork.kernel.org/patch/10298641/
>
> What options do we have now to fix the original issue?
>
> Chungfeng, can you set skip_phy_initialization for the hcd that has PHY's linked to it?
> Then usb_phy_roothub_*() driver will be a no-op for you. And we could revert to the original approach
> of doing phy_power_off() as well as phy_exit() during suspend.
>
> Alternatively, Martin, how about not relying on skip_phy_initialization flag but having default behaviour
> of no-op for the usb_phy_roothub_*() driver. As platforms migrate to it they can set a new
> flag in hcd to use it?
I added this code to add support for the USB controller on the Amlogic
Meson GXL and GXM SoCs:
these use a dwc3 controller for host mode

so while this approach would reduce the risk of breaking other
controllers your TI SoCs would still be "affected" since I would like
to enable the new logic for the dwc3 controller (which the TI SoCs use
as well).

I will come up with an RFC patch series based on your and Chunfeng's suggestions
thank you very much for working it out while I was away!

>>
>>>>>> - fix this in the PHY driver
>>>>>
>>>>> There is nothing to fix in the PHY driver. It is doing what it is supposed to do.
>>>> I actually wonder if phy_ops should have explicit suspend/resume support:
>>>> - assuming we define two new callbacks: .suspend and .resume
>>>> - the PHY framework could call .power_off by default if .suspend is not defined
>>>> - the PHY framework could call .power_on by default if .resume is not defined
>>>> - drivers could set .suspend and .resume on their own, allowing more
>>>> fine-grained control by for example *only* stopping the clock (but not
>>>> re-initializing the registers, etc.)
>>>>
>>>> @Roger: what do you think about this?
>>>> Kishon (the PHY framework maintainer) is also CC'ed - I would like to
>>>> hear his opinion too
>>>>
>>>>>> - somewhere else
>>>>>>
>>>>>>>> +}
>>>>>>>> +EXPORT_SYMBOL_GPL(usb_phy_roothub_power_off);
>>>>>>>> diff --git a/drivers/usb/core/phy.h b/drivers/usb/core/phy.h
>>>>>>>> new file mode 100644
>>>>>>>> index 000000000000..6fde59bfbff8
>>>>>>>> --- /dev/null
>>>>>>>> +++ b/drivers/usb/core/phy.h
>>>>>>>> @@ -0,0 +1,7 @@
>>>>>>>> +struct usb_phy_roothub;
>>>>>>>> +
>>>>>>>> +struct usb_phy_roothub *usb_phy_roothub_init(struct device *dev);
>>>>>>>> +int usb_phy_roothub_exit(struct usb_phy_roothub *phy_roothub);
>>>>>>>> +
>>>>>>>> +int usb_phy_roothub_power_on(struct usb_phy_roothub *phy_roothub);
>>>>>>>> +void usb_phy_roothub_power_off(struct usb_phy_roothub *phy_roothub);
>>>>>>>>
>>>>>>>
>>>>>
>
>>
>> [0] https://github.com/xdarklight/linux/commits/usb-phy-roothub-suspend-rfc-v1
>>
>
> --
> cheers,
> -roger
>
> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki


Regards
Martin
