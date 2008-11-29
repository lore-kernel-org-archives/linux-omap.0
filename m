From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 02/11] ARM: OMAP: Extend gpio label column width in omap_gpio
	debugfs file
Date: Fri, 28 Nov 2008 17:09:57 -0800
Message-ID: <20081129010957.12337.87853.stgit@localhost>
References: <20081129010728.12337.8217.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:57689 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753248AbYK2BJ4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 28 Nov 2008 20:09:56 -0500
In-Reply-To: <20081129010728.12337.8217.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: David Brownell <dbrownell@users.sourceforge.net>, linux-omap@vger.kernel.org, Jarkko Nikula <jarkko.nikula@nokia.com>

From: Jarkko Nikula <jarkko.nikula@nokia.com>

There are already various drivers having bigger label than 10 bytes. Most
of them fit well under 20 bytes but make column width exact so that
oversized labels don't mess up output alignment.

Signed-off-by: Jarkko Nikula <jarkko.nikula@nokia.com>
Acked-by: David Brownell <dbrownell@users.sourceforge.net>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/plat-omap/gpio.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
index 66e3647..8ff225b 100644
--- a/arch/arm/plat-omap/gpio.c
+++ b/arch/arm/plat-omap/gpio.c
@@ -1812,7 +1812,7 @@ static int dbg_gpio_show(struct seq_file *s, void *unused)
 				seq_printf(s, "MPUIO %2d ", j);
 			else
 				seq_printf(s, "GPIO %3d ", gpio);
-			seq_printf(s, "(%10s): %s %s",
+			seq_printf(s, "(%-20.20s): %s %s",
 					label,
 					is_in ? "in " : "out",
 					value ? "hi"  : "lo");

