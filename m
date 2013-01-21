From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v2 0/5] ARM: OMAP4: Enable AESS IP.
Date: Mon, 21 Jan 2013 01:54:17 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1301210152220.31667@utopia.booyaka.com>
References: <1357743792-13917-1-git-send-email-s-guiriec@ti.com> <50F9608A.8060102@ti.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="843723315-1163892296-1358733257=:31667"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:60505 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752593Ab3AUByS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 20 Jan 2013 20:54:18 -0500
In-Reply-To: <50F9608A.8060102@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sebastien Guiriec <s-guiriec@ti.com>, balbi@ti.com
Cc: =?ISO-8859-15?Q?Beno=EEt_Cousson?= <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Peter Ujfalusi <peter.ujfalusi@ti.com>, Tero Kristo <t-kristo@ti.com>, Jon Hunter <jon-hunter@ti.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--843723315-1163892296-1358733257=:31667
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Fri, 18 Jan 2013, Sebastien Guiriec wrote:

> Paul, Benoit,
>=20
> Any comments before I resend the serie with the minor comment for Felipe?

Not from me.  The series has been queued for 3.9 with Felipe's comment=20
fix; thanks Felipe.


- Paul

From: Paul Walmsley <paul@pwsan.com>
Date: Sun, 20 Jan 2013 18:52:09 -0700
Subject: [PATCH] ARM: OMAP2+: hwmod: add enable_preprogram hook

After setup/enable, some IP blocks need some additional setting to
indicate the PRCM that they are inactive until they are configured.
Some examples on OMAP4 include the AESS and FSUSB IP blocks.

To fix this cleanly, this patch adds another optional function
pointer, enable_preprogram, to the IP block's hwmod data.  The function
that is pointed to is called by the hwmod code immediately after the
IP block is reset.

This version of the patch includes a patch description fix from Felipe.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Sebastien Guiriec <s-guiriec@ti.com>
Cc: Beno=EEt Cousson <b-cousson@ti.com>
Cc: P=E9ter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Felipe Balbi <balbi@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod.c |   18 ++++++++++++++++++
 arch/arm/mach-omap2/omap_hwmod.h |    2 ++
 2 files changed, 20 insertions(+)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hw=
mod.c
index 4653efb..f37d22c 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -2053,6 +2053,23 @@ static int _omap4_get_context_lost(struct omap_hwmod=
 *oh)
 }
=20
 /**
+ * _enable_preprogram - Pre-program an IP block during the _enable() proce=
ss
+ * @oh: struct omap_hwmod *
+ *
+ * Some IP blocks (such as AESS) require some additional programming
+ * after enable before they can enter idle.  If a function pointer to
+ * do so is present in the hwmod data, then call it and pass along the
+ * return value; otherwise, return 0.
+ */
+static int __init _enable_preprogram(struct omap_hwmod *oh)
+{
+=09if (!oh->class->enable_preprogram)
+=09=09return 0;
+
+=09return oh->class->enable_preprogram(oh);
+}
+
+/**
  * _enable - enable an omap_hwmod
  * @oh: struct omap_hwmod *
  *
@@ -2156,6 +2173,7 @@ static int _enable(struct omap_hwmod *oh)
 =09=09=09=09_update_sysc_cache(oh);
 =09=09=09_enable_sysc(oh);
 =09=09}
+=09=09r =3D _enable_preprogram(oh);
 =09} else {
 =09=09if (soc_ops.disable_module)
 =09=09=09soc_ops.disable_module(oh);
diff --git a/arch/arm/mach-omap2/omap_hwmod.h b/arch/arm/mach-omap2/omap_hw=
mod.h
index 3ae852a..41066b4 100644
--- a/arch/arm/mach-omap2/omap_hwmod.h
+++ b/arch/arm/mach-omap2/omap_hwmod.h
@@ -501,6 +501,7 @@ struct omap_hwmod_omap4_prcm {
  * @rev: revision of the IP class
  * @pre_shutdown: ptr to fn to be executed immediately prior to device shu=
tdown
  * @reset: ptr to fn to be executed in place of the standard hwmod reset f=
n
+ * @enable_preprogram:  ptr to fn to be executed during device enable
  *
  * Represent the class of a OMAP hardware "modules" (e.g. timer,
  * smartreflex, gpio, uart...)
@@ -524,6 +525,7 @@ struct omap_hwmod_class {
 =09u32=09=09=09=09=09rev;
 =09int=09=09=09=09=09(*pre_shutdown)(struct omap_hwmod *oh);
 =09int=09=09=09=09=09(*reset)(struct omap_hwmod *oh);
+=09int=09=09=09=09=09(*enable_preprogram)(struct omap_hwmod *oh);
 };
=20
 /**
--=20
1.7.10.4

--843723315-1163892296-1358733257=:31667--
