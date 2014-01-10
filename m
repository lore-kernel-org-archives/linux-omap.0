From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 0/2] ARM: DRA7XX/AM43XX build fixes
Date: Fri, 10 Jan 2014 11:57:28 +0200
Message-ID: <1389347850-22435-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:55756 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751794AbaAJJ6I (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 10 Jan 2014 04:58:08 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tony@atomide.com, mturquette@linaro.org
Cc: linux-arm-kernel@lists.infradead.org

Hi,

The move of clock code from mach-omap2 to drivers/clk/ti introduces
a couple of new build errors with AM43XX/DRA7XX only builds. The
following patches address these issues by modifying the Kconfig + Makefile
under mach-omap2.

Also, it seems DRA7XX only build is not possible at the moment, added
patch #2 to fix this.

-Tero

