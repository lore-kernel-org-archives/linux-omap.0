From: Tony Lindgren <tony@atomide.com>
Subject: Re: [i2c] [PATCH 6/8] i2c-omap: Mark init-only functions as __init
Date: Fri, 17 Oct 2008 10:07:25 -0700
Message-ID: <20081017170725.GR15820@atomide.com>
References: <1222329234-31473-1-git-send-email-tony@atomide.com> <1222329234-31473-2-git-send-email-tony@atomide.com> <1222329234-31473-3-git-send-email-tony@atomide.com> <1222329234-31473-4-git-send-email-tony@atomide.com> <1222329234-31473-5-git-send-email-tony@atomide.com> <1222329234-31473-6-git-send-email-tony@atomide.com> <1222329234-31473-7-git-send-email-tony@atomide.com> <20080929223045.GU2716@fluff.org.uk> <20081017153925.GL15820@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="tfmLD+Hxjexp/STe"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:54414 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754038AbYJQRHb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 Oct 2008 13:07:31 -0400
Content-Disposition: inline
In-Reply-To: <20081017153925.GL15820@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ben Dooks <ben-linux@fluff.org>
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, i2c@lm-sensors.org


--tfmLD+Hxjexp/STe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* Tony Lindgren <tony@atomide.com> [081017 08:40]:
> * Ben Dooks <ben-linux@fluff.org> [080929 15:30]:
> > On Thu, Sep 25, 2008 at 10:53:52AM +0300, Tony Lindgren wrote:
> > > From: Paul Walmsley <paul@pwsan.com>
> > > 
> > > Mark functions called only at init time as __init.
> > 
> > surely these should be __devinit in case of hotplugged-ness?
> 
> Here's this one fixed.

Sorry, these should be __init, not __devinit as they are called from
platform_driver_register(), not i2c_add_driver(). Updated patch
again to revert to the original version.

> 
> Tony
> 
> 
> >  
> > > Signed-off-by: Paul Walmsley <paul@pwsan.com>
> > > Signed-off-by: Tony Lindgren <tony@atomide.com>
> > > ---
> > >  drivers/i2c/busses/i2c-omap.c |    4 ++--
> > >  1 files changed, 2 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> > > index b41431a..e71f1f2 100644
> > > --- a/drivers/i2c/busses/i2c-omap.c
> > > +++ b/drivers/i2c/busses/i2c-omap.c
> > > @@ -154,7 +154,7 @@ static inline u16 omap_i2c_read_reg(struct omap_i2c_dev *i2c_dev, int reg)
> > >  	return __raw_readw(i2c_dev->base + reg);
> > >  }
> > >  
> > > -static int omap_i2c_get_clocks(struct omap_i2c_dev *dev)
> > > +static int __init omap_i2c_get_clocks(struct omap_i2c_dev *dev)
> > >  {
> > >  	if (cpu_is_omap16xx() || cpu_class_is_omap2()) {
> > >  		dev->iclk = clk_get(dev->dev, "i2c_ick");
> > > @@ -697,7 +697,7 @@ static const struct i2c_algorithm omap_i2c_algo = {
> > >  	.functionality	= omap_i2c_func,
> > >  };
> > >  
> > > -static int
> > > +static int __init
> > >  omap_i2c_probe(struct platform_device *pdev)
> > >  {
> > >  	struct omap_i2c_dev	*dev;
> > > -- 
> > > 1.5.6.rc3.21.g8c6b5
> > > 
> > > 
> > > _______________________________________________
> > > i2c mailing list
> > > i2c@lm-sensors.org
> > > http://lists.lm-sensors.org/mailman/listinfo/i2c
> > 
> > -- 
> > Ben (ben@fluff.org, http://www.fluff.org/)
> > 
> >   'a smiley only costs 4 bytes'

--tfmLD+Hxjexp/STe
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: inline; filename="0006-i2c-omap-Mark-init-only-functions-as-__init.patch"

>From 827b812e278a3a4fceba0a6957bbaddf2a53d19c Mon Sep 17 00:00:00 2001
From: Paul Walmsley <paul@pwsan.com>
Date: Fri, 17 Oct 2008 07:44:58 -0700
Subject: [PATCH] i2c-omap: Mark init-only functions as __init

Mark functions called only at init time as __init.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/i2c/busses/i2c-omap.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 5dd8a24..45c9511 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -154,7 +154,7 @@ static inline u16 omap_i2c_read_reg(struct omap_i2c_dev *i2c_dev, int reg)
 	return __raw_readw(i2c_dev->base + reg);
 }
 
-static int omap_i2c_get_clocks(struct omap_i2c_dev *dev)
+static int __init omap_i2c_get_clocks(struct omap_i2c_dev *dev)
 {
 	if (cpu_is_omap16xx() || cpu_class_is_omap2()) {
 		dev->iclk = clk_get(dev->dev, "i2c_ick");
@@ -692,7 +692,7 @@ static const struct i2c_algorithm omap_i2c_algo = {
 	.functionality	= omap_i2c_func,
 };
 
-static int
+static int __init
 omap_i2c_probe(struct platform_device *pdev)
 {
 	struct omap_i2c_dev	*dev;
-- 
1.5.6.rc3.21.g8c6b5


--tfmLD+Hxjexp/STe--
