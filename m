From: Martin Blumenstingl <martin.blumenstingl-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Subject: Re: [PATCH usb-next v10 3/8] usb: core: add a wrapper for the USB
 PHYs on the HCD
Date: Tue, 20 Mar 2018 23:01:05 +0100
Message-ID: <CAFBinCC7X08oVt223FeZHSqmbCry9aKA8JXz+WmLuDRwwtr+gQ@mail.gmail.com>
References: <20180218184504.3331-1-martin.blumenstingl@googlemail.com>
 <20180218184504.3331-4-martin.blumenstingl@googlemail.com>
 <7f511a6f-f3a2-2002-f601-5ce1742f4539@ti.com>
 <CAFBinCAOG9Yj5PQo4wsxH2Ev6WOwFge+jBMprRiOgxKuA_z8wA@mail.gmail.com>
 <e723fe80-1ff3-6f47-fbbd-699dfcd0be4f@ti.com>
 <CAFBinCBB2eqHC-k9wN67ZehKb9eun=mPaLuqhrbR-J1C0Ldqtw@mail.gmail.com>
 <1521547467.3717.92.camel@mhfsdcap03>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0000000000003f07770567df376b"
Return-path: <linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <1521547467.3717.92.camel@mhfsdcap03>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mediatek/>
List-Post: <mailto:linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-mediatek" <linux-mediatek-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Chunfeng Yun <chunfeng.yun-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Cc: mark.rutland-5wv7dgnIgG8@public.gmane.org, Peter.Chen-3arQi8VN3Tc@public.gmane.org, Neil Armstrong <narmstrong-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, KISHON VIJAY ABRAHAM <kishon-l0cyMroinI0@public.gmane.org>, linux-ci5G2KO2hbZ+pU9mqzGVBQ@public.gmane.org, felipe.balbi-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, yixun.lan-LpR1jeaWuhtBDgjK7y7TUQ@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-amlogic-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, "Gerlach,
 Dave" <d-gerlach-l0cyMroinI0@public.gmane.org>, Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, mathias.nyman-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--0000000000003f07770567df376b
Content-Type: text/plain; charset="UTF-8"

Hi Roger, Hi Chunfeng,

On Tue, Mar 20, 2018 at 1:04 PM, Chunfeng Yun <chunfeng.yun-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org> wrote:
> Hi Martin & Roger:
>
> On Mon, 2018-03-19 at 17:12 +0100, Martin Blumenstingl wrote:
>> Hi Roger,
>>
>> On Mon, Mar 19, 2018 at 9:49 AM, Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org> wrote:
>> > Hi,
>> >
>> > On 19/03/18 00:29, Martin Blumenstingl wrote:
>> >> Hi Roger,
>> >>
>> >> On Fri, Mar 16, 2018 at 3:32 PM, Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org> wrote:
>> >>> +some TI folks
>> >>>
>> >>> Hi Martin,
>> >>>
>> >>> On 18/02/18 20:44, Martin Blumenstingl wrote:
>> >>>> Many SoC platforms have separate devices for the USB PHY which are
>> >>>> registered through the generic PHY framework. These PHYs have to be
>> >>>> enabled to make the USB controller actually work. They also have to be
>> >>>> disabled again on shutdown/suspend.
>> >>>>
>> >>>> Currently (at least) the following HCI platform drivers are using custom
>> >>>> code to obtain all PHYs via devicetree for the roothub/controller and
>> >>>> disable/enable them when required:
>> >>>> - ehci-platform.c has ehci_platform_power_{on,off}
>> >>>> - xhci-mtk.c has xhci_mtk_phy_{init,exit,power_on,power_off}
>> >>>> - ohci-platform.c has ohci_platform_power_{on,off}
>> >>>>
>> >>>> With this new wrapper the USB PHYs can be specified directly in the
>> >>>> USB controller's devicetree node (just like on the drivers listed
>> >>>> above). This allows SoCs like the Amlogic Meson GXL family to operate
>> >>>> correctly once this is wired up correctly. These SoCs use a dwc3
>> >>>> controller and require all USB PHYs to be initialized (if one of the USB
>> >>>> PHYs it not initialized then none of USB port works at all).
>> >>>>
>> >>>> Signed-off-by: Martin Blumenstingl <martin.blumenstingl-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
>> >>>> Tested-by: Yixun Lan <yixun.lan-LpR1jeaWuhtBDgjK7y7TUQ@public.gmane.org>
>> >>>> Cc: Neil Armstrong <narmstrong-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
>> >>>> Cc: Chunfeng Yun <chunfeng.yun-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
>> >>>
>> >>> This patch is breaking low power cases on TI SoCs when USB is in host mode.
>> >>> I'll explain why below.
>> >> based on your explanation and reading the TI PHY drivers I am assuming
>> >> that the affected SoCs are using the "phy-omap-usb2" driver
>> >>
>> > yes and phy-ti-pipe3 as well i.e. "ti,phy-usb3" and "ti,omap-usb3"
>> I missed that, thanks
>>
>> >>>> ---
>> >>>>  drivers/usb/core/Makefile |   2 +-
>> >>>>  drivers/usb/core/phy.c    | 158 ++++++++++++++++++++++++++++++++++++++++++++++
>> >>>>  drivers/usb/core/phy.h    |   7 ++
>> >>>>  3 files changed, 166 insertions(+), 1 deletion(-)
>> >>>>  create mode 100644 drivers/usb/core/phy.c
>> >>>>  create mode 100644 drivers/usb/core/phy.h
>> >>>>
>> >>>> diff --git a/drivers/usb/core/Makefile b/drivers/usb/core/Makefile
>> >>>> index 92c9cefb4317..18e874b0441e 100644
>> >>>> --- a/drivers/usb/core/Makefile
>> >>>> +++ b/drivers/usb/core/Makefile
>> >>>> @@ -6,7 +6,7 @@
>> >>>>  usbcore-y := usb.o hub.o hcd.o urb.o message.o driver.o
>> >>>>  usbcore-y += config.o file.o buffer.o sysfs.o endpoint.o
>> >>>>  usbcore-y += devio.o notify.o generic.o quirks.o devices.o
>> >>>> -usbcore-y += port.o
>> >>>> +usbcore-y += phy.o port.o
>> >>>>
>> >>>>  usbcore-$(CONFIG_OF)         += of.o
>> >>>>  usbcore-$(CONFIG_USB_PCI)            += hcd-pci.o
>> >>>> diff --git a/drivers/usb/core/phy.c b/drivers/usb/core/phy.c
>> >>>> new file mode 100644
>> >>>> index 000000000000..09b7c43c0ea4
>> >>>> --- /dev/null
>> >>>> +++ b/drivers/usb/core/phy.c
>> >>>> @@ -0,0 +1,158 @@
>> >>>> +// SPDX-License-Identifier: GPL-2.0+
>> >>>> +/*
>> >>>> + * A wrapper for multiple PHYs which passes all phy_* function calls to
>> >>>> + * multiple (actual) PHY devices. This is comes handy when initializing
>> >>>> + * all PHYs on a HCD and to keep them all in the same state.
>> >>>> + *
>> >>>> + * Copyright (C) 2018 Martin Blumenstingl <martin.blumenstingl-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
>> >>>> + */
>> >>>> +
>> >>>> +#include <linux/device.h>
>> >>>> +#include <linux/list.h>
>> >>>> +#include <linux/phy/phy.h>
>> >>>> +#include <linux/of.h>
>> >>>> +
>> >>>> +#include "phy.h"
>> >>>> +
>> >>>> +struct usb_phy_roothub {
>> >>>> +     struct phy              *phy;
>> >>>> +     struct list_head        list;
>> >>>> +};
>> >>>> +
>> >>>> +static struct usb_phy_roothub *usb_phy_roothub_alloc(struct device *dev)
>> >>>> +{
>> >>>> +     struct usb_phy_roothub *roothub_entry;
>> >>>> +
>> >>>> +     roothub_entry = devm_kzalloc(dev, sizeof(*roothub_entry), GFP_KERNEL);
>> >>>> +     if (!roothub_entry)
>> >>>> +             return ERR_PTR(-ENOMEM);
>> >>>> +
>> >>>> +     INIT_LIST_HEAD(&roothub_entry->list);
>> >>>> +
>> >>>> +     return roothub_entry;
>> >>>> +}
>> >>>> +
>> >>>> +static int usb_phy_roothub_add_phy(struct device *dev, int index,
>> >>>> +                                struct list_head *list)
>> >>>> +{
>> >>>> +     struct usb_phy_roothub *roothub_entry;
>> >>>> +     struct phy *phy = devm_of_phy_get_by_index(dev, dev->of_node, index);
>> >>>> +
>> >>>> +     if (IS_ERR_OR_NULL(phy)) {
>> >>>> +             if (!phy || PTR_ERR(phy) == -ENODEV)
>> >>>> +                     return 0;
>> >>>> +             else
>> >>>> +                     return PTR_ERR(phy);
>> >>>> +     }
>> >>>> +
>> >>>> +     roothub_entry = usb_phy_roothub_alloc(dev);
>> >>>> +     if (IS_ERR(roothub_entry))
>> >>>> +             return PTR_ERR(roothub_entry);
>> >>>> +
>> >>>> +     roothub_entry->phy = phy;
>> >>>> +
>> >>>> +     list_add_tail(&roothub_entry->list, list);
>> >>>> +
>> >>>> +     return 0;
>> >>>> +}
>> >>>> +
>> >>>> +struct usb_phy_roothub *usb_phy_roothub_init(struct device *dev)
>> >>>> +{
>> >>>> +     struct usb_phy_roothub *phy_roothub;
>> >>>> +     struct usb_phy_roothub *roothub_entry;
>> >>>> +     struct list_head *head;
>> >>>> +     int i, num_phys, err;
>> >>>> +
>> >>>> +     num_phys = of_count_phandle_with_args(dev->of_node, "phys",
>> >>>> +                                           "#phy-cells");
>> >>>> +     if (num_phys <= 0)
>> >>>> +             return NULL;
>> >>>> +
>> >>>> +     phy_roothub = usb_phy_roothub_alloc(dev);
>> >>>> +     if (IS_ERR(phy_roothub))
>> >>>> +             return phy_roothub;
>> >>>> +
>> >>>> +     for (i = 0; i < num_phys; i++) {
>> >>>> +             err = usb_phy_roothub_add_phy(dev, i, &phy_roothub->list);
>> >>>> +             if (err)
>> >>>> +                     goto err_out;
>> >>>> +     }
>> >>>> +
>> >>>> +     head = &phy_roothub->list;
>> >>>> +
>> >>>> +     list_for_each_entry(roothub_entry, head, list) {
>> >>>> +             err = phy_init(roothub_entry->phy);
>> >>>
>> >>> The phy_init() function actually enables the PHY clocks.
>> >>> It should be moved to the usb_phy_roothub_exit() routine just before calling phy_power_on().
>> >> do you mean that phy_init should be moved to usb_phy_roothub_power_on
>> >> (just before phy_power_on is called within usb_phy_roothub_power_on)?
>> >>
>> >
>> > Yes.
>> >
>> >> an earlier version of my patch did exactly this, but it caused
>> >> problems during a suspend/resume cycle on Mediatek devices
>> >> Chunfeng Yun reported that issue here [0], quote from that mail for
>> >> easier reading:
>> >> "In order to keep link state on mt8173, we just power off all phys(not
>> >> exit) when system enter suspend, then power on them again (needn't
>> >> init, otherwise device will be disconnected) when system resume, this
>> >> can avoid re-enumerating device."
>> >>
>> >>>> +             if (err)
>> >>>> +                     goto err_exit_phys;
>> >>>> +     }
>> >>>> +
>> >>>> +     return phy_roothub;
>> >>>> +
>> >>>> +err_exit_phys:
>> >>>> +     list_for_each_entry_continue_reverse(roothub_entry, head, list)
>> >>>> +             phy_exit(roothub_entry->phy);
>> >>>> +
>> >>>> +err_out:
>> >>>> +     return ERR_PTR(err);
>> >>>> +}
>> >>>> +EXPORT_SYMBOL_GPL(usb_phy_roothub_init);
>> >>>> +
>> >>>> +int usb_phy_roothub_exit(struct usb_phy_roothub *phy_roothub)
>> >>>> +{
>> >>>> +     struct usb_phy_roothub *roothub_entry;
>> >>>> +     struct list_head *head;
>> >>>> +     int err, ret = 0;
>> >>>> +
>> >>>> +     if (!phy_roothub)
>> >>>> +             return 0;
>> >>>> +
>> >>>> +     head = &phy_roothub->list;
>> >>>> +
>> >>>> +     list_for_each_entry(roothub_entry, head, list) {
>> >>>> +             err = phy_exit(roothub_entry->phy);
>> >>>> +             if (err)
>> >>>> +                     ret = ret;
>> >>>> +     }
>> >>>
>> >>> phy_exit() should be moved to usb_phy_roothub_poweroff() just after calling phy_power_off().
>> >> if I understood Chunfeng Yun correctly this will require
>> >> re-enumeration of the USB devices after a suspend/resume cycle on
>> >> Mediatek SoCs
>> >>
>> >
>> > OK. I suppose that there are 2 cases
>> > 1) Mediatek's case: USB controller context retained across suspend/resume.
>> > Remote wakeup probably required.
>> > No re-enumeration preferred after resume. phy_exit()/phy_init() must not be called
>> > during suspend/resume to keep PHY link active.
>> Documentation/devicetree/bindings/usb/mediatek,mtu3.txt indeed shows
>> that the parent of the USB controller can be marked as "wakeup-source"
>>
>> > 2) TI's case: low power important: USB context is lost, OK to re-enumerate.
>> > phy_exit()/phy_init() must be called during suspend/resume.
>> ACK
>>
>> >>> With that there is nothing else being done here. Shouldn't we be doing the equivalent of
>> >>> usb_phy_roothub_del_phy() and usb_phy_roothub_free() here?
>> >>>
>> >>>> +
>> >>>> +     return ret;
>> >>>> +}
>> >>>> +EXPORT_SYMBOL_GPL(usb_phy_roothub_exit);
>> >>>> +
>> >>>> +int usb_phy_roothub_power_on(struct usb_phy_roothub *phy_roothub)
>> >>>> +{
>> >>>> +     struct usb_phy_roothub *roothub_entry;
>> >>>> +     struct list_head *head;
>> >>>> +     int err;
>> >>>> +
>> >>>> +     if (!phy_roothub)
>> >>>> +             return 0;
>> >>>> +
>> >>>> +     head = &phy_roothub->list;
>> >>>> +
>> >>>> +     list_for_each_entry(roothub_entry, head, list) {
>> >>>> +             err = phy_power_on(roothub_entry->phy);
>> >>>> +             if (err)
>> >>>> +                     goto err_out;
>> >>>> +     }
>> >>>> +
>> >>>> +     return 0;
>> >>>> +
>> >>>> +err_out:
>> >>>> +     list_for_each_entry_continue_reverse(roothub_entry, head, list)
>> >>>> +             phy_power_off(roothub_entry->phy);
>> >>>> +
>> >>>> +     return err;
>> >>>> +}
>> >>>> +EXPORT_SYMBOL_GPL(usb_phy_roothub_power_on);
>> >>>> +
>> >>>> +void usb_phy_roothub_power_off(struct usb_phy_roothub *phy_roothub)
>> >>>> +{
>> >>>> +     struct usb_phy_roothub *roothub_entry;
>> >>>> +
>> >>>> +     if (!phy_roothub)
>> >>>> +             return;
>> >>>> +
>> >>>> +     list_for_each_entry_reverse(roothub_entry, &phy_roothub->list, list)
>> >>>> +             phy_power_off(roothub_entry->phy);
>> >>>
>> >>> Not doing the phy_exit() here leaves the clocks enabled on our SoC and
>> >>> we're no longer able to reach low power states on system suspend.
>> >> I'm not sure where this problem should be solved:
>> >> - set skip_phy_initialization in struct usb_hcd to 1 for the affected
>> >> TI platforms
>> >
>> > Many TI platforms are affected, omap5*, dra7*, am43*
>> >
>> >> - fix this in the usb_phy_roothub code
>> >
>> > I'd vote for fixing it in the usb_phy_roothub code. How?
>> > How about using the device_can_wakeup() to decide if we should call phy_exit()/init() or not?
>> > If the USB device can't wakeup the system there is no point in keeping it powered/clocked right?
>> @Chunfeng: can you confirm Roger's idea that we could call phy_exit if
>> the controller is *NOT* marked as "wakeup-source"?
>> I am also not sure if it would work, since the "wakeup-source"
>> property is defined on the USB controller's parent node in case of the
>> Mediatek MTU3 (Mediatek USB3.0 DRD) controller
>>
> Very sorry, I forgot that MTU3 & xHCI drivers always set them as wakeup
> devices by device_init_wakeup(dev, true),but not dependent on
> "wakeup-source" property, so maybe we can use device_can_wakeup() to
> decide whether call phy_exit()/init() or not.
the 64-bit Amlogic Meson GXL/GXM SoCs don't support suspend/resume
yet, so I cannot test this
based on this suggestion I threw up two patches which are *compile
tested only* based on Greg's usb-next branch
you can find them here: [0] (as well as attached to this mail)

@Chunfeng: can you please test this on one of your Mediatek SoCs?
@Roger: can you please test this on a TI SoC?

(apologies in advance if these patches don't work)

please note that I won't have access to my computer until Saturday.
if these patches need to be rewritten/replaced/etc. then feel free to
send your own version to the list

>> >> - fix this in the PHY driver
>> >
>> > There is nothing to fix in the PHY driver. It is doing what it is supposed to do.
>> I actually wonder if phy_ops should have explicit suspend/resume support:
>> - assuming we define two new callbacks: .suspend and .resume
>> - the PHY framework could call .power_off by default if .suspend is not defined
>> - the PHY framework could call .power_on by default if .resume is not defined
>> - drivers could set .suspend and .resume on their own, allowing more
>> fine-grained control by for example *only* stopping the clock (but not
>> re-initializing the registers, etc.)
>>
>> @Roger: what do you think about this?
>> Kishon (the PHY framework maintainer) is also CC'ed - I would like to
>> hear his opinion too
>>
>> >> - somewhere else
>> >>
>> >>>> +}
>> >>>> +EXPORT_SYMBOL_GPL(usb_phy_roothub_power_off);
>> >>>> diff --git a/drivers/usb/core/phy.h b/drivers/usb/core/phy.h
>> >>>> new file mode 100644
>> >>>> index 000000000000..6fde59bfbff8
>> >>>> --- /dev/null
>> >>>> +++ b/drivers/usb/core/phy.h
>> >>>> @@ -0,0 +1,7 @@
>> >>>> +struct usb_phy_roothub;
>> >>>> +
>> >>>> +struct usb_phy_roothub *usb_phy_roothub_init(struct device *dev);
>> >>>> +int usb_phy_roothub_exit(struct usb_phy_roothub *phy_roothub);
>> >>>> +
>> >>>> +int usb_phy_roothub_power_on(struct usb_phy_roothub *phy_roothub);
>> >>>> +void usb_phy_roothub_power_off(struct usb_phy_roothub *phy_roothub);
>> >>>>
>> >>>
>> >
>> > <snip>
>> >
>> > --
>> > cheers,
>> > -roger
>> >
>> > Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
>>
>>
>> Regards
>> Martin
>
>


Regards
Martin


[0] https://github.com/xdarklight/linux/commits/usb-phy-roothub-suspend-rfc-v1

--0000000000003f07770567df376b
Content-Type: text/x-patch; charset="US-ASCII";
	name="0001-usb-core-split-usb_phy_roothub_-init-alloc.patch"
Content-Disposition: attachment;
	filename="0001-usb-core-split-usb_phy_roothub_-init-alloc.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_jf07bhm80

RnJvbSA3OGFmZTNkZmJmMjFkZDUyMTA3NmQxZmQ2MjUwOTZmYTQ0MGY1MTk1IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBNYXJ0aW4gQmx1bWVuc3RpbmdsIDxtYXJ0aW4uYmx1bWVuc3Rp
bmdsQGdvb2dsZW1haWwuY29tPgpEYXRlOiBUdWUsIDIwIE1hciAyMDE4IDIyOjM2OjM5ICswMTAw
ClN1YmplY3Q6IFtQQVRDSCAxLzJdIHVzYjogY29yZTogc3BsaXQgdXNiX3BoeV9yb290aHViX3tp
bml0LGFsbG9jfQoKQmVmb3JlIHRoaXMgcGF0Y2ggdXNiX3BoeV9yb290aHViX2luaXQgc2VydmVk
IHR3byBwdXJwb3NlcyAoZnJvbSBhCmNhbGxlcidzIHBvaW50IG9mIHZpZXcgLSBsaWtlIGhjZC5j
KToKLSBwYXJzaW5nIHRoZSBQSFlzIGFuZCBhbGxvY2F0aW5nIHRoZSBsaXN0IGVudHJpZXMKLSBj
YWxsaW5nIHBoeV9pbml0IG9uIGVhY2ggbGlzdCBlbnRyeQoKV2hpbGUgdGhpcyB3b3JrZWQgc28g
ZmFyIGl0IGhhcyBvbmUgZGlzYWR2YW50YWdlOiBpZiB3ZSBuZWVkIHRvIGNhbGwKcGh5X2luaXQg
Zm9yIGVhY2ggUEhZIGluc3RhbmNlIHRoZW4gdGhlIGV4aXN0aW5nIGNvZGUgY2Fubm90IGJlIHJl
LXVzZWQuClNvbHZlIHRoaXMgYnkgc3BsaXR0aW5nIG9mZiB1c2JfcGh5X3Jvb3RodWJfYWxsb2Mg
d2hpY2ggb25seSBwYXJzZXMgdGhlClBIWXMgYW5kIGFsbG9jYXRlcyB0aGUgbGlzdCBlbnRyaWVz
Lgp1c2JfcGh5X3Jvb3RodWJfaW5pdCB0aGVuIGdldHMgYSBzdHJ1Y3QgdXNiX3BoeV9yb290aHVi
IGFuZCBvbmx5IGNhbGxzCnBoeV9pbml0IG9uIGVhY2ggUEhZIGluc3RhbmNlIChhbG9uZyB3aXRo
IHRoZSBjb3JyZXNwb25kaW5nIGNsZWFudXAgaWYKdGhhdCBmYWlsZWQgc29tZXdoZXJlKS4KClRo
aXMgaXMgYSBwcmVwYXJhdGlvbiBzdGVwIGZvciBhZGRpbmcgcHJvcGVyIHN1c3BlbmQgc3VwcG9y
dCBmb3Igc29tZQpoYXJkd2FyZSB0aGF0IHJlcXVpcmVzIHBoeV9leGl0IHRvIGJlIGNhbGxlZCBk
dXJpbmcgc3VzcGVuZCBhbmQgcGh5X2luaXQKdG8gYmUgY2FsbGVkIGR1cmluZyByZXN1bWUuCgpT
aWduZWQtb2ZmLWJ5OiBNYXJ0aW4gQmx1bWVuc3RpbmdsIDxtYXJ0aW4uYmx1bWVuc3RpbmdsQGdv
b2dsZW1haWwuY29tPgotLS0KIGRyaXZlcnMvdXNiL2NvcmUvaGNkLmMgfCAxMCArKysrKysrLS0t
CiBkcml2ZXJzL3VzYi9jb3JlL3BoeS5jIHwgNDUgKysrKysrKysrKysrKysrKysrKysrKy0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tCiBkcml2ZXJzL3VzYi9jb3JlL3BoeS5oIHwgIDQgKysrLQogMyBm
aWxlcyBjaGFuZ2VkLCAzMiBpbnNlcnRpb25zKCspLCAyNyBkZWxldGlvbnMoLSkKCmRpZmYgLS1n
aXQgYS9kcml2ZXJzL3VzYi9jb3JlL2hjZC5jIGIvZHJpdmVycy91c2IvY29yZS9oY2QuYwppbmRl
eCA1YTkyZDhmN2M0ODQuLjg5YjEwZDg1OTA0NyAxMDA2NDQKLS0tIGEvZHJpdmVycy91c2IvY29y
ZS9oY2QuYworKysgYi9kcml2ZXJzL3VzYi9jb3JlL2hjZC5jCkBAIC0yNzU4LDEyICsyNzU4LDE2
IEBAIGludCB1c2JfYWRkX2hjZChzdHJ1Y3QgdXNiX2hjZCAqaGNkLAogCX0KIAogCWlmICghaGNk
LT5za2lwX3BoeV9pbml0aWFsaXphdGlvbikgewotCQloY2QtPnBoeV9yb290aHViID0gdXNiX3Bo
eV9yb290aHViX2luaXQoaGNkLT5zZWxmLnN5c2Rldik7CisJCWhjZC0+cGh5X3Jvb3RodWIgPSB1
c2JfcGh5X3Jvb3RodWJfYWxsb2MoaGNkLT5zZWxmLnN5c2Rldik7CiAJCWlmIChJU19FUlIoaGNk
LT5waHlfcm9vdGh1YikpIHsKIAkJCXJldHZhbCA9IFBUUl9FUlIoaGNkLT5waHlfcm9vdGh1Yik7
Ci0JCQlnb3RvIGVycl9waHlfcm9vdGh1Yl9pbml0OworCQkJZ290byBlcnJfcGh5X3Jvb3RodWJf
YWxsb2M7CiAJCX0KIAorCQlyZXR2YWwgPSB1c2JfcGh5X3Jvb3RodWJfaW5pdChoY2QtPnBoeV9y
b290aHViKTsKKwkJaWYgKHJldHZhbCkKKwkJCWdvdG8gZXJyX3BoeV9yb290aHViX2FsbG9jOwor
CiAJCXJldHZhbCA9IHVzYl9waHlfcm9vdGh1Yl9wb3dlcl9vbihoY2QtPnBoeV9yb290aHViKTsK
IAkJaWYgKHJldHZhbCkKIAkJCWdvdG8gZXJyX3VzYl9waHlfcm9vdGh1Yl9wb3dlcl9vbjsKQEAg
LTI5MzYsNyArMjk0MCw3IEBAIGludCB1c2JfYWRkX2hjZChzdHJ1Y3QgdXNiX2hjZCAqaGNkLAog
CXVzYl9waHlfcm9vdGh1Yl9wb3dlcl9vZmYoaGNkLT5waHlfcm9vdGh1Yik7CiBlcnJfdXNiX3Bo
eV9yb290aHViX3Bvd2VyX29uOgogCXVzYl9waHlfcm9vdGh1Yl9leGl0KGhjZC0+cGh5X3Jvb3Ro
dWIpOwotZXJyX3BoeV9yb290aHViX2luaXQ6CitlcnJfcGh5X3Jvb3RodWJfYWxsb2M6CiAJaWYg
KGhjZC0+cmVtb3ZlX3BoeSAmJiBoY2QtPnVzYl9waHkpIHsKIAkJdXNiX3BoeV9zaHV0ZG93biho
Y2QtPnVzYl9waHkpOwogCQl1c2JfcHV0X3BoeShoY2QtPnVzYl9waHkpOwpkaWZmIC0tZ2l0IGEv
ZHJpdmVycy91c2IvY29yZS9waHkuYyBiL2RyaXZlcnMvdXNiL2NvcmUvcGh5LmMKaW5kZXggMDli
N2M0M2MwZWE0Li41MGE4MGRiZTc3NmMgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvdXNiL2NvcmUvcGh5
LmMKKysrIGIvZHJpdmVycy91c2IvY29yZS9waHkuYwpAQCAtMTksMTkgKzE5LDYgQEAgc3RydWN0
IHVzYl9waHlfcm9vdGh1YiB7CiAJc3RydWN0IGxpc3RfaGVhZAlsaXN0OwogfTsKIAotc3RhdGlj
IHN0cnVjdCB1c2JfcGh5X3Jvb3RodWIgKnVzYl9waHlfcm9vdGh1Yl9hbGxvYyhzdHJ1Y3QgZGV2
aWNlICpkZXYpCi17Ci0Jc3RydWN0IHVzYl9waHlfcm9vdGh1YiAqcm9vdGh1Yl9lbnRyeTsKLQot
CXJvb3RodWJfZW50cnkgPSBkZXZtX2t6YWxsb2MoZGV2LCBzaXplb2YoKnJvb3RodWJfZW50cnkp
LCBHRlBfS0VSTkVMKTsKLQlpZiAoIXJvb3RodWJfZW50cnkpCi0JCXJldHVybiBFUlJfUFRSKC1F
Tk9NRU0pOwotCi0JSU5JVF9MSVNUX0hFQUQoJnJvb3RodWJfZW50cnktPmxpc3QpOwotCi0JcmV0
dXJuIHJvb3RodWJfZW50cnk7Ci19Ci0KIHN0YXRpYyBpbnQgdXNiX3BoeV9yb290aHViX2FkZF9w
aHkoc3RydWN0IGRldmljZSAqZGV2LCBpbnQgaW5kZXgsCiAJCQkJICAgc3RydWN0IGxpc3RfaGVh
ZCAqbGlzdCkKIHsKQEAgLTU2LDExICs0Myw5IEBAIHN0YXRpYyBpbnQgdXNiX3BoeV9yb290aHVi
X2FkZF9waHkoc3RydWN0IGRldmljZSAqZGV2LCBpbnQgaW5kZXgsCiAJcmV0dXJuIDA7CiB9CiAK
LXN0cnVjdCB1c2JfcGh5X3Jvb3RodWIgKnVzYl9waHlfcm9vdGh1Yl9pbml0KHN0cnVjdCBkZXZp
Y2UgKmRldikKK3N0cnVjdCB1c2JfcGh5X3Jvb3RodWIgKnVzYl9waHlfcm9vdGh1Yl9hbGxvYyhz
dHJ1Y3QgZGV2aWNlICpkZXYpCiB7CiAJc3RydWN0IHVzYl9waHlfcm9vdGh1YiAqcGh5X3Jvb3Ro
dWI7Ci0Jc3RydWN0IHVzYl9waHlfcm9vdGh1YiAqcm9vdGh1Yl9lbnRyeTsKLQlzdHJ1Y3QgbGlz
dF9oZWFkICpoZWFkOwogCWludCBpLCBudW1fcGh5cywgZXJyOwogCiAJbnVtX3BoeXMgPSBvZl9j
b3VudF9waGFuZGxlX3dpdGhfYXJncyhkZXYtPm9mX25vZGUsICJwaHlzIiwKQEAgLTY4LDE2ICs1
MywzMSBAQCBzdHJ1Y3QgdXNiX3BoeV9yb290aHViICp1c2JfcGh5X3Jvb3RodWJfaW5pdChzdHJ1
Y3QgZGV2aWNlICpkZXYpCiAJaWYgKG51bV9waHlzIDw9IDApCiAJCXJldHVybiBOVUxMOwogCi0J
cGh5X3Jvb3RodWIgPSB1c2JfcGh5X3Jvb3RodWJfYWxsb2MoZGV2KTsKLQlpZiAoSVNfRVJSKHBo
eV9yb290aHViKSkKLQkJcmV0dXJuIHBoeV9yb290aHViOworCXBoeV9yb290aHViID0gZGV2bV9r
emFsbG9jKGRldiwgc2l6ZW9mKCpwaHlfcm9vdGh1YiksIEdGUF9LRVJORUwpOworCWlmICghcGh5
X3Jvb3RodWIpCisJCXJldHVybiBFUlJfUFRSKC1FTk9NRU0pOworCisJSU5JVF9MSVNUX0hFQUQo
JnBoeV9yb290aHViLT5saXN0KTsKIAogCWZvciAoaSA9IDA7IGkgPCBudW1fcGh5czsgaSsrKSB7
CiAJCWVyciA9IHVzYl9waHlfcm9vdGh1Yl9hZGRfcGh5KGRldiwgaSwgJnBoeV9yb290aHViLT5s
aXN0KTsKIAkJaWYgKGVycikKLQkJCWdvdG8gZXJyX291dDsKKwkJCXJldHVybiBFUlJfUFRSKGVy
cik7CiAJfQogCisJcmV0dXJuIHBoeV9yb290aHViOworfQorRVhQT1JUX1NZTUJPTF9HUEwodXNi
X3BoeV9yb290aHViX2FsbG9jKTsKKworaW50IHVzYl9waHlfcm9vdGh1Yl9pbml0KHN0cnVjdCB1
c2JfcGh5X3Jvb3RodWIgKnBoeV9yb290aHViKQoreworCXN0cnVjdCB1c2JfcGh5X3Jvb3RodWIg
KnJvb3RodWJfZW50cnk7CisJc3RydWN0IGxpc3RfaGVhZCAqaGVhZDsKKwlpbnQgZXJyOworCisJ
aWYgKCFwaHlfcm9vdGh1YikKKwkJcmV0dXJuIDA7CisKIAloZWFkID0gJnBoeV9yb290aHViLT5s
aXN0OwogCiAJbGlzdF9mb3JfZWFjaF9lbnRyeShyb290aHViX2VudHJ5LCBoZWFkLCBsaXN0KSB7
CkBAIC04NiwxNCArODYsMTMgQEAgc3RydWN0IHVzYl9waHlfcm9vdGh1YiAqdXNiX3BoeV9yb290
aHViX2luaXQoc3RydWN0IGRldmljZSAqZGV2KQogCQkJZ290byBlcnJfZXhpdF9waHlzOwogCX0K
IAotCXJldHVybiBwaHlfcm9vdGh1YjsKKwlyZXR1cm4gMDsKIAogZXJyX2V4aXRfcGh5czoKIAls
aXN0X2Zvcl9lYWNoX2VudHJ5X2NvbnRpbnVlX3JldmVyc2Uocm9vdGh1Yl9lbnRyeSwgaGVhZCwg
bGlzdCkKIAkJcGh5X2V4aXQocm9vdGh1Yl9lbnRyeS0+cGh5KTsKIAotZXJyX291dDoKLQlyZXR1
cm4gRVJSX1BUUihlcnIpOworCXJldHVybiBlcnI7CiB9CiBFWFBPUlRfU1lNQk9MX0dQTCh1c2Jf
cGh5X3Jvb3RodWJfaW5pdCk7CiAKZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2NvcmUvcGh5Lmgg
Yi9kcml2ZXJzL3VzYi9jb3JlL3BoeS5oCmluZGV4IDZmZGU1OWJmYmZmOC4uZWIzMTI1MzIwMWFk
IDEwMDY0NAotLS0gYS9kcml2ZXJzL3VzYi9jb3JlL3BoeS5oCisrKyBiL2RyaXZlcnMvdXNiL2Nv
cmUvcGh5LmgKQEAgLTEsNiArMSw4IEBACiBzdHJ1Y3QgdXNiX3BoeV9yb290aHViOwogCi1zdHJ1
Y3QgdXNiX3BoeV9yb290aHViICp1c2JfcGh5X3Jvb3RodWJfaW5pdChzdHJ1Y3QgZGV2aWNlICpk
ZXYpOworc3RydWN0IHVzYl9waHlfcm9vdGh1YiAqdXNiX3BoeV9yb290aHViX2FsbG9jKHN0cnVj
dCBkZXZpY2UgKmRldik7CisKK2ludCB1c2JfcGh5X3Jvb3RodWJfaW5pdChzdHJ1Y3QgdXNiX3Bo
eV9yb290aHViICpwaHlfcm9vdGh1Yik7CiBpbnQgdXNiX3BoeV9yb290aHViX2V4aXQoc3RydWN0
IHVzYl9waHlfcm9vdGh1YiAqcGh5X3Jvb3RodWIpOwogCiBpbnQgdXNiX3BoeV9yb290aHViX3Bv
d2VyX29uKHN0cnVjdCB1c2JfcGh5X3Jvb3RodWIgKnBoeV9yb290aHViKTsKLS0gCjIuMTYuMgoK
--0000000000003f07770567df376b
Content-Type: text/x-patch; charset="US-ASCII";
	name="0002-usb-core-use-phy_exit-during-suspend-if-wake-up-is-n.patch"
Content-Disposition: attachment;
	filename="0002-usb-core-use-phy_exit-during-suspend-if-wake-up-is-n.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_jf07bhmj1

RnJvbSAxMzY3ZjQ5ZmY0OWNlYzI0OWJkOWJhOTVlNTM5NWRkMTc2MGVlZThiIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBNYXJ0aW4gQmx1bWVuc3RpbmdsIDxtYXJ0aW4uYmx1bWVuc3Rp
bmdsQGdvb2dsZW1haWwuY29tPgpEYXRlOiBUdWUsIDIwIE1hciAyMDE4IDIyOjQ3OjM4ICswMTAw
ClN1YmplY3Q6IFtQQVRDSCAyLzJdIHVzYjogY29yZTogdXNlIHBoeV9leGl0IGR1cmluZyBzdXNw
ZW5kIGlmIHdha2UgdXAgaXMgbm90CiBzdXBwb3J0ZWQKCklmIHRoZSBVU0IgY29udHJvbGxlciBj
YW4gd2FrZSB1cCB0aGUgc3lzdGVtICh3aGljaCBpcyB0aGUgY2FzZSBmb3IKZXhhbXBsZSB3aXRo
IHRoZSBNZWRpYXRlayBVU0IzIElQKSB0aGVuIHdlIG11c3Qgbm90IGNhbGwgcGh5X2V4aXQgZHVy
aW5nCnN1c3BlbmQgdG8gZW5zdXJlIHRoYXQgdGhlIFVTQiBjb250cm9sbGVyIGRvZXNuJ3QgaGF2
ZSB0byByZS1lbnVtZXJhdGUKdGhlIGRldmljZXMgZHVyaW5nIHJlc3VtZS4KSG93ZXZlciwgaWYg
dGhlIFVTQiBjb250cm9sbGVyIGNhbm5vdCB3YWtlIHVwIHRoZSBzeXN0ZW0gKHdoaWNoIGlzIHRo
ZQpjYXNlIGZvciBleGFtcGxlIG9uIHZhcmlvdXMgVEkgcGxhdGZvcm1zIHVzaW5nIGEgZHdjMyBj
b250cm9sbGVyKSB0aGVuCndlIG11c3QgY2FsbCBwaHlfZXhpdCBkdXJpbmcgc3VzcGVuZC4gT3Ro
ZXJ3aXNlIHRoZSBQSFkgZHJpdmVyIGtlZXBzIHRoZQpjbG9ja3MgZW5hYmxlZCwgd2hpY2ggcHJl
dmVudHMgdGhlIHN5c3RlbSBmcm9tIGVudGVyaW5nIHRoZSBzdXNwZW5kCnN0YXRlLgoKU29sdmUg
dGhpcyBieSBpbnRyb2R1Y2luZyB0d28gbmV3IGZ1bmN0aW9ucyBpbiB0aGUgUEhZIHdyYXBwZXIg
d2hpY2ggYXJlCmRlZGljYXRlZCB0byB0aGUgc3VzcGVuZCBhbmQgcmVzdW1lIGhhbmRsaW5nLgpJ
ZiB0aGUgY29udHJvbGxlciBjYW4gd2FrZSB1cCB0aGUgc3lzdGVtIHRoZSBuZXcgdXNiX3BoeV9y
b290aHViX3N1c3BlbmQKZnVuY3Rpb24gd2lsbCBzaW1wbHkgY2FsbCB1c2JfcGh5X3Jvb3RodWJf
cG93ZXJfb2ZmLiBIb3dldmVyLCBpZiB3YWtlIHVwCmlzIG5vdCBzdXBwb3J0ZWQgYnkgdGhlIGNv
bnRyb2xsZXIgaXQgd2lsbCBhbHNvIGNhbGwKdXNiX3BoeV9yb290aHViX2V4aXQuClRoZSBhbHNv
IG5ldyB1c2JfcGh5X3Jvb3RodWJfcmVzdW1lIGZ1bmN0aW9uIHRha2VzIGNhcmUgb2YgY2FsbGlu
Zwp1c2JfcGh5X3Jvb3RodWJfaW5pdCAoaWYgdGhlIGNvbnRyb2xsZXIgY2FuJ3Qgd2FrZSB1cCB0
aGUgc3lzdGVtKSBpbgphZGRpdGlvbiB0byB1c2JfcGh5X3Jvb3RodWJfcG93ZXJfb24uCgpGaXhl
czogMDdkYmZmMGRkYmQ4NmMgKCJ1c2I6IGNvcmU6IGFkZCBhIHdyYXBwZXIgZm9yIHRoZSBVU0Ig
UEhZcyBvbiB0aGUgSENEIikKRml4ZXM6IDE3OGEwYmNlMDVjYmMxICgidXNiOiBjb3JlOiBoY2Q6
IGludGVncmF0ZSB0aGUgUEhZIHdyYXBwZXIgaW50byB0aGUgSENEIGNvcmUiKQpTaWduZWQtb2Zm
LWJ5OiBNYXJ0aW4gQmx1bWVuc3RpbmdsIDxtYXJ0aW4uYmx1bWVuc3RpbmdsQGdvb2dsZW1haWwu
Y29tPgotLS0KIGRyaXZlcnMvdXNiL2NvcmUvaGNkLmMgfCAgNiArKystLS0KIGRyaXZlcnMvdXNi
L2NvcmUvcGh5LmMgfCAyOSArKysrKysrKysrKysrKysrKysrKysrKysrKysrKwogZHJpdmVycy91
c2IvY29yZS9waHkuaCB8ICA1ICsrKysrCiAzIGZpbGVzIGNoYW5nZWQsIDM3IGluc2VydGlvbnMo
KyksIDMgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvY29yZS9oY2QuYyBi
L2RyaXZlcnMvdXNiL2NvcmUvaGNkLmMKaW5kZXggODliMTBkODU5MDQ3Li42ZDRhNDE5NWNhMDAg
MTAwNjQ0Ci0tLSBhL2RyaXZlcnMvdXNiL2NvcmUvaGNkLmMKKysrIGIvZHJpdmVycy91c2IvY29y
ZS9oY2QuYwpAQCAtMjI2Miw3ICsyMjYyLDcgQEAgaW50IGhjZF9idXNfc3VzcGVuZChzdHJ1Y3Qg
dXNiX2RldmljZSAqcmhkZXYsIHBtX21lc3NhZ2VfdCBtc2cpCiAJCWhjZC0+c3RhdGUgPSBIQ19T
VEFURV9TVVNQRU5ERUQ7CiAKIAkJaWYgKCFQTVNHX0lTX0FVVE8obXNnKSkKLQkJCXVzYl9waHlf
cm9vdGh1Yl9wb3dlcl9vZmYoaGNkLT5waHlfcm9vdGh1Yik7CisJCQl1c2JfcGh5X3Jvb3RodWJf
c3VzcGVuZChoY2QtPnBoeV9yb290aHViKTsKIAogCQkvKiBEaWQgd2UgcmFjZSB3aXRoIGEgcm9v
dC1odWIgd2FrZXVwIGV2ZW50PyAqLwogCQlpZiAocmhkZXYtPmRvX3JlbW90ZV93YWtldXApIHsK
QEAgLTIzMDIsNyArMjMwMiw3IEBAIGludCBoY2RfYnVzX3Jlc3VtZShzdHJ1Y3QgdXNiX2Rldmlj
ZSAqcmhkZXYsIHBtX21lc3NhZ2VfdCBtc2cpCiAJfQogCiAJaWYgKCFQTVNHX0lTX0FVVE8obXNn
KSkgewotCQlzdGF0dXMgPSB1c2JfcGh5X3Jvb3RodWJfcG93ZXJfb24oaGNkLT5waHlfcm9vdGh1
Yik7CisJCXN0YXR1cyA9IHVzYl9waHlfcm9vdGh1Yl9yZXN1bWUoaGNkLT5waHlfcm9vdGh1Yik7
CiAJCWlmIChzdGF0dXMpCiAJCQlyZXR1cm4gc3RhdHVzOwogCX0KQEAgLTIzNDQsNyArMjM0NCw3
IEBAIGludCBoY2RfYnVzX3Jlc3VtZShzdHJ1Y3QgdXNiX2RldmljZSAqcmhkZXYsIHBtX21lc3Nh
Z2VfdCBtc2cpCiAJCX0KIAl9IGVsc2UgewogCQloY2QtPnN0YXRlID0gb2xkX3N0YXRlOwotCQl1
c2JfcGh5X3Jvb3RodWJfcG93ZXJfb2ZmKGhjZC0+cGh5X3Jvb3RodWIpOworCQl1c2JfcGh5X3Jv
b3RodWJfc3VzcGVuZChoY2QtPnBoeV9yb290aHViKTsKIAkJZGV2X2RiZygmcmhkZXYtPmRldiwg
ImJ1cyAlcyBmYWlsLCBlcnIgJWRcbiIsCiAJCQkJInJlc3VtZSIsIHN0YXR1cyk7CiAJCWlmIChz
dGF0dXMgIT0gLUVTSFVURE9XTikKZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2NvcmUvcGh5LmMg
Yi9kcml2ZXJzL3VzYi9jb3JlL3BoeS5jCmluZGV4IDUwYTgwZGJlNzc2Yy4uMmVjYTM3MTY4NGZh
IDEwMDY0NAotLS0gYS9kcml2ZXJzL3VzYi9jb3JlL3BoeS5jCisrKyBiL2RyaXZlcnMvdXNiL2Nv
cmUvcGh5LmMKQEAgLTE1NSwzICsxNTUsMzIgQEAgdm9pZCB1c2JfcGh5X3Jvb3RodWJfcG93ZXJf
b2ZmKHN0cnVjdCB1c2JfcGh5X3Jvb3RodWIgKnBoeV9yb290aHViKQogCQlwaHlfcG93ZXJfb2Zm
KHJvb3RodWJfZW50cnktPnBoeSk7CiB9CiBFWFBPUlRfU1lNQk9MX0dQTCh1c2JfcGh5X3Jvb3Ro
dWJfcG93ZXJfb2ZmKTsKKworaW50IHVzYl9waHlfcm9vdGh1Yl9zdXNwZW5kKHN0cnVjdCBkZXZp
Y2UgKmRldiwKKwkJCSAgICBzdHJ1Y3QgdXNiX3BoeV9yb290aHViICpwaHlfcm9vdGh1YikKK3sK
Kwl1c2JfcGh5X3Jvb3RodWJfcG93ZXJfb2ZmKHBoeV9yb290aHViKTsKKworCS8qIGtlZXAgdGhl
IFBIWXMgaW5pdGlhbGl6ZWQgc28gdGhlIGRldmljZSBjYW4gd2FrZSB1cCB0aGUgc3lzdGVtICov
CisJaWYgKGRldmljZV9jYW5fd2FrZXVwKGRldikpCisJCXJldHVybiAwOworCisJcmV0dXJuIHVz
Yl9waHlfcm9vdGh1Yl9leGl0KHBoeV9yb290aHViKTsKK30KK0VYUE9SVF9TWU1CT0xfR1BMKHVz
Yl9waHlfcm9vdGh1Yl9zdXNwZW5kKTsKKworaW50IHVzYl9waHlfcm9vdGh1Yl9yZXN1bWUoc3Ry
dWN0IGRldmljZSAqZGV2LAorCQkJICAgc3RydWN0IHVzYl9waHlfcm9vdGh1YiAqcGh5X3Jvb3Ro
dWIpCit7CisJaW50IGVycjsKKworCS8qIGlmIHRoZSBkZXZpY2UgY2FuJ3Qgd2FrZSB1cCB0aGUg
c3lzdGVtIF9leGl0IHdhcyBjYWxsZWQgKi8KKwlpZiAoZGV2aWNlX2Nhbl93YWtldXAoZGV2KSkg
eworCQllcnIgPSB1c2JfcGh5X3Jvb3RodWJfaW5pdChwaHlfcm9vdGh1Yik7CisJCWlmIChlcnIp
CisJCQlyZXR1cm4gZXJyOworCX0KKworCXJldHVybiB1c2JfcGh5X3Jvb3RodWJfcG93ZXJfb24o
cGh5X3Jvb3RodWIpOworfQorRVhQT1JUX1NZTUJPTF9HUEwodXNiX3BoeV9yb290aHViX3Jlc3Vt
ZSk7CmRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9jb3JlL3BoeS5oIGIvZHJpdmVycy91c2IvY29y
ZS9waHkuaAppbmRleCBlYjMxMjUzMjAxYWQuLjYwMWFlZmQ0MTg3OCAxMDA2NDQKLS0tIGEvZHJp
dmVycy91c2IvY29yZS9waHkuaAorKysgYi9kcml2ZXJzL3VzYi9jb3JlL3BoeS5oCkBAIC03LDMg
KzcsOCBAQCBpbnQgdXNiX3BoeV9yb290aHViX2V4aXQoc3RydWN0IHVzYl9waHlfcm9vdGh1YiAq
cGh5X3Jvb3RodWIpOwogCiBpbnQgdXNiX3BoeV9yb290aHViX3Bvd2VyX29uKHN0cnVjdCB1c2Jf
cGh5X3Jvb3RodWIgKnBoeV9yb290aHViKTsKIHZvaWQgdXNiX3BoeV9yb290aHViX3Bvd2VyX29m
ZihzdHJ1Y3QgdXNiX3BoeV9yb290aHViICpwaHlfcm9vdGh1Yik7CisKK2ludCB1c2JfcGh5X3Jv
b3RodWJfc3VzcGVuZChzdHJ1Y3QgZGV2aWNlICpkZXYsCisJCQkgICAgc3RydWN0IHVzYl9waHlf
cm9vdGh1YiAqcGh5X3Jvb3RodWIpOworaW50IHVzYl9waHlfcm9vdGh1Yl9yZXN1bWUoc3RydWN0
IGRldmljZSAqZGV2LAorCQkJICAgc3RydWN0IHVzYl9waHlfcm9vdGh1YiAqcGh5X3Jvb3RodWIp
OwotLSAKMi4xNi4yCgo=
--0000000000003f07770567df376b
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-mediatek mailing list
Linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
http://lists.infradead.org/mailman/listinfo/linux-mediatek

--0000000000003f07770567df376b--
