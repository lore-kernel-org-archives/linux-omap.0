Return-Path: <SRS0=5dD+=DV=vger.kernel.org=linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27DE2C43467
	for <linux-omap@archiver.kernel.org>; Wed, 14 Oct 2020 15:18:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CEFEA22227
	for <linux-omap@archiver.kernel.org>; Wed, 14 Oct 2020 15:18:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KuTToN1V";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="I4dgr4cb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731736AbgJNPSv (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Wed, 14 Oct 2020 11:18:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726596AbgJNPSu (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Wed, 14 Oct 2020 11:18:50 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0D51C061755;
        Wed, 14 Oct 2020 08:18:49 -0700 (PDT)
Message-Id: <20201014145727.102895678@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602688728;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=ZKsj80ymynJu9n+vKl8hANyFjBXKxoMgZSnkilPgmtg=;
        b=KuTToN1VvpQUXs32to1oL9yEvRSqsKVK4qRmQncPwyQyH0cbRLTdvwNI/EF2PhSEga3R/i
        BloWNR888cauapc4ikFbY1Jr9MbnXS3QiFaL1787kNrimjSmO8S/DnSnqX6L01RMyzM4m7
        hDt98E3Txy63I+KlpdyJ6n5MLwrPVMmAms55aaGQtaRo+ink3bBgGncDVc6gxnXgTYw5p+
        1Opw4/09QqaBRnHEVPqRrOAfLa2ODYvpoxR2CXUgpLcQvFfzsCUvfN4EYU5Hm3yxdDFVOw
        WwTc3m64UdJkmMuoOdAURJA1sCZmMn/ZQP7A8z4dgeWo+1+4/w27emBoJbHesA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602688728;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=ZKsj80ymynJu9n+vKl8hANyFjBXKxoMgZSnkilPgmtg=;
        b=I4dgr4cb6Tpgy6SE79KKi5KhiM4OWAwi+eCcNRnqXnqoFBbtoj200noBAovosqw68dctAH
        3D4yxMwgfYoclyAw==
Date:   Wed, 14 Oct 2020 16:52:16 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Winischhofer <thomas@winischhofer.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, stable@vger.kernel.org,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Johan Hovold <johan@kernel.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Valentina Manea <valentina.manea.m@gmail.com>,
        Shuah Khan <shuah@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        linux-omap@vger.kernel.org, Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, Felipe Balbi <balbi@kernel.org>,
        Duncan Sands <duncan.sands@free.fr>
Subject: [patch 01/12] USB: sisusbvga: Make console support depend on BROKEN
References: <20201014145215.518912759@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

The console part of sisusbvga is broken vs. printk(). It uses in_atomic()
to detect contexts in which it cannot sleep despite the big fat comment in
preempt.h which says: Do not use in_atomic() in driver code.

in_atomic() does not work on kernels with CONFIG_PREEMPT_COUNT=n which
means that spin/rw_lock held regions are not detected by it.

There is no way to make this work by handing context information through to
the driver and this only can be solved once the core printk infrastructure
supports sleepable console drivers.

Make it depend on BROKEN for now.

Fixes: 1bbb4f2035d9 ("[PATCH] USB: sisusb[vga] update")
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Thomas Winischhofer <thomas@winischhofer.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org
Cc: stable@vger.kernel.org
---
 drivers/usb/misc/sisusbvga/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/usb/misc/sisusbvga/Kconfig
+++ b/drivers/usb/misc/sisusbvga/Kconfig
@@ -16,7 +16,7 @@ config USB_SISUSBVGA
 
 config USB_SISUSBVGA_CON
 	bool "Text console and mode switching support" if USB_SISUSBVGA
-	depends on VT
+	depends on VT && BROKEN
 	select FONT_8x16
 	help
 	  Say Y here if you want a VGA text console via the USB dongle or

