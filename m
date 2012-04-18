From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH v2 0/9] PM: Create the AVS class of drivers
Date: Wed, 18 Apr 2012 10:04:22 +0200
Message-ID: <CAORVsuV-GJAabY49G0fOgcBcg-CNdpNiTE+AcBN07wrWZH3qcQ@mail.gmail.com>
References: <1332173578-27422-1-git-send-email-j-pihet@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1332173578-27422-1-git-send-email-j-pihet@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: akpm@linux-foundation.org, gregkh@linuxfoundation.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@ti.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, LKML <linux-kernel@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, KEERTHY J <j-keerthy@ti.com>
Cc: Jean Pihet <j-pihet@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi Andrew, Greg,

Can you please look at this patch set?
The idea is to create a framework and drivers for the AVS class of
devices. This patch set implements the first step by moving the
existing code to drivers/power/avs. Next steps will be to implement
class support and notifications, add more classes of operations for
OMAP chips, etc.

Keerthy J is taking over the ownership of this code and will continue
the development further.

What do you think?

Regards,
Jean

On Mon, Mar 19, 2012 at 5:12 PM,  <jean.pihet@newoldbits.com> wrote:
> From: Jean Pihet <j-pihet@ti.com>
>
> AVS is a power management technique which controls the operating
> voltage of a device in order to optimize (i.e. reduce) its power
> consumption. The voltage is adapted depending on static factors
> (chip manufacturing process) and dynamic factors (temperature
> depending performance).
> AVS is also called SmartReflex on OMAP devices.
>
> To that end, create the AVS framework in drivers/power/avs and
> move the OMAP SmartReflex code to the new directory.
>
> In preparation to the move of the OMAP code the following changes hav=
e been
> made:
> - split the include files into generic and platform specific code,
> - fill in platform data from the device initialization code and pass
> =A0it to the driver,
> - create CONFIG_AVS* config options accordingly.
>
> The platform integration data for SmartReflex is passed from hwmod
> and the voltage layer to the driver using pdata.
>
>
> Tested on OMAP3 Beagleboard using omap2plus_defconfig with the
> CONFIG_POWER_AVS* options set.
> Based on master branch of the l-o git tree (3.3.0-rc6) [1], commit
> 85244e0edd240da2004bb2ab7cbcbc67a336f20d.
>
> [1] git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap.g=
it
>
>
> History:
> v2: rework after the comments on MLs
> =A0. Keep the OMAP Kconfig options in the arch dir (Rafael),
> =A0. Move the shared header file from plat-omap to
> =A0 =A0include/linux/power/ (Tony)
>
> v1: initial revision
>
>
> Jean Pihet (9):
> =A0ARM: OMAP3+: voltage: export functions to plat/voltage.h
> =A0ARM: OMAP2+: SmartReflex: move the driver specific macros in
> =A0 =A0include/linux/power
> =A0ARM: OMAP3+: SmartReflex: class drivers should use struct omap_sr =
*
> =A0ARM: OMAP2+: smartreflex: Use the names from hwmod data instead of
> =A0 =A0voltage domains.
> =A0ARM: OMAP3: hwmod: rename the smartreflex entries
> =A0ARM: OMAP2+: SmartReflex: introduce a busy loop condition test mac=
ro
> =A0ARM: OMAP2+: SmartReflex: Use per-OPP data structure
> =A0ARM: OMAP2+: SmartReflex: add POWER_AVS Kconfig options
> =A0ARM: OMAP: SmartReflex: Move smartreflex driver to drivers/
>
> =A0arch/arm/mach-omap2/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A0=
4 +-
> =A0arch/arm/mach-omap2/omap_hwmod_3xxx_data.c | =A0 12 +-
> =A0arch/arm/mach-omap2/omap_hwmod_44xx_data.c | =A0 =A03 +-
> =A0arch/arm/mach-omap2/pm.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0=
 =A02 +-
> =A0arch/arm/mach-omap2/smartreflex-class3.c =A0 | =A0 60 --
> =A0arch/arm/mach-omap2/smartreflex.c =A0 =A0 =A0 =A0 =A0| 1165 ------=
----------------------
> =A0arch/arm/mach-omap2/smartreflex.h =A0 =A0 =A0 =A0 =A0| =A0256 ----=
--
> =A0arch/arm/mach-omap2/sr_device.c =A0 =A0 =A0 =A0 =A0 =A0| =A0 38 +-
> =A0arch/arm/mach-omap2/voltage.h =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A0=
1 -
> =A0arch/arm/mach-omap2/vp.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0=
 =A02 -
> =A0arch/arm/plat-omap/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 3=
0 +-
> =A0arch/arm/plat-omap/include/plat/voltage.h =A0| =A0 =A03 +
> =A0drivers/power/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0|=
 =A0 =A02 +
> =A0drivers/power/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0=
 =A02 +
> =A0drivers/power/avs/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0=
 12 +
> =A0drivers/power/avs/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A0=
2 +
> =A0drivers/power/avs/smartreflex-class3.c =A0 =A0 | =A0 61 ++
> =A0drivers/power/avs/smartreflex.c =A0 =A0 =A0 =A0 =A0 =A0| 1118 ++++=
++++++++++++++++++++++
> =A0drivers/power/avs/smartreflex.h =A0 =A0 =A0 =A0 =A0 =A0| =A0238 ++=
++++
> =A0include/linux/power/smartreflex.h =A0 =A0 =A0 =A0 =A0| =A0 97 +++
> =A020 files changed, 1590 insertions(+), 1518 deletions(-)
> =A0delete mode 100644 arch/arm/mach-omap2/smartreflex-class3.c
> =A0delete mode 100644 arch/arm/mach-omap2/smartreflex.c
> =A0delete mode 100644 arch/arm/mach-omap2/smartreflex.h
> =A0create mode 100644 drivers/power/avs/Kconfig
> =A0create mode 100644 drivers/power/avs/Makefile
> =A0create mode 100644 drivers/power/avs/smartreflex-class3.c
> =A0create mode 100644 drivers/power/avs/smartreflex.c
> =A0create mode 100644 drivers/power/avs/smartreflex.h
> =A0create mode 100644 include/linux/power/smartreflex.h
>
> --
> 1.7.5.4
>
