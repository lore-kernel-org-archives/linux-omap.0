From: Tony Lindgren <tony@atomide.com>
Subject: Re: [i2c] [PATCH 1/8] i2c-omap: Do not use interruptible wait call
	in omap_i2c_xfer_msg
Date: Fri, 17 Oct 2008 08:35:58 -0700
Message-ID: <20081017153557.GI15820@atomide.com>
References: <1222329234-31473-1-git-send-email-tony@atomide.com> <1222329234-31473-2-git-send-email-tony@atomide.com> <20080929222100.GN2716@fluff.org.uk> <20080930145100.62fdb0fa.jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="RhUH2Ysw6aD5utA4"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:57624 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755600AbYJQPgh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 Oct 2008 11:36:37 -0400
Content-Disposition: inline
In-Reply-To: <20080930145100.62fdb0fa.jarkko.nikula@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@nokia.com>
Cc: ext Ben Dooks <ben-linux@fluff.org>, i2c@lm-sensors.org, Juha Yrjola <juha.yrjola@solidboot.com>, linux-omap@vger.kernel.org


--RhUH2Ysw6aD5utA4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* Jarkko Nikula <jarkko.nikula@nokia.com> [080930 04:52]:
> On Mon, 29 Sep 2008 23:21:00 +0100
> "ext Ben Dooks" <ben-linux@fluff.org> wrote:
> 
> > On Thu, Sep 25, 2008 at 10:53:47AM +0300, Tony Lindgren wrote:
> > > From: Jarkko Nikula <jarkko.nikula@nokia.com>
> > > 
> > > If there is a signal pending and wait_for_completion_interruptible_timeout
> > > terminates with -ERESTARTSYS, we return and disable the i2c clocks in
> > > omap_i2c_xfer.
> > > 
> > > If we terminate before sending last i2c message with a stop condition, the
> > > bus remains busy and we are not able to send new messages into bus with
> > > successive omap_i2c_xfer calls. Therefore a pending signal is not caught
> > > here and we return only because of timeout or i2c error.
> > 
> > I assume that this is preferable to aborting an transfer when the
> > signal is caught (if possible) ?
> >  
> Most probably yes as long as the stop condition is generated
> successfully. IRCC bug behind this fix, OMAP I2C went into bus
> arbitration without code able to recover easily or something like that.
> 
> Would it be ok to let this fix as now, probably adding FIXME line near
> wait_for_completion_timeout so that we don't break anything now but
> note that this is not optimal fix?

Here's this one updated with a comment.

Tony


--RhUH2Ysw6aD5utA4
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: inline; filename="0001-i2c-omap-Do-not-use-interruptible-wait-call-in-omap.patch"

>From d93aaaf440acb6705c2eac4fc7ee8c9a4f32580f Mon Sep 17 00:00:00 2001
From: Jarkko Nikula <jarkko.nikula@nokia.com>
Date: Fri, 17 Oct 2008 07:16:49 -0700
Subject: [PATCH] i2c-omap: Do not use interruptible wait call in omap_i2c_xfer_msg

If there is a signal pending and wait_for_completion_interruptible_timeout
terminates with -ERESTARTSYS, we return and disable the i2c clocks in
omap_i2c_xfer.

If we terminate before sending last i2c message with a stop condition, the
bus remains busy and we are not able to send new messages into bus with
successive omap_i2c_xfer calls. Therefore a pending signal is not caught
here and we return only because of timeout or i2c error.

Signed-off-by: Jarkko Nikula <jarkko.nikula@nokia.com>
Signed-off-by: Juha Yrjola <juha.yrjola@solidboot.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/i2c/busses/i2c-omap.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 608038d..17476ec 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -328,8 +328,12 @@ static int omap_i2c_xfer_msg(struct i2c_adapter *adap,
 		w |= OMAP_I2C_CON_STP;
 	omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, w);
 
-	r = wait_for_completion_interruptible_timeout(&dev->cmd_complete,
-						      OMAP_I2C_TIMEOUT);
+	/*
+	 * REVISIT: We should abort the transfer on signals, but the bus goes
+	 * into arbitration and we're currently unable to recover from it.
+	 */
+	r = wait_for_completion_timeout(&dev->cmd_complete,
+					OMAP_I2C_TIMEOUT);
 	dev->buf_len = 0;
 	if (r < 0)
 		return r;
-- 
1.5.6.rc3.21.g8c6b5


--RhUH2Ysw6aD5utA4--
