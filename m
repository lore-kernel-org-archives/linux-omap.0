Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4412125B0B5
	for <linux-omap@vger.kernel.org>; Wed,  1 Jul 2026 17:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782928662; cv=none; b=Pkx5H0nqL9dEUmaH85sQYCSirxTQfrIUcEr2MlHjCuxB0onPrkDCSIROmyl36a3Ln5JdV+vPpmW7e5rLHns6UWFptlvX2rn/guNIR88YjsX8bJQnoZwDsFSgJP49gWi7OY7iOT1kBVztpnPxWcDSAayCtbBJ1qTBUTgp9/MMCjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782928662; c=relaxed/simple;
	bh=m4JnlKp71dmBmVmXd0wN7hnWPeqvxXn+YH64ucbXVAM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TJ1YjXzPFdBBMVGxAJGVusyedoQ6E3JMeiUGjXJ0vbPjwluUfJonJP4n18Tk5UgBElSe5cJYyCEFsEH9pxE9pGhhn2o4xQZTmWm/nRf1K9gM0wi1HvN5OOMpJwIIHulkQOVHnit8q9OzOfILrCVL2ehWVJ04csvj5FmzV0PuVqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y7Qd3hYC; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y7Qd3hYC"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-37ff436a048so510355a91.1
        for <linux-omap@vger.kernel.org>; Wed, 01 Jul 2026 10:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782928660; x=1783533460; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VL4o1uarTpj9xDmNVkt39wRpQkwyzo96/1lQVKIfDYU=;
        b=Y7Qd3hYCNYOsveLwGL8Xs6iwHf57IaAexqqFkP3QNdOy/L8e5X8/fWx0dvZaNEM4co
         QLNw0DROjy/zAuEJniCp+rALDB2HzmMQXHtiIMeQfMXtwHUhlF+YVx3A46GvQMMhq6Mf
         GzD+5jXt1jAnFb1IkegbK1D58KKDM8Ek7bWzxQsAOCGeucMwDQkf5tLwFQWANveS8wKv
         ui3f0Q0pKkM2ghnyYVr0yE6T9l1ltn9ABpL7pOSvfQNQMFxHW/I62vkuveFhCymbZHqR
         XL7x9QC+xvIvxIei9/fO6ZhU5gzqq1Pgrq5H8qJd77bGlkrARSifYvZLvwjGbTYbKnUU
         Vl4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782928660; x=1783533460;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VL4o1uarTpj9xDmNVkt39wRpQkwyzo96/1lQVKIfDYU=;
        b=J+jcdw8txMnTqZtwnwAUBHUtSHIaUAk4HBH71+u/mvyGZWGNSFlKVUW8w9B3PWatM8
         mFsWYhzXoI+XFUP4jfENfuYFFU4rm6cfaIzh1d2a7ad1lKA6x+euX6BB29YWuFhSUkFk
         1kTyCZidWXWEpU6iXdJamzo0Xu1bfcxNHvxlHOjnY0avTHsjtlMdZDmBI68cYFysD7Eh
         l56ya3u3QvHej6pLnLQFykXomQtjAfzRU+PEk1+W8f7ldm84EApNMWd/QEYHZ+Zj37Co
         B2TSFJ3AqjrC6NP5i0oSbTq/b0SwRs/vhM8d8kYCQg5gLy+vrcBflmW8I8NYpJC+SjJ+
         ctoQ==
X-Gm-Message-State: AOJu0Yxla1MrLovEge+L3036DV7+ZoNHYePoHP0WBEX3fDsBudxXXnVx
	w4STLz1jN7oEgKBreElCckIUCC7ncSiCOwAEACK8KCkCr5Ip5OYtbldx4XcYidukbJo=
X-Gm-Gg: AfdE7cmluCmSY+pbsFshbaaBp8RVzWVcpU/w3Hfs2uvuvFf4sgOjPTk+lGAUZ6zfHlc
	+MvvYltspCxSmj10sTmTb3Xsd4g+n3MZ4Ho31PNoHapLG7VwTXDquDe6Bw68v5WkBovS2GmF/Tc
	WDiltd/ok5IAIGu5XGoPaDLnK5UdK86Zs5jMHHhA0k/cG0v2aCtJLzHA+Srxt9iOO3e9dy6lPZM
	qhipJSZ0vkNTaEzMPcIzOrpSTJESFGm/BOPKShL0dzkYWs0/Alej7QR5g8l2byG5kkjbYdQh1/X
	pcI0ZJsKFTFL6qR43lsnxt7rtgdmXPxvbnE2g6cjbjX9zImvlpot2R58DGg8lYAqcu/v1+krq5s
	rN9+nlTZSjJd64NSsg2G/YQRXYRgWAyM/E7yXwF6USFU9VggZvbbQ0JKJhka7rAeKVgCevFPzoo
	jUQvvwUeDSGLiGcdqB88w=
X-Received: by 2002:a05:6a21:50c:b0:3b5:4fff:fa0f with SMTP id adf61e73a8af0-3bfed238ebdmr2953675637.14.1782928660440;
        Wed, 01 Jul 2026 10:57:40 -0700 (PDT)
Received: from localhost.localdomain ([2804:18:103:9e2a:b51:b011:2af9:a710])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f0bbdc544sm79130eec.25.2026.07.01.10.57.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 10:57:40 -0700 (PDT)
From: Wagner Popov dos Santos <wpopov@gmail.com>
To: linux-omap@vger.kernel.org
Cc: devicetree@vger.kernel.org,
	Bin Liu <b-liu@ti.com>,
	Wagner Popov dos Santos <wpopov@gmail.com>
Subject: [PATCH] ARM: dts: am33xx: avoid invalid OCP device-link for timer1 and timer2
Date: Wed,  1 Jul 2026 14:56:47 -0300
Message-ID: <20260701175647.8694-1-wpopov@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch fixes boot-time fw_devlink errors on AM335x/UCC3 caused
by invalid device-link creation attempts involving timer1/timer2
and supplier ocp.

Observed kernel log messages:

  ti-sysc 44e31000.target-module: Failed to create device link (0x180)
  with supplier ocp for
  /ocp/interconnect@44c00000/segment@200000/target-module@31000/timer@0

  ti-sysc 48040000.target-module: Failed to create device link (0x180)
  with supplier ocp for
  /ocp/interconnect@48000000/segment@0/target-module@40000/timer@0

The change updates dependency handling for timer1 and timer2 so the
kernel no longer attempts this invalid link-creation path during
initialization of supplier ocp.

Impact:

- Removes the two ti-sysc/fw_devlink error messages at boot
- Preserves current timer and clock assignment behavior
- No functional regression observed in boot and timer operation tests

Signed-off-by: Wagner Popov dos Santos <wpopov@gmail.com>
---
 arch/arm/boot/dts/ti/omap/am33xx.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/ti/omap/am33xx.dtsi b/arch/arm/boot/dts/ti/omap/am33xx.dtsi
index ca3e7f5d7d0dc..760598d5ae1c9 100644
--- a/arch/arm/boot/dts/ti/omap/am33xx.dtsi
+++ b/arch/arm/boot/dts/ti/omap/am33xx.dtsi
@@ -708,6 +708,7 @@ &timer1_target {
 	timer@0 {
 		assigned-clocks = <&timer1_fck>;
 		assigned-clock-parents = <&sys_clkin_ck>;
+		post-init-providers = <&ocp>;
 	};
 };
 
@@ -721,5 +722,6 @@ &timer2_target {
 	timer@0 {
 		assigned-clocks = <&timer2_fck>;
 		assigned-clock-parents = <&sys_clkin_ck>;
+		post-init-providers = <&ocp>;
 	};
 };
-- 
2.43.0

