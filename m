From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v2] [I2C-OMAP] Add support for 16-bit registers
Date: Mon, 11 Jan 2010 17:28:15 -0800
Message-ID: <20100112012814.GK5055@atomide.com>
References: <1260669242-29865-1-git-send-email-darkstar6262@gmail.com>
 <6cb013311001090947m2268833cv3784f469dc8b861d@mail.gmail.com>
 <20100109183321.GH2879@atomide.com>
 <6cb013311001091035x54321b3aqb814f476200980af@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="eJnRUKwClWJh1Khz"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <6cb013311001091035x54321b3aqb814f476200980af-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Cory Maccarrone <darkstar6262-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--eJnRUKwClWJh1Khz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* Cory Maccarrone <darkstar6262-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> [100109 10:34]:
> On Sat, Jan 9, 2010 at 10:33 AM, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> wrote:
> >
> > Let's plan on adding this into omap-testing branch next week so
> > we can make sure things are OK for the other platforms.
> >
> > Then assuming no issues, let's ask Ben can queue it.
> >
> 
> Excellent, thank you!

Applied to omap-testing with the following fix. Can you please merge
it into your original patch?

Regards,

Tony

--eJnRUKwClWJh1Khz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename=i2c-omap-fix-reg-shift

>From 5b640a850de9fb87b9e9e6dd2cfeb7144ada8053 Mon Sep 17 00:00:00 2001
From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Date: Mon, 11 Jan 2010 17:22:21 -0800
Subject: [PATCH] i2c-omap: Fix reg_shift init

Otherwise register access won't work during probe
for omap_i2c_unidle.

Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 913abd7..9c3ce4d 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -894,6 +894,12 @@ omap_i2c_probe(struct platform_device *pdev)
 	dev->idle = 1;
 	dev->dev = &pdev->dev;
 	dev->irq = irq->start;
+
+	if (cpu_is_omap7xx())
+		dev->reg_shift = 1;
+	else
+		dev->reg_shift = 2;
+
 	dev->base = ioremap(mem->start, resource_size(mem));
 	if (!dev->base) {
 		r = -ENOMEM;
@@ -925,11 +931,6 @@ omap_i2c_probe(struct platform_device *pdev)
 		dev->b_hw = 1; /* Enable hardware fixes */
 	}
 
-	if (cpu_is_omap7xx())
-		dev->reg_shift = 1;
-	else
-		dev->reg_shift = 2;
-
 	/* reset ASAP, clearing any IRQs */
 	omap_i2c_init(dev);
 

--eJnRUKwClWJh1Khz--
