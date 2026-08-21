Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3330A4334CA
	for <linux-omap@vger.kernel.org>; Fri, 21 Aug 2026 08:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787300052; cv=none; b=p5JLRmQLfhn/ikGf0SoMQbnbShuQort61/9dNFOVTmZCNinvh0uMM1Y+vi7TBMNP95sZy2ci2JZma0GEO9mGYO7dkETVe688q7Es2Pczl0xg9jwLzM2MenuqulJuAGevBbnml3CqtGiYBW+TGgHZIdHVKZuN/gMDdF0Tm+NIV9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787300052; c=relaxed/simple;
	bh=mT24nnk/I1Ij9QrLvfDGHsOQ/vipjk4FsG8df0huinQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pltm1j0BhaygYqxdrQNNoSEnZsqCtTapaqePmwrcO57iO8UXZqER3ZAw8KTu6sTSNS+7mhcs4GU0ZFKIAaQROGLaIt630Fibe0hJYdJ0WqiLTbfvZC6TqQcejOruPhdK/IrNUXu9COFPR6C6zKlx1rFk2LORfmFEHn8qiwc9qcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eTHZT69O; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eTHZT69O"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787300049;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=9dHyc6OyWyfr6wGCZseIDHPnwffk4iAkg01WX+1mfkE=;
	b=eTHZT69OjAe5oxeHaDD+dcB3Rh4b784T3lKiFba29ZjVDrsUxifDSlG3HvK6oVyp5Ofe04
	uTdX8EsDrxkOfWPaW/TY7OLOiusgzv0L7RHl2XZvNu71RVmppmoZRYR29Olp4Wx9BU+usp
	Crpxa3fTDLEWE65RlseSJUmsIQNFNvA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-650-d0cUIMXaOmudE7mjPq5s-Q-1; Fri,
 21 Aug 2026 04:14:04 -0400
X-MC-Unique: d0cUIMXaOmudE7mjPq5s-Q-1
X-Mimecast-MFC-AGG-ID: d0cUIMXaOmudE7mjPq5s-Q_1787300043
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 203E91800149;
	Fri, 21 Aug 2026 08:14:03 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.32.129])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E9190180034C;
	Fri, 21 Aug 2026 08:13:58 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Aaro Koskinen <aaro.koskinen@iki.fi>,
	Andreas Kemnade <andreas@kemnade.info>,
	Kevin Hilman <khilman@baylibre.com>,
	Roger Quadros <rogerq@kernel.org>,
	Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: OMAP2+: Replace __ASSEMBLY__ with __ASSEMBLER__
Date: Fri, 21 Aug 2026 10:13:56 +0200
Message-ID: <20260821081356.165038-1-thuth@redhat.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

While the GCC and Clang compilers already define __ASSEMBLER__ auto-
matically when compiling assembly code, __ASSEMBLY__ is a macro that
only gets defined by the Makefiles in the kernel. This can be very
confusing when switching between userspace and kernelspace coding, or
when dealing with uapi headers that rather should use __ASSEMBLER__
instead. Let's standardize now on the __ASSEMBLER__ macro to avoid
this confusion.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 Note: This has been split from an earlier bigger patch of mine into
       this separate patch to ease reviewing

 arch/arm/mach-omap2/control.h | 8 ++++----
 arch/arm/mach-omap2/soc.h     | 4 ++--
 arch/arm/mach-omap2/sram.h    | 4 ++--
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-omap2/control.h b/arch/arm/mach-omap2/control.h
index 7e7440533bf90..e4f4b16958084 100644
--- a/arch/arm/mach-omap2/control.h
+++ b/arch/arm/mach-omap2/control.h
@@ -18,7 +18,7 @@
 
 #include "am33xx.h"
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 #define OMAP242X_CTRL_REGADDR(reg)					\
 		OMAP2_L4_IO_ADDRESS(OMAP242X_CTRL_BASE + (reg))
 #define OMAP243X_CTRL_REGADDR(reg)					\
@@ -36,7 +36,7 @@
 		OMAP2_L4_IO_ADDRESS(OMAP343X_CTRL_BASE + (reg))
 #define AM33XX_CTRL_REGADDR(reg)					\
 		AM33XX_L4_WK_IO_ADDRESS(AM33XX_SCM_BASE + (reg))
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 /*
  * As elsewhere, the "OMAP2_" prefix indicates that the macro is valid for
@@ -503,7 +503,7 @@
 #define		FEAT_NEON_NONE		1
 
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 #ifdef CONFIG_ARCH_OMAP2PLUS
 extern u8 omap_ctrl_readb(u16 offset);
 extern u16 omap_ctrl_readw(u16 offset);
@@ -534,7 +534,7 @@ int omap_control_init(void);
 #define omap_ctrl_writel(x, y)		WARN_ON(1)
 #define omap4_ctrl_pad_writel(x, y)	WARN_ON(1)
 #endif
-#endif	/* __ASSEMBLY__ */
+#endif	/* __ASSEMBLER__ */
 
 #endif /* __ARCH_ARM_MACH_OMAP2_CONTROL_H */
 
diff --git a/arch/arm/mach-omap2/soc.h b/arch/arm/mach-omap2/soc.h
index 9e3dbb743e5c4..b3949559edadf 100644
--- a/arch/arm/mach-omap2/soc.h
+++ b/arch/arm/mach-omap2/soc.h
@@ -19,7 +19,7 @@
 #include "am33xx.h"
 #include "omap54xx.h"
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #include <linux/bitops.h>
 #include <linux/of.h>
@@ -501,4 +501,4 @@ level(__##fn);
 #define cpu_is_ti816x()		soc_is_ti816x()
 #define cpu_is_ti81xx()		soc_is_ti81xx()
 
-#endif	/* __ASSEMBLY__ */
+#endif	/* __ASSEMBLER__ */
diff --git a/arch/arm/mach-omap2/sram.h b/arch/arm/mach-omap2/sram.h
index 030cabc39821d..a1d72e014e62b 100644
--- a/arch/arm/mach-omap2/sram.h
+++ b/arch/arm/mach-omap2/sram.h
@@ -3,7 +3,7 @@
  * Interface for functions that need to be run in internal SRAM
  */
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 extern void omap2_sram_ddr_init(u32 *slow_dll_ctrl, u32 fast_dll_ctrl,
 				u32 base_cs, u32 force_unlock);
@@ -48,7 +48,7 @@ extern void omap_push_sram_idle(void);
 static inline void omap_push_sram_idle(void) {}
 #endif /* CONFIG_PM */
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 /*
  * OMAP2+: define the SRAM PA addresses.
-- 
2.55.0

