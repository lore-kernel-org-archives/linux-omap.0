Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.171
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794666179;
	b=veyEzY5BP9lcdl/xV/Bq2wOnIp7Ay0ljCdxT/g8TPcR9wp2lLEeBPhnH2OXs4+oKN0j9
	 VwaWvFxBoO8hzqG0BzqUchEC6YIKEzyJnrbWcFplR+IXA1NYqFXsER7uRIZ/MxUJwFZ4l
	 qdPoQFqyboo5buGiLe572WdtQ+0AulL4njPk0nIC2a4VnC0iLpaVnOq3FSa9lwvBjRoRV
	 h54Bj6ezlWL1/rjTvK3/VexiaRtuVvOqoeR8cECPH4PK/RLWNKWLT9rBpcuSST/cwUBxH
	 BAHmwj6BKRdu/sqgZtfiBO/QKDec5pSxBOT0oOTXXJeCuGhAR1kOY63t2vA4b/2obWQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794666179;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type;
	bh=G5yus5RH2Mmxq4O40QSTYF6RMwPjngJIn1JYpz9Q3bE=;
	b=jAWo7bOtH0YfEzPEyOD7xMDnQ4c30KoXVq4wATWhoFBuOJYyADp5mBszXwUzCTw4iPXm
	 XPC/XxiPRnv+WLl00HZC8Up0N42FbA1kyCmQ1EqmS+qV1UpE3Ahey38dwJGNAc5JeDydg
	 usN2cl0o0AAaHuMRTYCmNNBYj1ES/mtQcorBDUypFE7PheYp/kj7ol1j7CkO+ZoGVOLwa
	 syHgIQst6exQfd3N4m3PPl7rlAENfgQl5OkCl8L/IE/8vpeHBBudMlYr4Er00eM/hrR68
	 9Du9RHc2/6za+fMPD/S0X3pxW5darTfT/6+8OzO5CKIZupp7IDb6nMrM0njo/dw6riA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OKa6KfC7;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.171
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3CFA606A32E
	for <linux-omap@vger.kernel.org>; Sat, 14 Nov 2026 14:22:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C3CFA606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OKa6KfC7
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-536c8f958d7so12455431cf.1
        for <linux-omap@vger.kernel.org>; Sat, 14 Nov 2026 06:22:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794666178; cv=none;
        d=google.com; s=arc-20260327;
        b=OiXzMhLLJ6vfTmxXdhAtT83GZNdQ/v2jTOuaqt3jCSjnvvrs8FKMNJ5X4sJGUEcBeR
         bpAraKGYyDSNyg//HGF+WkmjJa5OtphFcRy0Y+i80/ObFX2KFKQijYzHnUqIQOeGwrfd
         YxrllGKSTZk8L6ZbNk2gor7Qs2DGIdGcMxMl/JKESrYfYlV1CaZF4R2A/g73yAL4eYF2
         8oL32JxIR2HzenLxP7ZPB1fD20ROn0FETPwMFgEuwIwReEnubCRkAuXCxQD4nJ6KkgQQ
         yODVu3aKWplEIBATmYuVJDeVU6tiS4ID44hd5xX4fpD4pJjqSsr7N2yRQC0C0s7sVKbP
         exmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=G5yus5RH2Mmxq4O40QSTYF6RMwPjngJIn1JYpz9Q3bE=;
        fh=Sri1dxalKcFAeuEuDQf83LY8vDYqVP2CZQy5AJUmL/k=;
        b=MHSQ4X+x+tsECIERIkEHBGlAXGg3PXl4yiQsKw6zHNspOmb9HNqcVhp9/00Q1ZrXkf
         KuD8ezq5By56D9JDpZAuNMfCV05Ae+bHiVot+fSwEmOC/YFfawAQmfzrji1TGKDO04ey
         M/PHnz8PoYSitvb7O1AvkL7qitPwpl8mVFF6zLyuJ9NsGea6N9ngwHpSd9iN2VA0HBbY
         xzPCg1HSkGbSHORBFQB4NQnv4z3DjW2SyOU2W+HX6m9Iopzgeu84hzOvyjGhjx1mrRoT
         6UqlbQ/93r7vvJf3olhMR2EPphyOt+mz8l/epZzFaGPYHa7eSabVFQJ3RMd0yGSl0rxS
         HJKg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794666178; x=1795270978; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=G5yus5RH2Mmxq4O40QSTYF6RMwPjngJIn1JYpz9Q3bE=;
        b=OKa6KfC7ruy5yaZT8s4W8fKpzxvy2X8Or+9st7L3BqjXlq12bO5v0k3ujfceeea6vc
         zEkpkol+mYW2vkHJdhrY4ykz6LgSw2TZO/HVzKAsoun0282sWSCLUrI+5x9Kync1dasg
         Lgk4xvEMHufsV9B2EUGbXIoeSxVA59kUMGnOpL03Aa2r2Bls/oA4bCUO40sArQuqGlXv
         yJ3hD32WWpzpymZzULVZJF7PKs1V5RUd5znLYtFRYr7GXlpfQbqZH/EFw6lVTS+KFfZA
         8dmcKABy0xebNEraKsBBGM2blkuOZKyvYL5xLU2TklJ/Kqa3CXB7nKcZ2Lu9ShlS6+UW
         KdyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794666178; x=1795270978;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=G5yus5RH2Mmxq4O40QSTYF6RMwPjngJIn1JYpz9Q3bE=;
        b=Aqq+qMfLoD2zx2sGpJfJQvJj7057ccu6H2IyDB5x4JHykdy3FPzev1pwAlmuu6skB+
         xx5Zzh9ZFCfq+9uXhLl90wAhyMd8sKfeztXlNa5EbbhXEOwE0u+DNwfkWprKqtLSuOJZ
         JLJLyZSYrAYSVRoh+jnFQJOw3aW4IakFII+0FG5hhz5S8Cfs/miLZMod/uFq0R1ZMnB0
         7iIflThRH8on9sTb8q2nVpIDhOY+helcEi0bnuXS9XjU3ui+uuunOLweaF/k6FZ8oZum
         TnuaO6Lc0uRXQpwUldmTERYSknFvQF9p852RgXeKCP0MO9PBjVsYZ/8nVrkwaeRUicfy
         rjnA==
X-Gm-Message-State: APuU4Z+NRy+RWjU/5X/J+x2B2mTjGjDkHN+SNTxBDIth1MtoHqjVRxss
	7Ev0DsyXcitWqMxFTVXcphC0udSoq3RYQwQue8KGV9JRHBXlYIFQbGOWXzyLpBI92ngv+se7DnY
	bOB/pqpJgw7J2H4FRwNccNSlWqyDypWA=
X-Gm-Gg: AYBFou2YxelEph70WifozK4HUVoGxKV6kLS84nGBD6/DhIYzwJ+XjI5UNc5pZQmDjj+
	RKO/huGW00R/GG1tlW/p+4RtP0ihbOSaSU+VHTV//thw5DSI5pLhGPgV4lH+DBbhe4U5uTZwKk4
	LaBus+ToTovIN35akEuH2IEarH6vOnkg7x5RObu1sOZV5PJ39P+WiIP89LvJjnVuhrIf2RZNDbj
	aGX89+tS3e0IpcPVnW3+OsYDwsoF87dcvq5IBYV+sU8RMqgiSI9aMyNeO7I7c1lv7duhrkQgoje
	Y6fdP7wGYk4alCaL7Dq91L2GZAT2PJb/hPbYO/H9JrQK8rJOl/WX6nsxFo627oxJjnsVQOexP1v
	W1J+t2InJFrupC25rP2kqlypfb/iJX1uA5NP9gj5dcTISXG0GV+TUZH9jmFlEM7ZMc2kcXg==
X-Received: by 2002:a05:622a:99a:b0:55c:303f:622b with SMTP id
 d75a77b69052e-55c304f17b0mr39835191cf.0.1794666177718; Sat, 14 Nov 2026
 06:22:57 -0800 (PST)
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Post: <mailto:linux-omap@vger.kernel.org>
List-Help: <mailto:linux-omap+help@vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-omap+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Alex Guo <alexguo1023@gmail.com>
Date: Sat, 14 Nov 2026 22:22:45 +0800
X-Gm-Features: AclHuK9yiLIXob55ZroLFT0Cg9mD_HokkJX4TvKd-iDgDxOTy4uoDwFYBnQu6Xs
Message-ID: <CAAi4Z-ff4LK0ZX1JHGkcv0JE0Eij7C2y+gRMhaMq7kHVjGsJ=g@mail.gmail.com>
Subject: [PATCH] bus: omap_l3_noc: Check IRQ lookup results
To: aaro.koskinen@iki.fi, andreas@kemnade.info, khilman@baylibre.com, 
	rogerq@kernel.org, tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

omap_l3_probe() passes the results of platform_get_irq() to
devm_request_irq() without checking for errors. When the interrupt
controller is not ready, the lookup can return -EPROBE_DEFER, but
the IRQ request can turn it into -EINVAL and prevent a probe retry.

Check both IRQ lookup results and return the original error.

A similar issue was fixed in commit 47c3e06ed95a
("spi: tegra210-quad: Fix missin IRQ check in tegra_qspi_probe").

Fixes: 2722e56de603 ("OMAP4: l3: Introduce l3-interconnect error
handling driver")
Signed-off-by: Alex Guo <alexguo1023@gmail.com>
---
Build-tested the affected driver object with Clang 18 for ARM
(multi_v7_defconfig). No hardware test was performed.

 drivers/bus/omap_l3_noc.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/bus/omap_l3_noc.c b/drivers/bus/omap_l3_noc.c
index 56794c67d865..0e445b36a647 100644
--- a/drivers/bus/omap_l3_noc.c
+++ b/drivers/bus/omap_l3_noc.c
@@ -276,6 +276,9 @@ static int omap_l3_probe(struct platform_device *pdev)
         * Setup interrupt Handlers
         */
        l3->debug_irq = platform_get_irq(pdev, 0);
+       if (l3->debug_irq < 0)
+               return l3->debug_irq;
+
        ret = devm_request_irq(l3->dev, l3->debug_irq, l3_interrupt_handler,
                               IRQF_NO_THREAD, "l3-dbg-irq", l3);
        if (ret) {
@@ -285,6 +288,9 @@ static int omap_l3_probe(struct platform_device *pdev)
        }

        l3->app_irq = platform_get_irq(pdev, 1);
+       if (l3->app_irq < 0)
+               return l3->app_irq;
+
        ret = devm_request_irq(l3->dev, l3->app_irq, l3_interrupt_handler,
                               IRQF_NO_THREAD, "l3-app-irq", l3);
        if (ret)
--
2.43.0
