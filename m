From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH v2 0/9] PM: Create the AVS class of drivers
Date: Tue, 3 Apr 2012 13:14:23 +0200
Message-ID: <CAORVsuWJrEjUi11dyQZCnn-6BwOg9cN94G44JWpYvCtB8LbxKw@mail.gmail.com>
References: <1332173578-27422-1-git-send-email-j-pihet@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:45502 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751705Ab2DCLOY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 Apr 2012 07:14:24 -0400
Received: by eekc41 with SMTP id c41so1178073eek.19
        for <linux-omap@vger.kernel.org>; Tue, 03 Apr 2012 04:14:23 -0700 (PDT)
In-Reply-To: <1332173578-27422-1-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@ti.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, LKML <linux-kernel@vger.kernel.org>, Tony Lindgren <tony@atomide.com>
Cc: Jean Pihet <j-pihet@ti.com>

Hi Tony, Rafael,

Here is a gentle ping on this series.
Do you think this can go in the next rc?

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
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
