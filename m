From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH 1/3] omap mailbox: cleanup register definition with
	macro
Date: Sat, 22 Nov 2008 13:55:01 +0200
Message-ID: <20081122115500.GB6289@frodo>
References: <1227313717-26399-1-git-send-email-Hiroshi.DOYU@nokia.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:53643 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757222AbYKVLzP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 22 Nov 2008 06:55:15 -0500
Content-Disposition: inline
In-Reply-To: <1227313717-26399-1-git-send-email-Hiroshi.DOYU@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: linux-omap@vger.kernel.org

On Sat, Nov 22, 2008 at 02:28:35AM +0200, Hiroshi DOYU wrote:
> +static unsigned long mbox_base;

shouldn't this be __void iomem *mbox_base ?

Then you would need a patch like this (not even compile tested):

diff --git a/arch/arm/mach-omap2/mailbox.c b/arch/arm/mach-omap2/mailbox.c
index 22546d0..7aa68e5 100644
--- a/arch/arm/mach-omap2/mailbox.c
+++ b/arch/arm/mach-omap2/mailbox.c
@@ -48,7 +48,7 @@
 #define MAILBOX_IRQSTATUS_3            0x118
 #define MAILBOX_IRQENABLE_3            0x11c
 
-static unsigned long mbox_base;
+static void __iomem *mbox_base;
 
 #define MAILBOX_IRQ_NOTFULL(n)         (1 << (2 * (n) + 1))
 #define MAILBOX_IRQ_NEWMSG(n)          (1 << (2 * (n)))
@@ -75,12 +75,12 @@ static void omap2_mbox_enable_irq(struct omap_mbox *mbox,
 
 static inline unsigned int mbox_read_reg(unsigned int reg)
 {
-       return __raw_readl((void __iomem *)(mbox_base + reg));
+       return __raw_readl(mbox_base + reg);
 }
 
 static inline void mbox_write_reg(unsigned int val, unsigned int reg)
 {
-       __raw_writel(val, (void __iomem *)(mbox_base + reg));
+       __raw_writel(val, (mbox_base + reg));
 }
 
 /* Mailbox H/W preparations */
@@ -268,7 +268,7 @@ static int __init omap2_mbox_probe(struct platform_device *pdev)
                dev_err(&pdev->dev, "invalid mem resource\n");
                return -ENODEV;
        }
-       mbox_base = res->start;
+       mbox_base = ioremap(res->start, res->end - res->start);
 
        /* DSP IRQ */
        res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);

-- 
balbi
