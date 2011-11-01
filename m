From: Vishal Mahaveer <vishalm@ti.com>
Subject: [PATCH 0/1] OMAP: TWL: set clk32kg regulator on
Date: Tue, 1 Nov 2011 09:40:51 -0600
Message-ID: <1320162052-32276-1-git-send-email-vishalm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:55320 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753020Ab1KAUhd (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 1 Nov 2011 16:37:33 -0400
Received: from dlep33.itg.ti.com ([157.170.170.112])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id pA1KbXJT016473
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 1 Nov 2011 15:37:33 -0500
Received: from dlep26.itg.ti.com (smtp-le.itg.ti.com [157.170.170.27])
	by dlep33.itg.ti.com (8.13.7/8.13.8) with ESMTP id pA1KbWV7003895
	for <linux-omap@vger.kernel.org>; Tue, 1 Nov 2011 15:37:32 -0500 (CDT)
Received: from DLEE74.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id pA1KbWHZ004312
	for <linux-omap@vger.kernel.org>; Tue, 1 Nov 2011 15:37:32 -0500 (CDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Vishal Mahaveer <vishalm@ti.com>

Set constraint always_on for clk32kg regulator.
This regulator is used by connectivity chip (wl12xx) on OMAP platforms.

Vishal Mahaveer (1):
  OMAP: TWL: set clk32kg regulator on

 arch/arm/mach-omap2/twl-common.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

