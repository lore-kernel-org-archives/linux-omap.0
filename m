From: Kees Cook <keescook@chromium.org>
Subject: [PATCH v2 16/31] usb/phy-isp1301-omap: Remove .data assignment
Date: Wed, 20 Sep 2017 16:27:40 -0700
Message-ID: <1505950075-50223-17-git-send-email-keescook@chromium.org>
References: <1505950075-50223-1-git-send-email-keescook@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1505950075-50223-1-git-send-email-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Kees Cook <keescook@chromium.org>, Felipe Balbi <balbi@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

The .data assignment appears to be redundant to the WORK_STOP bit for
stopping the timer. Also, it appears this timer is entirely unused
as it is only ever started under #define VERBOSE, which is explicitly
undefined.

Cc: Felipe Balbi <balbi@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org
Cc: linux-omap@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/usb/phy/phy-isp1301-omap.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/usb/phy/phy-isp1301-omap.c b/drivers/usb/phy/phy-isp1301-omap.c
index 5630840b77b1..8a07ce63b92d 100644
--- a/drivers/usb/phy/phy-isp1301-omap.c
+++ b/drivers/usb/phy/phy-isp1301-omap.c
@@ -1222,7 +1222,6 @@ static int isp1301_remove(struct i2c_client *i2c)
 	if (machine_is_omap_h2())
 		gpio_free(2);
 
-	isp->timer.data = 0;
 	set_bit(WORK_STOP, &isp->todo);
 	del_timer_sync(&isp->timer);
 	flush_work(&isp->work);
-- 
2.7.4
