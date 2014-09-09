From: Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: Re: [PATCH 1/3] omap-dma: Allow compile-testing omap1_camera driver
Date: Tue, 9 Sep 2014 14:52:17 -0300
Message-ID: <20140909145217.4bce41b0@recife.lan>
References: <20140909124306.2d5a0d76@canb.auug.org.au>
	<6cbd00c5f2d342b573aaf9c0e533778374dd2e1e.1410273306.git.m.chehab@samsung.com>
	<20140909144157.GF12361@n2100.arm.linux.org.uk>
	<20140909123654.37d60f38.m.chehab@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <20140909123654.37d60f38.m.chehab@samsung.com>
Sender: linux-media-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Linux Media Mailing List <linux-media@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Vinod Koul <vinod.koul@intel.com>, Arnd Bergmann <arnd@arndb.de>, Peter Griffin <peter.griffin@linaro.org>, Balaji T K <balajitk@ti.com>, Nishanth Menon <nm@ti.com>, linux-next@vger.kernel.org, linux-kernel@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>, Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>, linux-omap <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Em Tue, 09 Sep 2014 12:36:54 -0300
Mauro Carvalho Chehab <m.chehab@samsung.com> escreveu:

> Em Tue, 9 Sep 2014 15:41:58 +0100
> Russell King - ARM Linux <linux@arm.linux.org.uk> escreveu:
>=20
> > On Tue, Sep 09, 2014 at 11:38:17AM -0300, Mauro Carvalho Chehab wro=
te:
> > > We want to be able to COMPILE_TEST the omap1_camera driver.
> > > It compiles fine, but it fails linkediting:
> > >=20
> > > ERROR: "omap_stop_dma" [drivers/media/platform/soc_camera/omap1_c=
amera.ko] undefined!
> > > ERROR: "omap_start_dma" [drivers/media/platform/soc_camera/omap1_=
camera.ko] undefined!
> > > ERROR: "omap_dma_link_lch" [drivers/media/platform/soc_camera/oma=
p1_camera.ko] undefined!
> > > ERROR: "omap_set_dma_dest_burst_mode" [drivers/media/platform/soc=
_camera/omap1_camera.ko] undefined!
> > > ERROR: "omap_set_dma_src_params" [drivers/media/platform/soc_came=
ra/omap1_camera.ko] undefined!
> > > ERROR: "omap_request_dma" [drivers/media/platform/soc_camera/omap=
1_camera.ko] undefined!
> > > ERROR: "omap_set_dma_transfer_params" [drivers/media/platform/soc=
_camera/omap1_camera.ko] undefined!
> > > ERROR: "omap_set_dma_dest_params" [drivers/media/platform/soc_cam=
era/omap1_camera.ko] undefined!
> > > ERROR: "omap_free_dma" [drivers/media/platform/soc_camera/omap1_c=
amera.ko] undefined!
> > >=20
> > > So, add some stub functions to avoid it.
> >=20
> > The real answer to this is to find someone who still uses it, and c=
onvert
> > it to the DMA engine API.  If there's no users, the driver might as=
 well
> > be killed off.
>=20
> Hmm... it seems that there are still several drivers still relying on
> the functions declared at: omap-dma.h:
>=20
> $ grep extern include/linux/omap-dma.h |perl -ne 'print "$1\n" if (m/=
extern\s\S+\s(.*)\(/)' >funcs && git grep -f funcs -l
> arch/arm/mach-omap1/pm.c
> arch/arm/mach-omap2/pm24xx.c
> arch/arm/plat-omap/dma.c
> drivers/dma/omap-dma.c
> drivers/media/platform/omap/omap_vout_vrfb.c
> drivers/media/platform/omap3isp/isphist.c
> drivers/media/platform/soc_camera/omap1_camera.c
> drivers/mtd/onenand/omap2.c
> drivers/usb/gadget/udc/omap_udc.c
> drivers/usb/musb/tusb6010_omap.c
> drivers/video/fbdev/omap/omapfb_main.c
> include/linux/omap-dma.h
>=20
> Perhaps we can remove the header and mark all the above as BROKEN.
>=20
> If nobody fixes, we can strip all of them from the Kernel.

Are all the functions declared at omap-dma.h part of the
old DMA API that should be deprecated?

If so, it seems that the OMAP2 and OMAP3 also depends on this=20
thing, as all the PM code for OMAP depends on the functions
declared inside omap-dma.h, and marking them as BROKEN
causes compilation to failure:

arch/arm/mach-omap2/built-in.o: In function `omap3_save_scratchpad_cont=
ents':
:(.text+0x798): undefined reference to `omap3_restore_3630'
:(.text+0x7a8): undefined reference to `omap3_restore'
:(.text+0x7ac): undefined reference to `omap3_restore_es3'
arch/arm/mach-omap2/built-in.o: In function `omap3_sram_restore_context=
':
:(.text+0x925c): undefined reference to `omap_push_sram_idle'
arch/arm/mach-omap2/built-in.o: In function `option_set':
:(.text+0xc15c): undefined reference to `omap3_pm_off_mode_enable'
arch/arm/mach-omap2/built-in.o: In function `pwrdm_suspend_set':
:(.text+0xc1a0): undefined reference to `omap3_pm_set_suspend_state'
arch/arm/mach-omap2/built-in.o: In function `pwrdm_suspend_get':
:(.text+0xc1e4): undefined reference to `omap3_pm_get_suspend_state'
arch/arm/mach-omap2/built-in.o: In function `omap3_enter_idle_bm':
:(.text+0xc7ec): undefined reference to `omap_sram_idle'
:(.text+0xc848): undefined reference to `pm34xx_errata'
arch/arm/mach-omap2/built-in.o: In function `omap2420_init_late':
:(.init.text+0xf64): undefined reference to `omap2_pm_init'
arch/arm/mach-omap2/built-in.o: In function `omap2430_init_late':
:(.init.text+0x1024): undefined reference to `omap2_pm_init'
arch/arm/mach-omap2/built-in.o: In function `omap3_init_late':
:(.init.text+0x1248): undefined reference to `omap3_pm_init'
arch/arm/mach-omap2/built-in.o: In function `omap3430_init_late':
:(.init.text+0x1264): undefined reference to `omap3_pm_init'
arch/arm/mach-omap2/built-in.o: In function `omap35xx_init_late':
:(.init.text+0x1280): undefined reference to `omap3_pm_init'
arch/arm/mach-omap2/built-in.o: In function `omap3630_init_late':
:(.init.text+0x129c): undefined reference to `omap3_pm_init'
arch/arm/mach-omap2/built-in.o: In function `am35xx_init_late':
:(.init.text+0x12b8): undefined reference to `omap3_pm_init'
arch/arm/mach-omap2/built-in.o::(.init.text+0x12d4): more undefined ref=
erences to `omap3_pm_init' follow

This was compiled with allmodconfig on arm, with COMPILE_TEST
disabled (a few sub-archs disabled too), to avoid spurious
unrelated compilation issues).

Am I missing something?

BTW, CONFIG_PM is auto-selected by ARCH_OMAP3.

And those are the functions that the OMAP3 code uses from omap-dma.h:

arch/arm/mach-omap2/pm34xx.c:92:2: error: implicit declaration of funct=
ion =E2=80=98omap_dma_global_context_save=E2=80=99 [-Werror=3Dimplicit-=
function-declaration]
arch/arm/mach-omap2/pm34xx.c:103:2: error: implicit declaration of func=
tion =E2=80=98omap_dma_global_context_restore=E2=80=99 [-Werror=3Dimpli=
cit-function-declaration]
arch/arm/mach-omap2/pm24xx.c:170:2: error: implicit declaration of func=
tion =E2=80=98omap_dma_running=E2=80=99 [-Werror=3Dimplicit-function-de=
claration]

Just enabling this won't work, as the code at arch/arm/plat-omap/dma.c
depends on several other functions inside omap-dma.h.


Regards,
Mauro

-

=46rom: Mauro Carvalho Chehab <m.chehab@samsung.com>
Subject: [PATCH] omap-dma: remove deprecated omap-dma.h API

We want to be able to COMPILE_TEST the omap1_camera driver.
It compiles fine, but it fails linkediting:

ERROR: "omap_stop_dma" [drivers/media/platform/soc_camera/omap1_camera.=
ko] undefined!
ERROR: "omap_start_dma" [drivers/media/platform/soc_camera/omap1_camera=
=2Eko] undefined!
ERROR: "omap_dma_link_lch" [drivers/media/platform/soc_camera/omap1_cam=
era.ko] undefined!
ERROR: "omap_set_dma_dest_burst_mode" [drivers/media/platform/soc_camer=
a/omap1_camera.ko] undefined!
ERROR: "omap_set_dma_src_params" [drivers/media/platform/soc_camera/oma=
p1_camera.ko] undefined!
ERROR: "omap_request_dma" [drivers/media/platform/soc_camera/omap1_came=
ra.ko] undefined!
ERROR: "omap_set_dma_transfer_params" [drivers/media/platform/soc_camer=
a/omap1_camera.ko] undefined!
ERROR: "omap_set_dma_dest_params" [drivers/media/platform/soc_camera/om=
ap1_camera.ko] undefined!
ERROR: "omap_free_dma" [drivers/media/platform/soc_camera/omap1_camera.=
ko] undefined!

That's because OMAP1 is using a legacy deprecated API.
Instead of fixing it, the right thing to do is to convert the
remaining OMAP drivers that use the legacy API to the standard
DMA API.

While this doesn't happen, let's mark the broken stuff with
BROKEN.

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Mauro Carvalho Chehab <m.chehab@samsung.com>

diff --git a/include/linux/omap-dma.h b/include/linux/omap-dma.h
index 6f06f8bc612c..2f19292d1e78 100644
--- a/include/linux/omap-dma.h
+++ b/include/linux/omap-dma.h
@@ -291,6 +291,12 @@ struct omap_system_dma_plat_info {
 #define dma_omap15xx()	__dma_omap15xx(d)
 #define dma_omap16xx()	__dma_omap16xx(d)
=20
+#ifdef CONFIG_BROKEN
+
+/*
+ * Deprecated non-standard DMA API.
+ */
+
 extern struct omap_system_dma_plat_info *omap_get_plat_info(void);
=20
 extern void omap_set_dma_priority(int lch, int dst_port, int priority)=
;
@@ -377,6 +383,8 @@ extern int omap_modify_dma_chain_params(int chain_i=
d,
 extern int omap_dma_chain_status(int chain_id);
 #endif
=20
+#endif /* CONFIG_BROKEN */
+
 #if defined(CONFIG_ARCH_OMAP1) && IS_ENABLED(CONFIG_FB_OMAP)
 #include <mach/lcd_dma.h>
 #else
diff --git a/arch/arm/mach-omap1/Kconfig b/arch/arm/mach-omap1/Kconfig
index cdd05f2e67ee..c5dbcebd8fdc 100644
--- a/arch/arm/mach-omap1/Kconfig
+++ b/arch/arm/mach-omap1/Kconfig
@@ -34,6 +34,11 @@ config ARCH_OMAP16XX
 comment "OMAP Board Type"
 	depends on ARCH_OMAP1
=20
+config OMAP1_PM
+	tristate
+	depends on PM
+	depends on BROKEN
+
 config MACH_OMAP_INNOVATOR
 	bool "TI Innovator"
 	depends on ARCH_OMAP1 && (ARCH_OMAP15XX || ARCH_OMAP16XX)
diff --git a/arch/arm/mach-omap1/Makefile b/arch/arm/mach-omap1/Makefil=
e
index 3889b6cd211e..4a80fcd9528e 100644
--- a/arch/arm/mach-omap1/Makefile
+++ b/arch/arm/mach-omap1/Makefile
@@ -17,7 +17,7 @@ obj-$(CONFIG_OMAP_32K_TIMER)	+=3D timer32k.o
 obj-$(CONFIG_ARCH_OMAP16XX) +=3D ocpi.o
=20
 # Power Management
-obj-$(CONFIG_PM) +=3D pm.o sleep.o
+obj-$(CONFIG_OMAP1_PM) +=3D pm.o sleep.o
=20
 i2c-omap-$(CONFIG_I2C_OMAP)		:=3D i2c.o
 obj-y					+=3D $(i2c-omap-m) $(i2c-omap-y)
diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index e7189dcc9309..8a670f374638 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -11,6 +11,16 @@ config ARCH_OMAP2
 	select CPU_V6
 	select SOC_HAS_OMAP2_SDRC
=20
+config OMAP2_PM24XX
+	bool
+	depends on ARCH_OMAP2
+	depends on BROKEN
+
+config OMAP2_PM34XX
+	bool
+	depends on ARCH_OMAP3
+	depends on BROKEN
+
 config ARCH_OMAP3
 	bool "TI OMAP3"
 	depends on ARCH_MULTI_V7
diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefil=
e
index 69bbcba8842f..9b88e8083b22 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -84,9 +84,9 @@ endif
 obj-$(CONFIG_OMAP_PM_NOOP)		+=3D omap-pm-noop.o
=20
 ifeq ($(CONFIG_PM),y)
-obj-$(CONFIG_ARCH_OMAP2)		+=3D pm24xx.o
-obj-$(CONFIG_ARCH_OMAP2)		+=3D sleep24xx.o
-obj-$(CONFIG_ARCH_OMAP3)		+=3D pm34xx.o sleep34xx.o
+obj-$(CONFIG_OMAP2_PM24XX)		+=3D pm24xx.o
+obj-$(CONFIG_OMAP2_PM24XX)		+=3D sleep24xx.o
+obj-$(CONFIG_OMAP3_PM34XX)		+=3D pm34xx.o sleep34xx.o
 obj-$(CONFIG_ARCH_OMAP4)		+=3D pm44xx.o omap-mpuss-lowpower.o
 obj-$(CONFIG_SOC_OMAP5)			+=3D omap-mpuss-lowpower.o
 obj-$(CONFIG_SOC_DRA7XX)		+=3D omap-mpuss-lowpower.o
diff --git a/arch/arm/plat-omap/Makefile b/arch/arm/plat-omap/Makefile
index 0b01b68fd033..07c45d60a026 100644
--- a/arch/arm/plat-omap/Makefile
+++ b/arch/arm/plat-omap/Makefile
@@ -5,7 +5,8 @@
 ccflags-$(CONFIG_ARCH_MULTIPLATFORM) :=3D -I$(srctree)/arch/arm/plat-o=
map/include
=20
 # Common support
-obj-y :=3D sram.o dma.o counter_32k.o
+obj-y :=3D sram.o counter_32k.o
+obj-$(CONFIG_BROKEN) :=3D dma.o
 obj-m :=3D
 obj-n :=3D
 obj-  :=3D
diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index 9b1ea0ef59af..8f297523ba0f 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -321,6 +321,7 @@ config MMP_TDMA
 config DMA_OMAP
 	tristate "OMAP DMA support"
 	depends on ARCH_OMAP
+	depends on BROKEN
 	select DMA_ENGINE
 	select DMA_VIRTUAL_CHANNELS
=20
diff --git a/drivers/media/platform/Kconfig b/drivers/media/platform/Kc=
onfig
index bee9074ebc13..63a87448ac83 100644
--- a/drivers/media/platform/Kconfig
+++ b/drivers/media/platform/Kconfig
@@ -97,6 +97,7 @@ config VIDEO_OMAP3
 	tristate "OMAP 3 Camera support"
 	depends on VIDEO_V4L2 && I2C && VIDEO_V4L2_SUBDEV_API && ARCH_OMAP3
 	depends on HAS_DMA
+	depends on BROKEN
 	select ARM_DMA_USE_IOMMU
 	select OMAP_IOMMU
 	select VIDEOBUF2_DMA_CONTIG
diff --git a/drivers/media/platform/omap/Kconfig b/drivers/media/platfo=
rm/omap/Kconfig
index 05de442d24e4..d4a3c6170907 100644
--- a/drivers/media/platform/omap/Kconfig
+++ b/drivers/media/platform/omap/Kconfig
@@ -4,6 +4,7 @@ config VIDEO_OMAP2_VOUT_VRFB
 config VIDEO_OMAP2_VOUT
 	tristate "OMAP2/OMAP3 V4L2-Display driver"
 	depends on ARCH_OMAP2 || ARCH_OMAP3 || (COMPILE_TEST && HAS_MMU)
+	depends on BROKEN
 	select VIDEOBUF_GEN
 	select VIDEOBUF_DMA_CONTIG
 	select OMAP2_DSS if HAS_IOMEM && ARCH_OMAP2PLUS
diff --git a/drivers/media/platform/soc_camera/Kconfig b/drivers/media/=
platform/soc_camera/Kconfig
index 6af6c6dccda8..52afbdd2b915 100644
--- a/drivers/media/platform/soc_camera/Kconfig
+++ b/drivers/media/platform/soc_camera/Kconfig
@@ -65,6 +65,7 @@ config VIDEO_OMAP1
 	depends on VIDEO_DEV && SOC_CAMERA
 	depends on ARCH_OMAP1 || COMPILE_TEST
 	depends on HAS_DMA
+	depends on BROKEN
 	select VIDEOBUF_DMA_CONTIG
 	select VIDEOBUF_DMA_SG
 	---help---
diff --git a/drivers/mtd/onenand/Kconfig b/drivers/mtd/onenand/Kconfig
index dcae2f6a2b11..2155c081e7ea 100644
--- a/drivers/mtd/onenand/Kconfig
+++ b/drivers/mtd/onenand/Kconfig
@@ -26,6 +26,7 @@ config MTD_ONENAND_GENERIC
 config MTD_ONENAND_OMAP2
 	tristate "OneNAND on OMAP2/OMAP3 support"
 	depends on ARCH_OMAP2 || ARCH_OMAP3
+	depends on BROKEN
 	help
 	  Support for a OneNAND flash device connected to an OMAP2/OMAP3 CPU
 	  via the GPMC memory controller.
diff --git a/drivers/usb/gadget/udc/Kconfig b/drivers/usb/gadget/udc/Kc=
onfig
index 5151f947a4f5..66216d1e3c22 100644
--- a/drivers/usb/gadget/udc/Kconfig
+++ b/drivers/usb/gadget/udc/Kconfig
@@ -29,6 +29,11 @@ menu "USB Peripheral Controller"
 # Integrated controllers
 #
=20
+config UDC_OMAP
+	tristate
+	depends on USB_OMAP
+	depends on BROKEN
+
 config USB_AT91
 	tristate "Atmel AT91 USB Device Port"
 	depends on ARCH_AT91
diff --git a/drivers/usb/gadget/udc/Makefile b/drivers/usb/gadget/udc/M=
akefile
index 4096122bb283..9b14964adccd 100644
--- a/drivers/usb/gadget/udc/Makefile
+++ b/drivers/usb/gadget/udc/Makefile
@@ -9,7 +9,7 @@ obj-$(CONFIG_USB_AMD5536UDC)	+=3D amd5536udc.o
 obj-$(CONFIG_USB_PXA25X)	+=3D pxa25x_udc.o
 obj-$(CONFIG_USB_PXA27X)	+=3D pxa27x_udc.o
 obj-$(CONFIG_USB_GOKU)		+=3D goku_udc.o
-obj-$(CONFIG_USB_OMAP)		+=3D omap_udc.o
+obj-$(CONFIG_UDC_OMAP)		+=3D omap_udc.o
 obj-$(CONFIG_USB_S3C2410)	+=3D s3c2410_udc.o
 obj-$(CONFIG_USB_AT91)		+=3D at91_udc.o
 obj-$(CONFIG_USB_ATMEL_USBA)	+=3D atmel_usba_udc.o
diff --git a/drivers/usb/musb/Kconfig b/drivers/usb/musb/Kconfig
index 06cc5d6ea681..13c3e3767938 100644
--- a/drivers/usb/musb/Kconfig
+++ b/drivers/usb/musb/Kconfig
@@ -147,6 +147,7 @@ config USB_TUSB_OMAP_DMA
 	bool 'TUSB 6010'
 	depends on USB_MUSB_TUSB6010 =3D USB_MUSB_HDRC # both built-in or bot=
h modules
 	depends on ARCH_OMAP
+	depends on BROKEN
 	help
 	  Enable DMA transfers on TUSB 6010 when OMAP DMA is available.
=20
diff --git a/drivers/video/fbdev/omap/Kconfig b/drivers/video/fbdev/oma=
p/Kconfig
index 18c4cb0d5690..c0a6d208c6e3 100644
--- a/drivers/video/fbdev/omap/Kconfig
+++ b/drivers/video/fbdev/omap/Kconfig
@@ -2,6 +2,7 @@ config FB_OMAP
 	tristate "OMAP frame buffer support"
 	depends on FB
 	depends on ARCH_OMAP1
+	depends on BROKEN
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
