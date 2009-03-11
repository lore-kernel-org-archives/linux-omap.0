From: Nishanth Menon <menon.nishanth@gmail.com>
Subject: [PATCH] OMAP:clock: missing list_del for clk_notifier_unregister
Date: Wed, 11 Mar 2009 19:59:40 +0200
Message-ID: <49B7FC0C.9080408@gmail.com>
References: <7A436F7769CA33409C6B44B358BFFF0CFF48FEA4@dlee02.ent.ti.com> <13B9B4C6EF24D648824FF11BE8967162037B763A5A@dlee02.ent.ti.com> <7A436F7769CA33409C6B44B358BFFF0CFF490055@dlee02.ent.ti.com> <13B9B4C6EF24D648824FF11BE8967162037B763B7D@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f177.google.com ([209.85.219.177]:34580 "EHLO
	mail-ew0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752685AbZCKR7q (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Mar 2009 13:59:46 -0400
Received: by ewy25 with SMTP id 25so100438ewy.37
        for <linux-omap@vger.kernel.org>; Wed, 11 Mar 2009 10:59:42 -0700 (PDT)
In-Reply-To: <13B9B4C6EF24D648824FF11BE8967162037B763B7D@dlee02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Woodruff, Richard" <r-woodruff2@ti.com>, ameya.palande@nokia.com
Cc: "Menon, Nishanth" <nm@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, ext Paul Walmsley <paul@pwsan.com>, "Nayak, Rajendra" <rnayak@ti.com>, "Gupta, Ramesh" <grgupta@ti.com>

>From b30537e692ac7e72858479327935b16813ea3f56 Mon Sep 17 00:00:00 2001
From: Nishanth Menon <nm@ti.com>
Date: Wed, 11 Mar 2009 11:29:11 -0500
Subject: [PATCH] OMAP:clock: missing list_del for clk_notifier_unregister

Apologies on the spam.. looks like my git-send-email needs a bit more
tweaking :(.. sending from gmail..

clk_notifier_unregister should clean the list before
freeing clock notifier, else clk_notifier_list is
filled with dangling pointers

Issue seen while repetative loading/unloading of bridgedriver

Ref: http://marc.info/?t=123678326300002&r=1&w=2

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/plat-omap/clock.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/clock.c b/arch/arm/plat-omap/clock.c
index c8d9e96..523d1b0 100644
--- a/arch/arm/plat-omap/clock.c
+++ b/arch/arm/plat-omap/clock.c
@@ -725,8 +725,11 @@ int clk_notifier_unregister(struct clk *clk, struct
notifier_block *nb)
          * XXX ugh, layering violation.  there should be some
          * support in the notifier code for this.
          */
-        if (!cn->notifier_head.head)
+        if (!cn->notifier_head.head) {
+            /* Free up my clock node too */
+            list_del(&cn->node);
             kfree(cn);
+        }
 
     } else {
         r = -ENOENT;
-- 
1.5.4.3


