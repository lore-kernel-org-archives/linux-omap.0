From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 0/3] MFD/GPIO: Add twl6040 GPO driver
Date: Thu, 16 Aug 2012 15:13:12 +0300
Message-ID: <1345119195-7490-1-git-send-email-peter.ujfalusi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:46426 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753855Ab2HPMNC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 16 Aug 2012 08:13:02 -0400
Received: by obbuo13 with SMTP id uo13so3597295obb.19
        for <linux-omap@vger.kernel.org>; Thu, 16 Aug 2012 05:13:00 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Samuel Ortiz <sameo@linux.intel.com>, Grant Likely <grant.likely@secretlab.ca>, Linus Walleij <linus.walleij@stericsson.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, peter.ujfalusi@ti.com

Hello,

Changes since v1:
- Removed the ti,use-gpo property from DT bindings
- Register the GPO driver if we booted with DT blob or in legacy if the pdata
  for the GPO driver is present
- DT binding Documentation update

The Documentation update has reference to the twl6040.dtsi file which will be
created to hold the common/static properties for the twl6040.
To avoid cross tree merge issues later I have only included the Documentation
update to this series and I will send the actual .dtsi/.dts changes via
linux-omap. If this is not a problem.

The dependencies for this series are in mainline and I think this series can
go via GPIO if Samuel agrees with the changes.

Intro mail from v1:

The following series adds support for the GPO (General Purpose Output) on the
twl6040/41 audio chip.
The series has been tested on SDP4430, compile tested for x86_64 and x86_32 bit
to be sure it does not introduce build breakage.

Regards,
Peter
---
Peter Ujfalusi (3):
  mfd: twl6040: Fix GPO mask
  mfd: twl6040: Add twl6040-gpio child
  gpio: Add basic support for TWL6040 GPOs

 Documentation/devicetree/bindings/mfd/twl6040.txt |    9 +-
 drivers/gpio/Kconfig                              |    7 +
 drivers/gpio/Makefile                             |    1 +
 drivers/gpio/gpio-twl6040.c                       |  137 +++++++++++++++++++++
 drivers/mfd/twl6040-core.c                        |   15 +++
 include/linux/mfd/twl6040.h                       |   11 ++-
 6 files changed, 175 insertions(+), 5 deletions(-)
 create mode 100644 drivers/gpio/gpio-twl6040.c

-- 
1.7.8.6

