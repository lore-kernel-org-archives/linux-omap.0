Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 990B93FA5D4
	for <linux-omap@vger.kernel.org>; Tue,  4 Aug 2026 02:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785810314; cv=none; b=XyYehbxCZhFZRgalbhRdsxhkKKhr3+34moBA66XEMlVVp9uj5i2CN7VoHHO5CmF1CJnybx0RAxmQjZQK2emrB30bLm6dBTQMogERYZO3JuaIMDVbtrkop+9/lD67fvsNbpl6PGMMMfIME/quJU/WjeAr1thlmRhUjJG4TWpeCLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785810314; c=relaxed/simple;
	bh=0ajQB+hPab2vIWSNK6YjKmU3k2ZE+ruh1odyGqqOzg8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k6wwyOxJAZ81WMSqOeDNuNR8TCvch/eYetv3Ji99tIqRaaglAtnxV3RLpFE6XoiqRJpugo370xodWAWm2kBgJkOqTQn0lGFb/ZCk/auHwo9Jp4d6ME+ZFQGqCRkid4AfckPPgz1Mg1hntvcC0eeXBZ+NfH3rVJslnC5nUjqGEgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OVV4PXhL; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OVV4PXhL"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2d02b4c3601so44917575ad.3
        for <linux-omap@vger.kernel.org>; Mon, 03 Aug 2026 19:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785810310; x=1786415110; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=1OaiGLLoxTsUad13rL5qrpAU9a1lh1UZkttvZnhnlXg=;
        b=OVV4PXhLzZLP8OQoWeJOJafRZj1Q1/uqjr+H4cemRtroqQK1zzAhvSPJEgaMAm/Hn5
         e9pJzZdVt9YDYQojIAtzvRwQEotV0xX2lPqOFdknjKuJHsYgOL+Qtpo3tlSx2i2MGqTM
         hzqp/H8Qaw7iPkEnL9+3OdU5CwOstGRRcE+HAESnBFoJOzH5yArhIFA6XkAnoQSAVu94
         Mgv3sWDXCCVoXSoS935qKLyiCdINFAev03baH6hPwdPoMj0n9UmtCoCLfLalyqgJORkD
         WBpNFsXwS+xhupjFnO1GU826p2lWhZn+bUskAm3vzyAry3zcE6qupz0+07iAqmNdKLX6
         D3mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785810310; x=1786415110;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1OaiGLLoxTsUad13rL5qrpAU9a1lh1UZkttvZnhnlXg=;
        b=dd26PTE92wGIcmUq3K8vAm0uVXQgePSEDJbSyz9pYSSvAvc5DgQxTRC0/kTkCrYrU8
         Yu2vcVaPf4fI6XIFcJYjZiFkqa66nf9lxZcF5X1eebWWm3rk/g2+fKHxgXOqRMJASZ9z
         kZOwMAfBdw50Nx1TTu9w4dEyMxQh7yryHc6zLFUuO7kLjcXMbub7n3mtuJcG6AZ0hOc2
         ktAGYSrFYl7VYKLrZoaVlo9IhWLnlBheVLRnwIi+v1CDG0Bp964Od/DTASVdjHmrG4YP
         yEQpkoJZ+ZZs2DY5NRRajNhUFXE5USnovtMEjD7rp65NVnTvw6WumVbeRsR+CPUQ4ugF
         G6HA==
X-Forwarded-Encrypted: i=1; AHgh+RrMNxCCGN16zAm6OTcLu8houvd9C9KOgEqxuC8NcaCx13U2ofwxw7jIsXmOrkPPx1gED1tZz6U11BqD@vger.kernel.org
X-Gm-Message-State: AOJu0YwLLL/wO5ny4Ci33JJbU0/Z7kEwP5NPnTDljF1GcjZ9FyUJaidV
	ctcUlqj1FRFBcgbmgYzltYHs0v2pa8tln+XCf7MdLxYyFGF4ejsvwMRY
X-Gm-Gg: AR+sD12G69DJYjL0foQCDJCTa0HegGBkcOKbPo/URIPkpq/Ha8q2ITWe506SAarDwXW
	p5FF2+JSKX4vwDLmb2CGhMoo0cppJ2TFDs74TCiIBvbV/PTzTA/iow9NchyUCNccQMdyC743Db7
	2pX+zFj0Kd8/AOb++xvO2fNEgcrFzLM8RU+BIab8vZk8ZxcYmIHf6/BfDYvpPjKPuRAIWX5kRHF
	jscZ9iWsMTXrI/zBCrSDdkyxLq9I6T4ejlisQBPMtcgVJdJHphVwgxX1PR4wJZIn8SxZZDAetRy
	QVAeP+PbBWXGYyBk8j2WdeqKwng3PIUoyt919NtGtzpEZ6YHYbssEz/wjGYMdL/a6etCWgHLrWM
	iP+Yi+TRo10JBSFSQwbjo/v2y5rqq+sw1FXFmTScTgCJtS3rwAA8bfnOy+Ox3pNIOqFPg4e3tYT
	yf6Fa1QczslrIDWd6rtr0TfFyXn+gOsjvibQl6KBYTChze6PyryVz1a8ecYKJpI63OqBR/lT/T
X-Received: by 2002:a17:902:ea05:b0:2c9:d55d:2d3 with SMTP id d9443c01a7336-2d052244e67mr121387165ad.15.1785810309827;
        Mon, 03 Aug 2026 19:25:09 -0700 (PDT)
Received: from osman.mioffice.cn ([43.224.245.178])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d04b1216bdsm45230825ad.69.2026.08.03.19.25.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 19:25:08 -0700 (PDT)
From: Zhan Xusheng <zhanxusheng1024@gmail.com>
X-Google-Original-From: Zhan Xusheng <zhanxusheng@xiaomi.com>
To: Ulf Hansson <ulfh@kernel.org>
Cc: Jisheng Zhang <jszhang@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Sekhar Nori <nsekhar@ti.com>,
	Ravikumar Kattekola <rk@ti.com>,
	Pedro Demarchi Gomes <pedrodemargomes@gmail.com>,
	linux-mmc@vger.kernel.org,
	linux-omap@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhan Xusheng <zhanxusheng@xiaomi.com>,
	stable@vger.kernel.org
Subject: [PATCH] mmc: omap_hsmmc: fix busy_timeout overflow in ns conversion on 32-bit
Date: Tue,  4 Aug 2026 10:25:00 +0800
Message-ID: <20260804022500.3768116-1-zhanxusheng@xiaomi.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

omap_hsmmc_prepare_data() converts the command busy timeout to nanoseconds
with:

	timeout = req->cmd->busy_timeout * NSEC_PER_MSEC;

busy_timeout is an unsigned int (milliseconds) and timeout is a u64, but
NSEC_PER_MSEC is 1000000L.  On 32-bit builds the multiplication is
performed in 32-bit arithmetic and wraps for busy_timeout values above
~4294 ms, before the result is assigned to the u64.

The driver does not set mmc->max_busy_timeout, so the core does not cap the
busy timeout, and commands such as erase or SANITIZE (MMC_SANITIZE_TIMEOUT_MS
is 240000 ms) can pass a busy_timeout far larger than 4294 ms.  The wrapped,
much smaller ns value is then programmed via set_data_timeout(), so the data
timeout is set too short and the operation can time out prematurely.

Cast busy_timeout to u64 before the multiplication so the conversion is done
in 64-bit arithmetic.

Fixes: 8cc9a3e73de1 ("mmc: host: omap_hsmmc: use generic_cmd6_time to program timeout value for CMD6")
Cc: stable@vger.kernel.org
Signed-off-by: Zhan Xusheng <zhanxusheng@xiaomi.com>
---
 drivers/mmc/host/omap_hsmmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 58c881f2725b..3356ac5a1fa0 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -1357,7 +1357,7 @@ omap_hsmmc_prepare_data(struct omap_hsmmc_host *host, struct mmc_request *req)
 	if (req->data == NULL) {
 		OMAP_HSMMC_WRITE(host->base, BLK, 0);
 		if (req->cmd->flags & MMC_RSP_BUSY) {
-			timeout = req->cmd->busy_timeout * NSEC_PER_MSEC;
+			timeout = (u64)req->cmd->busy_timeout * NSEC_PER_MSEC;
 
 			/*
 			 * Set an arbitrary 100ms data timeout for commands with
-- 
2.43.0

