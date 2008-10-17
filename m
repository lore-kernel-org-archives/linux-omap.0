From: Tony Lindgren <tony@atomide.com>
Subject: Re: [i2c] [PATCH 5/8] i2c-omap: Add support on 34xx
Date: Fri, 17 Oct 2008 08:38:44 -0700
Message-ID: <20081017153844.GK15820@atomide.com>
References: <1222329234-31473-1-git-send-email-tony@atomide.com> <1222329234-31473-2-git-send-email-tony@atomide.com> <1222329234-31473-3-git-send-email-tony@atomide.com> <1222329234-31473-4-git-send-email-tony@atomide.com> <1222329234-31473-5-git-send-email-tony@atomide.com> <1222329234-31473-6-git-send-email-tony@atomide.com> <20080929222843.GS2716@fluff.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="DEueqSqTbz/jWVG1"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:61024 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754397AbYJQPjB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 Oct 2008 11:39:01 -0400
Content-Disposition: inline
In-Reply-To: <20080929222843.GS2716@fluff.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ben Dooks <ben-linux@fluff.org>
Cc: i2c@lm-sensors.org, linux-omap@vger.kernel.org, Chandra shekhar <x0044955@ti.com>


--DEueqSqTbz/jWVG1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* Ben Dooks <ben-linux@fluff.org> [080929 15:28]:
> On Thu, Sep 25, 2008 at 10:53:51AM +0300, Tony Lindgren wrote:
> > From: Chandra shekhar <x0044955@ti.com>
> 
> Not very informative description in here. At lease you could have
> copied the subject?

Here's this one updated.

Tony


>  
> > Signed-off-by: chandra shekhar <x0044955@ti.com>
> > Signed-off-by: Tony Lindgren <tony@atomide.com>
> > ---
> >  drivers/i2c/busses/i2c-omap.c |   12 +++++++-----
> >  1 files changed, 7 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> > index ded4636..b41431a 100644
> > --- a/drivers/i2c/busses/i2c-omap.c
> > +++ b/drivers/i2c/busses/i2c-omap.c
> > @@ -156,7 +156,7 @@ static inline u16 omap_i2c_read_reg(struct omap_i2c_dev *i2c_dev, int reg)
> >  
> >  static int omap_i2c_get_clocks(struct omap_i2c_dev *dev)
> >  {
> > -	if (cpu_is_omap16xx() || cpu_is_omap24xx()) {
> > +	if (cpu_is_omap16xx() || cpu_class_is_omap2()) {
> >  		dev->iclk = clk_get(dev->dev, "i2c_ick");
> >  		if (IS_ERR(dev->iclk)) {
> >  			dev->iclk = NULL;
> > @@ -279,7 +279,7 @@ static int omap_i2c_init(struct omap_i2c_dev *dev)
> >  			psc = fclk_rate / 12000000;
> >  	}
> >  
> > -	if (cpu_is_omap2430()) {
> > +	if (cpu_is_omap2430() || cpu_is_omap34xx()) {
> >  
> >  		/* HSI2C controller internal clk rate should be 19.2 Mhz */
> >  		internal_clk = 19200;
> > @@ -616,7 +616,8 @@ omap_i2c_isr(int this_irq, void *dev_id)
> >  					*dev->buf++ = w;
> >  					dev->buf_len--;
> >  					/* Data reg from 2430 is 8 bit wide */
> > -					if (!cpu_is_omap2430()) {
> > +					if (!cpu_is_omap2430() &&
> > +							!cpu_is_omap34xx()) {
> >  						if (dev->buf_len) {
> >  							*dev->buf++ = w >> 8;
> >  							dev->buf_len--;
> > @@ -654,7 +655,8 @@ omap_i2c_isr(int this_irq, void *dev_id)
> >  					w = *dev->buf++;
> >  					dev->buf_len--;
> >  					/* Data reg from  2430 is 8 bit wide */
> > -					if (!cpu_is_omap2430()) {
> > +					if (!cpu_is_omap2430() &&
> > +							!cpu_is_omap34xx()) {
> >  						if (dev->buf_len) {
> >  							w |= *dev->buf++ << 8;
> >  							dev->buf_len--;
> > @@ -748,7 +750,7 @@ omap_i2c_probe(struct platform_device *pdev)
> >  	if (cpu_is_omap15xx())
> >  		dev->rev1 = omap_i2c_read_reg(dev, OMAP_I2C_REV_REG) < 0x20;
> >  
> > -	if (cpu_is_omap2430()) {
> > +	if (cpu_is_omap2430() || cpu_is_omap34xx()) {
> >  		u16 s;
> >  
> >  		/* Set up the fifo size - Get total size */
> > -- 
> > 1.5.6.rc3.21.g8c6b5
> > 
> > 
> > _______________________________________________
> > i2c mailing list
> > i2c@lm-sensors.org
> > http://lists.lm-sensors.org/mailman/listinfo/i2c
> 
> -- 
> Ben (ben@fluff.org, http://www.fluff.org/)
> 
>   'a smiley only costs 4 bytes'

--DEueqSqTbz/jWVG1
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: inline; filename="0005-i2c-omap-Add-support-for-omap34xx.patch"

>From e5bba093a9541e2943f8e582bd459343d9574b38 Mon Sep 17 00:00:00 2001
From: Chandra shekhar <x0044955@ti.com>
Date: Fri, 17 Oct 2008 07:44:01 -0700
Subject: [PATCH] i2c-omap: Add support for omap34xx

Add support for omap34xx

Signed-off-by: chandra shekhar <x0044955@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/i2c/busses/i2c-omap.c |   12 +++++++-----
 1 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index a87e21c..5dd8a24 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -156,7 +156,7 @@ static inline u16 omap_i2c_read_reg(struct omap_i2c_dev *i2c_dev, int reg)
 
 static int omap_i2c_get_clocks(struct omap_i2c_dev *dev)
 {
-	if (cpu_is_omap16xx() || cpu_is_omap24xx()) {
+	if (cpu_is_omap16xx() || cpu_class_is_omap2()) {
 		dev->iclk = clk_get(dev->dev, "i2c_ick");
 		if (IS_ERR(dev->iclk)) {
 			dev->iclk = NULL;
@@ -268,7 +268,7 @@ static int omap_i2c_init(struct omap_i2c_dev *dev)
 			psc = fclk_rate / 12000000;
 	}
 
-	if (cpu_is_omap2430()) {
+	if (cpu_is_omap2430() || cpu_is_omap34xx()) {
 
 		/* HSI2C controller internal clk rate should be 19.2 Mhz */
 		internal_clk = 19200;
@@ -611,7 +611,8 @@ omap_i2c_isr(int this_irq, void *dev_id)
 					*dev->buf++ = w;
 					dev->buf_len--;
 					/* Data reg from 2430 is 8 bit wide */
-					if (!cpu_is_omap2430()) {
+					if (!cpu_is_omap2430() &&
+							!cpu_is_omap34xx()) {
 						if (dev->buf_len) {
 							*dev->buf++ = w >> 8;
 							dev->buf_len--;
@@ -649,7 +650,8 @@ omap_i2c_isr(int this_irq, void *dev_id)
 					w = *dev->buf++;
 					dev->buf_len--;
 					/* Data reg from  2430 is 8 bit wide */
-					if (!cpu_is_omap2430()) {
+					if (!cpu_is_omap2430() &&
+							!cpu_is_omap34xx()) {
 						if (dev->buf_len) {
 							w |= *dev->buf++ << 8;
 							dev->buf_len--;
@@ -748,7 +750,7 @@ omap_i2c_probe(struct platform_device *pdev)
 	if (cpu_is_omap15xx())
 		dev->rev1 = omap_i2c_read_reg(dev, OMAP_I2C_REV_REG) < 0x20;
 
-	if (cpu_is_omap2430()) {
+	if (cpu_is_omap2430() || cpu_is_omap34xx()) {
 		u16 s;
 
 		/* Set up the fifo size - Get total size */
-- 
1.5.6.rc3.21.g8c6b5


--DEueqSqTbz/jWVG1--
