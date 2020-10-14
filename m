Return-Path: <SRS0=5dD+=DV=vger.kernel.org=linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AD2EC433DF
	for <linux-omap@archiver.kernel.org>; Wed, 14 Oct 2020 15:20:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7D1422201
	for <linux-omap@archiver.kernel.org>; Wed, 14 Oct 2020 15:20:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cebomU+7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jFRpPE0l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389185AbgJNPUJ (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Wed, 14 Oct 2020 11:20:09 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:59158 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731787AbgJNPS5 (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Wed, 14 Oct 2020 11:18:57 -0400
Message-Id: <20201014145727.828083323@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602688735;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=N32D1F03swzHfdGQ4x5b3zezLn/pWbqF1oQiqUx5Yvo=;
        b=cebomU+72lP/7bhe6Jo/6wDxF4V+B8qyPAxeAY1e4qHf3C5zUd86KxnQOqxg9754PzOkxa
        We2qXfrln4z5Jwqv6Y8thXyVNihI4+Ki3PDDPxEz2nVkYoqxAycIqSSXsK/JTqzx3MoHVv
        9mNLKYiVS7j7av9Q4POnGvrvO/yszXHwQi4xcs2Pn1e5qt+NkpKhxb9rUqDn5fLBBh7KzQ
        DGBibp3t0PnqcORy6fTg8ZQCqOGMlRvnTbvkRA18twwlMP+q3dv2QhK9go2OMr8ccmyKBB
        u8a406W37NKn0x6BqR9xazSMTF0gfilJAnfgGNL0aYUMLd2vhfhAkwQOE05B7w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602688735;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=N32D1F03swzHfdGQ4x5b3zezLn/pWbqF1oQiqUx5Yvo=;
        b=jFRpPE0lhJTYJiqmHYSFF9Ug9ydzyJpzzI3Z+EtVqru8wzTkQNxS7OBWTr7nbPdd0Z9H9N
        wmxJdAX+zfsty5Bg==
Date:   Wed, 14 Oct 2020 16:52:22 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Valentina Manea <valentina.manea.m@gmail.com>,
        Shuah Khan <shuah@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org,
        Thomas Winischhofer <thomas@winischhofer.net>,
        Johan Hovold <johan@kernel.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        linux-omap@vger.kernel.org, Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, Felipe Balbi <balbi@kernel.org>,
        Duncan Sands <duncan.sands@free.fr>
Subject: [patch 07/12] usbip: Remove in_interrupt() check
References: <20201014145215.518912759@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

From: Ahmed S. Darwish <a.darwish@linutronix.de>

The usage of in_interrupt() in drivers is phased out and Linus clearly
requested that code which changes behaviour depending on context should
either be separated or the context be conveyed in an argument passed by the
caller, which usually knows the context.

usbip_recv() uses in_interrupt() to conditionally print context information
for debugging messages. The value is zero as the function is only called
from various *_rx_loop() kthread functions. Remove it.

Signed-off-by: Ahmed S. Darwish <a.darwish@linutronix.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Valentina Manea <valentina.manea.m@gmail.com>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org

---
 drivers/usb/usbip/usbip_common.c |    5 -----
 1 file changed, 5 deletions(-)

--- a/drivers/usb/usbip/usbip_common.c
+++ b/drivers/usb/usbip/usbip_common.c
@@ -324,11 +324,6 @@ int usbip_recv(struct socket *sock, void
 	} while (msg_data_left(&msg));
 
 	if (usbip_dbg_flag_xmit) {
-		if (!in_interrupt())
-			pr_debug("%-10s:", current->comm);
-		else
-			pr_debug("interrupt  :");
-
 		pr_debug("receiving....\n");
 		usbip_dump_buffer(buf, size);
 		pr_debug("received, osize %d ret %d size %zd total %d\n",

