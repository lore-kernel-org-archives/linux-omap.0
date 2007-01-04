From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] ARM: OMAP: Fix section mismatch warnings in omap-rng
Date: Thu, 04 Jan 2007 10:01:25 -0800
Message-ID: <20070104180125.7A4491FB2E9@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
References: <459D1DFD.6080606@googlemail.com>
	<1168015759.7712.7.camel@balbi> <459D3396.8020604@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <459D3396.8020604@googlemail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com, felipe.lima@indt.org.br, dirk.behme@googlemail.com
List-Id: linux-omap@vger.kernel.org

> Ah, yes, I see. Anybody with a better patch for this?

How about this.

========	CUT HERE
Keep omap_rng_probe() out of its platform_driver, addressing a
section mismatch problem.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>

Index: osk2/drivers/char/hw_random/omap-rng.c
===================================================================
--- osk2.orig/drivers/char/hw_random/omap-rng.c	2006-12-30 14:59:25.000000000 -0800
+++ osk2/drivers/char/hw_random/omap-rng.c	2007-01-04 09:55:58.000000000 -0800
@@ -179,7 +179,6 @@ static struct platform_driver omap_rng_d
 		.name		= "omap_rng",
 		.owner		= THIS_MODULE,
 	},
-	.probe		= omap_rng_probe,
 	.remove		= __exit_p(omap_rng_remove),
 	.suspend	= omap_rng_suspend,
 	.resume		= omap_rng_resume
@@ -190,7 +189,7 @@ static int __init omap_rng_init(void)
 	if (!cpu_is_omap16xx() && !cpu_is_omap24xx())
 		return -ENODEV;
 
-	return platform_driver_register(&omap_rng_driver);
+	return platform_driver_probe(&omap_rng_driver, omap_rng_probe);
 }
 
 static void __exit omap_rng_exit(void)
