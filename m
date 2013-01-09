From: Sebastien Guiriec <s-guiriec@ti.com>
Subject: [PATCH v2 1/5] ARM: OMAP2+: hwmod: add enable_preprogram hook
Date: Wed, 9 Jan 2013 16:03:07 +0100
Message-ID: <1357743792-13917-2-git-send-email-s-guiriec@ti.com>
References: <1357743792-13917-1-git-send-email-s-guiriec@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:42938 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757995Ab3AIPDX (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 9 Jan 2013 10:03:23 -0500
In-Reply-To: <1357743792-13917-1-git-send-email-s-guiriec@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sebastien Guiriec <s-guiriec@ti.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Peter Ujfalusi <peter.ujfalusi@ti.com>, Liam Girdwood <lrg@ti.com>, Tero Kristo <t-kristo@ti.com>, Jon Hunter <jon-hunter@ti.com>, Felipe Balbi <balbi@ti.com>

=46rom: Paul Walmsley <paul@pwsan.com>

After setup/enable, some IP blocks need some additional setting to
indicate the PRCM that they are inactive until they are configured.
Some examples on OMAP4 include the AESS and FSUSB IP blocks.

To fix this cleanly, this patch adds another optional function
pointer, setup_preprogram, to the IP block's hwmod data.  The function
that is pointed to is called by the hwmod code immediately after the
IP block is reset.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Sebastien Guiriec <s-guiriec@ti.com>
Cc: Beno=C3=AEt Cousson <b-cousson@ti.com>
Cc: P=C3=A9ter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Felipe Balbi <balbi@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod.c |   18 ++++++++++++++++++
 arch/arm/mach-omap2/omap_hwmod.h |    2 ++
 2 files changed, 20 insertions(+)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/oma=
p_hwmod.c
index 4653efb..f37d22c 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -2053,6 +2053,23 @@ static int _omap4_get_context_lost(struct omap_h=
wmod *oh)
 }
=20
 /**
+ * _enable_preprogram - Pre-program an IP block during the _enable() p=
rocess
+ * @oh: struct omap_hwmod *
+ *
+ * Some IP blocks (such as AESS) require some additional programming
+ * after enable before they can enter idle.  If a function pointer to
+ * do so is present in the hwmod data, then call it and pass along the
+ * return value; otherwise, return 0.
+ */
+static int __init _enable_preprogram(struct omap_hwmod *oh)
+{
+	if (!oh->class->enable_preprogram)
+		return 0;
+
+	return oh->class->enable_preprogram(oh);
+}
+
+/**
  * _enable - enable an omap_hwmod
  * @oh: struct omap_hwmod *
  *
@@ -2156,6 +2173,7 @@ static int _enable(struct omap_hwmod *oh)
 				_update_sysc_cache(oh);
 			_enable_sysc(oh);
 		}
+		r =3D _enable_preprogram(oh);
 	} else {
 		if (soc_ops.disable_module)
 			soc_ops.disable_module(oh);
diff --git a/arch/arm/mach-omap2/omap_hwmod.h b/arch/arm/mach-omap2/oma=
p_hwmod.h
index 3ae852a..41066b4 100644
--- a/arch/arm/mach-omap2/omap_hwmod.h
+++ b/arch/arm/mach-omap2/omap_hwmod.h
@@ -501,6 +501,7 @@ struct omap_hwmod_omap4_prcm {
  * @rev: revision of the IP class
  * @pre_shutdown: ptr to fn to be executed immediately prior to device=
 shutdown
  * @reset: ptr to fn to be executed in place of the standard hwmod res=
et fn
+ * @enable_preprogram:  ptr to fn to be executed during device enable
  *
  * Represent the class of a OMAP hardware "modules" (e.g. timer,
  * smartreflex, gpio, uart...)
@@ -524,6 +525,7 @@ struct omap_hwmod_class {
 	u32					rev;
 	int					(*pre_shutdown)(struct omap_hwmod *oh);
 	int					(*reset)(struct omap_hwmod *oh);
+	int					(*enable_preprogram)(struct omap_hwmod *oh);
 };
=20
 /**
--=20
1.7.10.4

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
