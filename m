From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 04/12] ARM: OMAP3: mmc-twl4030 fix name buffer length
Date: Tue, 10 Mar 2009 14:06:08 -0700
Message-ID: <20090310210608.16425.95680.stgit@localhost>
References: <20090310205824.16425.97745.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:51914 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756178AbZCJVGK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Mar 2009 17:06:10 -0400
In-Reply-To: <20090310205824.16425.97745.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: David Brownell <dbrownell@users.sourceforge.net>, linux-omap@vger.kernel.org, Adrian Hunter <adrian.hunter@nokia.com>

From: Adrian Hunter <adrian.hunter@nokia.com>

Add 1 to buffer length for null terminator.

Signed-off-by: Adrian Hunter <adrian.hunter@nokia.com>
Acked-by: David Brownell <dbrownell@users.sourceforge.net>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/mmc-twl4030.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/mmc-twl4030.c b/arch/arm/mach-omap2/mmc-twl4030.c
index 437f520..909f57c 100644
--- a/arch/arm/mach-omap2/mmc-twl4030.c
+++ b/arch/arm/mach-omap2/mmc-twl4030.c
@@ -59,7 +59,7 @@ static struct twl_mmc_controller {
 	struct omap_mmc_platform_data	*mmc;
 	u8		twl_vmmc_dev_grp;
 	u8		twl_mmc_dedicated;
-	char		name[HSMMC_NAME_LEN];
+	char		name[HSMMC_NAME_LEN + 1];
 } hsmmc[] = {
 	{
 		.twl_vmmc_dev_grp		= VMMC1_DEV_GRP,

