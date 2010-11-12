From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: [PATCH v3 1/1] OMAP2: Spi: Force CS to be in inactive state after
 off-mode transition
Date: Fri, 12 Nov 2010 17:45:21 +0100
Message-ID: <4CDD6F21.7000609@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([88.190.12.23]:44456 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932641Ab0KLQpa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 12 Nov 2010 11:45:30 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>, spi-devel-general <spi-devel-general@lists.sourceforge.net>
Cc: David Brownell <dbrownell@users.sourceforge.net>, Grant Likely <grant.likely@secretlab.ca>, Kevin Hilman <khilman@deeprootsystems.com>

When SPI wake up from OFF mode, CS is in the wrong state: force it to 
the inactive state.

During the system life, I monitored the CS behavior using a 
oscilloscope. I also activated debug in omap2_mcspi, so I saw when 
driver disable the clocks and
Each time the CS was in the correct state.
It was only when system was put suspend to ram with off-mode activated 
that on resume the CS was in wrong state( ie activated).

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
  drivers/spi/omap2_mcspi.c |   29 +++++++++++++++++++++++++++++
  1 files changed, 29 insertions(+), 0 deletions(-)

diff --git a/drivers/spi/omap2_mcspi.c b/drivers/spi/omap2_mcspi.c
index 2a651e6..708990e 100644
--- a/drivers/spi/omap2_mcspi.c
+++ b/drivers/spi/omap2_mcspi.c
@@ -1305,11 +1305,40 @@ static int __exit omap2_mcspi_remove(struct 
platform_device *pdev)
  /* work with hotplug and coldplug */
  MODULE_ALIAS("platform:omap2_mcspi");
  +#ifdef	CONFIG_PM
+/* When SPI wake up, CS is in wrong state: force it to unactive state*/
+static int omap2_mcspi_resume(struct platform_device *pdev)
+{
+	struct spi_master	*master;
+	struct omap2_mcspi	*mcspi;
+	struct omap2_mcspi_cs *cs;
+
+	master = dev_get_drvdata(&pdev->dev);
+	mcspi = spi_master_get_devdata(master);
+	omap2_mcspi_enable_clocks(master);
+	/* We need to togle CS state for OMAP take this chang in account*/
+
+	list_for_each_entry(cs, &omap2_mcspi_ctx[master->bus_num - 1].cs,
+			    node)
+    {
+        MOD_REG_BIT(cs->chconf0, OMAP2_MCSPI_CHCONF_FORCE, 1);
+		__raw_writel(cs->chconf0, cs->base + OMAP2_MCSPI_CHCONF0);
+        MOD_REG_BIT(cs->chconf0, OMAP2_MCSPI_CHCONF_FORCE, 0);
+		__raw_writel(cs->chconf0, cs->base + OMAP2_MCSPI_CHCONF0);
+    }
+	omap2_mcspi_disable_clocks(master);
+    return 0;
+}
+#else
+#define	omap2_mcspi_resume	NULL
+#endif
+
  static struct platform_driver omap2_mcspi_driver = {
  	.driver = {
  		.name =		"omap2_mcspi",
  		.owner =	THIS_MODULE,
  	},
+	.resume =	omap2_mcspi_resume,
  	.remove =	__exit_p(omap2_mcspi_remove),
  };
  -- 1.7.0.4

