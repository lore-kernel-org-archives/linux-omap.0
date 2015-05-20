From: Nicholas Krause <xerofoify@gmail.com>
Subject: [PATCH] mach-omap2: Remove use of deprecated marco,
 PTR_RET in devices.c
Date: Wed, 20 May 2015 15:32:26 -0400
Message-ID: <1432150346-31590-1-git-send-email-xerofoify@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux@arm.linux.org.uk, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

This removes the deprecacted marco, PTR_RET and changes the
functions that use this marco in their return statement to
instead use the non deprecacted function, PTR_ERR_OR_ZERO
for the file devices.c.

Signed-off-by: Nicholas Krause <xerofoify@gmail.com>
---
 arch/arm/mach-omap2/devices.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index 990338f..a69bd67 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -63,7 +63,7 @@ static int __init omap3_l3_init(void)
 
 	WARN(IS_ERR(pdev), "could not build omap_device for %s\n", oh_name);
 
-	return PTR_RET(pdev);
+	return PTR_ERR_OR_ZERO(pdev);
 }
 omap_postcore_initcall(omap3_l3_init);
 
@@ -333,6 +333,6 @@ static int __init omap_gpmc_init(void)
 	pdev = omap_device_build("omap-gpmc", -1, oh, NULL, 0);
 	WARN(IS_ERR(pdev), "could not build omap_device for %s\n", oh_name);
 
-	return PTR_RET(pdev);
+	return PTR_ERR_OR_ZERO(pdev);
 }
 omap_postcore_initcall(omap_gpmc_init);
-- 
2.1.4
