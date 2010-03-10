From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v2] [I2C-OMAP] Add support for 16-bit registers
Date: Wed, 10 Mar 2010 14:30:00 -0800
Message-ID: <20100310223000.GT2900@atomide.com>
References: <1260669242-29865-1-git-send-email-darkstar6262@gmail.com>
 <6cb013311001090947m2268833cv3784f469dc8b861d@mail.gmail.com>
 <20100109183321.GH2879@atomide.com>
 <6cb013311001091035x54321b3aqb814f476200980af@mail.gmail.com>
 <20100112012814.GK5055@atomide.com>
 <87k4tkf3ye.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Ns7jmDPpOpCD+GE/"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <87k4tkf3ye.fsf-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: Cory Maccarrone <darkstar6262-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--Ns7jmDPpOpCD+GE/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org> [100310 10:01]:
> Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> writes:
> 
> > * Cory Maccarrone <darkstar6262-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> [100109 10:34]:
> >> On Sat, Jan 9, 2010 at 10:33 AM, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> wrote:
> >> >
> >> > Let's plan on adding this into omap-testing branch next week so
> >> > we can make sure things are OK for the other platforms.
> >> >
> >> > Then assuming no issues, let's ask Ben can queue it.
> >> >
> >> 
> >> Excellent, thank you!
> >
> > Applied to omap-testing with the following fix. Can you please merge
> > it into your original patch?
> 
> Unfortunately, Tony's additional fix did not make it into the version
> that was merged to mainline, which results in a crash during
> probe when using v2.6.34-rc1.
> 
> Ben, can you queue the fix below from Tony for -rc2?

The original patch attached again below.

Oops, did I maybe send a wrong patchwork link earlier to the
patch?

Anyways, for the future, considering how critical this driver is
for all omaps.. And considering how badly this driver needs some
updates done..

How about we pile up the i2c-omap patches for testing into linux-omap
branch first, then ask Ben to pull it around -rc6 after we've all
acked and tested the changes?

Ben does that sound OK to you?

Regards,

Tony

--Ns7jmDPpOpCD+GE/
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: inline; filename="i2c-init-fix.patch"

>From 07e3b9fc5a37c3d1228ecc6fb2726211bb8d41df Mon Sep 17 00:00:00 2001
From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Date: Tue, 9 Mar 2010 16:53:18 -0800
Subject: [PATCH] i2c-omap: Fix reg_shift init

Otherwise register access won't work during probe
for omap_i2c_unidle.

Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index c7c2375..3d7cf1f 100644
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
 

--Ns7jmDPpOpCD+GE/--
