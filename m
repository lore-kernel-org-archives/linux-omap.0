Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A7A34B192
	for <linux-omap@vger.kernel.org>; Thu, 26 Mar 2026 02:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774492492; cv=none; b=Fj13/A7158h8bXhcSLX3XSls977gqb0fUmYXyJ4ckAk9iCMoTAW4yQlMBT2a+vxR7Yz9RYbPXCVmQN8XYSlqndboofhWU0mku6kdnto8029e7LsNLVmamHYZcVf6bXCd5sVAIJWrhLFqxRr6kBXV2HOIccXAdxBCquyINhoppks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774492492; c=relaxed/simple;
	bh=TBzzG7hacy5c9qPr3l7NpzqNvZmFVX6fFumUw/1gN6M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tqqngM6WbTlvAb/9WrCiZ656tnO3JTPlv/THFqaBJXtZFb6MiTYeFvz4tbUoG9Wq7YKSqN/HTPnv3eN2ubSTcc/IRLbVEzFt3vTrj6SioVAaIlK3KwSVb6yJXbrB/tA/ggQBT8diUsL4tlnWBatPuhPDYIhm19eGBFA8Ctd7I3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nj4bVc7p; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nj4bVc7p"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-82a62714fe6so178486b3a.0
        for <linux-omap@vger.kernel.org>; Wed, 25 Mar 2026 19:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774492490; x=1775097290; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DClgII7euPARd4Aw2OGYINNJTYi6FW2MEXDTcwKQgeM=;
        b=nj4bVc7psqPja2ngWETFftwZZXez5LVI+dOVOjQMn/ujh5XS70uHICHQB4bXiWqe2+
         fugHUlDpQQKqkTw8g8n1TXzSfCUOMZuYf6A985e/yy6iQecs/9ME7sT3rXK9l64WK0wX
         zxrS+IcWzyrKaIKDTy4eIKYkEcRLRWvr5p3SaQMnyNl0kvkKLqlQ9PA5I4j/1dR1CcIF
         A2MXHbHjnimH5b4+C3/wmBmazCtvsPxeXphlhslBLmUrE1VkWmXfaeuxsa3zeBsPyovY
         MDPyXS57gTdAE6mPT2u3/naQpLvFt6PEHiLHovqRdriNdzpCJOPNBKjw4TS+S5DLV0Kc
         u+3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774492490; x=1775097290;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DClgII7euPARd4Aw2OGYINNJTYi6FW2MEXDTcwKQgeM=;
        b=K4UNsa07gHb8GHS0ttiEX0H0agQsDCpNOu6+xJ0PbHW0C0N7+NRLsKlZ3DIvmt5LPv
         hIae+8kr/W7g5BReQHAmjNQf3CEwNf5aiaLfbMB4oL2rg6n8dkVKulWUetE9V4kEgvxd
         lKLR7vMiFVnjYjJOkOD6+rDarVTpFtw0j6pu7I/wpTtUgQffeUFZ9Skeb9qXVH9+ykg4
         5zMATjHzd3xdv3OQaJp93ZZ1QNoBBpVAdSYjVat3ncGMPm9xJjN7tOAxFVAAUHf1YuPu
         LdlDTNy4yOQJxjKsHU9m2Gc11CEDCx80Sj9cIoktq9URQNvywpeu21GmuzFlq8VbGyU6
         fj6g==
X-Gm-Message-State: AOJu0YwofjEd5pLDpTKKdiMeVSLLk6eNgK5R2SmvGeCfrZc+Fe5w/spI
	VQAbsY5kLUPrHTBKlfHkTsRByo+61O+IaYRFps0A9NdPv1IV7+h/La6xwAFJkSWC
X-Gm-Gg: ATEYQzz+dAv6Gkv1LtkfzN+sdFhS3h7afhmxygMNIvvlsZORlWMOSsguTq/gFZzaY05
	lq6GdmQve0fpsNftb+mpRX3FZjCV7y/O3Zr+U/q82ReiGu/+U0U07nh8WwmHLkpmcG+tcBMc8K3
	HGwkwdjpigIuH91WyvatJ6pWOa1PNeh5qsESO4sLReJ5eCbIyUgDr/DHT1aZ08DHefoNr4hcXt4
	1vkhEMq5RsKixQo2Nvdu1wveRtZ32NNwGYASTaKBJus+X2zQG/7ZGXnu3dcuTcx/bGgYB/D8i12
	MZVpIkdf2srydtWlXfx5gAX3P1N9OadZrCKQRqXRittPviB9HbAvY//iOGLEbA6BXedd5A6cv7z
	8vR/ZKGqn2GGsbvY5qHdEJoa8d/M+C5TiUCTnShA9dXG6nhCD8O3akqLK6fF536qLbrS5/gpZyj
	/Nyc9I2Lx/FCq+Zv9H09kLtAse2sgVklwKnwNUH3AG4NV37ZF8sXGpvGc=
X-Received: by 2002:a05:6a00:27a0:b0:829:7b30:92f4 with SMTP id d2e1a72fcca58-82c6da3394emr5062994b3a.16.1774492490469;
        Wed, 25 Mar 2026 19:34:50 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d::8bd])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82c7d3d5e81sm998465b3a.51.2026.03.25.19.34.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 19:34:50 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-omap@vger.kernel.org
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>,
	Andreas Kemnade <andreas@kemnade.info>,
	Kevin Hilman <khilman@baylibre.com>,
	Roger Quadros <rogerq@kernel.org>,
	Tony Lindgren <tony@atomide.com>,
	Russell King <linux@armlinux.org.uk>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-arm-kernel@lists.infradead.org (moderated list:ARM SUB-ARCHITECTURES),
	linux-kernel@vger.kernel.org (open list),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be)?\b)
Subject: [PATCH] ARM: omap2: simplify allocation for omap_device
Date: Wed, 25 Mar 2026 19:34:32 -0700
Message-ID: <20260326023432.54127-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use a flexible array member to combine allocations.

Add __counted_by for extra runtime analysis.

Remove goto paths as they are not really needed anymore.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 arch/arm/mach-omap2/omap_device.c | 21 ++++++---------------
 arch/arm/mach-omap2/omap_device.h |  2 +-
 2 files changed, 7 insertions(+), 16 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_device.c b/arch/arm/mach-omap2/omap_device.c
index 79db4c49ffc9..55f2a9d5f4df 100644
--- a/arch/arm/mach-omap2/omap_device.c
+++ b/arch/arm/mach-omap2/omap_device.c
@@ -309,17 +309,15 @@ static struct omap_device *omap_device_alloc(struct platform_device *pdev,
 	int i;
 	struct omap_hwmod **hwmods;
 
-	od = kzalloc_obj(struct omap_device);
-	if (!od)
-		goto oda_exit1;
+	od = kzalloc_flex(*od, hwmods, oh_cnt);
+	if (!od) {
+		dev_err(&pdev->dev, "omap_device: build failed (%d)\n", ret);
+		return ERR_PTR(ret);
+	}
 
 	od->hwmods_cnt = oh_cnt;
+	memcpy(od->hwmods, ohs, oh_cnt * sizeof(*od->hwmods));
 
-	hwmods = kmemdup_array(ohs, oh_cnt, sizeof(*hwmods), GFP_KERNEL);
-	if (!hwmods)
-		goto oda_exit2;
-
-	od->hwmods = hwmods;
 	od->pdev = pdev;
 	pdev->archdata.od = od;
 
@@ -329,13 +327,6 @@ static struct omap_device *omap_device_alloc(struct platform_device *pdev,
 	}
 
 	return od;
-
-oda_exit2:
-	kfree(od);
-oda_exit1:
-	dev_err(&pdev->dev, "omap_device: build failed (%d)\n", ret);
-
-	return ERR_PTR(ret);
 }
 
 static void omap_device_delete(struct omap_device *od)
diff --git a/arch/arm/mach-omap2/omap_device.h b/arch/arm/mach-omap2/omap_device.h
index aa8096ecb23c..9283c15c2403 100644
--- a/arch/arm/mach-omap2/omap_device.h
+++ b/arch/arm/mach-omap2/omap_device.h
@@ -51,11 +51,11 @@
  */
 struct omap_device {
 	struct platform_device		*pdev;
-	struct omap_hwmod		**hwmods;
 	unsigned long			_driver_status;
 	u8				hwmods_cnt;
 	u8				_state;
 	u8                              flags;
+	struct omap_hwmod		*hwmods[] __counted_by(hwmods_cnt);
 };
 
 /* Device driver interface (call via platform_data fn ptrs) */
-- 
2.53.0

