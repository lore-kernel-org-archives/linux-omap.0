From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: [PATCH 35/50] staging: omap-thermal: section of device driver callbacks
Date: Fri, 15 Mar 2013 09:00:23 -0400
Message-ID: <1363352438-15935-36-git-send-email-eduardo.valentin@ti.com>
References: <1363352438-15935-1-git-send-email-eduardo.valentin@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1363352438-15935-1-git-send-email-eduardo.valentin@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: devel@driverdev.osuosl.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Eduardo Valentin <eduardo.valentin@ti.com>
List-Id: linux-omap@vger.kernel.org

Section with platform device callbacks

Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>
---
 drivers/staging/omap-thermal/omap-bandgap.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/staging/omap-thermal/omap-bandgap.c b/drivers/staging/omap-thermal/omap-bandgap.c
index 8c7ac0e..8746187 100644
--- a/drivers/staging/omap-thermal/omap-bandgap.c
+++ b/drivers/staging/omap-thermal/omap-bandgap.c
@@ -862,6 +862,8 @@ static struct omap_bandgap *omap_bandgap_build(struct platform_device *pdev)
 	return bg_ptr;
 }
 
+/***   Device driver call backs   ***/
+
 static
 int omap_bandgap_probe(struct platform_device *pdev)
 {
-- 
1.7.7.1.488.ge8e1c
