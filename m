Return-Path: <linux-omap-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D823CC77B7A
	for <linux-omap@archiver.kernel.org>; Thu,  1 Jun 2023 10:56:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231878AbjFAK4C (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Thu, 1 Jun 2023 06:56:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231463AbjFAK4B (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Thu, 1 Jun 2023 06:56:01 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C62D3F2;
        Thu,  1 Jun 2023 03:55:59 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E92D01063;
        Thu,  1 Jun 2023 03:56:44 -0700 (PDT)
Received: from e122027.cambridge.arm.com (e122027.cambridge.arm.com [10.1.26.32])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 196753F7D8;
        Thu,  1 Jun 2023 03:55:56 -0700 (PDT)
From:   Steven Price <steven.price@arm.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Tony Lindgren <tony@atomide.com>
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-omap@vger.kernel.org, Vignesh Raghavendra <vigneshr@ti.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Johan Hovold <johan@kernel.org>,
        John Ogness <john.ogness@linutronix.de>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Dhruva Gole <d-gole@ti.com>,
        Steven Price <steven.price@arm.com>
Subject: [PATCH] serial: core: Don't drop port_mutex in serial_core_remove_one_port
Date:   Thu,  1 Jun 2023 11:55:48 +0100
Message-Id: <20230601105548.29965-1-steven.price@arm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

Commit 84a9582fd203 ("serial: core: Start managing serial controllers to
enable runtime PM") required the caller to hold port_mutex rather than
taking it locally. However the mutex_unlock() call wasn't removed
causing the mutex to be dropped unexpectly. Remove the call to
mutex_unlock() (and fix up the early return) to restore correct
behaviour.

Fixes: 84a9582fd203 ("serial: core: Start managing serial controllers to enable runtime PM")
Signed-off-by: Steven Price <steven.price@arm.com>
---
 drivers/tty/serial/serial_core.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 29bd5ede0b25..efda90215ee9 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -3194,7 +3194,7 @@ static void serial_core_remove_one_port(struct uart_driver *drv,
 
 	if (!uart_port) {
 		mutex_unlock(&port->mutex);
-		goto out;
+		return;
 	}
 	mutex_unlock(&port->mutex);
 
@@ -3234,8 +3234,6 @@ static void serial_core_remove_one_port(struct uart_driver *drv,
 	wait_event(state->remove_wait, !atomic_read(&state->refcount));
 	state->uart_port = NULL;
 	mutex_unlock(&port->mutex);
-out:
-	mutex_unlock(&port_mutex);
 }
 
 /**
-- 
2.39.2

