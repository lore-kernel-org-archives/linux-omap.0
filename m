Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EC8924169D
	for <linux-omap@vger.kernel.org>; Sun, 29 Mar 2026 18:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774809025; cv=none; b=g9fxgbLF4aA1sbJB4QaCua2rZ5MSg/J74Mp3QbJftQITjAc1ggEpIgBVJegcnLfJ1FA4B/6eNiS3id4RNHatVGw+U8FPi3bMmmhekD2JfSsBKkmhbqreIdaLGb8+1e0UVNhZ1k9mK/VJz8oPY8Y1386SwfwhW52GMzDWZICT/XA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774809025; c=relaxed/simple;
	bh=pq1S2/WTsxuiTEJQKGv2gIgx0xjUtOuCL7F0BYi1akA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZIEEGOdcHgu9lt4kXZVj5IRyjhrxwGWEsV3L/hoC8ruo/uDYrTVS/aeRDYTAQK/PYGk94977P2u4q4Gz/1xtr7qwWAFPCS342S5JLkF7CyaH8Qsn8pujdT+CxhoLc/jsiVNA1p8O23B6V7PXAAkcMpLxcj3xohOqdZwZMJY39DM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F4SyAqBc; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F4SyAqBc"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-48557c8ad47so28479305e9.0
        for <linux-omap@vger.kernel.org>; Sun, 29 Mar 2026 11:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774809022; x=1775413822; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=wCXcpkuT9MjL6s3OBnbX3wIF98Pu7GQq85w5vsjac8c=;
        b=F4SyAqBcSu5TzIL1Yr/FEIqxj4hSyjjIZI2nxPaIX094liCfrEcDvJ97Sb0zH3AdXo
         VGW35vdWA7e99TeYfRJ3tKC11lFmW7Ej7j2NuAoKRVW+d4dE5L8QyOEKMdts0HWbnwFJ
         2bHYuhYvcmSPl4dTTNK0ko5oIsc9ttSn7o9dLmd2fKQJPd2qBeW4z2GvjVpskwKHcZyH
         3PDnCf3DCtysVjblfZXwP2yiyqeSGzY648/zCXbmyFgBROIUxUUrT8X6MMHIYdidzEQs
         5Cl13+1iseSykcYVxQHm48vL/ToIsXBuToU3Z/b7tN2bBPKe4LOOSLfROR62H8YYmdF+
         gw8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774809022; x=1775413822;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wCXcpkuT9MjL6s3OBnbX3wIF98Pu7GQq85w5vsjac8c=;
        b=MDUvS/gy5sTpsGUczeV+vOuzRwzWf25FJoiPbCOwXhY6EvJkiEtbHYBTH9Qk0SWfNm
         QMvjYPyk6ETyNk1h5TfuOM7sWDqoNafSehemMXdBzyiK9kskvFOF0h4OoEfqI+kaxpTh
         2jkLevl2TJBOAKyhTibRfycjK8wjIl2YDcDqa+7bCuc0ide8c9nLZk8jXKO5yeW8cm+M
         lQwks0siPJk8l6y2G8VlaDZPjZxAzIMaJkIcXqWdTjVP3LSdhQwgo31aWSMX6l4QVJkh
         dAovX2mG5G3ckzG6seduUeexE5ZPZhSkKAkSncgAHWOanWAjnSIrluNiwke5K+gL0DrJ
         /+1A==
X-Forwarded-Encrypted: i=1; AJvYcCVBfMWHZ6ODmJR4WJcxSQbg1kJXKpuYtFGZaA6LLCy/fAWD/9dT0TaU2S/krbgKcPTwM4Q+PlyA5lV0@vger.kernel.org
X-Gm-Message-State: AOJu0YwgLyzypXIRtfrMnNivokWGVrFHe8jy8TbKAvadylROALAeDogF
	pfWDb5OJqemT6N70dWLGn/IQxnyHjAokvg5KfuAVHyACgwn4HsgvUau2
X-Gm-Gg: ATEYQzx554PYe7U7xpnh55cu14unI07siKXKtM+v1MdRZDuiWSoHPK1X+8oh4YhD/Qr
	lrCBwcjrSab2ivpDm9C4s4mUot+/6CoqA/YuP68NGs/pkAvzQZF5jwgWoJOUxjmEw68lCefWYTp
	arNsFGdkMei7EF3vFCxKcyIFKMdXC6sGLR26SVSZB6pJ6+JBqbCObUgsLyLparx0AZvAwF1qYiw
	5ingPcMxXXmLtjqgUOWq+DuARFy+GOkcZhQeWESN0FHJHkmPULODUgbMrRAdGTJAS2fx72TrN1a
	2pCYgXGFVm5OhxTuIHtf9uVKjlgdJHtTTBqyi7W6fWHrDM4+Q0rUkq8G6+ZGsb7oFrxWtBpIP4g
	FPr+TMJFR9kXJ9CD8HuO4YPcAaTUO2QUMRRep0il4cCRJpiWPsP6WliFsx1J29jmZ0R1a4OOO72
	bBcrayf7DmdAazVUzs732Sh5IugaOXNImNtU7Lh13hgIfiprr5W0VYf9I=
X-Received: by 2002:a05:600c:1f13:b0:487:169:9f64 with SMTP id 5b1f17b1804b1-48727d73709mr164080515e9.12.1774809022057;
        Sun, 29 Mar 2026 11:30:22 -0700 (PDT)
Received: from nixos-office (195-23-151-163.net.novis.pt. [195.23.151.163])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43cf245f8a3sm14307369f8f.24.2026.03.29.11.30.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2026 11:30:21 -0700 (PDT)
Sender: Julian Braha <julian.braha@gmail.com>
From: Julian Braha <julianbraha@gmail.com>
To: tony@atomide.com,
	d-gerlach@ti.com
Cc: daniel.lezcano@linaro.org,
	tglx@linutronix.de,
	linux@armlinux.org.uk,
	arnd@arndb.de,
	linux-kernel@vger.kernel.org,
	linux-omap@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Julian Braha <julianbraha@gmail.com>
Subject: [PATCH] ARM: omap2: dead code cleanup in kconfig for ARCH_OMAP4
Date: Sun, 29 Mar 2026 19:30:18 +0100
Message-ID: <20260329183018.519560-1-julianbraha@gmail.com>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The same kconfig 'select OMAP_INTERCONNECT' appears twice for ARCH_OMAP4.
I propose removing the second instance, as it is effectively dead code.

This dead code was found by kconfirm, a static analysis tool for Kconfig.

Signed-off-by: Julian Braha <julianbraha@gmail.com>
---
 arch/arm/mach-omap2/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index 821727eefd5a..f3f19bcfca2c 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -42,7 +42,6 @@ config ARCH_OMAP4
 	select PM if CPU_IDLE
 	select ARM_ERRATA_754322
 	select ARM_ERRATA_775420
-	select OMAP_INTERCONNECT
 
 config SOC_OMAP5
 	bool "TI OMAP5"
-- 
2.51.2

