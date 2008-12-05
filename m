From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 1/6] ARM: OMAP2: Prepare cpu detection for further improvements
Date: Thu, 04 Dec 2008 18:39:14 -0800
Message-ID: <20081205023914.3868.89924.stgit@localhost>
References: <20081205023737.3868.78857.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:50629 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755582AbYLECjQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Dec 2008 21:39:16 -0500
In-Reply-To: <20081205023737.3868.78857.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org

Rename omap2_check_revision to omap24xx_check_revision.
Then next patch will split if further and add omap34xx_check_revision.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/id.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
index bf45ff3..b6ee18c 100644
--- a/arch/arm/mach-omap2/id.c
+++ b/arch/arm/mach-omap2/id.c
@@ -191,7 +191,7 @@ static void __init _set_omap_chip(void)
 
 }
 
-void __init omap2_check_revision(void)
+void __init omap24xx_check_revision(void)
 {
 	int i, j;
 	u32 idcode;
@@ -266,6 +266,11 @@ void __init omap2_check_revision(void)
 
 }
 
+void __init omap2_check_revision(void)
+{
+	omap24xx_check_revision();
+}
+
 void __init omap2_set_globals_tap(struct omap_globals *omap2_globals)
 {
 	class = omap2_globals->class;

