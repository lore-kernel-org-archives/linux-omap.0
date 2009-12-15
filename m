From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: [PATCH 3/5 v8] OMAP: McBSP: Introduce caching in register write operations
Date: Tue, 15 Dec 2009 01:36:47 +0100
Message-ID: <200912150136.49087.jkrzyszt@tis.icnet.pl>
References: <200912092124.14430.jkrzyszt@tis.icnet.pl> <20091211151149.c20acce5.jhnikula@gmail.com> <200912111451.29185.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from d1.icnet.pl ([212.160.220.21]:37578 "EHLO d1.icnet.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750907AbZLOAhS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 14 Dec 2009 19:37:18 -0500
In-Reply-To: <200912111451.29185.jkrzyszt@tis.icnet.pl>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, linux-omap@vger.kernel.org

Determine cache size required per McBSP port at init time, based on pro=
cessor
type running on.
Allocate space for storing cached copies of McBSP register values at po=
rt
request.
Modify omap_msbcp_write() function to update the cache with every regis=
ter
write operation.
Modify omap_mcbsp_read() to support reading from cache or hardware.
Update MCBSP_READ() macro for modified omap_mcbsp_read() function API.
Introduce a new macro that reads from the cache.

Applies on top of patch 2 from this series:
[PATCH v7 2/5] OMAP: McBSP: Modify macros/functions API for easy cache =
access

Tested on OMAP1510 based Amstrad Delta using linux-omap for-next,
commit 82f1d8f22f2c65e70206e40a6f17688bf64a892c.
Compile-tested with: omap_perseus2_730_defconfig, omap_generic_1610_def=
config,
omap_generic_2420_defconfig, omap_2430sdp_defconfig, omap_3430sdp_defco=
nfig,
omap_4430sdp_defconfig with CONFIG_OMAP_MCBSP=3Dy selected.

Signed-off-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>

---
=46riday 11 December 2009 14:51:27 Janusz Krzysztofik napisa=C5=82(a):
> Friday 11 December 2009 14:11:49 Jarkko Nikula napisa=C5=82(a):
> >
> > ... Could have my ack to patches 1-4 by moving the cache
> > allocation after the mcbsp->free test lines. Memory leak and other
> > badness would happen otherwise in case of multiple call to
> > omap_mcbsp_request.
>
> Yes, it's a bug, sorry.

Actually, three distinct bugs could be recognized, not one :/
1. Possible overwriting of mcbsp->reg_cache pointer for an already occu=
pied=20
   port.
2. Not freeing allocated cache memory on return after the port appears =
not=20
   free.
3. In omap_mcbsp_free(), marking the port as free before deallocating t=
he=20
   cache, could result in memory leak as well.

I hope all are addressed correctly. Since releasing the port with

	mcbsp->free =3D 1;

after kzalloc() failure should be atomic, I have assumed this doesn't r=
equire=20
locking.

Tested both alone and with patch v7 4/5 on top, just for case.

Thanks,
Janusz

diff -upr git.orig/arch/arm/mach-omap1/mcbsp.c git/arch/arm/mach-omap1/=
mcbsp.c
--- git.orig/arch/arm/mach-omap1/mcbsp.c	2009-12-02 15:48:37.000000000 =
+0100
+++ git/arch/arm/mach-omap1/mcbsp.c	2009-12-14 21:32:56.000000000 +0100
@@ -99,9 +99,11 @@ static struct omap_mcbsp_platform_data o
 	},
 };
 #define OMAP7XX_MCBSP_PDATA_SZ		ARRAY_SIZE(omap7xx_mcbsp_pdata)
+#define OMAP7XX_MCBSP_REG_NUM		(OMAP_MCBSP_REG_XCERH / sizeof(u16) + 1=
)
 #else
 #define omap7xx_mcbsp_pdata		NULL
 #define OMAP7XX_MCBSP_PDATA_SZ		0
+#define OMAP7XX_MCBSP_REG_NUM		0
 #endif
=20
 #ifdef CONFIG_ARCH_OMAP15XX
@@ -132,9 +134,11 @@ static struct omap_mcbsp_platform_data o
 	},
 };
 #define OMAP15XX_MCBSP_PDATA_SZ		ARRAY_SIZE(omap15xx_mcbsp_pdata)
+#define OMAP15XX_MCBSP_REG_NUM		(OMAP_MCBSP_REG_XCERH / sizeof(u16) + =
1)
 #else
 #define omap15xx_mcbsp_pdata		NULL
 #define OMAP15XX_MCBSP_PDATA_SZ		0
+#define OMAP15XX_MCBSP_REG_NUM		0
 #endif
=20
 #ifdef CONFIG_ARCH_OMAP16XX
@@ -165,19 +169,25 @@ static struct omap_mcbsp_platform_data o
 	},
 };
 #define OMAP16XX_MCBSP_PDATA_SZ		ARRAY_SIZE(omap16xx_mcbsp_pdata)
+#define OMAP16XX_MCBSP_REG_NUM		(OMAP_MCBSP_REG_XCERH / sizeof(u16) + =
1)
 #else
 #define omap16xx_mcbsp_pdata		NULL
 #define OMAP16XX_MCBSP_PDATA_SZ		0
+#define OMAP16XX_MCBSP_REG_NUM		0
 #endif
=20
 int __init omap1_mcbsp_init(void)
 {
-	if (cpu_is_omap7xx())
+	if (cpu_is_omap7xx()) {
 		omap_mcbsp_count =3D OMAP7XX_MCBSP_PDATA_SZ;
-	if (cpu_is_omap15xx())
+		omap_mcbsp_cache_size =3D OMAP7XX_MCBSP_REG_NUM * sizeof(u16);
+	} else if (cpu_is_omap15xx()) {
 		omap_mcbsp_count =3D OMAP15XX_MCBSP_PDATA_SZ;
-	if (cpu_is_omap16xx())
+		omap_mcbsp_cache_size =3D OMAP15XX_MCBSP_REG_NUM * sizeof(u16);
+	} else if (cpu_is_omap16xx()) {
 		omap_mcbsp_count =3D OMAP16XX_MCBSP_PDATA_SZ;
+		omap_mcbsp_cache_size =3D OMAP16XX_MCBSP_REG_NUM * sizeof(u16);
+	}
=20
 	mcbsp_ptr =3D kzalloc(omap_mcbsp_count * sizeof(struct omap_mcbsp *),
 								GFP_KERNEL);
diff -upr git.orig/arch/arm/mach-omap2/mcbsp.c git/arch/arm/mach-omap2/=
mcbsp.c
--- git.orig/arch/arm/mach-omap2/mcbsp.c	2009-12-02 15:48:38.000000000 =
+0100
+++ git/arch/arm/mach-omap2/mcbsp.c	2009-12-14 21:32:56.000000000 +0100
@@ -65,9 +65,11 @@ static struct omap_mcbsp_platform_data o
 	},
 };
 #define OMAP2420_MCBSP_PDATA_SZ		ARRAY_SIZE(omap2420_mcbsp_pdata)
+#define OMAP2420_MCBSP_REG_NUM		(OMAP_MCBSP_REG_RCCR / sizeof(u32) + 1=
)
 #else
 #define omap2420_mcbsp_pdata		NULL
 #define OMAP2420_MCBSP_PDATA_SZ		0
+#define OMAP2420_MCBSP_REG_NUM		0
 #endif
=20
 #ifdef CONFIG_ARCH_OMAP2430
@@ -114,9 +116,11 @@ static struct omap_mcbsp_platform_data o
 	},
 };
 #define OMAP2430_MCBSP_PDATA_SZ		ARRAY_SIZE(omap2430_mcbsp_pdata)
+#define OMAP2430_MCBSP_REG_NUM		(OMAP_MCBSP_REG_RCCR / sizeof(u32) + 1=
)
 #else
 #define omap2430_mcbsp_pdata		NULL
 #define OMAP2430_MCBSP_PDATA_SZ		0
+#define OMAP2430_MCBSP_REG_NUM		0
 #endif
=20
 #ifdef CONFIG_ARCH_OMAP34XX
@@ -168,9 +172,11 @@ static struct omap_mcbsp_platform_data o
 	},
 };
 #define OMAP34XX_MCBSP_PDATA_SZ		ARRAY_SIZE(omap34xx_mcbsp_pdata)
+#define OMAP34XX_MCBSP_REG_NUM		(OMAP_MCBSP_REG_RCCR / sizeof(u32) + 1=
)
 #else
 #define omap34xx_mcbsp_pdata		NULL
 #define OMAP34XX_MCBSP_PDATA_SZ		0
+#define OMAP34XX_MCBSP_REG_NUM		0
 #endif
=20
 static struct omap_mcbsp_platform_data omap44xx_mcbsp_pdata[] =3D {
@@ -208,17 +214,23 @@ static struct omap_mcbsp_platform_data o
 	},
 };
 #define OMAP44XX_MCBSP_PDATA_SZ		ARRAY_SIZE(omap44xx_mcbsp_pdata)
+#define OMAP44XX_MCBSP_REG_NUM		(OMAP_MCBSP_REG_RCCR / sizeof(u32) + 1=
)
=20
 static int __init omap2_mcbsp_init(void)
 {
-	if (cpu_is_omap2420())
+	if (cpu_is_omap2420()) {
 		omap_mcbsp_count =3D OMAP2420_MCBSP_PDATA_SZ;
-	if (cpu_is_omap2430())
+		omap_mcbsp_cache_size =3D OMAP2420_MCBSP_REG_NUM * sizeof(u16);
+	} else if (cpu_is_omap2430()) {
 		omap_mcbsp_count =3D OMAP2430_MCBSP_PDATA_SZ;
-	if (cpu_is_omap34xx())
+		omap_mcbsp_cache_size =3D OMAP2430_MCBSP_REG_NUM * sizeof(u32);
+	} else if (cpu_is_omap34xx()) {
 		omap_mcbsp_count =3D OMAP34XX_MCBSP_PDATA_SZ;
-	if (cpu_is_omap44xx())
+		omap_mcbsp_cache_size =3D OMAP34XX_MCBSP_REG_NUM * sizeof(u32);
+	} else if (cpu_is_omap44xx()) {
 		omap_mcbsp_count =3D OMAP44XX_MCBSP_PDATA_SZ;
+		omap_mcbsp_cache_size =3D OMAP44XX_MCBSP_REG_NUM * sizeof(u32);
+	}
=20
 	mcbsp_ptr =3D kzalloc(omap_mcbsp_count * sizeof(struct omap_mcbsp *),
 								GFP_KERNEL);
diff -upr git.orig/arch/arm/plat-omap/include/plat/mcbsp.h git/arch/arm=
/plat-omap/include/plat/mcbsp.h
--- git.orig/arch/arm/plat-omap/include/plat/mcbsp.h	2009-12-02 15:48:5=
1.000000000 +0100
+++ git/arch/arm/plat-omap/include/plat/mcbsp.h	2009-12-14 21:32:56.000=
000000 +0100
@@ -415,9 +415,10 @@ struct omap_mcbsp {
 	u16 max_tx_thres;
 	u16 max_rx_thres;
 #endif
+	void *reg_cache;
 };
 extern struct omap_mcbsp **mcbsp_ptr;
-extern int omap_mcbsp_count;
+extern int omap_mcbsp_count, omap_mcbsp_cache_size;
=20
 int omap_mcbsp_init(void);
 void omap_mcbsp_register_board_cfg(struct omap_mcbsp_platform_data *co=
nfig,
diff -upr git.orig/arch/arm/plat-omap/mcbsp.c git/arch/arm/plat-omap/mc=
bsp.c
--- git.orig/arch/arm/plat-omap/mcbsp.c	2009-12-11 18:19:18.000000000 +=
0100
+++ git/arch/arm/plat-omap/mcbsp.c	2009-12-14 21:45:16.000000000 +0100
@@ -28,28 +28,42 @@
 #include <plat/mcbsp.h>
=20
 struct omap_mcbsp **mcbsp_ptr;
-int omap_mcbsp_count;
+int omap_mcbsp_count, omap_mcbsp_cache_size;
=20
 void omap_mcbsp_write(struct omap_mcbsp *mcbsp, u16 reg, u32 val)
 {
-	if (cpu_class_is_omap1() || cpu_is_omap2420())
+	if (cpu_class_is_omap1()) {
+		((u16 *)mcbsp->reg_cache)[reg / sizeof(u16)] =3D (u16)val;
 		__raw_writew((u16)val, mcbsp->io_base + reg);
-	else
+	} else if (cpu_is_omap2420()) {
+		((u16 *)mcbsp->reg_cache)[reg / sizeof(u32)] =3D (u16)val;
+		__raw_writew((u16)val, mcbsp->io_base + reg);
+	} else {
+		((u32 *)mcbsp->reg_cache)[reg / sizeof(u32)] =3D val;
 		__raw_writel(val, mcbsp->io_base + reg);
+	}
 }
=20
-int omap_mcbsp_read(struct omap_mcbsp *mcbsp, u16 reg)
+int omap_mcbsp_read(struct omap_mcbsp *mcbsp, u16 reg, bool from_cache=
)
 {
-	if (cpu_class_is_omap1() || cpu_is_omap2420())
-		return __raw_readw(mcbsp->io_base + reg);
-	else
-		return __raw_readl(mcbsp->io_base + reg);
+	if (cpu_class_is_omap1()) {
+		return !from_cache ? __raw_readw(mcbsp->io_base + reg) :
+				((u16 *)mcbsp->reg_cache)[reg / sizeof(u16)];
+	} else if (cpu_is_omap2420()) {
+		return !from_cache ? __raw_readw(mcbsp->io_base + reg) :
+				((u16 *)mcbsp->reg_cache)[reg / sizeof(u32)];
+	} else {
+		return !from_cache ? __raw_readl(mcbsp->io_base + reg) :
+				((u32 *)mcbsp->reg_cache)[reg / sizeof(u32)];
+	}
 }
=20
 #define MCBSP_READ(mcbsp, reg) \
-		omap_mcbsp_read(mcbsp, OMAP_MCBSP_REG_##reg)
+		omap_mcbsp_read(mcbsp, OMAP_MCBSP_REG_##reg, 0)
 #define MCBSP_WRITE(mcbsp, reg, val) \
 		omap_mcbsp_write(mcbsp, OMAP_MCBSP_REG_##reg, val)
+#define MCBSP_READ_CACHE(mcbsp, reg) \
+		omap_mcbsp_read(mcbsp, OMAP_MCBSP_REG_##reg, 1)
=20
 #define omap_mcbsp_check_valid_id(id)	(id < omap_mcbsp_count)
 #define id_to_mcbsp_ptr(id)		mcbsp_ptr[id];
@@ -402,6 +416,12 @@ int omap_mcbsp_request(unsigned int id)
 	mcbsp->free =3D 0;
 	spin_unlock(&mcbsp->lock);
=20
+	mcbsp->reg_cache =3D kzalloc(omap_mcbsp_cache_size, GFP_KERNEL);
+	if (!mcbsp->reg_cache) {
+		mcbsp->free =3D 1;
+		return -ENOMEM;
+	}
+
 	if (mcbsp->pdata && mcbsp->pdata->ops && mcbsp->pdata->ops->request)
 		mcbsp->pdata->ops->request(id);
=20
@@ -471,6 +491,9 @@ void omap_mcbsp_free(unsigned int id)
 		free_irq(mcbsp->tx_irq, (void *)mcbsp);
 	}
=20
+	kfree(mcbsp->reg_cache);
+	mcbsp->reg_cache =3D NULL;
+
 	spin_lock(&mcbsp->lock);
 	if (mcbsp->free) {
 		dev_err(mcbsp->dev, "McBSP%d was not reserved\n",
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
