From: Nicholas Krause <xerofoify@gmail.com>
Subject: [PATCH RESEND] mach-omap2:Remove calls to deprecacted marco,
 PTR_RET in the files, fb.c and pmu.c
Date: Mon, 18 May 2015 10:07:59 -0400
Message-ID: <1431958079-486-1-git-send-email-xerofoify@gmail.com>
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
Cc: khilman@deeprootsystems.com, linux-omap@vger.kernel.org, linux@arm.linux.org.uk, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

This removes two calls to the deprecated marco,PTR_RET in
the files,fb.c and pmu.c for the functions,omap_init_vrfb
and omap_init_pmu respectfully. Furthermore these are now
replaced by calling the correctly non deprecacted function,
PTR_ERR_OR_ZERO in both functions.

Signed-off-by: Nicholas Krause <xerofoify@gmail.com>
---
 arch/arm/mach-omap2/fb.c  | 2 +-
 arch/arm/mach-omap2/pmu.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/fb.c b/arch/arm/mach-omap2/fb.c
index 26e28e9..1f1ecf8 100644
--- a/arch/arm/mach-omap2/fb.c
+++ b/arch/arm/mach-omap2/fb.c
@@ -84,7 +84,7 @@ int __init omap_init_vrfb(void)
 	pdev = platform_device_register_resndata(NULL, "omapvrfb", -1,
 			res, num_res, NULL, 0);
 
-	return PTR_RET(pdev);
+	return PTR_ERR_OR_ZERO(pdev);
 }
 #else
 int __init omap_init_vrfb(void) { return 0; }
diff --git a/arch/arm/mach-omap2/pmu.c b/arch/arm/mach-omap2/pmu.c
index a69e9a3..d2adfeb 100644
--- a/arch/arm/mach-omap2/pmu.c
+++ b/arch/arm/mach-omap2/pmu.c
@@ -55,7 +55,7 @@ static int __init omap2_init_pmu(unsigned oh_num, char *oh_names[])
 	WARN(IS_ERR(omap_pmu_dev), "Can't build omap_device for %s.\n",
 	     dev_name);
 
-	return PTR_RET(omap_pmu_dev);
+	return PTR_ERR_OR_ZERO(omap_pmu_dev);
 }
 
 static int __init omap_init_pmu(void)
-- 
2.1.4
