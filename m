From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 9/9] ARM: OMAP2+: hwmod: extend OCP_* register offsets from 16
 to 32 bits
Date: Tue, 28 Feb 2012 04:10:57 -0700
Message-ID: <20120228111056.808.87964.stgit@dusk>
References: <20120228110943.808.73639.stgit@dusk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:35190 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965190Ab2B1LLf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 28 Feb 2012 06:11:35 -0500
In-Reply-To: <20120228110943.808.73639.stgit@dusk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: =?utf-8?q?Beno=C3=AEt?= Cousson <b-cousson@ti.com>

Extend the OCP_* register offsets in the struct
omap_hwmod_class_sysconfig to 32 bits.  This is required to add the
OMAP4+ GPU hwmod, which uses OCP_* register offsets larger than 16
bits.

Another possible solution may be to simply add a single 16 bit offset
field in this structure, and to add code to factor that offset into
all OCP_* register accesses.  This would save some memory, since
almost no modules need 32 bit offsets.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Beno=C3=AEt Cousson <b-cousson@ti.com>
---
 arch/arm/plat-omap/include/plat/omap_hwmod.h |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/omap_hwmod.h b/arch/arm/pl=
at-omap/include/plat/omap_hwmod.h
index f0a0711..083b6da 100644
--- a/arch/arm/plat-omap/include/plat/omap_hwmod.h
+++ b/arch/arm/plat-omap/include/plat/omap_hwmod.h
@@ -328,9 +328,9 @@ struct omap_hwmod_sysc_fields {
  * then this field has to be populated with the correct offset structu=
re.
  */
 struct omap_hwmod_class_sysconfig {
-	u16 rev_offs;
-	u16 sysc_offs;
-	u16 syss_offs;
+	u32 rev_offs;
+	u32 sysc_offs;
+	u32 syss_offs;
 	u16 sysc_flags;
 	struct omap_hwmod_sysc_fields *sysc_fields;
 	u8 srst_udelay;


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
