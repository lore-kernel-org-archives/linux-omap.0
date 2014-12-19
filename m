From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 0/2] ARM: OMAP DSS hwmod reset fix
Date: Fri, 19 Dec 2014 12:45:12 +0200
Message-ID: <1418985914-9027-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:42766 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751877AbaLSKpw (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 19 Dec 2014 05:45:52 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

Hi,

Here are similar patches for AM43xx and DRA7xxx than was done earlier for
OMAP4/5 in

543b2847d4bdb07eb1b50003095bc65cf2a1e2c0
 ("ARM: OMAP4: hwmod: set DSS submodule parent hwmods")

and

9ed69650897e8738c959fe8242ec41499f3f3f35
("ARM: OMAP5: hwmod: set DSS submodule parent hwmods")

I don't think missing the reset causes any problems, but the boot time warnings
are annoying.

 Tomi

Tomi Valkeinen (2):
  ARM: AM43xx: hwmod: set DSS submodule parent hwmods
  ARM: DRA7xx: hwmod: set DSS submodule parent hwmods

 arch/arm/mach-omap2/omap_hwmod_43xx_data.c | 2 ++
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c  | 2 ++
 2 files changed, 4 insertions(+)

-- 
2.2.0

