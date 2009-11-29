From: Mike Rapoport <mike@compulab.co.il>
Subject: [PATCH] omap3: cm-t35: add mux initialization
Date: Sun, 29 Nov 2009 10:07:09 +0200
Message-ID: <cover.1259481545.git.mike@compulab.co.il>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from compulab.co.il ([67.18.134.219]:58288 "EHLO compulab.co.il"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751017AbZK2ILU (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 29 Nov 2009 03:11:20 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, Mike Rapoport <mike@compulab.co.il>

Tony,

These patches are follow-ups to your mux rework series.
The first one is pretty trivial and adds OUTPUT_PULL{UP,DOWN} to shorten
the lines in omap_board_mux arrays. 
The second patch adds the mux configuration for CM-T35. This is actually
the most compact subset of 'cat /sys/kernel/debug/omap_mux/board' that makes
CM-T35 functional :)

The following changes since commit d8bfa71e2e9d794f9c7e5b019f316804f7f50582:
  Tony Lindgren (1):
          omap: mux: Add data for 2430

Mike Rapoport (2):
  omap3: mux: add shorthands for OUTPUT_PULL{UP,DOWN}
  omap3: cm-t35: add mux initialization

 arch/arm/mach-omap2/Kconfig        |    1 +
 arch/arm/mach-omap2/board-cm-t35.c |   95 +++++++++++++++++++++++++++++++++--
 arch/arm/mach-omap2/mux.h          |    2 +
 3 files changed, 92 insertions(+), 6 deletions(-)

