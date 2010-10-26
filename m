From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH v2 0/4] tidspbridge: SCM layer violation fixes
Date: Tue, 26 Oct 2010 11:15:59 -0500
Message-ID: <1288109763-9446-1-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:47579 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751334Ab0JZQ02 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 26 Oct 2010 12:26:28 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@deeprootsystems.com>, Paul Walmsley <paul@pwsan.com>
Cc: Russell King <linux@arm.linux.org.uk>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Kalle Jokiniemi <kalle.jokiniemi@digia.com>, Rajendra Nayak <rnayak@ti.com>, Felipe Contreras <felipe.contreras@gmail.com>, Tero Kristo <tero.kristo@nokia.com>, Fernando Guzman Lugo <x0095840@ti.com>, Rene Sapiens <rene.sapiens@ti.com>, Ernesto Ramos <ernesto@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Omar Ramirez Luna <omar.ramirez@ti.com>

This is the patch series shared by Paul, for a short term fix to
a compile break due SCM layer layer violations from tidspbridge
driver, where the latter is used to write directly into registers
and use SCM layer macros, among other layer bypassing.

patch: "staging: tidspbridge: use new SCM DSP boot control fns"
was split from its original version, it is meant to be on hold until
the rest of the series gets upstreamed and can be found in the
staging tree (unless best advice is given).

Paul Walmsley (4):
  OMAP: control: add functions for DSP boot address/mode control
  OMAP3: PM: update DSP reset code to use new SCM DSP boot control
    functions
  OMAP: dsp: convert OMAP3430 adaptation layer to use new SCM DSP boot
    control fns
  staging: tidspbridge: use new SCM DSP boot control fns

 arch/arm/mach-omap2/control.c                 |   51 ++++++++++++++++++++++
 arch/arm/mach-omap2/control.h                 |   16 ++++---
 arch/arm/mach-omap2/dsp.c                     |    4 ++
 arch/arm/mach-omap2/pm34xx.c                  |    6 +-
 arch/arm/plat-omap/include/plat/dsp.h         |    4 ++
 arch/arm/plat-omap/include/plat/iva2_dsp.h    |   56 +++++++++++++++++++++++++
 drivers/staging/tidspbridge/core/tiomap3430.c |   13 +++---
 7 files changed, 133 insertions(+), 17 deletions(-)
 create mode 100644 arch/arm/plat-omap/include/plat/iva2_dsp.h

