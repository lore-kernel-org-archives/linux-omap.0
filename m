Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F8F352007;
	Tue, 16 Jun 2026 18:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781632938; cv=none; b=F64GP55WaqBm4c6fGjH6qrQOkEFHi16w9nPTUGFtztO+aycc61lH7sTl47FygnHdZ/BEvhTU9z9YSIMesJGzyjeyaLfEF9/6069AsR9T9lvVeywoJCXPye5aVYl284NMrO3yvuBTQCglsp4VEKGwW0oVrN/k4pD2lCsV6JeJpbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781632938; c=relaxed/simple;
	bh=T6vaIAkCD1fr6HICgze0QFFtLTScwroIuelWGLmOlLw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=o8/5WGHDvLzuPqKuXbUKup1xSM7P0UdrXc0E2E2SygVuoosh2437AW6J4tugvAvftXRCsquMc5hqC6wedDyp7sZKtwjmcFDZXUsV0siOEIUx3Khw7Z8z0ETkzOxvWL9ZTR7v5mNDU5zYRHCHD50tICxHGh9rFi71qNITjcCWtlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=gv8gmT3/; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="gv8gmT3/"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=Subject:To:From:Reply-To:Cc:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=VqBp2YLsM32E0REqpNCDe06V2yuMHSi6VSGKJN37n6U=; t=1781632937; x=1782842537; 
	b=gv8gmT3/NoJ9X6IqRwS0sOmZfRH05O/mICMojdBk2H/X+AIVUz7J90Ya/7y0l4618IICKi+STie
	bs7OcjefoaYPwqXE6g0y8+GcdAZBk1NfohIqCA6qyzwhhXjFFQIS8hX1Teux3qhQwdOH4Yti90JeQ
	vsaKwtIo5mY59XgduorFNRBr8s7qEl3Ron54uGyVLwt/zhh2PIA9pXEkluH1IGZXt5Nj+2XFEdxco
	0k58DRkyAhxaH66NQhX6k7sRZ8fggwRqZjnHOCkCWrI9+AWcyTsRQA3geVZyxoSfDxBTLIjP/BuHi
	uH0k4Q9w7j5BhreFlwUGpal+yAm7XpcGLuBA==;
From: Andreas Kemnade <andreas@kemnade.info>
To: aaro.koskinen@iki.fi,
	andreas@kemnade.info,
	khilman@baylibre.com,
	rogerq@kernel.org,
	tony@atomide.com,
	linux@armlinux.org.uk,
	linux-omap@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: omap2plus_defconfig: enable things required by iwd
Date: Tue, 16 Jun 2026 19:51:52 +0200
Message-ID: <20260616175152.1373709-1-andreas@kemnade.info>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Several crypto related things are missing for opreation of iwd, turn
them on according to the list being printed out.

:~# /usr/libexec/iwd &
:~# No HMAC(SHA1) support found
No HMAC(MD5) support found
No CMAC(AES) support found
No HMAC(SHA256) support not found
No HMAC(SHA512) support found, certain TLS connections might fail
DES support not found
AES support not found
No CBC(DES3_EDE) support found, certain TLS connections might fail
No CBC(AES) support found, WPS will not be available
No Diffie-Hellman support found, WPS will not be available
The following options are missing in the kernel:
        CONFIG_CRYPTO_USER_API_HASH
        CONFIG_CRYPTO_USER_API_SKCIPHER
        CONFIG_KEY_DH_OPERATIONS
        CONFIG_CRYPTO_ECB
        CONFIG_CRYPTO_MD5
        CONFIG_CRYPTO_CBC
        CONFIG_CRYPTO_SHA256
        CONFIG_CRYPTO_AES
        CONFIG_CRYPTO_DES
        CONFIG_CRYPTO_CMAC
        CONFIG_CRYPTO_HMAC
        CONFIG_CRYPTO_SHA512
        CONFIG_CRYPTO_SHA1

Apparently missing USER_API_SKCIPHER did also
hide some things for iwd.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
 arch/arm/configs/omap2plus_defconfig | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index ad5ae1636dee..fa6fb8b27f93 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -257,6 +257,9 @@ CONFIG_RXKAD=y
 CONFIG_CFG80211=m
 CONFIG_CFG80211_WEXT=y
 CONFIG_MAC80211=m
+CONFIG_RFKILL=m
+CONFIG_RFKILL_INPUT=y
+CONFIG_RFKILL_GPIO=m
 CONFIG_PCI=y
 CONFIG_PCI_MSI=y
 CONFIG_PCI_DRA7XX_EP=y
@@ -703,7 +706,15 @@ CONFIG_NFS_V4=y
 CONFIG_ROOT_NFS=y
 CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_ISO8859_1=y
+CONFIG_KEY_DH_OPERATIONS=y
 CONFIG_SECURITY=y
+CONFIG_CRYPTO_DH_RFC7919_GROUPS=y
+CONFIG_CRYPTO_DES=m
+CONFIG_CRYPTO_DEFLATE=y
+CONFIG_CRYPTO_LZO=y
+CONFIG_CRYPTO_ZSTD=y
+CONFIG_CRYPTO_USER_API_HASH=m
+CONFIG_CRYPTO_USER_API_SKCIPHER=m
 CONFIG_CRYPTO_GHASH_ARM_CE=m
 CONFIG_CRYPTO_AES=m
 CONFIG_CRYPTO_AES_ARM_BS=m
-- 
2.47.3

