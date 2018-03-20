From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH usb-next v10 3/8] usb: core: add a wrapper for the USB
 PHYs on the HCD
Date: Tue, 20 Mar 2018 16:57:03 +0530
Message-ID: <e5dcaf32-7001-d647-1a36-359a9728fa9a@ti.com>
References: <20180218184504.3331-1-martin.blumenstingl@googlemail.com>
 <20180218184504.3331-4-martin.blumenstingl@googlemail.com>
 <7f511a6f-f3a2-2002-f601-5ce1742f4539@ti.com>
 <CAFBinCAOG9Yj5PQo4wsxH2Ev6WOwFge+jBMprRiOgxKuA_z8wA@mail.gmail.com>
 <e723fe80-1ff3-6f47-fbbd-699dfcd0be4f@ti.com>
 <CAFBinCBB2eqHC-k9wN67ZehKb9eun=mPaLuqhrbR-J1C0Ldqtw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAFBinCBB2eqHC-k9wN67ZehKb9eun=mPaLuqhrbR-J1C0Ldqtw@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>, Roger Quadros <rogerq@ti.com>, Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc: mark.rutland@arm.com, Peter.Chen@nxp.com, Neil Armstrong <narmstrong@baylibre.com>, linux-tegra@vger.kernel.org, thierry.reding@gmail.com, linux@prisktech.co.nz, felipe.balbi@linux.intel.com, jonathanh@nvidia.com, stern@rowland.harvard.edu, devicetree@vger.kernel.org, arnd@arndb.de, yixun.lan@amlogic.com, robh+dt@kernel.org, linux-mediatek@lists.infradead.org, matthias.bgg@gmail.com, linux-amlogic@lists.infradead.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, "Gerlach, Dave" <d-gerlach@ti.com>, Keerthy <j-keerthy@ti.com>, linux-usb@vger.kernel.org, mathias.nyman@intel.com, gregkh@linuxfoundation.org
List-Id: linux-omap@vger.kernel.org

Hi,

On Monday 19 March 2018 09:42 PM, Martin Blumenstingl wrote:
> Hi Roger,
> 
> On Mon, Mar 19, 2018 at 9:49 AM, Roger Quadros <rogerq@ti.com> wrote:
>> Hi,
>>
>> On 19/03/18 00:29, Martin Blumenstingl wrote:
>>> Hi Roger,
>>>
>>> On Fri, Mar 16, 2018 at 3:32 PM, Roger Quadros <rogerq@ti.com> wrote:
>>>> +some TI folks
>>>>
>>>> Hi Martin,
>>>>
>>>> On 18/02/18 20:44, Martin Blumenstingl wrote:
>>>>> Many SoC platforms have separate devices for the USB PHY which are
>>>>> registered through the generic PHY framework. These PHYs have to be
>>>>> enabled to make the USB controller actually work. They also have to be
>>>>> disabled again on shutdown/suspend.
>>>>>
>>>>> Currently (at least) the following HCI platform drivers are using custom
>>>>> code to obtain all PHYs via devicetree for the roothub/controller and
>>>>> disable/enable them when required:
>>>>> - ehci-platform.c has ehci_platform_power_{on,off}
>>>>> - xhci-mtk.c has xhci_mtk_phy_{init,exit,power_on,power_off}
>>>>> - ohci-platform.c has ohci_platform_power_{on,off}
>>>>>
>>>>> With this new wrapper the USB PHYs can be specified directly in the
>>>>> USB controller's devicetree node (just like on the drivers listed
>>>>> above). This allows SoCs like the Amlogic Meson GXL family to operate
>>>>> correctly once this is wired up correctly. These SoCs use a dwc3
>>>>> controller and require all USB PHYs to be initialized (if one of the USB
>>>>> PHYs it not initialized then none of USB port works at all).
>>>>>
>>>>> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
>>>>> Tested-by: Yixun Lan <yixun.lan@amlogic.com>
>>>>> Cc: Neil Armstrong <narmstrong@baylibre.com>
>>>>> Cc: Chunfeng Yun <chunfeng.yun@mediatek.com>
>>>>
>>>> This patch is breaking low power cases on TI SoCs when USB is in host mode.
>>>> I'll explain why below.
>>> based on your explanation and reading the TI PHY drivers I am assuming
>>> that the affected SoCs are using the "phy-omap-usb2" driver
>>>
>> yes and phy-ti-pipe3 as well i.e. "ti,phy-usb3" and "ti,omap-usb3"
> I missed that, thanks
> 
>>>>> ---
>>>>>  drivers/usb/core/Makefile |   2 +-
>>>>>  drivers/usb/core/phy.c    | 158 ++++++++++++++++++++++++++++++++++++++++++++++
>>>>>  drivers/usb/core/phy.h    |   7 ++
>>>>>  3 files changed, 166 insertions(+), 1 deletion(-)
>>>>>  create mode 100644 drivers/usb/core/phy.c
>>>>>  create mode 100644 drivers/usb/core/phy.h
>>>>>
>>>>> diff --git a/drivers/usb/core/Makefile b/drivers/usb/core/Makefile
>>>>> index 92c9cefb4317..18e874b0441e 100644
>>>>> --- a/drivers/usb/core/Makefile
>>>>> +++ b/drivers/usb/core/Makefile
>>>>> @@ -6,7 +6,7 @@
>>>>>  usbcore-y := usb.o hub.o hcd.o urb.o message.o driver.o
>>>>>  usbcore-y += config.o file.o buffer.o sysfs.o endpoint.o
>>>>>  usbcore-y += devio.o notify.o generic.o quirks.o devices.o
>>>>> -usbcore-y += port.o
>>>>> +usbcore-y += phy.o port.o
>>>>>
>>>>>  usbcore-$(CONFIG_OF)         += of.o
>>>>>  usbcore-$(CONFIG_USB_PCI)            += hcd-pci.o
>>>>> diff --git a/drivers/usb/core/phy.c b/drivers/usb/core/phy.c
>>>>> new file mode 100644
>>>>> index 000000000000..09b7c43c0ea4
>>>>> --- /dev/null
>>>>> +++ b/drivers/usb/core/phy.c
>>>>> @@ -0,0 +1,158 @@
>>>>> +// SPDX-License-Identifier: GPL-2.0+
>>>>> +/*
>>>>> + * A wrapper for multiple PHYs which passes all phy_* function calls to
>>>>> + * multiple (actual) PHY devices. This is comes handy when initializing
>>>>> + * all PHYs on a HCD and to keep them all in the same state.
>>>>> + *
>>>>> + * Copyright (C) 2018 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
>>>>> + */
>>>>> +
>>>>> +#include <linux/device.h>
>>>>> +#include <linux/list.h>
>>>>> +#include <linux/phy/phy.h>
>>>>> +#include <linux/of.h>
>>>>> +
>>>>> +#include "phy.h"
>>>>> +
>>>>> +struct usb_phy_roothub {
>>>>> +     struct phy              *phy;
>>>>> +     struct list_head        list;
>>>>> +};
>>>>> +
>>>>> +static struct usb_phy_roothub *usb_phy_roothub_alloc(struct device *dev)
>>>>> +{
>>>>> +     struct usb_phy_roothub *roothub_entry;
>>>>> +
>>>>> +     roothub_entry = devm_kzalloc(dev, sizeof(*roothub_entry), GFP_KERNEL);
>>>>> +     if (!roothub_entry)
>>>>> +             return ERR_PTR(-ENOMEM);
>>>>> +
>>>>> +     INIT_LIST_HEAD(&roothub_entry->list);
>>>>> +
>>>>> +     return roothub_entry;
>>>>> +}
>>>>> +
>>>>> +static int usb_phy_roothub_add_phy(struct device *dev, int index,
>>>>> +                                struct list_head *list)
>>>>> +{
>>>>> +     struct usb_phy_roothub *roothub_entry;
>>>>> +     struct phy *phy = devm_of_phy_get_by_index(dev, dev->of_node, index);
>>>>> +
>>>>> +     if (IS_ERR_OR_NULL(phy)) {
>>>>> +             if (!phy || PTR_ERR(phy) == -ENODEV)
>>>>> +                     return 0;
>>>>> +             else
>>>>> +                     return PTR_ERR(phy);
>>>>> +     }
>>>>> +
>>>>> +     roothub_entry = usb_phy_roothub_alloc(dev);
>>>>> +     if (IS_ERR(roothub_entry))
>>>>> +             return PTR_ERR(roothub_entry);
>>>>> +
>>>>> +     roothub_entry->phy = phy;
>>>>> +
>>>>> +     list_add_tail(&roothub_entry->list, list);
>>>>> +
>>>>> +     return 0;
>>>>> +}
>>>>> +
>>>>> +struct usb_phy_roothub *usb_phy_roothub_init(struct device *dev)
>>>>> +{
>>>>> +     struct usb_phy_roothub *phy_roothub;
>>>>> +     struct usb_phy_roothub *roothub_entry;
>>>>> +     struct list_head *head;
>>>>> +     int i, num_phys, err;
>>>>> +
>>>>> +     num_phys = of_count_phandle_with_args(dev->of_node, "phys",
>>>>> +                                           "#phy-cells");
>>>>> +     if (num_phys <= 0)
>>>>> +             return NULL;
>>>>> +
>>>>> +     phy_roothub = usb_phy_roothub_alloc(dev);
>>>>> +     if (IS_ERR(phy_roothub))
>>>>> +             return phy_roothub;
>>>>> +
>>>>> +     for (i = 0; i < num_phys; i++) {
>>>>> +             err = usb_phy_roothub_add_phy(dev, i, &phy_roothub->list);
>>>>> +             if (err)
>>>>> +                     goto err_out;
>>>>> +     }
>>>>> +
>>>>> +     head = &phy_roothub->list;
>>>>> +
>>>>> +     list_for_each_entry(roothub_entry, head, list) {
>>>>> +             err = phy_init(roothub_entry->phy);
>>>>
>>>> The phy_init() function actually enables the PHY clocks.
>>>> It should be moved to the usb_phy_roothub_exit() routine just before calling phy_power_on().
>>> do you mean that phy_init should be moved to usb_phy_roothub_power_on
>>> (just before phy_power_on is called within usb_phy_roothub_power_on)?
>>>
>>
>> Yes.
>>
>>> an earlier version of my patch did exactly this, but it caused
>>> problems during a suspend/resume cycle on Mediatek devices
>>> Chunfeng Yun reported that issue here [0], quote from that mail for
>>> easier reading:
>>> "In order to keep link state on mt8173, we just power off all phys(not
>>> exit) when system enter suspend, then power on them again (needn't
>>> init, otherwise device will be disconnected) when system resume, this
>>> can avoid re-enumerating device."
>>>
>>>>> +             if (err)
>>>>> +                     goto err_exit_phys;
>>>>> +     }
>>>>> +
>>>>> +     return phy_roothub;
>>>>> +
>>>>> +err_exit_phys:
>>>>> +     list_for_each_entry_continue_reverse(roothub_entry, head, list)
>>>>> +             phy_exit(roothub_entry->phy);
>>>>> +
>>>>> +err_out:
>>>>> +     return ERR_PTR(err);
>>>>> +}
>>>>> +EXPORT_SYMBOL_GPL(usb_phy_roothub_init);
>>>>> +
>>>>> +int usb_phy_roothub_exit(struct usb_phy_roothub *phy_roothub)
>>>>> +{
>>>>> +     struct usb_phy_roothub *roothub_entry;
>>>>> +     struct list_head *head;
>>>>> +     int err, ret = 0;
>>>>> +
>>>>> +     if (!phy_roothub)
>>>>> +             return 0;
>>>>> +
>>>>> +     head = &phy_roothub->list;
>>>>> +
>>>>> +     list_for_each_entry(roothub_entry, head, list) {
>>>>> +             err = phy_exit(roothub_entry->phy);
>>>>> +             if (err)
>>>>> +                     ret = ret;
>>>>> +     }
>>>>
>>>> phy_exit() should be moved to usb_phy_roothub_poweroff() just after calling phy_power_off().
>>> if I understood Chunfeng Yun correctly this will require
>>> re-enumeration of the USB devices after a suspend/resume cycle on
>>> Mediatek SoCs
>>>
>>
>> OK. I suppose that there are 2 cases
>> 1) Mediatek's case: USB controller context retained across suspend/resume.
>> Remote wakeup probably required.
>> No re-enumeration preferred after resume. phy_exit()/phy_init() must not be called
>> during suspend/resume to keep PHY link active.
> Documentation/devicetree/bindings/usb/mediatek,mtu3.txt indeed shows
> that the parent of the USB controller can be marked as "wakeup-source"
> 
>> 2) TI's case: low power important: USB context is lost, OK to re-enumerate.
>> phy_exit()/phy_init() must be called during suspend/resume.
> ACK
> 
>>>> With that there is nothing else being done here. Shouldn't we be doing the equivalent of
>>>> usb_phy_roothub_del_phy() and usb_phy_roothub_free() here?
>>>>
>>>>> +
>>>>> +     return ret;
>>>>> +}
>>>>> +EXPORT_SYMBOL_GPL(usb_phy_roothub_exit);
>>>>> +
>>>>> +int usb_phy_roothub_power_on(struct usb_phy_roothub *phy_roothub)
>>>>> +{
>>>>> +     struct usb_phy_roothub *roothub_entry;
>>>>> +     struct list_head *head;
>>>>> +     int err;
>>>>> +
>>>>> +     if (!phy_roothub)
>>>>> +             return 0;
>>>>> +
>>>>> +     head = &phy_roothub->list;
>>>>> +
>>>>> +     list_for_each_entry(roothub_entry, head, list) {
>>>>> +             err = phy_power_on(roothub_entry->phy);
>>>>> +             if (err)
>>>>> +                     goto err_out;
>>>>> +     }
>>>>> +
>>>>> +     return 0;
>>>>> +
>>>>> +err_out:
>>>>> +     list_for_each_entry_continue_reverse(roothub_entry, head, list)
>>>>> +             phy_power_off(roothub_entry->phy);
>>>>> +
>>>>> +     return err;
>>>>> +}
>>>>> +EXPORT_SYMBOL_GPL(usb_phy_roothub_power_on);
>>>>> +
>>>>> +void usb_phy_roothub_power_off(struct usb_phy_roothub *phy_roothub)
>>>>> +{
>>>>> +     struct usb_phy_roothub *roothub_entry;
>>>>> +
>>>>> +     if (!phy_roothub)
>>>>> +             return;
>>>>> +
>>>>> +     list_for_each_entry_reverse(roothub_entry, &phy_roothub->list, list)
>>>>> +             phy_power_off(roothub_entry->phy);
>>>>
>>>> Not doing the phy_exit() here leaves the clocks enabled on our SoC and
>>>> we're no longer able to reach low power states on system suspend.
>>> I'm not sure where this problem should be solved:
>>> - set skip_phy_initialization in struct usb_hcd to 1 for the affected
>>> TI platforms
>>
>> Many TI platforms are affected, omap5*, dra7*, am43*
>>
>>> - fix this in the usb_phy_roothub code
>>
>> I'd vote for fixing it in the usb_phy_roothub code. How?
>> How about using the device_can_wakeup() to decide if we should call phy_exit()/init() or not?
>> If the USB device can't wakeup the system there is no point in keeping it powered/clocked right?
> @Chunfeng: can you confirm Roger's idea that we could call phy_exit if
> the controller is *NOT* marked as "wakeup-source"?
> I am also not sure if it would work, since the "wakeup-source"
> property is defined on the USB controller's parent node in case of the
> Mediatek MTU3 (Mediatek USB3.0 DRD) controller
> 
>>> - fix this in the PHY driver
>>
>> There is nothing to fix in the PHY driver. It is doing what it is supposed to do.
> I actually wonder if phy_ops should have explicit suspend/resume support:

Not in favor of adding explicit suspend/resume ops since PM framework already
has those. I think we should let PHY drivers manage suspend/resume on its own
(after creating the dependency between the controller device and PHY using
device_link_add).

Thanks
Kishon
