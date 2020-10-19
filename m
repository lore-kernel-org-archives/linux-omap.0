Return-Path: <SRS0=yR1H=D2=vger.kernel.org=linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E9BFC43467
	for <linux-omap@archiver.kernel.org>; Mon, 19 Oct 2020 10:18:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F361722276
	for <linux-omap@archiver.kernel.org>; Mon, 19 Oct 2020 10:18:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DkOW+oqB";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ukkqVAZW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729387AbgJSKSU (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Mon, 19 Oct 2020 06:18:20 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:58756 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729210AbgJSKSM (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Mon, 19 Oct 2020 06:18:12 -0400
Message-Id: <20201019101110.332963099@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1603102690;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=dX7drupC9tJwDgrKaubl+xgZ5vF2h10siTohooz8pfU=;
        b=DkOW+oqBGph9qdl3NB+IO3bAWHEx0hDVdZQr7mdAH/mI8bWN259m/6mQ+GdfrIwwHclbSm
        d4KDXOrXHoqzK36EBNJ620ykBl3KV0WL3IYL2XtUe0eVwa58eo9p1PYEzmLWFoLGaxxlyi
        5qDhBfX61/ubYHJJc+OIiO1q359jU7WuydYss9lTtIje80m8Xzc27wgBJlECQzEWSlQB/x
        681X/NFAIpPdOUlS2uCFaNS2wL047IFr0XvrdSw5fQ6Y5ndxwteudXWqUBTCIZK/iRV9FF
        9rsf0daTNDGGlgohcR5n5q7HPsbYaAKpcNqeQtmtHWlozh00S61QowhMaIVHUA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1603102690;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=dX7drupC9tJwDgrKaubl+xgZ5vF2h10siTohooz8pfU=;
        b=ukkqVAZWUZRoaElft2syvVEMEOeTfiR51UY6hvVpXDzFz+j/0DfC10Z9+EKbw3LvamC3O+
        MXG1zMeHMKUgN2Dw==
Date:   Mon, 19 Oct 2020 12:06:36 +0200
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
Subject: [patch V2 07/13] usbip: Remove in_interrupt() check
References: <20201019100629.419020859@linutronix.de>
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
Acked-by: Shuah Khan <skhan@linuxfoundation.org>
Cc: Valentina Manea <valentina.manea.m@gmail.com>
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

