From: "stanley.miao" <stanley.miao@windriver.com>
Subject: Re: OOPS in OMAP 1-wire driver
Date: Thu, 20 Nov 2008 11:27:24 +0800
Message-ID: <1227151644.14497.48.camel@localhost>
References: <a46a26fd0811191640w70ef4e2cy5551e26a433c0532@mail.gmail.com>
Reply-To: stanley.miao@windriver.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:37228 "EHLO mail.wrs.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751205AbYKTDVQ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 19 Nov 2008 22:21:16 -0500
In-Reply-To: <a46a26fd0811191640w70ef4e2cy5551e26a433c0532@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Juha Kuikka <juha.kuikka@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

It has been fixed and the patch was added to -mm tree.

Stanley.


From: "Stanley.Miao" <stanley.miao@windriver.com>

OMAP LDP boot crash.  This is because w1 subsystem changed the search
interface, so update omap_hdq's search interface to follow the change.

Signed-off-by: Stanley.Miao <stanley.miao@windriver.com>
Signed-off-by: Evgeniy Polyakov <zbr@ioremap.net>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/w1/masters/omap_hdq.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff -puN drivers/w1/masters/omap_hdq.c~w1-omap-fix-omap-ldp-boot-crash
drivers/w1/masters/omap_hdq.c
--- a/drivers/w1/masters/omap_hdq.c~w1-omap-fix-omap-ldp-boot-crash
+++ a/drivers/w1/masters/omap_hdq.c
@@ -86,8 +86,8 @@ static struct platform_driver omap_hdq_d
 static u8 omap_w1_read_byte(void *_hdq);
 static void omap_w1_write_byte(void *_hdq, u8 byte);
 static u8 omap_w1_reset_bus(void *_hdq);
-static void omap_w1_search_bus(void *_hdq, u8 search_type,
-       w1_slave_found_callback slave_found);
+static void omap_w1_search_bus(void *_hdq, struct w1_master
*master_dev,
+               u8 search_type, w1_slave_found_callback slave_found);
 
 
 static struct w1_bus_master omap_w1_master = {
@@ -231,8 +231,8 @@ static u8 omap_w1_reset_bus(void *_hdq)
 }
 
 /* W1 search callback function */
-static void omap_w1_search_bus(void *_hdq, u8 search_type,
-       w1_slave_found_callback slave_found)
+static void omap_w1_search_bus(void *_hdq, struct w1_master
*master_dev,
+               u8 search_type, w1_slave_found_callback slave_found)
 {
        u64 module_id, rn_le, cs, id;
 
@@ -249,7 +249,7 @@ static void omap_w1_search_bus(void *_hd
        cs = w1_calc_crc8((u8 *)&rn_le, 7);
        id = (cs << 56) | module_id;
 
-       slave_found(_hdq, id);
+       slave_found(master_dev, id);
 }
 
 static int _omap_hdq_reset(struct hdq_data *hdq_data)
_
