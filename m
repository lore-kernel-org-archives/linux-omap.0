From: jp.francois@cynove.com
Subject: [PATCH] ARM : omap : remove __init for _enable_preprogram
Date: Tue, 14 May 2013 18:07:01 +0200
Message-ID: <1368547621-8570-1-git-send-email-jp.francois@cynove.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: khilman@linaro.org
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, paul@pwsan.com, stable@vger.kernel.org, =?UTF-8?q?Jean-Philippe=20Fran=C3=A7ois?= <jp.francois@cynove.com>
List-Id: linux-omap@vger.kernel.org

_enable_preprogram is marked as __init, but is called from _enable whic=
h is not.
This results in oops once init is freed.
=46ix this by removing the __init marker.

Signed-off-by: Jean-Philippe Fran=C3=A7ois <jp.francois@cynove.com>

Index: b/arch/arm/mach-omap2/omap_hwmod.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -2066,7 +2066,7 @@
  * do so is present in the hwmod data, then call it and pass along the
  * return value; otherwise, return 0.
  */
-static int __init _enable_preprogram(struct omap_hwmod *oh)
+static int _enable_preprogram(struct omap_hwmod *oh)
 {
 	if (!oh->class->enable_preprogram)
 		return 0;
