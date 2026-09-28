Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F2E04E4C36
	for <linux-omap@vger.kernel.org>; Mon, 28 Sep 2026 17:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790616988; cv=none; b=EPq+i6ZTP7uLv8nv3roeCdDy3qrD+ilayVep/q2vUkoGXoQQrZpiZZV6zojq3KV2Z+oYcZhjgKdSSZkzfiQ07vNy6r8GeTjzxA1HBo47JcIR1FzEagDQNcKDbTBVBkSpB5xtisICQ4MZiP+u4+i1VvUaNvPfWMCa8v14izvb7Pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790616988; c=relaxed/simple;
	bh=bvv2oS4oIBucXPP7+zG21vJ1hRwRJThPHQGWsxYyRG4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dT5Duvmot1EnlM4VRzCoRrh3BTQkMwg9CsRtYQay4lFYLRUo3Tbg4Po0NGAadALpzm+fW00g5ieeXw8iOSCrhEzYay8Tq7GtrpbEJ/CBUEXZI08mRbojgJAte7MUYB+ggXKIRV9P1xquW+KzMZo160RpEGU24zJbdN0XBlQy2HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=moGNaSkf; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="moGNaSkf"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc4c08393b0so1397000a12.0
        for <linux-omap@vger.kernel.org>; Mon, 28 Sep 2026 10:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1790616985; x=1791221785; darn=vger.kernel.org;
        h=content-type:mime-version:message-id:date:subject:cc:to:from:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QcMM/70ueq1BvxYllSAMCDlH687AiK6lQ79IdX64Iy4=;
        b=moGNaSkfTuXcj0FZSXlQ4BsmgG63eNWWVwbc7Vp7xBMleF00iuGuDZ0YsCKKvLfPc6
         F6aqQDaC2fWK0JO+Tta/tM+Kvz55MinwgHHr/rNcW8zWLNC6RORaEiOirvSURIBPA1zw
         Ow6wvaoLtlnRu8xWBBFSEqZ3umvzVMfY/tzk5u1pwAOmAan8IJj0zMiHFPbnbmB11sa2
         UUk1pXObREeS8FFNhN7q4tclGV6rYaBBANpKTDAKwbC2KUR03rTOAFzRka5zJwUx1Vfv
         e36MPgBk2oZyM1nETkurnMB4CSS0R0ejXSLrBcz27XsTAN0GR8TiM9sXBEz2rz8OtIMB
         z8WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790616985; x=1791221785;
        h=content-type:mime-version:message-id:date:subject:cc:to:from
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=QcMM/70ueq1BvxYllSAMCDlH687AiK6lQ79IdX64Iy4=;
        b=XI39SZxdLhBRPOa/WnwFKJ1Cg2pC/+tmc/r+kZtY9M7/mUgzXga4qx2NVJFmqvhnIL
         7iEjk0FDTFxIcg3XTR7dtUedvykwFWLMPmlYlo9nx6iRlnbTPsaDPKAK6Ekhqm2JzQX+
         rch3StB6DMhB+rJ0bS7y5aLQOuwIoIYXieIsUaCf976yVCdTT5bRJnsP1jFK75ynDnWj
         l8B7VAUefoGxNHwQw48aOMf9/mLih4uOU36+3lhU36qX1ze0hVwLibFSkl5WswEiuQ1a
         yBBlxtBnngLQRMVc3/M+3N3ILZ4RuXzsRK1JfeV9me/LlTU3UMoBj0mYXw6Sbb4ujC2M
         jSHw==
X-Gm-Message-State: AFq9FYJkw1t00oFcwNKd63Y1yf9QDYg4FZznaTPbNv+hJPoF8Pv+7a5r
	IB+e2RpqmuMKmC+F9TZUL0ZMtaOSGkg1ek8sRFYDB8922DeT+66rloRRFyqrpNnKvcI=
X-Gm-Gg: AYBFou2NPfLKNpxJrcfrs/KH85sRA5HNQrK6hh0TY+XVsDjEGnxcu9k7XkC8imkNC21
	PreCg/rS9u/VIRvYWxe+ziajrb+g7uyQq13h9HLpWpXVn2baWdWRF00fUcBTSQcFWrRx1vIZGxE
	7dBK1M2b2sv2Yp17UHwuu8GAB9J9OTF2gBzNEw5S4LVMqBAWj3oimGD/W78P3UC22CTknLEIRZh
	u0wATe6oHXfQeLnbTEvYUk/BdWN+gxPoyAMtW0yi/7M1clsZFOgCbbOHmZ2K/P01PP24Gz+GXZ1
	ZA/3Qf5tfdRCP2fKPqv4E738K5jQXin2P6OshWirH411s0ZklfK5QiF+Qqv0trv3qx2IYr6W1d7
	trGYtwJL/KkwsIq3V49HVl9qtKDv4bpRLsvaxLVPjpOvK1tXLL5FPPGQsaEAGaiQ9AX0NsffAdt
	/C4Yt3J00pRafwExZKiqptZfx0rDsm0KXeovwcoT0u4k5aCsa7QW/nxNQsXvvJv8crNyM=
X-Received: by 2002:a17:90b:4cc4:b0:3a0:ace4:d2a9 with SMTP id 98e67ed59e1d1-3a0ace4d746mr9210271a91.64.1790616985559;
        Mon, 28 Sep 2026 10:36:25 -0700 (PDT)
Received: from localhost ([71.212.197.238])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-2df91409040sm46157205ad.41.2026.09.28.10.36.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 10:36:25 -0700 (PDT)
From: Kevin Hilman <khilman@baylibre.com>
To: soc@lists.linux.dev
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [GIT PULL] ARM: dts: OMAP fixes for v7.3-rc
Date: Mon, 28 Sep 2026 10:36:24 -0700
Message-ID: <7hecedb7mv.fsf@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

The following changes since commit cee9395acd8043be0644b25c34bfa86623f2b935:

  Linux 7.3-rc1 (2026-08-30 13:34:40 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap.git tags/omap-for-v7.3/fixes-signed

for you to fetch changes up to 2fabd2f406d0cf787be47b3bbeea99b30004033d:

  ARM: dts: ti/omap: dra7: fix PCIe PHY clock divider definition (2026-08-31 09:54:09 -0700)

----------------------------------------------------------------
ARM: dts: OMAP fixes for v7.3-rc
- ti/omap: dra7: fix PCIe PHY clock divider definition

----------------------------------------------------------------
David Oberhollenzer (1):
      ARM: dts: ti/omap: dra7: fix PCIe PHY clock divider definition

 arch/arm/boot/dts/ti/omap/dra7xx-clocks.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
