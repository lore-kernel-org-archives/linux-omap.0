Return-Path: <linux-omap-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 818C7C77B7F
	for <linux-omap@archiver.kernel.org>; Mon,  8 May 2023 08:20:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233613AbjEHIUg (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Mon, 8 May 2023 04:20:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232438AbjEHIUf (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Mon, 8 May 2023 04:20:35 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1FD471AEF2;
        Mon,  8 May 2023 01:20:30 -0700 (PDT)
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id BB2998121;
        Mon,  8 May 2023 08:20:27 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Peter Hurley <peter@hurleysoftware.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Andy Shevchenko <andriy.shevchenko@intel.com>,
        Dhruva Gole <d-gole@ti.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Johan Hovold <johan@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-omap@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] serial: 8250: omap: Fix freeing of resources on failed register
Date:   Mon,  8 May 2023 11:20:11 +0300
Message-Id: <20230508082014.23083-2-tony@atomide.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508082014.23083-1-tony@atomide.com>
References: <20230508082014.23083-1-tony@atomide.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

If serial8250_register_8250_port() fails, the SoC can hang as the
deferred PMQoS work will still run as is not flushed and removed.

Fixes: 61929cf0169d ("tty: serial: Add 8250-core based omap driver")
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/tty/serial/8250/8250_omap.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -1532,7 +1532,9 @@ static int omap8250_probe(struct platform_device *pdev)
 err:
 	pm_runtime_dont_use_autosuspend(&pdev->dev);
 	pm_runtime_put_sync(&pdev->dev);
+	flush_work(&priv->qos_work);
 	pm_runtime_disable(&pdev->dev);
+	cpu_latency_qos_remove_request(&priv->pm_qos_request);
 	return ret;
 }
 
-- 
2.40.1
