From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 11/11] OMAP: hwmod: add an hardreset API for use by other core
	code
Date: Tue, 21 Sep 2010 10:34:54 -0600
Message-ID: <20100921163453.20258.55542.stgit@twilight.localdomain>
References: <20100921163021.20258.87587.stgit@twilight.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:47056 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757968Ab0IUQfl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 21 Sep 2010 12:35:41 -0400
In-Reply-To: <20100921163021.20258.87587.stgit@twilight.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: =?utf-8?q?Beno=C3=AEt?= Cousson <b-cousson@ti.com>

Expose an hardreset API from hwmod in order to assert / deassert all th=
e
individual reset lines that belong to an hwmod.  This API is needed by
some of the more complicated processor drivers, e.g., DSP/Bridge,
Syslink, etc.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Beno=C3=AEt Cousson <b-cousson@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod.c             |   78 ++++++++++++++++++=
++++++++
 arch/arm/plat-omap/include/plat/omap_hwmod.h |    4 +
 2 files changed, 82 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/oma=
p_hwmod.c
index 3e90984..8c27923 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -1829,6 +1829,84 @@ int omap_hwmod_disable_wakeup(struct omap_hwmod =
*oh)
 }
=20
 /**
+ * omap_hwmod_assert_hardreset - assert the HW reset line of submodule=
s
+ * contained in the hwmod module.
+ * @oh: struct omap_hwmod *
+ * @name: name of the reset line to lookup and assert
+ *
+ * Some IP like dsp, ipu or iva contain processor that require
+ * an HW reset line to be assert / deassert in order to enable fully
+ * the IP.  Returns -EINVAL if @oh is null or if the operation is not
+ * yet supported on this OMAP; otherwise, passes along the return valu=
e
+ * from _assert_hardreset().
+ */
+int omap_hwmod_assert_hardreset(struct omap_hwmod *oh, const char *nam=
e)
+{
+	int ret;
+
+	if (!oh)
+		return -EINVAL;
+
+	mutex_lock(&oh->_mutex);
+	ret =3D _assert_hardreset(oh, name);
+	mutex_unlock(&oh->_mutex);
+
+	return ret;
+}
+
+/**
+ * omap_hwmod_deassert_hardreset - deassert the HW reset line of submo=
dules
+ * contained in the hwmod module.
+ * @oh: struct omap_hwmod *
+ * @name: name of the reset line to look up and deassert
+ *
+ * Some IP like dsp, ipu or iva contain processor that require
+ * an HW reset line to be assert / deassert in order to enable fully
+ * the IP.  Returns -EINVAL if @oh is null or if the operation is not
+ * yet supported on this OMAP; otherwise, passes along the return valu=
e
+ * from _deassert_hardreset().
+ */
+int omap_hwmod_deassert_hardreset(struct omap_hwmod *oh, const char *n=
ame)
+{
+	int ret;
+
+	if (!oh)
+		return -EINVAL;
+
+	mutex_lock(&oh->_mutex);
+	ret =3D _deassert_hardreset(oh, name);
+	mutex_unlock(&oh->_mutex);
+
+	return ret;
+}
+
+/**
+ * omap_hwmod_read_hardreset - read the HW reset line state of submodu=
les
+ * contained in the hwmod module
+ * @oh: struct omap_hwmod *
+ * @name: name of the reset line to look up and read
+ *
+ * Return the current state of the hwmod @oh's reset line named @name:
+ * returns -EINVAL upon parameter error or if this operation
+ * is unsupported on the current OMAP; otherwise, passes along the ret=
urn
+ * value from _read_hardreset().
+ */
+int omap_hwmod_read_hardreset(struct omap_hwmod *oh, const char *name)
+{
+	int ret;
+
+	if (!oh)
+		return -EINVAL;
+
+	mutex_lock(&oh->_mutex);
+	ret =3D _read_hardreset(oh, name);
+	mutex_unlock(&oh->_mutex);
+
+	return ret;
+}
+
+
+/**
  * omap_hwmod_for_each_by_class - call @fn for each hwmod of class @cl=
assname
  * @classname: struct omap_hwmod_class name to search for
  * @fn: callback function pointer to call for each hwmod in class @cla=
ssname
diff --git a/arch/arm/plat-omap/include/plat/omap_hwmod.h b/arch/arm/pl=
at-omap/include/plat/omap_hwmod.h
index 590bfae..7fde44d 100644
--- a/arch/arm/plat-omap/include/plat/omap_hwmod.h
+++ b/arch/arm/plat-omap/include/plat/omap_hwmod.h
@@ -512,6 +512,10 @@ int omap_hwmod_idle(struct omap_hwmod *oh);
 int _omap_hwmod_idle(struct omap_hwmod *oh);
 int omap_hwmod_shutdown(struct omap_hwmod *oh);
=20
+int omap_hwmod_assert_hardreset(struct omap_hwmod *oh, const char *nam=
e);
+int omap_hwmod_deassert_hardreset(struct omap_hwmod *oh, const char *n=
ame);
+int omap_hwmod_read_hardreset(struct omap_hwmod *oh, const char *name)=
;
+
 int omap_hwmod_enable_clocks(struct omap_hwmod *oh);
 int omap_hwmod_disable_clocks(struct omap_hwmod *oh);
=20


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
