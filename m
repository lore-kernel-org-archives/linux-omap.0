From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 01/11] ARM: OMAP2+: hwmod: add setup_preprogram hook
Date: Thu, 07 Jun 2012 00:13:06 -0600
Message-ID: <20120607061303.25532.65533.stgit@dusk>
References: <20120607060901.25532.68354.stgit@dusk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:60867 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759931Ab2FGGVg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Jun 2012 02:21:36 -0400
In-Reply-To: <20120607060901.25532.68354.stgit@dusk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: =?utf-8?b?UMOpdGVy?= Ujfalusi <peter.ujfalusi@ti.com>, =?utf-8?q?Beno=C3=AEt?= Cousson <b-cousson@ti.com>

After reset, some IP blocks cannot indicate to the PRCM that they are
inactive until they are configured.  One example on OMAP4 is the AESS
IP block.

To fix this cleanly, this patch adds another optional function
pointer, setup_preprogram, to the IP block's hwmod data.  The function
that is pointed to is called by the hwmod code immediately after the
IP block is reset.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Beno=C3=AEt Cousson <b-cousson@ti.com>
Cc: P=C3=A9ter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod.c             |   21 ++++++++++++++++++=
++-
 arch/arm/plat-omap/include/plat/omap_hwmod.h |    9 +++++++++
 2 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/oma=
p_hwmod.c
index bf86f7e..b0d3064 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -2103,6 +2103,23 @@ static void __init _setup_iclk_autoidle(struct o=
map_hwmod *oh)
 }
=20
 /**
+ * _setup_preprogram - Pre-program an IP block during the _setup() pro=
cess
+ * @oh: struct omap_hwmod *
+ *
+ * Some IP blocks (such as AESS) require some additional programming
+ * after reset before they can enter idle.  If a function pointer to
+ * do so is present in the hwmod data, then call it and pass along the
+ * return value; otherwise, return 0.
+ */
+static int __init _setup_preprogram(struct omap_hwmod *oh)
+{
+	if (!oh->class->setup_preprogram)
+		return 0;
+
+	return oh->class->setup_preprogram(oh);
+}
+
+/**
  * _setup_reset - reset an IP block during the setup process
  * @oh: struct omap_hwmod *
  *
@@ -2224,8 +2241,10 @@ static int __init _setup(struct omap_hwmod *oh, =
void *data)
=20
 	_setup_iclk_autoidle(oh);
=20
-	if (!_setup_reset(oh))
+	if (!_setup_reset(oh)) {
+		_setup_preprogram(oh);
 		_setup_postsetup(oh);
+	}
=20
 	return 0;
 }
diff --git a/arch/arm/plat-omap/include/plat/omap_hwmod.h b/arch/arm/pl=
at-omap/include/plat/omap_hwmod.h
index c835b71..fdc4b2a 100644
--- a/arch/arm/plat-omap/include/plat/omap_hwmod.h
+++ b/arch/arm/plat-omap/include/plat/omap_hwmod.h
@@ -458,6 +458,7 @@ struct omap_hwmod_omap4_prcm {
  * @rev: revision of the IP class
  * @pre_shutdown: ptr to fn to be executed immediately prior to device=
 shutdown
  * @reset: ptr to fn to be executed in place of the standard hwmod res=
et fn
+ * @setup_preprogram: ptr to fn to be executed after the reset in _set=
up()
  *
  * Represent the class of a OMAP hardware "modules" (e.g. timer,
  * smartreflex, gpio, uart...)
@@ -474,6 +475,13 @@ struct omap_hwmod_omap4_prcm {
  * executed in place of the standard hwmod _reset() code in
  * mach-omap2/omap_hwmod.c.  This is needed for IP blocks which have
  * unusual reset sequences - usually processor IP blocks like the IVA.
+ *
+ * @setup_preprogram is called between the calls to _setup_reset() and
+ * _setup_postsetup().  It is intended to be used for IP blocks that
+ * require some initial configuration during their first
+ * initialization.  (For example, the AESS IP block on OMAP4+ cannot
+ * enter idle until its internal autogating bit is set.)  Most IP bloc=
ks
+ * will not need this.
  */
 struct omap_hwmod_class {
 	const char				*name;
@@ -481,6 +489,7 @@ struct omap_hwmod_class {
 	u32					rev;
 	int					(*pre_shutdown)(struct omap_hwmod *oh);
 	int					(*reset)(struct omap_hwmod *oh);
+	int					(*setup_preprogram)(struct omap_hwmod *oh);
 };
=20
 /**


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
