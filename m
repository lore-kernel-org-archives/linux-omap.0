Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 069694D9579
	for <linux-omap@vger.kernel.org>; Mon, 28 Sep 2026 17:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790617150; cv=none; b=SGRAA+HxHYkggvHE7hV3Kh5w7FIT4W2/sem9Ok7qvtl3Ds3LHEGhRG5q+UERurPZOh0UCU8VDbciApgOvnH9KddVXG6/9yxsITUZM48/94JMCwBq6d/VenoVCLsJ08bJlZByMHMtRJy8WMrasJ35gRz/YExMsdYsXz2EGuNQftc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790617150; c=relaxed/simple;
	bh=g+4oTeY8QR1R4YLmG26YkV30pNEmlYAmrs8+WG8WE8k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kPwlJfkJfajcBMI/pw62fv2o933Ws5i3ohTd94qz56QIs8Isdf4y5Z2R+4t8pOuKgadgco8gw55Ba4pnQk9g2xXoelSK4VlQCGnceSXoxp5Ag6a7nbFSdR2i4risZNSEiUC9Kafvc1FG6xtKZVWgjwi+9HXv7nsjkFbCAGPdoNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=GOohbCca; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="GOohbCca"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-398cb5615deso2745304a91.3
        for <linux-omap@vger.kernel.org>; Mon, 28 Sep 2026 10:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1790617148; x=1791221948; darn=vger.kernel.org;
        h=content-type:mime-version:message-id:date:subject:cc:to:from:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=KQcSNDmKTezvsQvsnROQYZUeQT8pZqDnSHqZSPctCj8=;
        b=GOohbCca3pdwte5nj6iQrU4LvtHXQCVJa67zUwV1Welx3RNIbQAuydj9NOYj0aNAtC
         +TOslSI4xG5pTwdL3K/d9WT8bBjNjitHwjjyutA0EVH9eUP4UwOxyCrqBBmA14gZfE0p
         RfLgOttsNdzPbg6bXo+JtT03Yglx7Ju8hET9/PvMhrMbOpgWONdB9pSHPGDJnX2vx+oh
         xPG9YLEC+feTkKgT0RNGNpi5ivU/L73or5J9jv0szrDiKFRGJaaHHPNcbYocK78CKUsD
         kcSsRDBpwzUXM0MNFgrfrW7/4XH5cfidCwVRcMQytFt6Av27FROiN50NEoNM+8OhWE1h
         KdkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790617148; x=1791221948;
        h=content-type:mime-version:message-id:date:subject:cc:to:from
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=KQcSNDmKTezvsQvsnROQYZUeQT8pZqDnSHqZSPctCj8=;
        b=PEVXVDIeHXpECUDe1Sgwd3wma76ppipwqIKz+pvhtA9NxJWRLIIyvaH4OC32EasTgG
         Jc8KakStFEyXZNA6sBV5BodnlqFbBbfPiXQfviWG9hpk8Docy0Mz3gSxxBf8oUIaJu/j
         9RafvncdK2Ly1gCVy87AVI6G2daMd6Z/1cd+Iozyj6th/rdYWURlpFnxm1eSNJbX2Z8L
         UPQo45jEDDYxfj0nel07j1f//yfQQLypftI3DLugZlN7APR70KGNW6HGDJAkZzhDhcSL
         Fd/Zsec9Kq4BT+uOiZTTpqQTTNTkSUXMAOgWG8ESvBu4IVvkNgWhd0kg3hpsuOX1yMGh
         IDgA==
X-Gm-Message-State: AFq9FYL9GyaYJc4CS96JnMajC345ADyFqP1HhFEmLzdGk2Cb+Hn5gQXF
	BnTNfREPy21InGvZUXTBwVBwAFYnpIs/g0TVvLBhiZoQmErMlDYQDlrLRy7X6awaPX0=
X-Gm-Gg: AYBFou2VwKPmfvh3XnszOZuXpwLja1N85+yEbkPC2VLML4XlUMzwc0CkUucQqnmx2qg
	ZQQ6dSc5iFno8d3xWJD2DTL9zLoh/J7RDNcGCWGuhkveFc6tHpDiZNogYWRew7iZauDrYBaLVVz
	etFa3K9ttHKuiJY8N44OZOs86qE/BgJa1QmjXSeRKnjgFDfIlN1yn4YahdnxHj8MvAY8306A2EA
	hv8N/Tjp2xfc/YOSz9wxZn4UxJRK+0jKCNQkIDSHUyw5Gwlzf5Q2jG68TQrsJjSg4yASzsk2YOp
	J6zElJrA0iu9Mi3pik4jTnfPiQygOUOwsmGYpthwOL4w9YicoMK97z+PgB5feC36XRUB+fXpj1q
	JI32Djk8eo1VGboe/FcCy+tGUDs6DI6TdlFIjWOazDCMPwK+jB6nZX329/JN+hoA3DTFYorMoF7
	yJxETzAbDeHOJorN/cAPDfQlJw596AAkOBmeDWwTDYLR7OhyKgWyNfSL9pvg8zENyG7kE=
X-Received: by 2002:a17:90b:4b86:b0:3a0:ea9b:1e38 with SMTP id 98e67ed59e1d1-3a0ea9b31d0mr5816499a91.27.1790617148332;
        Mon, 28 Sep 2026 10:39:08 -0700 (PDT)
Received: from localhost ([71.212.197.238])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-3a4986e964asm515286a91.15.2026.09.28.10.39.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 10:39:07 -0700 (PDT)
From: Kevin Hilman <khilman@baylibre.com>
To: soc@lists.linux.dev
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [GIT PULL] arm: soc: OMAP fixes for v7.4
Date: Mon, 28 Sep 2026 10:39:07 -0700
Message-ID: <7hzex19sxw.fsf@baylibre.com>
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

  git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap.git tags/omap-for-v7.4/soc-signed

for you to fetch changes up to d1e94aea2b15f076d3f95b309fbb372a8fe2e9f0:

  ARM: OMAP2+: remove unused ctrl_module_wkup_44xx.h header (2026-09-21 09:01:49 -0700)

----------------------------------------------------------------
arm: soc: OMAP fixes for v7.4
- remove unused ctrl_module_wkup_44xx.h header
- Replace __ASSEMBLY__ with __ASSEMBLER__

----------------------------------------------------------------
Ethan Nelson-Moore (1):
      ARM: OMAP2+: remove unused ctrl_module_wkup_44xx.h header

Thomas Huth (1):
      ARM: OMAP2+: Replace __ASSEMBLY__ with __ASSEMBLER__

 arch/arm/mach-omap2/control.h               |  8 ++++----
 arch/arm/mach-omap2/ctrl_module_wkup_44xx.h | 89 -----------------------------------------------------------------------------------------
 arch/arm/mach-omap2/soc.h                   |  4 ++--
 arch/arm/mach-omap2/sram.h                  |  4 ++--
 4 files changed, 8 insertions(+), 97 deletions(-)
 delete mode 100644 arch/arm/mach-omap2/ctrl_module_wkup_44xx.h
