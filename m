From: jean.pihet@newoldbits.com
Subject: [PATCH 0/7 v5] OMAP3: clean up ASM sleep code
Date: Fri, 17 Dec 2010 11:08:19 +0100
Message-ID: <1292580506-4421-1-git-send-email-j-pihet@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:35981 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753037Ab0LQKIn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 Dec 2010 05:08:43 -0500
Received: by wwa36 with SMTP id 36so482702wwa.1
        for <linux-omap@vger.kernel.org>; Fri, 17 Dec 2010 02:08:42 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@deeprootsystems.com, linux-arm-kernel@lists.infradead.org, Jean Pihet <j-pihet@ti.com>

From: Jean Pihet <j-pihet@ti.com>

This patch only contains clean-ups and cosmetic changes,
no functional change.

Clean-up of the ASM sleep code, for better readability and
easier maintenance.

Applies on top of Nishant's latest idle path errata fixes step 2,
cf. http://marc.info/?l=linux-omap&m=129139584919242&w=2

Jean Pihet (7):
  OMAP2+: use global values for the SRAM PA addresses
  OMAP3: remove hardcoded values from the ASM sleep code
  OMAP3: re-organize the ASM sleep code
  OMAP3: rework of the ASM sleep code execution paths
  OMAP3: add comments for low power code errata
  OMAP3: ASM sleep code format rework
  OMAP3: remove unused code from the ASM sleep code

 arch/arm/mach-omap2/control.c          |    9 +-
 arch/arm/mach-omap2/control.h          |    2 +
 arch/arm/mach-omap2/pm.h               |    1 -
 arch/arm/mach-omap2/pm34xx.c           |    4 +-
 arch/arm/mach-omap2/sdrc.h             |    1 -
 arch/arm/mach-omap2/sleep34xx.S        |  724 +++++++++++++++++---------------
 arch/arm/plat-omap/include/plat/sram.h |   11 +
 arch/arm/plat-omap/sram.c              |    7 +-
 8 files changed, 413 insertions(+), 346 deletions(-)

