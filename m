From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] twl4030: Fix pwrirq by making sure the module is
	responding (Re: kernel oops for 3430sdp)
Date: Wed, 8 Oct 2008 17:55:21 +0300
Message-ID: <20081008145517.GJ30831@atomide.com>
References: <A24693684029E5489D1D202277BE8944123692F2@dlee02.ent.ti.com> <200810071128.52889.david-b@pacbell.net> <20081007200921.GI8273@frodo>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="3siQDZowHQqNOShm"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:54349 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750753AbYJHOzf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 Oct 2008 10:55:35 -0400
Content-Disposition: inline
In-Reply-To: <20081007200921.GI8273@frodo>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <me@felipebalbi.com>
Cc: David Brownell <david-b@pacbell.net>, "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


--3siQDZowHQqNOShm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* Felipe Balbi <me@felipebalbi.com> [081008 06:13]:
> On Tue, Oct 07, 2008 at 11:28:52AM -0700, David Brownell wrote:
> > On Tuesday 07 October 2008, Aguirre Rodriguez, Sergio Alberto wrote:
> > > <1>Unable to handle kernel NULL pointer dereference at virtual address 00000000
> > 
> > Did you try with the hack I've sent, to work around one problematic
> > (and surprisingly reproducible!) i2c-omap timeout?  Appended.
> > 
> > Given I2C faults, many things blow up rudely ... hardly any I2C
> > drivers are written to tolerate transfer errors.  Not entirely
> > unreasonably, since such errors are otherwise quite rare.
> > 
> > 
> > I currently suspect there's an issue where the i2c-omap code can
> > handle a bunch of requests that group closely together ... or are
> > separated by a lot of time ... but there's some middle ground
> > where if you wait the "right" amount of time before making the
> > next request, it times out instead of working correctly.
> > 
> > I have no proof behind that theory, but it does seem to match up
> > to a few of the observed facts.  Notably that the i2c timeouts
> > appear when the only device on that bus is the TWL4030, and the
> > drivers make known-to-be-valid requets ... the timeouts started
> > to appear only after some trivial changes in init timings, which
> > were caused by moving code out of drivers/i2c into directories
> > that are more appropriate.
> 
> I was debugging the i2c-omap.c today but so far no clue why that i2c
> timeout is coming. It's really weird that it only fails on twl4030-usb
> (well, actually pwrirq and twl4030-usb fails since it can't
> request_irq).

I suspect that twl is not yet initialized for pwrirq handling at this
point. At least this patch seems to help, no idea on what registers
we should check though.. Anybody got ideas on what needs to be checked
for pwrirq?

Tony

--3siQDZowHQqNOShm
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: inline; filename="twl-pwrirq-hack.patch"

>From f5766a9dbd845911f7bf87bbc71437964b2cc91a Mon Sep 17 00:00:00 2001
From: Tony Lindgren <tony@atomide.com>
Date: Wed, 8 Oct 2008 17:22:30 +0300
Subject: [PATCH] twl4030: Fix pwrirq by making sure the module is responding

Something needs to be checked with twl pwriq module before
trying to use it. Not yet sure what should be checked though..
At least PWR_IMR1 seems to change from 0x0 after few reads.

diff --git a/drivers/i2c/chips/twl4030-pwrirq.c b/drivers/i2c/chips/twl4030-pwrirq.c
index ce66dd4..fd17c3e 100644
--- a/drivers/i2c/chips/twl4030-pwrirq.c
+++ b/drivers/i2c/chips/twl4030-pwrirq.c
@@ -130,10 +130,19 @@ static int twl4030_pwrirq_thread(void *data)
 
 static int __init twl4030_pwrirq_init(void)
 {
-	int i, err;
+	int i = 10, err;
+	u8 tmp;
 
 	twl4030_pwrirq_mask = 0xff;
 
+	/* Wait for other the module to start responding */
+	while (i--) {
+		err = twl4030_i2c_read_u8(TWL4030_MODULE_INT, &tmp,
+						TWL4030_INT_PWR_IMR1);
+		if ((tmp & 0xf) != 0)
+			break;
+	}
+
 	err = twl4030_i2c_write_u8(TWL4030_MODULE_INT, twl4030_pwrirq_mask,
 					TWL4030_INT_PWR_IMR1);
 	if (err)

--3siQDZowHQqNOShm--
