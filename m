Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F5313C5849
	for <linux-omap@vger.kernel.org>; Thu,  4 Jun 2026 05:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780551660; cv=none; b=UrA770jRV5zeflBF4d7h8HVDyGd3UfHG9yEHXzYHMmDvHS/ypgNMRQsG3YevIi11MC1BdjXH+kF9pjY3QilHrr/0+qeVNdz5eWA1vgbY/PHg6Ow64Y6wvwytTXH8LiTBXqg3/xXoENUKmvp8TK+BF8MlTya++NSpViIwwq/Z8Wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780551660; c=relaxed/simple;
	bh=904hfk+1/sPDYqEKZWi/BogqSgfzWSRNP+4wfvbsumg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pyv4JlyZRb1uZZBJ9WglVVOPfuuQMhCHGrWDE9qpizPxMbxg/FRIHls4RsDoBGq68HOIRqYzoJKKVETZWyyn9O7AfVNSjk/yT03qSyYqAWAolCYhKZEblqpsxBT9evoQlvU6xlhXVmDApYconEbej969u/dicoA35U3WP4qi1vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oHBK4dIT; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oHBK4dIT"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-7dbcb505578so4181657b3.3
        for <linux-omap@vger.kernel.org>; Wed, 03 Jun 2026 22:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780551657; x=1781156457; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LREGCnvB9r3+rbw8NbYyQSnfAuuxbV3j4ZuR6PAmnmM=;
        b=oHBK4dITeRbzqSmc0lHBMv6lUn/6RpIr1EZ4hAF9Fy3gygPAUwTwMnj5gg0YjiPggK
         efFfFbdrEraoJCX7/KTNDUn1EQLBtiukpiG1NUnM0X282IQqMDpCcZlbKIh3383WJLqv
         yZP85FcreSBDgruGZWPWp2a8jjD5C788A9YEm1hzV0trti0ZrpvhbeY6dyM8WLP8gh9+
         Bmw+1IPiPrXT0NZusCfrLkrNee436mBBtsFpK28+jMqYxEEgAe2OVaIQBDLunoTNeDPW
         VF+v8/40tea8fqmMLOKOwvg4cs04CKqxeH3ELXNHS7iIA93Zn3otrwaqRbZzQd8DErpp
         1Rdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780551657; x=1781156457;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LREGCnvB9r3+rbw8NbYyQSnfAuuxbV3j4ZuR6PAmnmM=;
        b=Z4GLRccs8sdvdwjZJdM2vmBcrhRnpc+guPP0tplun6A+VNYOaL2T1KXGjJCpoQgVvG
         sHebFi1LS8EJsB3PomG5J3cFfSLeawH5ZW0Uwd2R0R681Q4Zju1nYplRqjRxItO3MpqY
         uV8kMD693CKkfC3wIo7FhuO4Vz4yRjn6IfZuTNYfEvhqaYHfWx+JOnKGjTwrqTzn2I6m
         qxp7Lve7uc5rNlle1fVgNCNxU400KDZdB1NISfla1va6r/zPLzKrKioopE+eBQdcxySP
         BiSb2cR5RdN5Nk0/M/682LTW4xJIWuQfyHFV8r1GLSosLIH1zt9elCdBtOxNC55DS5bO
         KQHw==
X-Forwarded-Encrypted: i=1; AFNElJ9XOEyTJfvQ/nanNgfpC60PevTigfG5dY289l2x7FbDLskBDJpIhNOLs9KgWJdRvwZG6zmmGmzXO+3f@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6lW+SGHIS8ecAkroAc7kroRwpFuAJbwf9EMJpmUzLDhTGPLQU
	0+3TTRlaZ7HYGRUdgpVa5Q6sbn9wtbziAJXJOOpK0b0tzfAZvdCtGTtp
X-Gm-Gg: Acq92OH8NQpYOLI/gFA4oGOJmS7udkpKKqEM4vpNRa211IE3G6KpqtH9ydiAGTYzt8i
	bF1/sOHLiyliCsMEPF78JqlRgCWHI1YIxfHoo0BskO8oZErlm8m8iwBqM37BVgAggzdOe1B7C2z
	kd5Cs6npdqDmEm1uPc1KbYJy1WuCVa0L9QfRVZ0bjl8PAeO5zHJcwRqyQ5jNFDsRB9z2SsBA9tn
	e9KSnjkGldGnHbMR2HJrXFiSBNcUnrnRb/bOPrLzyJUGDZk+oQC9YuC89+fsFM5IPBwYwmj46WJ
	wBHjRuK9z+ogJjK320BVLuCz4vboOrkAHS5PtAbiEyi8CAKG8Tc5fmk5+RKRdDsRzkpWpxi8dyW
	uYVe0IO0YvqQwGjBihRIEpucFMkiHDVc1Nnr4rvHUwt3xR26Z+6YbBV68wc8uECH4RA8qPwTVKO
	A1G9DrRAdOb71FpiEsCxxd/DhZcBTTucFEGSDo8eMDbVSbI8DwX/d2CgCbAS08NVWHjh5EGrJU8
	dIfEW2rcIMzRuI0f1VSkIgE3nOqWLQDTKo2TtGmVl5dQWxx8Bnxi+f5tUZrkhPdDbpPbg==
X-Received: by 2002:a05:690c:6d04:b0:7b3:3a49:752 with SMTP id 00721157ae682-7ea4d2715cemr58826857b3.41.1780551657199;
        Wed, 03 Jun 2026 22:40:57 -0700 (PDT)
Received: from localhost.localdomain (99-61-165-33.lightspeed.sntcca.sbcglobal.net. [99.61.165.33])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7ea23592beasm29137517b3.32.2026.06.03.22.40.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 22:40:55 -0700 (PDT)
From: Mithil Bavishi <bavishimithil@gmail.com>
To: Aaro Koskinen <aaro.koskinen@iki.fi>,
	Andreas Kemnade <andreas@kemnade.info>,
	Kevin Hilman <khilman@baylibre.com>,
	Roger Quadros <rogerq@kernel.org>,
	Tony Lindgren <tony@atomide.com>,
	Russell King <linux@armlinux.org.uk>
Cc: Sami Tolvanen <samitolvanen@google.com>,
	Kees Cook <kees@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-omap@vger.kernel.org,
	llvm@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Mithil Bavishi <bavishimithil@gmail.com>
Subject: [PATCH v3] ARM: OMAP2+: Add CFI type for omap4_finish_suspend
Date: Wed,  3 Jun 2026 22:40:48 -0700
Message-ID: <20260604054048.18980-1-bavishimithil@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With CONFIG_CFI enabled, OMAP4 can trap in omap4_enter_lowpower()
because omap_pm_ops.finish_suspend points directly to the assembly
routine omap4_finish_suspend, which lacks the expected KCFI type
metadata.

Annotate omap4_finish_suspend with SYM_TYPED_FUNC_START so the assembly
routine carries the KCFI type metadata.

Signed-off-by: Mithil Bavishi <bavishimithil@gmail.com>
Reviewed-by: Nathan Chancellor <nathan@kernel.org>
Reviewed-by: Andreas Kemnade <andreas@kemnade.info>
---
 arch/arm/mach-omap2/sleep44xx.S | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/sleep44xx.S b/arch/arm/mach-omap2/sleep44xx.S
index f09c91978..8b515f300 100644
--- a/arch/arm/mach-omap2/sleep44xx.S
+++ b/arch/arm/mach-omap2/sleep44xx.S
@@ -6,6 +6,7 @@
  * 	Santosh Shilimkar <santosh.shilimkar@ti.com>
  */
 
+#include <linux/cfi_types.h>
 #include <linux/linkage.h>
 #include <asm/assembler.h>
 #include <asm/smp_scu.h>
@@ -58,7 +59,7 @@
  * stack frame and it expects the caller to take care of it. Hence the entire
  * stack frame is saved to avoid possible stack corruption.
  */
-ENTRY(omap4_finish_suspend)
+SYM_TYPED_FUNC_START(omap4_finish_suspend)
 	stmfd	sp!, {r4-r12, lr}
 	cmp	r0, #0x0
 	beq	do_WFI				@ No lowpower state, jump to WFI
@@ -223,7 +224,7 @@ skip_scu_gp_clear:
 	isb
 	dsb
 	ldmfd	sp!, {r4-r12, pc}
-ENDPROC(omap4_finish_suspend)
+SYM_FUNC_END(omap4_finish_suspend)
 
 /*
  * ============================
-- 
2.43.0

