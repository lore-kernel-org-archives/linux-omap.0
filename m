From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 3/8] ARM: OMAP2: Fix tusb6010 init error and compilation
	warning
Date: Thu, 14 May 2009 10:45:54 -0700
Message-ID: <20090514174554.12080.63896.stgit@localhost>
References: <20090514174100.12080.9736.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:53766 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755388AbZENRqH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 14 May 2009 13:46:07 -0400
In-Reply-To: <20090514174100.12080.9736.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: Kalle Valo <kalle.valo@iki.fi>, Roel Kluin <roel.kluin@gmail.com>, linux-omap@vger.kernel.org, Jarkko Nikula <jarkko.nikula@nokia.com>

From: Jarkko Nikula <jarkko.nikula@nokia.com>

Fix "tusb6010 init error 5, -19" and compilation warning from function
tusb6010_platform_retime "warning: 'sysclk_ps' is used uninitialized in this
function".

I suppose commit c094ba34b8f780885d029ce3c2715a194b780e5d was meant to test
for zero fclk_ps instead of sysclk_ps.

Signed-off-by: Jarkko Nikula <jarkko.nikula@nokia.com>
Cc: Roel Kluin <roel.kluin@gmail.com>
Tested-by: Kalle Valo <kalle.valo@iki.fi>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/usb-tusb6010.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/usb-tusb6010.c b/arch/arm/mach-omap2/usb-tusb6010.c
index 8df55f4..8622c24 100644
--- a/arch/arm/mach-omap2/usb-tusb6010.c
+++ b/arch/arm/mach-omap2/usb-tusb6010.c
@@ -187,7 +187,7 @@ int tusb6010_platform_retime(unsigned is_refclk)
 	unsigned	sysclk_ps;
 	int		status;
 
-	if (!refclk_psec || sysclk_ps == 0)
+	if (!refclk_psec || fclk_ps == 0)
 		return -ENODEV;
 
 	sysclk_ps = is_refclk ? refclk_psec : TUSB6010_OSCCLK_60;

