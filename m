From: David Brownell <david-b@pacbell.net>
Subject: Re: [patch/rfc/rft 2.6.27-rc8-omap-git] twl4030-pwrirq simplification, cleanup
Date: Mon, 6 Oct 2008 08:51:02 -0700
Message-ID: <200810060851.03269.david-b@pacbell.net>
References: <200810060119.18848.david-b@pacbell.net> <20081006084609.GD7437@gandalf.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp128.sbc.mail.sp1.yahoo.com ([69.147.65.187]:35529 "HELO
	smtp128.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751449AbYJFPvF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Oct 2008 11:51:05 -0400
In-Reply-To: <20081006084609.GD7437@gandalf.research.nokia.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: felipe.balbi@nokia.com
Cc: linux-omap@vger.kernel.org

On Monday 06 October 2008, Felipe Balbi wrote:
> On Mon, Oct 06, 2008 at 01:19:18AM -0700, David Brownell wrote:
> > ...
> >
> > (This is similar to the GPIO patch I just sent, but simpler
> > except for the impact on the few drivers thinking oddly
> > about IRQs.  Those patches cover the key SIH modules, and
> > a similar one affects the PIH in twl4030-core.)
> 
> What are the dependencies for this patch ? It doesn't apply cleanly.

Applies against current GIT with a few minor offsets caused
by the patch working around the i2c-omap timeouts.  I've sent
that before; it's appended for reference.


---
 drivers/i2c/chips/twl4030-pwrirq.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

--- a/drivers/i2c/chips/twl4030-pwrirq.c
+++ b/drivers/i2c/chips/twl4030-pwrirq.c
@@ -161,6 +161,8 @@ static int twl4030_pwrirq_thread(void *d
 	return 0;
 }
 
+#include <linux/delay.h>
+
 static int __init twl4030_pwrirq_init(void)
 {
 	int i, err;
@@ -168,8 +170,16 @@ static int __init twl4030_pwrirq_init(vo
 	twl4030_pwrirq_mask = 0xff;
 	twl4030_pwrirq_pending_unmask = 0;
 
+/* HEY:  core already did this.
+ * But that's surely not why we
+ * sometimes see i2c timeouts here ...
+ */
+for (i = 0; i < 5; i++) {
 	err = twl4030_i2c_write_u8(TWL4030_MODULE_INT, twl4030_pwrirq_mask,
 					TWL4030_INT_PWR_IMR1);
+if (!err) break;
+msleep(10);
+}
 	if (err)
 		return err;
 
