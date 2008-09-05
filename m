From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH v3 2/2] OMAP2xxx EAC: fix sparse warnings
Date: Fri, 05 Sep 2008 01:37:39 -0600
Message-ID: <20080905073733.7741.67561.stgit@localhost.localdomain>
References: <20080905073522.7741.76584.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:56929 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755179AbYIEISb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Sep 2008 04:18:31 -0400
In-Reply-To: <20080905073522.7741.76584.stgit@localhost.localdomain>
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
index 47a95e2..667051e 100644
--- a/sound/arm/omap/eac.c
+++ b/sound/arm/omap/eac.c
@@ -787,12 +787,12 @@ static struct platform_driver eac_driver = {
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


