From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 01/12] OMAP1: Fix compilation of arch/arm/mach-omap1/mailbox.c
Date: Mon, 22 Jun 2009 14:38:18 +0300
Message-ID: <20090622113818.28477.93354.stgit@localhost>
References: <20090622113422.28477.27052.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:54206 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753593AbZFVLiY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 22 Jun 2009 07:38:24 -0400
In-Reply-To: <20090622113422.28477.27052.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Jonathan McDowell <noodles@earth.li>

From: Jonathan McDowell <noodles@earth.li>

This fixes the positioning of " in MODULE_AUTHOR, which is currently
causing a build failure on latest git with CONFIG_OMAP_MBOX_FWK=m; the
original breakage appears to date from the end of last year in
a5abbbe52b7e89a7633319c5417bd4331f7ac8ed

Signed-Off-By: Jonathan McDowell <noodles@earth.li>
Acked-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap1/mailbox.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap1/mailbox.c b/arch/arm/mach-omap1/mailbox.c
index 0af4d6c..6810b4a 100644
--- a/arch/arm/mach-omap1/mailbox.c
+++ b/arch/arm/mach-omap1/mailbox.c
@@ -203,5 +203,5 @@ module_exit(omap1_mbox_exit);
 
 MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("omap mailbox: omap1 architecture specific functions");
-MODULE_AUTHOR("Hiroshi DOYU" <Hiroshi.DOYU@nokia.com>);
+MODULE_AUTHOR("Hiroshi DOYU <Hiroshi.DOYU@nokia.com>");
 MODULE_ALIAS("platform:omap1-mailbox");

