From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv2 09/15] remoteproc/omap: Remove the omap_rproc_reserve_cma declaration
Date: Tue, 19 Nov 2019 16:16:39 +0200
Message-ID: <20191119141645.19777-10-t-kristo@ti.com>
References: <20191119141645.19777-1-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191119141645.19777-1-t-kristo@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: bjorn.andersson@linaro.org, ohad@wizery.com, linux-remoteproc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, s-anna@ti.com, Tero Kristo <t-kristo@ti.com>
List-Id: linux-omap@vger.kernel.org

From: Suman Anna <s-anna@ti.com>

The omap_rproc_reserve_cma() function is not defined at the moment.
This prototype was to be used to define a function to declare a
remoteproc device-specific CMA pool.

The remoteproc devices will be defined through DT going forward. A
device specific CMA pool will be defined under the reserved-memory
node, and will be associated with the appropriate remoteproc device
node. This function prototype will no longer be needed and has
therefore been cleaned up.

Signed-off-by: Suman Anna <s-anna@ti.com>
Signed-off-by: Tero Kristo <t-kristo@ti.com>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 include/linux/platform_data/remoteproc-omap.h | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/include/linux/platform_data/remoteproc-omap.h b/include/linux/platform_data/remoteproc-omap.h
index 6bea01e199fe..49c78805916f 100644
--- a/include/linux/platform_data/remoteproc-omap.h
+++ b/include/linux/platform_data/remoteproc-omap.h
@@ -21,16 +21,4 @@ struct omap_rproc_pdata {
 	int (*device_shutdown)(struct platform_device *pdev);
 };
 
-#if defined(CONFIG_OMAP_REMOTEPROC) || defined(CONFIG_OMAP_REMOTEPROC_MODULE)
-
-void __init omap_rproc_reserve_cma(void);
-
-#else
-
-static inline void __init omap_rproc_reserve_cma(void)
-{
-}
-
-#endif
-
 #endif /* _PLAT_REMOTEPROC_H */
-- 
2.17.1

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
