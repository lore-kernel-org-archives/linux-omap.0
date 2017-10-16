From: Kees Cook <keescook@chromium.org>
Subject: [PATCH] usb: isp1301-omap: Convert timers to use timer_setup()
Date: Mon, 16 Oct 2017 16:29:23 -0700
Message-ID: <20171016232923.GA101254@beast>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Felipe Balbi <balbi@kernel.org>, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

In preparation for unconditionally passing the struct timer_list pointer to
all timer callbacks, switch to using the new timer_setup() and from_timer()
to pass the timer pointer explicitly.

Cc: Felipe Balbi <balbi@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org
Cc: linux-omap@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
Acked-by: Tony Lindgren <tony@atomide.com>
---
 drivers/usb/phy/phy-isp1301-omap.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/phy/phy-isp1301-omap.c b/drivers/usb/phy/phy-isp1301-omap.c
index 8a07ce63b92d..00bcc6c6db17 100644
--- a/drivers/usb/phy/phy-isp1301-omap.c
+++ b/drivers/usb/phy/phy-isp1301-omap.c
@@ -1183,9 +1183,11 @@ static irqreturn_t isp1301_irq(int irq, void *isp)
 	return IRQ_HANDLED;
 }
 
-static void isp1301_timer(unsigned long _isp)
+static void isp1301_timer(struct timer_list *t)
 {
-	isp1301_defer_work((void *)_isp, WORK_TIMER);
+	struct isp1301 *isp = from_timer(isp, t, timer);
+
+	isp1301_defer_work(isp, WORK_TIMER);
 }
 
 /*-------------------------------------------------------------------------*/
@@ -1506,7 +1508,7 @@ isp1301_probe(struct i2c_client *i2c, const struct i2c_device_id *id)
 	}
 
 	INIT_WORK(&isp->work, isp1301_work);
-	setup_timer(&isp->timer, isp1301_timer, (unsigned long)isp);
+	timer_setup(&isp->timer, isp1301_timer, 0);
 
 	i2c_set_clientdata(i2c, isp);
 	isp->client = i2c;
-- 
2.7.4


-- 
Kees Cook
Pixel Security
