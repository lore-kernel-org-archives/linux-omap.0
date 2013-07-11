From: Afzal Mohammed <afzal@ti.com>
Subject: [PATCH RFC 00/13] ARM: OMAP2+: AM43x PRCM support
Date: Thu, 11 Jul 2013 12:03:00 +0530
Message-ID: <cover.1373519192.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:33920 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751009Ab3GKGda (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Jul 2013 02:33:30 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Paul Walmsley <paul@pwsan.com>, Benoit Cousson <benoit.cousson@linaro.org>, Tony Lindgren <tony@atomide.com>

Hi,

AM43x PRCM support (excluding clock tree) is being added with this
series. AM43x reuses most of the IP's from AM335x, as that is the
case, it was felt that reusing AM335x code as much as possible for
AM43x is better - it also helps to keep LOC less.

		********

This RFC is being posted to get an early feedback on approach taken
here mainly w.r.t reusing AM335x hwmod database for AM43x.

		********

Major reuse has been with hwmod database of AM335x, moving common
elements to a new array and keeping separate arrays for elements that
are specific only to either one of AM335x or AM43x. And in the cases
where relevant IP is present in both that has difference in details
like CLKCTRL register offsets, it is being updated at runtime based on
the SoC detected.

Powerdomain & Clockdomain data has been added separately as it was not
giving much advantage reusing AM335x ones (runtime updates required
was getting too ugly).

As AM43x PRCM is similar to OMAP4, OMAP4 power domain & clock domain
operations are being reused. This would have to be modified to have
only the required domain operation fields, some thing like reusing
Vaibhav Bedia's newly proposed domain operations for AM335x of [4]
if [1] completely makes it to the mainline (that would require
modifications to power and clock domain data fields of this series
too), otherwise a similar domain operations would have to be added
for AM43x.

Also it has to be ensured that only relevant HWMOD operations are
handled like in [4].

A single header file has been added to provide all AM43x PRCM defines.

Here sequencewise, initially AM335x hwmod is modified to have it's
fields get updated at runtime (wherever element is shared and has
some difference with AM43x). Then power domain, clock domain for AM43x
is added and finally AM335x hwmod database is updated with AM43x
specifics.

This series is being developed with additional clock tree changes that
would be DT'fied.

Additional DTS changes are also required for hwmod to get register
target address space as most of AM335x hwmod address space details has
been recently cleaned up and moved to DTS.

Vaibhav Bedia's [2] & [3] that are part of [1] has been used along
with this series for validating.

Regards
Afzal

[1] Consolidate AM335x and OMAP4 PRM/CM APIs -
	http://www.mail-archive.com/linux-omap@vger.kernel.org/msg91511.html
[2] [RFC 2/9] ARM: OMAP2+: CM code: Reintroduce SW_SLEEP for OMAP4 class of devices
[3] [RFC 6/9] ARM: OMAP4: CM code: Remove the check for non-zero clkctrl_offs
[4] [RFC 8/9] ARM: OMAP2+: AM335x: Migrate to OMAP4 PRM/CM APIs

Afzal Mohammed (8):
  ARM: OMAP2+: hwmod: AM335x: prepare for AM43x reuse
  ARM: OMAP2+: hwmod: AMx3: runtime AM335x handling
  ARM: OMAP2+: hwmod: AMx3: remove common static fields
  ARM: OMAP2+: PRCM: AM43x definitions
  ARM: OMAP2+: hwmod: AMx3: runtime AM43x handling
  ARM: OMAP2+: AM43x: PRCM kbuild
  ARM: OMAP2+: hwmod: type4 sysc
  ARM: OMAP2+: hwmod: AM43x: new w.r.t AM335x

Ambresh K (4):
  ARM: OMAP2+: PM: AM43x powerdomain data
  ARM: OMAP2+: CM: AM43x clockdomain data
  ARM: OMAP2+: hwmod: AM43x operations
  ARM: OMAP2+: AM43x PRCM init

Ankur Kishore (1):
  ARM: OMAP2+: CM: cm_inst offset s16->u16

 arch/arm/mach-omap2/Makefile                 |   5 +-
 arch/arm/mach-omap2/clockdomain.h            |   3 +-
 arch/arm/mach-omap2/clockdomains43xx_data.c  | 199 +++++++
 arch/arm/mach-omap2/cm33xx.c                 |  30 +-
 arch/arm/mach-omap2/cm33xx.h                 |  28 +-
 arch/arm/mach-omap2/cminst44xx.c             |  29 +-
 arch/arm/mach-omap2/cminst44xx.h             |  25 +-
 arch/arm/mach-omap2/io.c                     |   6 +
 arch/arm/mach-omap2/omap_hwmod.c             |   2 +-
 arch/arm/mach-omap2/omap_hwmod.h             |   5 +
 arch/arm/mach-omap2/omap_hwmod_33xx_data.c   | 850 ++++++++++++++++++++++++---
 arch/arm/mach-omap2/omap_hwmod_common_data.c |   6 +
 arch/arm/mach-omap2/powerdomain.h            |   1 +
 arch/arm/mach-omap2/powerdomains43xx_data.c  | 145 +++++
 arch/arm/mach-omap2/prcm43xx.h               | 148 +++++
 15 files changed, 1341 insertions(+), 141 deletions(-)
 create mode 100644 arch/arm/mach-omap2/clockdomains43xx_data.c
 create mode 100644 arch/arm/mach-omap2/powerdomains43xx_data.c
 create mode 100644 arch/arm/mach-omap2/prcm43xx.h

-- 
1.8.3.1

