From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: [PATCH v7 5/5] OMAP: McBSP: Split and move read/write functions to mach-omap1/2
Date: Wed, 9 Dec 2009 21:34:30 +0100
Message-ID: <200912092134.32015.jkrzyszt@tis.icnet.pl>
References: <200912092124.14430.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from d1.icnet.pl ([212.160.220.21]:39327 "EHLO d1.icnet.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755137AbZLIUeP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 Dec 2009 15:34:15 -0500
In-Reply-To: <200912092124.14430.jkrzyszt@tis.icnet.pl>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Jarkko Nikula <jhnikula@gmail.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, linux-omap@vger.kernel.org

Split omap_mcbsp_read()/_write() functions logic into omap1 and omap2/3=
/4
parts, then move them out of plat-omap/mcbsp.c into mach-omap1/mcbsp.c =
and
mach-omap2/mcbsp.c respectively, to leave some of the "if cpu_is_omapxx=
xx()
else" stuff.

Applies on top of patch 4 from this series:
[PATCH v7 4/5] OMAP: McBSP: Use cache when modifying individual registe=
r bits

Tested on OMAP1510 based Amstrad Delta using linux-omap for-next,
commit 82f1d8f22f2c65e70206e40a6f17688bf64a892c.
Compile-tested with omap_generic_2420_defconfig and omap_3430sdp_defcon=
fig.

Signed-off-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>

---
Wednesday 09 December 2009 00:39:16 Tony Lindgren napisa=C5=82(a):
> * Tony Lindgren <tony@atomide.com> [091208 15:32]:
> > * Janusz Krzysztofik <jkrzyszt@tis.icnet.pl> [091208 11:45]:
> > > Tuesday 08 December 2009 17:59:31 Tony Lindgren napisa=C5=82(a):
> > > >
> > > > Actually since we already have mach-omap1/mcbsp.c and
> > > > mach-omap2/mcbsp.c, it would be best to pass the cache size fro=
m
> > > > omap1_mcbsp_init and omap2_mcbsp_init. That leaves some of the =
if
> > > > cpu_is_omapxxxx() else stuff.
> > >
> > > Tony,
> > > Almost ready with it, one more question: what do you think about
> > > splitting and moving omap_mcbsp_read()/_write() there as well? If=
 you
> > > agree, should I submit 2 patches, one with this cleanup, the othe=
r one
> > > actually introducing cache support, or is one combined OK?
> >
> > Sounds good to me!
>
> Oh sorry forgot to reply to your question. If a single patch looks
> unreadable, then split it into two where the first patch splits
> omap_mcbsp_read/write.

Tony,
Since this one is new, in order to not block the 4 preceding patches th=
at do
not really need this one, I decided to create this additional cleanup a=
s the
last one in the series, to be dropped easily if not accepted for any pr=
oblems
with it.

Thanks,
Janusz

 arch/arm/mach-omap1/mcbsp.c             |   12 ++++++++++++
 arch/arm/mach-omap2/mcbsp.c             |   22 ++++++++++++++++++++++
 arch/arm/plat-omap/include/plat/mcbsp.h |    3 +++
 arch/arm/plat-omap/mcbsp.c              |   28 -----------------------=
-----
 4 files changed, 37 insertions(+), 28 deletions(-)

diff -upr git.orig/arch/arm/mach-omap1/mcbsp.c git/arch/arm/mach-omap1/=
mcbsp.c
--- git.orig/arch/arm/mach-omap1/mcbsp.c	2009-12-09 15:49:52.000000000 =
+0100
+++ git/arch/arm/mach-omap1/mcbsp.c	2009-12-09 16:20:43.000000000 +0100
@@ -31,6 +31,18 @@ static int dsp_use;
 static struct clk *api_clk;
 static struct clk *dsp_clk;
=20
+void omap_mcbsp_write(struct omap_mcbsp *mcbsp, u16 reg, u32 val)
+{
+	((u16 *)mcbsp->reg_cache)[reg / sizeof(u16)] =3D (u16)val;
+	__raw_writew((u16)val, mcbsp->io_base + reg);
+}
+
+int omap_mcbsp_read(struct omap_mcbsp *mcbsp, u16 reg, bool from_cache=
)
+{
+	return !from_cache ? __raw_readw(mcbsp->io_base + reg) :
+			((u16 *)mcbsp->reg_cache)[reg / sizeof(u16)];
+}
+
 static void omap1_mcbsp_request(unsigned int id)
 {
 	/*
diff -upr git.orig/arch/arm/mach-omap2/mcbsp.c git/arch/arm/mach-omap2/=
mcbsp.c
--- git.orig/arch/arm/mach-omap2/mcbsp.c	2009-12-09 15:49:52.000000000 =
+0100
+++ git/arch/arm/mach-omap2/mcbsp.c	2009-12-09 16:20:43.000000000 +0100
@@ -23,6 +23,28 @@
 #include <plat/cpu.h>
 #include <plat/mcbsp.h>
=20
+void omap_mcbsp_write(struct omap_mcbsp *mcbsp, u16 reg, u32 val)
+{
+	if (cpu_is_omap2420()) {
+		((u16 *)mcbsp->reg_cache)[reg / sizeof(u32)] =3D (u16)val;
+		__raw_writew((u16)val, mcbsp->io_base + reg);
+	} else {
+		((u32 *)mcbsp->reg_cache)[reg / sizeof(u32)] =3D val;
+		__raw_writel(val, mcbsp->io_base + reg);
+	}
+}
+
+int omap_mcbsp_read(struct omap_mcbsp *mcbsp, u16 reg, bool from_cache=
)
+{
+	if (cpu_is_omap2420()) {
+		return !from_cache ? __raw_readw(mcbsp->io_base + reg) :
+				((u16 *)mcbsp->reg_cache)[reg / sizeof(u32)];
+	} else {
+		return !from_cache ? __raw_readl(mcbsp->io_base + reg) :
+				((u32 *)mcbsp->reg_cache)[reg / sizeof(u32)];
+	}
+}
+
 static void omap2_mcbsp2_mux_setup(void)
 {
 	omap_cfg_reg(Y15_24XX_MCBSP2_CLKX);
diff -upr git.orig/arch/arm/plat-omap/include/plat/mcbsp.h git/arch/arm=
/plat-omap/include/plat/mcbsp.h
--- git.orig/arch/arm/plat-omap/include/plat/mcbsp.h	2009-12-09 15:49:5=
3.000000000 +0100
+++ git/arch/arm/plat-omap/include/plat/mcbsp.h	2009-12-09 16:20:43.000=
000000 +0100
@@ -420,6 +420,9 @@ struct omap_mcbsp {
 extern struct omap_mcbsp **mcbsp_ptr;
 extern int omap_mcbsp_count, omap_mcbsp_cache_size;
=20
+void omap_mcbsp_write(struct omap_mcbsp *mcbsp, u16 reg, u32 val);
+int omap_mcbsp_read(struct omap_mcbsp *mcbsp, u16 reg, bool from_cache=
);
+
 int omap_mcbsp_init(void);
 void omap_mcbsp_register_board_cfg(struct omap_mcbsp_platform_data *co=
nfig,
 					int size);
diff -upr git.orig/arch/arm/plat-omap/mcbsp.c git/arch/arm/plat-omap/mc=
bsp.c
--- git.orig/arch/arm/plat-omap/mcbsp.c	2009-12-09 16:20:29.000000000 +=
0100
+++ git/arch/arm/plat-omap/mcbsp.c	2009-12-09 16:20:43.000000000 +0100
@@ -30,34 +30,6 @@
 struct omap_mcbsp **mcbsp_ptr;
 int omap_mcbsp_count, omap_mcbsp_cache_size;
=20
-void omap_mcbsp_write(struct omap_mcbsp *mcbsp, u16 reg, u32 val)
-{
-	if (cpu_class_is_omap1()) {
-		((u16 *)mcbsp->reg_cache)[reg / sizeof(u16)] =3D (u16)val;
-		__raw_writew((u16)val, mcbsp->io_base + reg);
-	} else if (cpu_is_omap2420()) {
-		((u16 *)mcbsp->reg_cache)[reg / sizeof(u32)] =3D (u16)val;
-		__raw_writew((u16)val, mcbsp->io_base + reg);
-	} else {
-		((u32 *)mcbsp->reg_cache)[reg / sizeof(u32)] =3D val;
-		__raw_writel(val, mcbsp->io_base + reg);
-	}
-}
-
-int omap_mcbsp_read(struct omap_mcbsp *mcbsp, u16 reg, bool from_cache=
)
-{
-	if (cpu_class_is_omap1()) {
-		return !from_cache ? __raw_readw(mcbsp->io_base + reg) :
-				((u16 *)mcbsp->reg_cache)[reg / sizeof(u16)];
-	} else if (cpu_is_omap2420()) {
-		return !from_cache ? __raw_readw(mcbsp->io_base + reg) :
-				((u16 *)mcbsp->reg_cache)[reg / sizeof(u32)];
-	} else {
-		return !from_cache ? __raw_readl(mcbsp->io_base + reg) :
-				((u32 *)mcbsp->reg_cache)[reg / sizeof(u32)];
-	}
-}
-
 #define MCBSP_READ(mcbsp, reg) \
 		omap_mcbsp_read(mcbsp, OMAP_MCBSP_REG_##reg, 0)
 #define MCBSP_WRITE(mcbsp, reg, val) \
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
