Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=178.238.236.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794307659;
	b=yKdrmbcGL/5HLkplesV9at8N8lyrJHLNR0bpUsvblZA+BR45Wpb460OyWkOilCSZcdk2
	 ELmOHXivDb+Ge9o39y6I5hSbZuX17R7kMs7Ks6VTQnQKeEgwGGlu7pzpgu+rYXyaOaOi1
	 0nzNwg4d6iFzVOEwleafmU4icPSsTvevmeLil6DdOQom3c8f2GfY2joPCOzM/FKW0iUtS
	 cx9aZShHIPYaTWiggDhH78W7cfS4uzTzlHXX8SsX8wb4KK6nhfby3n4C+5kqwnU3KpD5v
	 RDvFkBv0g/fOF46XjvCYml++qPXYRrE6jxJHMKEy8N9oZQFRWNUh76+Mn7WCjzEv8cA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794307659;
	h=DMARC-Filter:DKIM-Signature:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=ASLqw2WGbahgy28JlRBtOez+HQ1G/chLD0+bBWmi0SE=;
	b=TfaqMmM1EvTNhoiV06bKqUd/VBrSvz2cQYXPXqZyAPCYECMb3OMNLGGN3jxMXL8W+4nm
	 A6wGyY1FLxICyTAqtc34tnT2cVb8moIke+3rtSwB960Agns/iY1kPjhPBDaciCzDXSjFv
	 XMgcEqgtqmh7zREKvvJKTFigxPSRklgetkVjWB+Yl9KBtWtvXTAyqoLuhdX455c6iBO6X
	 UO+l4jc99a49mfcGNeAUH0pgh+TEerbRFDeYl2JGwCxljQ9dqJXlD2uxaDZd4NEEbdZY3
	 kvMxtwmcFEdRD8MBBZiQwviRcJSVfRxqQyfHM5b5XvpTkvyVW6WPRd1Rg+KHnny76bg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kemnade.info;
	spf=pass smtp.mailfrom=kemnade.info;
	dkim=pass header.d=kemnade.info header.i=@kemnade.info header.a=rsa-sha256 header.s=20220719 header.b=t38ENQwe;
	arc=none smtp.remote-ip=178.238.236.174
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A72B60A2602;
	Tue, 10 Nov 2026 10:47:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1A72B60A2602
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.a=rsa-sha256 header.s=20220719 header.b=t38ENQwe
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=Cc:To:Subject:From:Reply-To:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=ASLqw2WGbahgy28JlRBtOez+HQ1G/chLD0+bBWmi0SE=; t=1794307658; x=1795517258; 
	b=t38ENQweXhhALL9ce6wSfPokSHj9eWy7a5Fiv4bUEVfVnr1YHD5NP4xR6KHoeWI3MVNj668s5MV
	OcCJ7FPZPgN3pL/M776yoLq3nndCoCOW4Nzv2oylHgBXNgqL0n70kZ67PNny0FGS9HUzZCN1ks23U
	tIaxFkKTNOar5q2nnU4XI5cPrSthPppMN/oezjBbN2CcK18zvVZ8ObY6Y3l3NoZDJVR2uy5CLjXbF
	Dcc+F0Wgy2rEOl74r1oUoJCbjH1TyPDMLvxAjGKtptnGpswQFM3sGk2xtFjEbU5GuBpHOFnL8ei6x
	0WkHym1yWSh5fNYcOVe8G3ucaXonJ9Tv99Gg==;
From: Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH 0/3] ARM: OMAP2+: Convert OMAP3 I2C to ti-sysc
Date: Tue, 10 Nov 2026 11:46:11 +0100
Message-Id: <20261110-i2c-sysc-v1-0-8945eb1d38f0@kemnade.info>
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Post: <mailto:linux-omap@vger.kernel.org>
List-Help: <mailto:linux-omap+help@vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-omap+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPP18moC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzNDQwNL3UyjZN3iyuJk3UQDEwsTA8vElBTzZCWg8oKi1LTMCrBR0bEQfnF
 pUlZqcglIv1JtLQAhbNcQbAAAAA==
X-Change-ID: 20261109-i2c-sysc-a048409add7c
To: Aaro Koskinen <aaro.koskinen@iki.fi>, 
 Kevin Hilman <khilman@baylibre.com>, Roger Quadros <rogerq@kernel.org>, 
 Tony Lindgren <tony@atomide.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Andi Shyti <andi.shyti@kernel.org>, 
 Thomas Richard <thomas.richard@bootlin.com>, 
 Wolfram Sang <wsa+renesas@sang-engineering.com>, 
 Paul Walmsley <paul@pwsan.com>, Russell King <linux@armlinux.org.uk>
Cc: Sicelo <absicsz@gmail.com>, linux-omap@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 Andreas Kemnade <andreas@kemnade.info>
X-Mailer: b4 0.17-dev-e5168
X-Developer-Signature: v=1; a=openpgp-sha256; l=1855; i=andreas@kemnade.info;
 h=from:subject:message-id; bh=UpJFh3PoDVLDvH5ZyfVZJskuEuyBbcLwqnc8Mv+3bBU=;
 b=owEBbQKS/ZANAwAKAYRhRfpAKNzxAcsmYgBq8vX1gYnY6WBKpOV/s0cKqWQ+BblbUs9VGyvUi
 UXRkWqdBDeJAjMEAAEKAB0WIQTY6xCZL0TEE1XHfFiEYUX6QCjc8QUCavL19QAKCRCEYUX6QCjc
 8asFD/9N28I5MAn+G62R1raiCjybOhvk/9jzVVtTBSX40orXPAP3slpGKAtFJFNMOAqOymBMozO
 bVNdQxzXev87w4+vrKANxmX4Yz/w0Gy+QxqxK615EHpGBAVZFhqvfPdkDBrlXIdqimkkXYj3tIM
 80FRftdpcETvd0ixPhHXSIYKllbVVdqpRoN+eMcKBxfiZ+uTCX+unjAqwagz+1xUIyBKsmpNcmr
 D4Na4hmyh+m4waUJIaYIDV0vk8GqnDqDV0KFTCUWZliGbAxVBhX6wCZs+xnATyjT/RBgFDH5AL5
 0BbDowYCWnVRkDuo2FMWJFuIQ1I67VYQAyxIIWra9a3d57Edw0luOfcPXUxhIozUxDftSYpZ+Z8
 OVs5Cx5xPpyxIiC+WVxIGvsazunnP+y5d3OH+qzTkLpYAcV3TqPbFL+XqQz3YZrAhF3g9O4mKfA
 hvlch33UPXzavQoRWSRp7GAPaRTyG7dsgBoZYCEwFabaD5m+y5Y9Ys3B9lxQC0wZEBKjXIMA/7e
 Th+trVdQy5aSyvDiCUs1UZ4YfNRMgDw8CS3WNu9v4ZnscdRVSe23LkM5aJtRtj+hI0NylH6LCHR
 Nwn3Zz5gRfsAV1UgUkvOE+b2tqk2jdGu4HN12opa1plFphoJt3C0f0T3q3fJioUG7cZEiQ/Ysq3
 u8TDixS37Lcx/Rg==
X-Developer-Key: i=andreas@kemnade.info; a=openpgp;
 fpr=EEC0DB858E66C0DA70620AC07DBD6AC74DE29324

During suspend on OMAP3, I2C suspend oopses. This is a longer standing issue,
in the past I mostly tested runtime suspendidle behaviour on that platform
(including uart autosuspend). A change in the I2C driver fixes some corner
cases in pm for ti-sysc based systems, but breaks systems using the deprecated
ti,hwmods property. 
To avoid that maintainance overhead, convert the i2c definition
First fix the I2C quirk needed for these older chips. OMAP2 stuff
is not touched due to its planned removal.
After OMAP2 is removed, arch/arm/mach-omap2/i2c.c can be removed, too.
I may try to check again if there is some safe fix in omap_device.c
but changing things there has a very high chance of unexpected side
effects.

Handling the commits:
In the past (e.g. around commit
42a79edd4a3dc1bb8e89fd2849f9e8e1e1c13977 for converting musb to ti-sys)
these changes were handled through a separate branch to keep them in
order.
Here is a hard requirement of the order. Patch 3 can most easily wait
but having patch 2 after patch 1 is a hard requirement. As the
affected devices get their devicetree updated with the kernel,
that should not hurt too much.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
Andreas Kemnade (3):
      bus: ti-sysc: fix I2C quirk for OMAP3 variants
      ARM: dts: ti/omap: describe omap3 i2c via ti-sysc
      ARM: OMAP2+: remove i2c from OMAP3 hwmods list

 arch/arm/boot/dts/ti/omap/omap3.dtsi       |  96 ++++++++++++++++++++-----
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c | 112 -----------------------------
 drivers/bus/ti-sysc.c                      |  19 +++--
 3 files changed, 91 insertions(+), 136 deletions(-)
---
base-commit: 7475ea8b58616b33c04afb976cf0fbaad9dd63fb
change-id: 20261109-i2c-sysc-a048409add7c

Best regards,
--  
Andreas Kemnade <andreas@kemnade.info>

