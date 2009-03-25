From: Frans Meulenbroeks <fransmeulenbroeks@gmail.com>
Subject: [PATCH] drivers/mmc/core/core.c: extend limit
Date: Wed, 25 Mar 2009 23:03:28 +0100 (CET)
Message-ID: <alpine.LNX.2.00.0903252248430.32070@linux-suse.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757421AbZCYWD5@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: drzeus-mmc@drzeus.cx
Cc: linux-kernel@vger.kernel.org, beagleboard@googlegroups.com, openembedded-devel@lists.openembedded.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi,

For some reason my 4GB Kingston SDHC class 6 cards stopped functioning 
properly with 2.6.28 on my beagleboard (arm based). The very same cards (I 
have two of them) worked properly with 2.6.27. What happened was that if I 
booted from the card I would get errors -110.
They are similar to the ones reported at lkml last sept in 
http://lkml.org/lkml/2008/9/23/390

Fortunately later on in this thread was a fix:
http://lkml.org/lkml/2008/10/20/124

This did not help me as the limit was already at 300000. However, I 
decided to raise the limit to 500000. Still no go so I also doubled the 
read limit from 100000 to 200000. After that the cards work without 
problem. Changing the write timing back to 300000 brought the problem back 
so apparently both timings need to be extended. Attached is the patch I 
used for this. As it is a timeout limit value, it should not harm anyone, 
and a longer timeout at least allows more cards to be used.

Signed-off-by: Frans Meulenbroeks <fransmeulenbroeks@gmail.com>
---

What somewhat troubles me is that this worked in .27, so it might be this 
patch does not address the root cause. Then again this is the best I can 
do. If someone has a better solution, I am more than happy to test it.

Frans.

Index: git/drivers/mmc/core/core.c
===================================================================
--- git.orig/drivers/mmc/core/core.c
+++ git/drivers/mmc/core/core.c
@@ -284,9 +284,9 @@ void mmc_set_data_timeout(struct mmc_dat
 			 * The limit is really 250 ms, but that is
 			 * insufficient for some crappy cards.
 			 */
-			limit_us = 300000;
+			limit_us = 500000;
 		else
-			limit_us = 100000;
+			limit_us = 200000;

 		/*
 		 * SDHC cards always use these fixed values.
