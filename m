From: Tony Lindgren <tony@atomide.com>
Subject: Re: [i2c] [PATCH 7/8] i2c-omap: Don't compile in OMAP15xx I2C ISR
	for non-OMAP15xx builds
Date: Fri, 17 Oct 2008 08:40:30 -0700
Message-ID: <20081017154029.GM15820@atomide.com>
References: <1222329234-31473-1-git-send-email-tony@atomide.com> <1222329234-31473-8-git-send-email-tony@atomide.com> <20080929222942.GT2716@fluff.org.uk> <200809291606.37236.david-b@pacbell.net> <alpine.DEB.2.00.0809292335310.27332@utopia.booyaka.com> <alpine.DEB.2.00.0809292336130.27332@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="FLPM4o+7JoHGki3m"
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:63111 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754847AbYJQPkw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 Oct 2008 11:40:52 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.0809292336130.27332@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@booyaka.com>
Cc: David Brownell <david-b@pacbell.net>, Ben Dooks <ben-linux@fluff.org>, i2c@lm-sensors.org, linux-omap@vger.kernel.org


--FLPM4o+7JoHGki3m
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

* Paul Walmsley <paul@booyaka.com> [080929 22:36]:
> On Mon, 29 Sep 2008, Paul Walmsley wrote:
> 
> > Hello Ben, David,
> > 
> > On Mon, 29 Sep 2008, David Brownell wrote:
> > 
> > > On Monday 29 September 2008, Ben Dooks wrote:
> > > > > -static void __exit omap_i2c_exit_driver(void)
> > > > > +static void __devexit omap_i2c_exit_driver(void)
> > > > 
> > > > a differerent change to the one advertised.
> > > > 
> > > > >  {
> > > > >       platform_driver_unregister(&omap_i2c_driver);
> > > > >  }
> > > 
> > > And incorrect too.
> > 
> > Indeed, will split and resubmit.
> 
> (and change to __init/__exit)

Here's this one with the __init/__exit changes removed.

Tony


--FLPM4o+7JoHGki3m
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: inline; filename="0007-i2c-omap-Don-t-compile-in-OMAP15xx-I2C-ISR-for-non.patch"

>From 6e8249e9d1aa28bda2c0123542582104635a0a83 Mon Sep 17 00:00:00 2001
From: Paul Walmsley <paul@pwsan.com>
Date: Fri, 17 Oct 2008 07:46:56 -0700
Subject: [PATCH] i2c-omap: Don't compile in OMAP15xx I2C ISR for non-OMAP15xx builds

Skip compiling OMAP15xx I2C ISR for non-OMAP15xx builds.  Saves 400 bytes
of text for most OMAP builds.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/i2c/busses/i2c-omap.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 018d284..5560064 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -506,6 +506,9 @@ omap_i2c_ack_stat(struct omap_i2c_dev *dev, u16 stat)
 	omap_i2c_write_reg(dev, OMAP_I2C_STAT_REG, stat);
 }
 
+/* rev1 devices are apparently only on some 15xx */
+#ifdef CONFIG_ARCH_OMAP15XX
+
 static irqreturn_t
 omap_i2c_rev1_isr(int this_irq, void *dev_id)
 {
@@ -560,6 +563,9 @@ omap_i2c_rev1_isr(int this_irq, void *dev_id)
 
 	return IRQ_HANDLED;
 }
+#else
+#define omap_i2c_rev1_isr		0
+#endif
 
 static irqreturn_t
 omap_i2c_isr(int this_irq, void *dev_id)
-- 
1.5.6.rc3.21.g8c6b5


--FLPM4o+7JoHGki3m--
