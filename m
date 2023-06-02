Return-Path: <linux-omap-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DADDFC7EE2F
	for <linux-omap@archiver.kernel.org>; Fri,  2 Jun 2023 07:00:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233609AbjFBHAO (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Fri, 2 Jun 2023 03:00:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233391AbjFBHAN (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Fri, 2 Jun 2023 03:00:13 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5584813D;
        Fri,  2 Jun 2023 00:00:12 -0700 (PDT)
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id E491D8111;
        Fri,  2 Jun 2023 07:00:09 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@intel.com>,
        Dhruva Gole <d-gole@ti.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        John Ogness <john.ogness@linutronix.de>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-omap@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/1] serial: core: Fix error handling for serial_core_ctrl_device_add()
Date:   Fri,  2 Jun 2023 10:00:05 +0300
Message-ID: <20230602070007.59268-1-tony@atomide.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

Checking for NULL is incorrect as serial_base_ctrl_add() uses ERR_PTR().

Let's also pass any returned error along, there's no reason to translate
all errors to -ENODEV.

Fixes: 84a9582fd203 ("serial: core: Start managing serial controllers to enable runtime PM")
Signed-off-by: Tony Lindgren <tony@atomide.com>
---

Changes since v1:

- Stop translating all errors to -ENODEV

- There's no need to use IS_ERR_OR_NULL() as noted by Jiri

---
 drivers/tty/serial/serial_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -3342,8 +3342,8 @@ int serial_core_register_port(struct uart_driver *drv, struct uart_port *port)
 	ctrl_dev = serial_core_ctrl_find(drv, port->dev, port->ctrl_id);
 	if (!ctrl_dev) {
 		new_ctrl_dev = serial_core_ctrl_device_add(port);
-		if (!new_ctrl_dev) {
-			ret = -ENODEV;
+		if (IS_ERR(new_ctrl_dev)) {
+			ret = PTR_ERR(new_ctrl_dev);
 			goto err_unlock;
 		}
 		ctrl_dev = new_ctrl_dev;
-- 
2.41.0
