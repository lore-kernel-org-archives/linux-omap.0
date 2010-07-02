From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 13/20] OMAP: hwmod data: add class for IVA hwmods
Date: Fri, 02 Jul 2010 09:29:34 -0600
Message-ID: <20100702152932.6221.98446.stgit@localhost.localdomain>
References: <20100702152703.6221.33529.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:45296 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758901Ab0GBPbF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 2 Jul 2010 11:31:05 -0400
In-Reply-To: <20100702152703.6221.33529.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Kevin Hilman <khilman@deeprootsystems.com>, =?utf-8?q?Beno=C3=AEt?= Cousson <b-cousson@ti.com>

=46rom: Kevin Hilman <khilman@deeprootsystems.com>

Add a new hwmod class for IVA devices.  To be used when hwmods
are created for IVA2 on OMAP3.

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Beno=C3=AEt Cousson <b-cousson@ti.com>
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/omap_hwmod_common_data.c |    3 +++
 arch/arm/mach-omap2/omap_hwmod_common_data.h |    1 +
 2 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_common_data.c b/arch/arm/ma=
ch-omap2/omap_hwmod_common_data.c
index 1e80b91..08a1342 100644
--- a/arch/arm/mach-omap2/omap_hwmod_common_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_common_data.c
@@ -66,3 +66,6 @@ struct omap_hwmod_class mpu_hwmod_class =3D {
 	.name =3D "mpu"
 };
=20
+struct omap_hwmod_class iva_hwmod_class =3D {
+	.name =3D "iva"
+};
diff --git a/arch/arm/mach-omap2/omap_hwmod_common_data.h b/arch/arm/ma=
ch-omap2/omap_hwmod_common_data.h
index 3645a28..c34e98b 100644
--- a/arch/arm/mach-omap2/omap_hwmod_common_data.h
+++ b/arch/arm/mach-omap2/omap_hwmod_common_data.h
@@ -20,5 +20,6 @@
 extern struct omap_hwmod_class l3_hwmod_class;
 extern struct omap_hwmod_class l4_hwmod_class;
 extern struct omap_hwmod_class mpu_hwmod_class;
+extern struct omap_hwmod_class iva_hwmod_class;
=20
 #endif


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
