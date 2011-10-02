From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 01/30] sound/omap: omap_mcpdm_remove cannot be __devexit
Date: Sun,  2 Oct 2011 16:45:31 +0200
Message-ID: <1317566760-25681-2-git-send-email-arnd@arndb.de>
References: <1317566760-25681-1-git-send-email-arnd@arndb.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1317566760-25681-1-git-send-email-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: linux-omap@vger.kernel.org

omap_mcpdm_remove is used from asoc_mcpdm_probe, which is an
initcall, and must not be discarded when HOTPLUG is disabled.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Jarkko Nikula <jarkko.nikula@bitmer.com>
---
 sound/soc/omap/mcpdm.c |    2 +-
 sound/soc/omap/mcpdm.h |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/omap/mcpdm.c b/sound/soc/omap/mcpdm.c
index 928f037..50e59194 100644
--- a/sound/soc/omap/mcpdm.c
+++ b/sound/soc/omap/mcpdm.c
@@ -449,7 +449,7 @@ exit:
 	return ret;
 }
 
-int __devexit omap_mcpdm_remove(struct platform_device *pdev)
+int omap_mcpdm_remove(struct platform_device *pdev)
 {
 	struct omap_mcpdm *mcpdm_ptr = platform_get_drvdata(pdev);
 
diff --git a/sound/soc/omap/mcpdm.h b/sound/soc/omap/mcpdm.h
index df3e16f..20c20a8 100644
--- a/sound/soc/omap/mcpdm.h
+++ b/sound/soc/omap/mcpdm.h
@@ -150,4 +150,4 @@ extern int omap_mcpdm_request(void);
 extern void omap_mcpdm_free(void);
 extern int omap_mcpdm_set_offset(int offset1, int offset2);
 int __devinit omap_mcpdm_probe(struct platform_device *pdev);
-int __devexit omap_mcpdm_remove(struct platform_device *pdev);
+int omap_mcpdm_remove(struct platform_device *pdev);
-- 
1.7.5.4
