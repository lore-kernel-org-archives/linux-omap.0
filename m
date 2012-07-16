From: Omar Ramirez Luna <omar.luna@linaro.org>
Subject: [PATCH 0/3] OMAP: hwmod: reset API proposal
Date: Mon, 16 Jul 2012 14:21:22 -0500
Message-ID: <1342466485-1050-1-git-send-email-omar.luna@linaro.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:47493 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752078Ab2GPTVe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 16 Jul 2012 15:21:34 -0400
Received: by obbuo13 with SMTP id uo13so9900910obb.19
        for <linux-omap@vger.kernel.org>; Mon, 16 Jul 2012 12:21:34 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Benoit Cousson <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, Kevin Hilman <khilman@ti.com>, Ohad Ben-Cohen <ohad@wizery.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Omar Ramirez Luna <omar.ramirez@copitl.com>

From: Omar Ramirez Luna <omar.ramirez@copitl.com>

***
RESEND: http://bit.ly/PZDbcc
Needed for ipu, dsp and their mmu reset lines.
***

Recent changes in omap_hwmod framework have reworked the behaviour
towards hardreset handling, commit 747834a (ARM: OMAP2+: hwmod:
revise hardreset behavior) recommends for drivers to implement
their own reset sequences until code out-of-tree hits mainline
and then their needs and code can be reviewed.

Since it is not clear when this will occur for all drivers and
hwmod code was not deleted (presumably because at some point it
will handle the resets once again), this series exports functions
to handle hardreset lines in an attempt to reduce code duplication
for those who have a common reset sequence.

These APIs are intended to be used by iommu for now, but were
tested with IPU and remoteproc on Pandaboard.

Omar Ramirez Luna (3):
  ARM: OMAP: hwmod: partially un-reset hwmods might not be properly
    enabled
  ARM: OMAP: hwmod: revise deassert sequence
  ARM: OMAP: omap_device: expose hwmod assert/deassert to omap devices

 arch/arm/mach-omap2/omap_hwmod.c              |   70 +++++++++++++++++++-----
 arch/arm/plat-omap/include/plat/omap_device.h |    4 ++
 arch/arm/plat-omap/omap_device.c              |   45 ++++++++++++++++
 3 files changed, 104 insertions(+), 15 deletions(-)

-- 
1.7.4.1

