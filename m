From: "Valentin, Eduardo" <eduardo.valentin@ti.com>
Subject: Re: [RFC PATCH 00/11] OMAP System Control Module
Date: Fri, 25 May 2012 14:11:26 +0300
Message-ID: <CAGF5oy_76y=8Cj=1YjhQAo_JvUb8T5K6E7PoWAkDWULjJXuGSg@mail.gmail.com>
References: <1337934361-1606-1-git-send-email-eduardo.valentin@ti.com>
	<4FBF63E7.3070605@dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:42645 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757092Ab2EYLL2 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 25 May 2012 07:11:28 -0400
Received: by obbwd18 with SMTP id wd18so1188497obb.28
        for <linux-omap@vger.kernel.org>; Fri, 25 May 2012 04:11:26 -0700 (PDT)
In-Reply-To: <4FBF63E7.3070605@dev.rtsoft.ru>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Konstantin Baydarov <kbaidarov@dev.rtsoft.ru>
Cc: b-cousson@ti.com, kishon@ti.com, santosh.shilimkar@ti.com, tony@atomide.com, paul@pwsan.com, balbi@ti.com, amit.kucheria@linaro.org, linux-pm@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, amit.kachhap@linaro.org

Konstantin,

On Fri, May 25, 2012 at 1:50 PM, Konstantin Baydarov
<kbaidarov@dev.rtsoft.ru> wrote:
> =A0Hi.
>
> On 05/25/2012 12:25 PM, Eduardo Valentin wrote:
>> Hello Paul and Tony,
>>
>> This is a series of patches adding a basic support for system contro=
l module,
>> on OMAP4+ context. It is a working in progress, but I wanted to shar=
e already
>> to get your feedback.
>>
>> I've modeled the driver as an MFD. You will see in this series:
>> . A rework of the system control module header (patch from Santosh, =
picked from the list)
>> . Device creation for control module core
>> . Early device creation for control module core
>> . The MFD core driver for system control module
>> . The MFD child for usb-phy pin control
>> . The MFD child for bandgap sensor
>> . Very early exposure of OMAP4 thermal zone
>> . All added drivers are only supporting DT probing
>> . The series is based on linux-omap master, as it has the hwmod entr=
ies for SCM.
>>
>> The overall idea of this series is to put in place the infrastructur=
e. It is
>> not touching nor removing the existing APIs under mach-omap2/control=
=2Ec for now.
>> But the target is to have these APIs moved to the MFD core driver.
>>
>> For early access, like ID checking, I have written the platform driv=
er
>> as an early platform driver and you will see also early device addit=
ion
>> and probing under device.c for this case. This is of course a propos=
al.
>> I see that there are people that thing this is a bit of an overkill.
>> Konstantin (CCd) was proposing a simpler solution by having
>> APIs with early_* prefixes, and solve the IO address mapping with
>> a DT entry, for instance. But feel free to propose better ways.
> In my latest version I got rid from early API set, check out patch fo=
r V3 patch set.
> I'll attach patch for current version later.


Please send it across so we can compare your approach with the one
present in this series.

>
> BR,
> =A0 =A0Konstantin Baydarov.
>
>>
>> This code has been ripped off from the Android 3.1 branch. I have re=
written
>> a couple of things, but the major driver functions and API's entries=
 are kept.
>>
>> So, based on this series, I see as a TODO list, for system control c=
ore driver:
>> - Start to move all the existing APIs under mach-omap2/control.c to =
the mfd core.
>> - Rewrite the users of the existing APIs, mentioned on previous item
>> Once we decide the API and agree on how to deal with early calls.
>> - Add remaining children (from top of my head, the CAM is one of the=
m,
>> but I also think we should prob have one for HWOBS for instance)
>> - Test on boards that use the existing APIs.
>>
>> TODO list for bandgap driver:
>> - Improve thermal zone definition for OMAP4
>> - Introduce the thermal zones for OMAP5
>>
>> Amit, due to hwmod dep, I didn't include any cooling binding in this=
 series,
>> based on the generic CPU cooling device.
>>
>> Overall series has been tested only with panda board OMAP4460.
>>
>> Your comments are welcome.
>>
>> All best,
>>
>> Eduardo Valentin (9):
>> =A0 ARM: OMAP: expose control.h to mach area
>> =A0 OMAP: Add early device for system control module
>> =A0 mfd: omap: control: core system control driver
>> =A0 OMAP2+: use control module mfd driver in omap_type
>> =A0 mfd: omap: control: usb-phy: introduce the ctrl-module usb drive=
r
>> =A0 ARM: OMAP4+: Adding the temperature sensor register set bit fiel=
ds
>> =A0 ARM: OMAP4+: thermal: introduce bandgap temperature sensor
>> =A0 omap4: thermal: add basic CPU thermal zone
>> =A0 ARM: DT: Add support to system control module for OMAP4
>>
>> Kishon Vijay Abraham I (1):
>> =A0 arm: omap: device: create a device for system control module
>>
>> Santosh Shilimkar (1):
>> =A0 ARM: OMAP4: Remove un-used control module headers and defines.
>>
>> =A0.../devicetree/bindings/mfd/omap_control.txt =A0 =A0 =A0 | =A0 44=
 +
>> =A0.../devicetree/bindings/thermal/omap_bandgap.txt =A0 | =A0 27 +
>> =A0arch/arm/boot/dts/omap4.dtsi =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 | =A0 13 +
>> =A0arch/arm/mach-omap2/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0| =A0 =A01 +
>> =A0arch/arm/mach-omap2/am35xx-emac.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0| =A0 =A02 +-
>> =A0arch/arm/mach-omap2/board-3430sdp.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
| =A0 =A02 +-
>> =A0arch/arm/mach-omap2/board-4430sdp.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
| =A0 =A02 +-
>> =A0arch/arm/mach-omap2/board-am3517crane.c =A0 =A0 =A0 =A0 =A0 =A0| =
=A0 =A02 +-
>> =A0arch/arm/mach-omap2/board-am3517evm.c =A0 =A0 =A0 =A0 =A0 =A0 =A0=
| =A0 =A02 +-
>> =A0arch/arm/mach-omap2/board-apollon.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
| =A0 =A02 +-
>> =A0arch/arm/mach-omap2/board-cm-t3517.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
| =A0 =A02 +-
>> =A0arch/arm/mach-omap2/board-h4.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 | =A0 =A02 +-
>> =A0arch/arm/mach-omap2/board-igep0020.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
| =A0 =A02 +-
>> =A0arch/arm/mach-omap2/board-ldp.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0| =A0 =A02 +-
>> =A0arch/arm/mach-omap2/board-omap3logic.c =A0 =A0 =A0 =A0 =A0 =A0 | =
=A0 =A02 +-
>> =A0arch/arm/mach-omap2/board-omap4panda.c =A0 =A0 =A0 =A0 =A0 =A0 | =
=A0 =A02 +-
>> =A0arch/arm/mach-omap2/board-omap4pcm049.c =A0 =A0 =A0 =A0 =A0 =A0| =
=A0 =A02 +-
>> =A0arch/arm/mach-omap2/clock2420_data.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
| =A0 =A02 +-
>> =A0arch/arm/mach-omap2/clock2430_data.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
| =A0 =A02 +-
>> =A0arch/arm/mach-omap2/clock3xxx_data.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
| =A0 =A02 +-
>> =A0arch/arm/mach-omap2/clock44xx_data.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
| =A0 =A02 +-
>> =A0arch/arm/mach-omap2/common.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 | =A0 =A02 +-
>> =A0arch/arm/mach-omap2/control.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0| =A0 =A02 +-
>> =A0arch/arm/mach-omap2/cpuidle34xx.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0| =A0 =A02 +-
>> =A0arch/arm/mach-omap2/devices.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0| =A0 57 +-
>> =A0arch/arm/mach-omap2/display.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0| =A0 =A02 +-
>> =A0arch/arm/mach-omap2/hsmmc.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0| =A0 =A02 +-
>> =A0arch/arm/mach-omap2/id.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 | =A0 18 +-
>> =A0arch/arm/mach-omap2/{ =3D> include/mach}/control.h =A0 | =A0163 +=
+-
>> =A0.../include/mach/ctrl_module_core_44xx.h =A0 =A0 =A0 =A0 =A0 | =A0=
391 -----
>> =A0.../include/mach/ctrl_module_pad_core_44xx.h =A0 =A0 =A0 | 1409 -=
----------------
>> =A0.../include/mach/ctrl_module_pad_wkup_44xx.h =A0 =A0 =A0 | =A0236=
 ---
>> =A0.../include/mach/ctrl_module_wkup_44xx.h =A0 =A0 =A0 =A0 =A0 | =A0=
 92 --
>> =A0arch/arm/mach-omap2/mcbsp.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0| =A0 =A02 +-
>> =A0arch/arm/mach-omap2/mux.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0| =A0 =A02 +-
>> =A0arch/arm/mach-omap2/omap_phy_internal.c =A0 =A0 =A0 =A0 =A0 =A0| =
=A0 =A02 +-
>> =A0arch/arm/mach-omap2/opp3xxx_data.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 | =A0 =A02 +-
>> =A0arch/arm/mach-omap2/opp4xxx_data.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 | =A0 =A02 +-
>> =A0arch/arm/mach-omap2/pm24xx.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 | =A0 =A02 +-
>> =A0arch/arm/mach-omap2/pm34xx.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 | =A0 =A02 +-
>> =A0arch/arm/mach-omap2/prcm.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 | =A0 =A02 +-
>> =A0arch/arm/mach-omap2/serial.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 | =A0 =A02 +-
>> =A0arch/arm/mach-omap2/sleep34xx.S =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0| =A0 =A02 +-
>> =A0arch/arm/mach-omap2/sr_device.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0| =A0 =A02 +-
>> =A0arch/arm/mach-omap2/usb-fs.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 | =A0 =A02 +-
>> =A0arch/arm/mach-omap2/voltage.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0| =A0 =A02 +-
>> =A0arch/arm/plat-omap/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 | =A0 =A03 +
>> =A0drivers/mfd/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0| =A0 =A09 +
>> =A0drivers/mfd/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 | =A0 =A01 +
>> =A0drivers/mfd/omap-control-core.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0| =A0211 +++
>> =A0drivers/thermal/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0| =A0 25 +
>> =A0drivers/thermal/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 | =A0 =A05 +-
>> =A0drivers/thermal/omap-bandgap.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 | 1602 ++++++++++++++++++++
>> =A0drivers/thermal/omap-bandgap.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 | =A0 75 +
>> =A0drivers/thermal/omap4-thermal.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0| =A0 72 +
>> =A0drivers/usb/otg/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0| =A0 13 +
>> =A0drivers/usb/otg/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 | =A0 =A01 +
>> =A0drivers/usb/otg/omap4-usb-phy.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0| =A0130 ++
>> =A0include/linux/mfd/omap_control.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 | =A0 69 +
>> =A0include/linux/usb/omap4_usb_phy.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0| =A0 53 +
>> =A060 files changed, 2617 insertions(+), 2173 deletions(-)
>> =A0create mode 100644 Documentation/devicetree/bindings/mfd/omap_con=
trol.txt
>> =A0create mode 100644 Documentation/devicetree/bindings/thermal/omap=
_bandgap.txt
>> =A0rename arch/arm/mach-omap2/{ =3D> include/mach}/control.h (75%)
>> =A0delete mode 100644 arch/arm/mach-omap2/include/mach/ctrl_module_c=
ore_44xx.h
>> =A0delete mode 100644 arch/arm/mach-omap2/include/mach/ctrl_module_p=
ad_core_44xx.h
>> =A0delete mode 100644 arch/arm/mach-omap2/include/mach/ctrl_module_p=
ad_wkup_44xx.h
>> =A0delete mode 100644 arch/arm/mach-omap2/include/mach/ctrl_module_w=
kup_44xx.h
>> =A0create mode 100644 drivers/mfd/omap-control-core.c
>> =A0create mode 100644 drivers/thermal/omap-bandgap.c
>> =A0create mode 100644 drivers/thermal/omap-bandgap.h
>> =A0create mode 100644 drivers/thermal/omap4-thermal.c
>> =A0create mode 100644 drivers/usb/otg/omap4-usb-phy.c
>> =A0create mode 100644 include/linux/mfd/omap_control.h
>> =A0create mode 100644 include/linux/usb/omap4_usb_phy.h
>>
>



--=20

Eduardo Valentin
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
