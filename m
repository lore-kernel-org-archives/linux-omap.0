Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=178.238.236.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793448355;
	b=O6RtxAyqki5IBng9KtSfcV1hiKT9mUqlIBsIA/fiZHtCUt7Zj1QWDPAdsaK3XpEJUGxc
	 1XwgYL9XBGOGN9mRxPDVPZxMo7nxSRSKvbA34MBYYbaaEcurf1aNnYpp9Q7G6uo1NPrDd
	 xDlFN2tXxT1Bk8oDXjJAl9YBm8lXqpFjmzPJBVSuEZ2FmvLqOTEt8Ii8q9ZbC2CqHIPXs
	 TvarXDL1i/6rywIweNtbSIIpddbpx2ZrWk6UUk18yVBXFgkbaKVw5nDlpoXbcGcPWsC4T
	 vLA1ZNOyc0h8mNYesKROWrwEUqjHzC+2LUdIzIyHvpWh95VrqEv7hGDMv53EVmchBiw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793448355;
	h=DMARC-Filter:DKIM-Signature:From:To:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=FnY35YNWnpPA4T/VaWdk7Fmbza5uMATO+i3TxNWIYUA=;
	b=m+nkThM/QHJG2dQW4YrQQGdFJyi3NJe5zrP0LUEU5GVroAWnXL6Uhtt6aogKS2++3oUt
	 H5Q9SvkI6fYrCuknVaNTPt0wKWNQflhddvd0FG6QYeKvvrASQNn2qBfCz+rHFs634aRC7
	 eg7Q4JSY2NSGUg2+LQc7zpd4SMFAa8dzO9xGKWojIFO2gHkK0SIlsDeObBhKTYnUhCBuX
	 JIdaDVcgcyG5XqDtGZiCFx3cn3smrpUEpolGlUucer5w2Ih/05VeFJWG5PInTL1OiDhgM
	 +OvbVuF3IAqKDs6yk90KrBrkqdVMnHLBcwAxRgE9czStWvONBnIdosHf/gYeBNWGT6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kemnade.info;
	spf=pass smtp.mailfrom=kemnade.info;
	dkim=pass header.d=kemnade.info header.i=@kemnade.info header.a=rsa-sha256 header.s=20220719 header.b=n+1YAE8p;
	arc=none smtp.remote-ip=178.238.236.174
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D610606A31A;
	Sat, 31 Oct 2026 12:05:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2D610606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kemnade.info header.i=@kemnade.info header.a=rsa-sha256 header.s=20220719 header.b=n+1YAE8p
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=Subject:To:From:Reply-To:Cc:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=FnY35YNWnpPA4T/VaWdk7Fmbza5uMATO+i3TxNWIYUA=; t=1793448354; x=1794657954; 
	b=n+1YAE8p7e27O8fip+F9HPoTBplnuz+rUbBwK8xTC9Opa05450qrN8WP58klyZAh5mZW+2XS9Iy
	19FB9ovaNfaEjsUGFiHqm/0G7OjJIgtkswKULxb9/9FMfCcCcRR5AV928vGnu5III4DHN09XvLCiD
	7R1d9Z+o3cU+ZsWuvZZoRVDQGq8RnQjZ37n9icYl98+hI3/Vf5EcnD8i73tfVo5QOv35ZN/x2/dEw
	MDVfNCzf4Df8EVe/WQQWnwsJ653OVAxGUd2f1K5BAHIeA8pIVunLo0nNxqx/EI1IPFNHT/XCDrC/b
	ma7hpr7aDbdfqK7HTf79C2SmrcxIfLJedkhQ==;
From: Andreas Kemnade <andreas@kemnade.info>
To: paul@pwsan.com,
	aaro.koskinen@iki.fi,
	andreas@kemnade.info,
	khilman@baylibre.com,
	rogerq@kernel.org,
	tony@atomide.com,
	linux@armlinux.org.uk,
	linux-omap@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: omap: omap_hwmod: do not WARN() on missing nodes for hwmods
Date: Sat, 31 Oct 2026 13:05:19 +0100
Message-ID: <20261031120519.655248-1-andreas@kemnade.info>
X-Mailer: git-send-email 2.47.3
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Post: <mailto:linux-omap@vger.kernel.org>
List-Help: <mailto:linux-omap+help@vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-omap+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If devices are converted from hwmod to ti-sysc, there might be an interim
state with the hwmod data still present but the devicetree not referencing
the hwmod. In such cases, the hwmod device data is still there,
the hwmod infrastructure does ignore that device but prints out a big
alarming WARN().
Be more silent in that case to avoid needing putting devicetree and
code changes into one patch but into one series, only require the
hwmod cleanup to come after the devicetree conversion.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
 arch/arm/mach-omap2/omap_hwmod.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 03cd523dff87..a67442a6a2c6 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -2329,8 +2329,10 @@ static int __init _init(struct omap_hwmod *oh, void *data)
 
 	r = _init_mpu_rt_base(oh, NULL, index, np);
 	if (r < 0) {
-		WARN(1, "omap_hwmod: %s: doesn't have mpu register target base\n",
-		     oh->name);
+		/* there might be a transition ongoing from hwmod to ti-sys */
+		if (np)
+			WARN(1, "omap_hwmod: %s: doesn't have mpu register target base\n",
+			     oh->name);
 		r = 0;
 		goto out_put_node;
 	}
-- 
2.47.3

