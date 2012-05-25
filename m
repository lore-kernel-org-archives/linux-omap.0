From: Konstantin Baydarov <kbaidarov@dev.rtsoft.ru>
Subject: Re: [RFC PATCH 00/11] OMAP System Control Module
Date: Fri, 25 May 2012 14:50:15 +0400
Message-ID: <4FBF63E7.3070605@dev.rtsoft.ru>
References: <1337934361-1606-1-git-send-email-eduardo.valentin@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1337934361-1606-1-git-send-email-eduardo.valentin@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Eduardo Valentin <eduardo.valentin@ti.com>
Cc: paul@pwsan.com, b-cousson@ti.com, tony@atomide.com, Konstantin Baydarov <kbaidarov@dev.rtsoft.ru>, balbi@ti.com, kishon@ti.com, santosh.shilimkar@ti.com, amit.kucheria@linaro.org, linux-pm@lists.linux-foundation.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, amit.kachhap@linaro.org
List-Id: linux-omap@vger.kernel.org

  Hi.

On 05/25/2012 12:25 PM, Eduardo Valentin wrote:
> Hello Paul and Tony,
>
> This is a series of patches adding a basic support for system control module,
> on OMAP4+ context. It is a working in progress, but I wanted to share already
> to get your feedback.
>
> I've modeled the driver as an MFD. You will see in this series:
> . A rework of the system control module header (patch from Santosh, picked from the list)
> . Device creation for control module core
> . Early device creation for control module core
> . The MFD core driver for system control module
> . The MFD child for usb-phy pin control
> . The MFD child for bandgap sensor
> . Very early exposure of OMAP4 thermal zone
> . All added drivers are only supporting DT probing
> . The series is based on linux-omap master, as it has the hwmod entries for SCM.
>
> The overall idea of this series is to put in place the infrastructure. It is
> not touching nor removing the existing APIs under mach-omap2/control.c for now.
> But the target is to have these APIs moved to the MFD core driver.
>
> For early access, like ID checking, I have written the platform driver
> as an early platform driver and you will see also early device addition
> and probing under device.c for this case. This is of course a proposal.
> I see that there are people that thing this is a bit of an overkill.
> Konstantin (CCd) was proposing a simpler solution by having
> APIs with early_* prefixes, and solve the IO address mapping with
> a DT entry, for instance. But feel free to propose better ways.
In my latest version I got rid from early API set, check out patch for V3 patch set.
I'll attach patch for current version later.

BR,
    Konstantin Baydarov.

>
> This code has been ripped off from the Android 3.1 branch. I have rewritten
> a couple of things, but the major driver functions and API's entries are kept.
>
> So, based on this series, I see as a TODO list, for system control core driver:
> - Start to move all the existing APIs under mach-omap2/control.c to the mfd core.
> - Rewrite the users of the existing APIs, mentioned on previous item
> Once we decide the API and agree on how to deal with early calls.
> - Add remaining children (from top of my head, the CAM is one of them,
> but I also think we should prob have one for HWOBS for instance)
> - Test on boards that use the existing APIs.
>
> TODO list for bandgap driver:
> - Improve thermal zone definition for OMAP4
> - Introduce the thermal zones for OMAP5
>
> Amit, due to hwmod dep, I didn't include any cooling binding in this series,
> based on the generic CPU cooling device.
>
> Overall series has been tested only with panda board OMAP4460.
>
> Your comments are welcome.
>
> All best,
>
> Eduardo Valentin (9):
>   ARM: OMAP: expose control.h to mach area
>   OMAP: Add early device for system control module
>   mfd: omap: control: core system control driver
>   OMAP2+: use control module mfd driver in omap_type
>   mfd: omap: control: usb-phy: introduce the ctrl-module usb driver
>   ARM: OMAP4+: Adding the temperature sensor register set bit fields
>   ARM: OMAP4+: thermal: introduce bandgap temperature sensor
>   omap4: thermal: add basic CPU thermal zone
>   ARM: DT: Add support to system control module for OMAP4
>
> Kishon Vijay Abraham I (1):
>   arm: omap: device: create a device for system control module
>
> Santosh Shilimkar (1):
>   ARM: OMAP4: Remove un-used control module headers and defines.
>
>  .../devicetree/bindings/mfd/omap_control.txt       |   44 +
>  .../devicetree/bindings/thermal/omap_bandgap.txt   |   27 +
>  arch/arm/boot/dts/omap4.dtsi                       |   13 +
>  arch/arm/mach-omap2/Kconfig                        |    1 +
>  arch/arm/mach-omap2/am35xx-emac.c                  |    2 +-
>  arch/arm/mach-omap2/board-3430sdp.c                |    2 +-
>  arch/arm/mach-omap2/board-4430sdp.c                |    2 +-
>  arch/arm/mach-omap2/board-am3517crane.c            |    2 +-
>  arch/arm/mach-omap2/board-am3517evm.c              |    2 +-
>  arch/arm/mach-omap2/board-apollon.c                |    2 +-
>  arch/arm/mach-omap2/board-cm-t3517.c               |    2 +-
>  arch/arm/mach-omap2/board-h4.c                     |    2 +-
>  arch/arm/mach-omap2/board-igep0020.c               |    2 +-
>  arch/arm/mach-omap2/board-ldp.c                    |    2 +-
>  arch/arm/mach-omap2/board-omap3logic.c             |    2 +-
>  arch/arm/mach-omap2/board-omap4panda.c             |    2 +-
>  arch/arm/mach-omap2/board-omap4pcm049.c            |    2 +-
>  arch/arm/mach-omap2/clock2420_data.c               |    2 +-
>  arch/arm/mach-omap2/clock2430_data.c               |    2 +-
>  arch/arm/mach-omap2/clock3xxx_data.c               |    2 +-
>  arch/arm/mach-omap2/clock44xx_data.c               |    2 +-
>  arch/arm/mach-omap2/common.c                       |    2 +-
>  arch/arm/mach-omap2/control.c                      |    2 +-
>  arch/arm/mach-omap2/cpuidle34xx.c                  |    2 +-
>  arch/arm/mach-omap2/devices.c                      |   57 +-
>  arch/arm/mach-omap2/display.c                      |    2 +-
>  arch/arm/mach-omap2/hsmmc.c                        |    2 +-
>  arch/arm/mach-omap2/id.c                           |   18 +-
>  arch/arm/mach-omap2/{ => include/mach}/control.h   |  163 ++-
>  .../include/mach/ctrl_module_core_44xx.h           |  391 -----
>  .../include/mach/ctrl_module_pad_core_44xx.h       | 1409 -----------------
>  .../include/mach/ctrl_module_pad_wkup_44xx.h       |  236 ---
>  .../include/mach/ctrl_module_wkup_44xx.h           |   92 --
>  arch/arm/mach-omap2/mcbsp.c                        |    2 +-
>  arch/arm/mach-omap2/mux.c                          |    2 +-
>  arch/arm/mach-omap2/omap_phy_internal.c            |    2 +-
>  arch/arm/mach-omap2/opp3xxx_data.c                 |    2 +-
>  arch/arm/mach-omap2/opp4xxx_data.c                 |    2 +-
>  arch/arm/mach-omap2/pm24xx.c                       |    2 +-
>  arch/arm/mach-omap2/pm34xx.c                       |    2 +-
>  arch/arm/mach-omap2/prcm.c                         |    2 +-
>  arch/arm/mach-omap2/serial.c                       |    2 +-
>  arch/arm/mach-omap2/sleep34xx.S                    |    2 +-
>  arch/arm/mach-omap2/sr_device.c                    |    2 +-
>  arch/arm/mach-omap2/usb-fs.c                       |    2 +-
>  arch/arm/mach-omap2/voltage.c                      |    2 +-
>  arch/arm/plat-omap/Kconfig                         |    3 +
>  drivers/mfd/Kconfig                                |    9 +
>  drivers/mfd/Makefile                               |    1 +
>  drivers/mfd/omap-control-core.c                    |  211 +++
>  drivers/thermal/Kconfig                            |   25 +
>  drivers/thermal/Makefile                           |    5 +-
>  drivers/thermal/omap-bandgap.c                     | 1602 ++++++++++++++++++++
>  drivers/thermal/omap-bandgap.h                     |   75 +
>  drivers/thermal/omap4-thermal.c                    |   72 +
>  drivers/usb/otg/Kconfig                            |   13 +
>  drivers/usb/otg/Makefile                           |    1 +
>  drivers/usb/otg/omap4-usb-phy.c                    |  130 ++
>  include/linux/mfd/omap_control.h                   |   69 +
>  include/linux/usb/omap4_usb_phy.h                  |   53 +
>  60 files changed, 2617 insertions(+), 2173 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mfd/omap_control.txt
>  create mode 100644 Documentation/devicetree/bindings/thermal/omap_bandgap.txt
>  rename arch/arm/mach-omap2/{ => include/mach}/control.h (75%)
>  delete mode 100644 arch/arm/mach-omap2/include/mach/ctrl_module_core_44xx.h
>  delete mode 100644 arch/arm/mach-omap2/include/mach/ctrl_module_pad_core_44xx.h
>  delete mode 100644 arch/arm/mach-omap2/include/mach/ctrl_module_pad_wkup_44xx.h
>  delete mode 100644 arch/arm/mach-omap2/include/mach/ctrl_module_wkup_44xx.h
>  create mode 100644 drivers/mfd/omap-control-core.c
>  create mode 100644 drivers/thermal/omap-bandgap.c
>  create mode 100644 drivers/thermal/omap-bandgap.h
>  create mode 100644 drivers/thermal/omap4-thermal.c
>  create mode 100644 drivers/usb/otg/omap4-usb-phy.c
>  create mode 100644 include/linux/mfd/omap_control.h
>  create mode 100644 include/linux/usb/omap4_usb_phy.h
>
