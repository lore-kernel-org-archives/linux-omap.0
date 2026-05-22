Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC958349CE0
	for <linux-omap@vger.kernel.org>; Fri, 22 May 2026 23:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779492654; cv=none; b=WM1IwRJAVODLOSo1EVEZlMqEfq1JrAtLdhP9AZnrY2wPyfafUnQD/S3Ze6b4ttVg5q6gu9nGAdaO1lmXUjCrmJydv6nHnB9rkcB+RmCpGvgI76VfDDjoaUn1tMNINah+YAA+6R5MHpJJ1Gzo0K8hLMFbll5kiJOE17loT6N7TxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779492654; c=relaxed/simple;
	bh=vvmjUek1QzkG1Hk5FgNGb9tW9zywdDL3NFyvPD5zYmA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YTN0hpi++pOl4ENOG4lpV+IMkGdJeTCeBgflLsSbMSyrI5O+lLH9d3e25Vnp7o1LnqB5aOyWQoCTkME4ACaES0hsb6Y20J2IPNcc2f5lUiNZPgT1/qdMcpQfgfES2j5stNB3pag8jefjp0ofe7tY+CTnDEjBGBMi7YVz0LywezM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=azL1YG94; arc=none smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="azL1YG94"
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-65c52bb5dd7so7692278d50.2
        for <linux-omap@vger.kernel.org>; Fri, 22 May 2026 16:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779492652; x=1780097452; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OVgXaIjnKTC975MfdRgmXFyZkQKLmkaHxhR1b9izJDM=;
        b=azL1YG9489KJYI1wI1D8Po0tfa9q/tKbbyk9A0N1Fruv3gnLZr9uHOPcJIkzk7KH48
         tye36PE6zAld5cr/AF2AEoJ182xxh5+IFDiA3qaBK15HfnoEUcORIghBxZXkIbPGbCWN
         z9UO96y0CahgAC/uUsWciMZjuzK1Dszl7ork5+csL2dTdWnGyoUyGcU+YyGsddwXqanX
         2Sp3WPTDe3ezqglgexcjJnY5/g4v0Ye7Ah799jLeZRJ5rOdi2Iz8pId3b48qbT7VXwcl
         qXsJ+2mTgp0Wwzaug9WZmvzl4N63+iYs4TMCwGv5v2vOTvrCfjJkRgt9OY37s84tV2Rf
         aZBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779492652; x=1780097452;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OVgXaIjnKTC975MfdRgmXFyZkQKLmkaHxhR1b9izJDM=;
        b=ELWOOFmc0JRDQpoSt07ahDvnL9oEDMcnnee5KUCeIsCXxj5Q+bnpSwnY3ucfQ9yrVG
         D2j++1SiCB4DrqOEB8pnpT4PIIiiY5wvy8KEsX48z0bMRv8V4vAFhO52tN0HUnBXuUED
         JCYoGvnUjpK3e0jUswlZ9dD21/thUgCjtddwriQDx8vnF4V0RoQxlzTuJzPYf4RpJm/y
         CZoU7OMNZikJBJ98Ta3XR+0nwiOgk6jCZHUGgwqnFrygLZZ7akKzHVOywHJC2VBSJGxt
         Ts1ykVrf7Bw4eGKC3bXszHU1eNdOs/M8G3S47jbVWmbzbyZNjcTeMIYCYC8hOCi9g2Oh
         IeXw==
X-Forwarded-Encrypted: i=1; AFNElJ8AC+UGtOvKbInuFX4fvSMqSiQr0sT8muraLmNIMJpOK/xR9QL+icU/Lh0XXqHK4ixBMvnu9iuzz+C2@vger.kernel.org
X-Gm-Message-State: AOJu0YzvhZb30P7gUPTgZsZ2+9A8+A9ymigM8Y4P7I/FYx/YpuU3/j3p
	sqAQM1AwNhFe7Zi/ffoDuYmzz7hBvhN4jGTGSwt2N4+vX8cE8i2ehE6r
X-Gm-Gg: Acq92OH44a5yBtK4vGneWS7qhu+D1JVEqiKVLCv/q6DbxYZQufWuS4/H4DQGDcJzxCS
	yJ8/4WjRvvwGh8DWZf/YMtdDeUjk7EzKsF5hvPnfRf8Kft0fEpPkWNhAp8upkOHhrgbIxuLqlQ/
	WyjE0OfjiRLX1GxozOZda3TbYuwkqHx7YfF2wz8ZWyXDD1DFMI1WCwxAwkjmW7iifttCauDOOMs
	w8lFC1VyKkVdGsyDDQu6xqItNLUT6XnZQ596GuzDUM4nbFM9MLX4Y9F/4DxjsOASolWzZ3+Dv+y
	HymOM7N7JOlWV6vJ5mcIpMBU6LHcANAmN8tMIQt+wA/T4VZ7WMeS0SSg8IreQgzi3mNNHwibUU0
	hdAfH1kcNLlDv4rrDIiZzbOoTf5M5N849MhN8aHUs4qxmpu8f5cmw/gRE7FrJ+R7w93nsndMS6+
	rUx9t0uaf/DFp6mqutXjqfHt0Sdy+NlI2NDkSVFqLaumT8233ktMJ4CA4JYhI4eCGPZO+eQPVN0
	EUzs3RP1Pe1IYBzwBmRfUBPeAW28owYXJ8x525TUrASSVjy+HU+Rf5AWSwNmuuVzP79tw==
X-Received: by 2002:a05:690e:418e:b0:65c:5b88:849f with SMTP id 956f58d0204a3-65ec9931107mr5745827d50.45.1779492651865;
        Fri, 22 May 2026 16:30:51 -0700 (PDT)
Received: from localhost.localdomain (99-61-165-33.lightspeed.sntcca.sbcglobal.net. [99.61.165.33])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-65ecfdfc74csm1341853d50.21.2026.05.22.16.30.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 16:30:51 -0700 (PDT)
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
Subject: [PATCH v2] ARM: OMAP2+: Add CFI type for omap4_finish_suspend
Date: Fri, 22 May 2026 16:30:36 -0700
Message-ID: <20260522233036.12277-1-bavishimithil@gmail.com>
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
---
 arch/arm/mach-omap2/sleep44xx.S | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/sleep44xx.S b/arch/arm/mach-omap2/sleep44xx.S
index f09c91978..0b48df6fc 100644
--- a/arch/arm/mach-omap2/sleep44xx.S
+++ b/arch/arm/mach-omap2/sleep44xx.S
@@ -58,7 +58,7 @@
  * stack frame and it expects the caller to take care of it. Hence the entire
  * stack frame is saved to avoid possible stack corruption.
  */
-ENTRY(omap4_finish_suspend)
+SYM_TYPED_FUNC_START(omap4_finish_suspend)
 	stmfd	sp!, {r4-r12, lr}
 	cmp	r0, #0x0
 	beq	do_WFI				@ No lowpower state, jump to WFI
@@ -223,7 +223,7 @@ skip_scu_gp_clear:
 	isb
 	dsb
 	ldmfd	sp!, {r4-r12, pc}
-ENDPROC(omap4_finish_suspend)
+SYM_FUNC_END(omap4_finish_suspend)
 
 /*
  * ============================
-- 
2.43.0

