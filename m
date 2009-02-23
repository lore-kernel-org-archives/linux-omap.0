From: Felipe Balbi <me@felipebalbi.com>
Subject: [rft/rfc/patch-v2.6.29-rc5+ 11/23] usb: host: ehci: add MODULE_AUTHOR
Date: Mon, 23 Feb 2009 20:55:23 +0200
Message-ID: <1235415335-17408-12-git-send-email-me@felipebalbi.com>
References: <1235415335-17408-1-git-send-email-me@felipebalbi.com>
 <1235415335-17408-2-git-send-email-me@felipebalbi.com>
 <1235415335-17408-3-git-send-email-me@felipebalbi.com>
 <1235415335-17408-4-git-send-email-me@felipebalbi.com>
 <1235415335-17408-5-git-send-email-me@felipebalbi.com>
 <1235415335-17408-6-git-send-email-me@felipebalbi.com>
 <1235415335-17408-7-git-send-email-me@felipebalbi.com>
 <1235415335-17408-8-git-send-email-me@felipebalbi.com>
 <1235415335-17408-9-git-send-email-me@felipebalbi.com>
 <1235415335-17408-10-git-send-email-me@felipebalbi.com>
 <1235415335-17408-11-git-send-email-me@felipebalbi.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:43109 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755049AbZBWTAC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 23 Feb 2009 14:00:02 -0500
In-Reply-To: <1235415335-17408-11-git-send-email-me@felipebalbi.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Steve Sakoman <steve@sakoman.com>, Anand Gadiyar <gadiyar@ti.com>, Felipe Balbi <me@felipebalbi.com>

add missing MODULE_AUTHOR(). No functional changes.

Signed-off-by: Felipe Balbi <me@felipebalbi.com>
---
 drivers/usb/host/ehci-omap.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/host/ehci-omap.c b/drivers/usb/host/ehci-omap.c
index b7f02f6..2fbf377 100644
--- a/drivers/usb/host/ehci-omap.c
+++ b/drivers/usb/host/ehci-omap.c
@@ -562,4 +562,5 @@ static const struct hc_driver ehci_omap_hc_driver = {
 };
 
 MODULE_ALIAS("platform:omap-ehci");
+MODULE_AUTHOR("Texas Instruments, Inc.");
 
-- 
1.6.1.3

