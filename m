Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E93636196E;
	Fri, 28 Aug 2026 21:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787952611; cv=none; b=tgK+5NPl62bHh8bJMsrTUPTFRQMLTqLUUhtLmVKhUSLW1XRCPjC6t/xm29YiyPosZacF0vXuTjzT/g+2vAUhMALH94kNImajMzLlC/Wwyf6ChW/1Fv4tUZPDsuntxyQqcqJo3mW8Tc4VfAULYxCPaTvwYuBcRXCf/uoxfvWldrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787952611; c=relaxed/simple;
	bh=MIdWbeMcZfGGJ/pZCUQTDeV/oaWcUupEL9QLvxkoY3s=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Os+0v0uhQ7rybIv4wLCg89yqUXCa77MbXcedg90mA32W002Kj1elyHP1cXup/TSi5Nu9Gnq4uuSqsyR85jpNzB+SMg4Gb/+cJqj3REbaj6TNE0tcTIA7lEEZcxxL027vgg4qFbasHS4L4JUaVdgcWvmLu01PoxvpKSfNTVY4ejs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=I473wf8g; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="I473wf8g"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=Subject:To:From:Reply-To:Cc:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=4XP1MNEQIFS/15FmvgwBeVhstHa8LWxSKOwtOogdACw=; t=1787952609; x=1789162209; 
	b=I473wf8gV0ZmgWCPktEeqQMDzkw1+AtNQFRvUAItl7eDjz7hFR3ovxryX+2zmbZMtSeLTeIP6C1
	OAzIh6+70NdJ3L4g/V8QX/LLs0Xmmv5RSJJ6tMQqXiDqwLFWgS4v+2HWFbtwKUKta0Ir3iom5O2EX
	z51eErunUPRKF9uFWv3SeKOm0Wpm7qY3Cf7rgWbtKfB/tslS1lgPltv4YqNMmw1EF4p3i458PpxFw
	qQ9OCrWpQ3KufxitpicUv1UdFBBAzfkfzKoU1PLdwYqkuOwS7e4JrA08jUkmnIuydeija+38/FOR3
	N+MocFL/liDnaKTzf4Y3cIK9Tz4e1Oj3xMzg==;
From: Andreas Kemnade <andreas@kemnade.info>
To: aaro.koskinen@iki.fi,
	andreas@kemnade.info,
	khilman@baylibre.com,
	rogerq@kernel.org,
	tony@atomide.com,
	linux@armlinux.org.uk,
	terrelln@fb.com,
	dsterba@suse.com,
	linux-omap@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: omap2plus_defconfig: Support for compressed firmware
Date: Fri, 28 Aug 2026 23:28:43 +0200
Message-ID: <20260828212843.614296-1-andreas@kemnade.info>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Especially zstd-compressed firmware is at least the standard in Alpine,
so enable it to avoid confusion when using firmware from such distros.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
 arch/arm/configs/omap2plus_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index f827f89567fdf..01b834d4b7106 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -268,6 +268,8 @@ CONFIG_PCI_ENDPOINT_CONFIGFS=y
 CONFIG_PCI_EPF_TEST=m
 CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
+CONFIG_FW_LOADER_COMPRESS=y
+CONFIG_FW_LOADER_COMPRESS_ZSTD=y
 CONFIG_OMAP_OCP2SCP=y
 CONFIG_CONNECTOR=m
 CONFIG_MTD=y
-- 
2.47.3

