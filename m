From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: [PATCH v5 0/7] Add TI EMIF SDRAM controller driver
Date: Thu, 3 May 2012 18:38:23 -0400
Message-ID: <CAP=VYLrCTOb9Qtz_HU5976cew_FR=qN6=x=_nD48ZprTcCjoUg@mail.gmail.com>
References: <1335529449-28046-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:40740 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756344Ab2ECWiz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 May 2012 18:38:55 -0400
In-Reply-To: <1335529449-28046-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-kernel@vger.kernel.org, greg@kroah.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Fri, Apr 27, 2012 at 8:24 AM, Santosh Shilimkar
<santosh.shilimkar@ti.com> wrote:
> Add a driver for the EMIF SDRAM controller used in Texas Instrument S=
oCs

Hi Santosh,

Can you send Greg a patch that adds proper dependencies to the Kconfig?
I was going to simply add an ARM dependency, but perhaps you want to
restrict it further to a subset of OMAP platforms?

At the moment it is causing build failures in other architectures.

http://kisskb.ellerman.id.au/kisskb/buildresult/6243036/

Thanks,
Paul.
--
>
> EMIF is an SDRAM controller that supports, based on its revision,
> one or more of LPDDR2/DDR2/DDR3 protocols.This driver adds support
> for LPDDR2.
>
> The driver supports the following features:
> - Calculates the DDR AC timing parameters to be set in EMIF
> =A0registers using data from the device data-sheets and based
> =A0on the DDR frequency. If data from data-sheets is not available
> =A0default timing values from the JEDEC spec are used. These
> =A0will be safe, but not necessarily optimal
> - API for changing timings during DVFS or at boot-up
> - Temperature alert configuration and handling of temperature
> =A0alerts, if any for LPDDR2 devices
> =A0* temperature alert is based on periodic polling of MR4 mode
> =A0 =A0register in DDR devices automatically performed by hardware
> =A0* timings are de-rated and brought back to nominal when
> =A0 =A0temperature raises and falls respectively
> - Cache of calculated register values to avoid re-calculating
> =A0them
>
> The driver will need some minor updates when it is eventually
> integrated with Dynamic Voltage and Frequency Scaling (DVFS).
> This can not be done now as DVFS support is not available in
> the mainline yet.
>
> Discussions with Santosh Shilimkar <santosh.shilimkar@ti.com>
> were immensely helpful in shaping up the interfaces. Vibhore Vardhan
> <vvardhan@gmail.com> did the initial code snippet for thermal
> handling.
>
> Testing:
> - The driver is tested on OMAP4430 SDP.
> - The driver in a slightly adapted form is also tested on OMAP5.
> - Since mainline kernel doesn't have DVFS support yet,
> =A0testing was done using a test module.
> - Temperature alert handling was tested with simulated interrupts
> =A0and faked temperature values as testing all cases in real-life
> =A0scenarios is difficult.
> - Tested the driver as a module
>
> Cc: Greg KH <greg@kroah.com>
>
> v5:
> - Moved the EMIF driver to drivers/memory as per discussion thread [2=
]
>
> v4:
> - Converted instances of EXPORT_SYMBOL to EXPORT_SYMBOL_GPL
> - Removed un-necessary "#ifndef __ASSEMBLY__'
> - Minor formatting fix
>
> v2:
> - Fixed a bug found in the implementation of errata i728
> =A0workaround
> - Fixed the value of frequency printed in debugfs
> - Dropped the hwmod patch as Paul has already posted a
> =A0a hwmod series [1] that adds hwmod for EMIF
> - Converted instances of __init to __init_or_module
>
> Regards
> Santosh
>
> [1] http://thread.gmane.org/gmane.linux.ports.arm.omap/72855
> [2] https://lkml.org/lkml/2012/4/12/173
>
>
> Aneesh V (7):
> =A0ddr: add LPDDR2 data from JESD209-2
> =A0memory: emif: add register definitions for EMIF
> =A0memory: emif: add basic infrastructure for EMIF driver
> =A0memory: emif: handle frequency and voltage change events
> =A0memory: emif: add interrupt and temperature handling
> =A0memory: emif: add one-time settings
> =A0memory: emif: add debugfs entries for emif
>
> =A0Documentation/memory-devices/ti-emif.txt | =A0 57 +
> =A0drivers/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
| =A0 =A04 +
> =A0drivers/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 |=
 =A0 =A03 +
> =A0drivers/memory/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 2=
2 +
> =A0drivers/memory/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A0=
5 +
> =A0drivers/memory/emif.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| 167=
0 ++++++++++++++++++++++++++++++
> =A0drivers/memory/emif.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0=
589 +++++++++++
> =A0include/linux/platform_data/emif_plat.h =A0| =A0128 +++
> =A0include/memory/jedec_ddr.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0175 ++=
++
> =A0lib/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0| =A0 =A08 +
> =A0lib/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 | =A0 =A02 +
> =A0lib/jedec_ddr_data.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0=
135 +++
> =A012 files changed, 2798 insertions(+), 0 deletions(-)
> =A0create mode 100644 Documentation/memory-devices/ti-emif.txt
> =A0create mode 100644 drivers/memory/Kconfig
> =A0create mode 100644 drivers/memory/Makefile
> =A0create mode 100644 drivers/memory/emif.c
> =A0create mode 100644 drivers/memory/emif.h
> =A0create mode 100644 include/linux/platform_data/emif_plat.h
> =A0create mode 100644 include/memory/jedec_ddr.h
> =A0create mode 100644 lib/jedec_ddr_data.c
>
> --
> 1.7.5.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kerne=
l" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at =A0http://www.tux.org/lkml/
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
