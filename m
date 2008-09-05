From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 2/2] OMAP2xxx EAC: fix sparse warnings
Date: Thu, 04 Sep 2008 23:24:26 -0600
Message-ID: <20080905052422.28183.88136.stgit@localhost.localdomain>
References: <20080905052312.28183.55601.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:38202 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750910AbYIEF1A (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Sep 2008 01:27:00 -0400
In-Reply-To: <20080905052312.28183.55601.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Paul Walmsley <paul@pwsan.com>

This patch resolves the following two sparse warnings:

sound/arm/omap/eac.c:788:12: warning: symbol 'eac_init' was not declared. Should it be static?
sound/arm/omap/eac.c:793:13: warning: symbol 'eac_exit' was not declared. Should it be static?

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 sound/arm/omap/eac.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/arm/omap/eac.c b/sound/arm/omap/eac.c
index c97c293..9981340 100644
--- a/sound/arm/omap/eac.c
+++ b/sound/arm/omap/eac.c
@@ -785,12 +785,12 @@ static struct platform_driver eac_driver = {
 	.remove		= eac_remove,
 };
 
-int __init eac_init(void)
+static int __init eac_init(void)
 {
 	return platform_driver_register(&eac_driver);
 }
 
-void __exit eac_exit(void)
+static void __exit eac_exit(void)
 {
 	platform_driver_unregister(&eac_driver);
 }


