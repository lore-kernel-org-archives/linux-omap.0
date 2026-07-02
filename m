Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9387F4ADD9D;
	Thu,  2 Jul 2026 13:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783000400; cv=none; b=fklqVPGEgTEPs/vilhgExqedkXev4/3y+7TBYGztYXjch6mR3q1Lf37j/e+y9eww6dKiHEOCj3pHzdet/G3b6QxsAtiyhAIjLDJ9tQrZXurVMcWvjTwh0aewDCTMnJvFseGX6YN4FvOtHirAoEpUjHThcTeBG4ryW/OVVy0ad20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783000400; c=relaxed/simple;
	bh=SsHv7eglcq/3f807scK8C7Ri2u8BTa5D48XTbqPe5So=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=JMBFmWuq+bUL/UZw1P6CJxgEUVtDmby9sdUIQu35H/msJKi9ECrwE4NlGF1AqzgQTz0UTtiBw5qMHQdFSEX3Nw+vh8d92gx3pilXMYkmI3X8636VmJ8Id3NTkUDqvVww/zt2H5EB+hd9ITa+UvhHSJ3CpKemHRQflAbCL5NwwMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=a5Eu+OCs; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="a5Eu+OCs"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=Cc:To:Subject:From:Reply-To:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=VCUIIUrab/Ij6Ur23OzvtXOHDAu9y4qtidV7a5tuD+Q=; t=1783000397; x=1784209997; 
	b=a5Eu+OCsdUXnRnVMxsxqiJ9PZEMhELMMmc0o03tPFqHtEK8FSBGbTQFQ7iNpdFaoro2cU1QUv7d
	QyyD/xjmdHBhZ7p6qQlCYaak4Zerh1D48mW+9Zq0XBqdbYoEx9lYrY/+Do7DGYbz1bSiLq7r30Y8c
	9bpbrFmcyFQGeDMCcSQdfl5RKdDS8WdMCDVxQCpdRqccK0ByyGupwhIkwnUfFwvyjv+DRcM6Jq3xo
	J/dF16JSiz/u7IJSn6kHipblSfUmONSqIc2LlTx7sk4t7L9Pu1myyBOEjJVqHmgr+3HlIHsfk79KZ
	Mnvxxhhnduj8jn2Y8iyWmaoNTxYookvqj/sQ==;
From: Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH 0/2] ARM: dts: ti/omap: embt2ws: define RGB LED
Date: Thu, 02 Jul 2026 15:52:42 +0200
Message-Id: <20260702-b200multiled-v1-0-c1799ad45c96@kemnade.info>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACptRmoC/yXMQQqDMBBG4avIrA1MR6rgVcSFiX90RG1JVATx7
 k3b5bd476KIoIhUZxcFHBr1tSY88ozc2K0DjPbJJCwlVyzGCvOyz5vO6I2DVCh80T19SSl5B3g
 9f7um/TvudoLbvg+67w8Z3pWPcAAAAA==
X-Change-ID: 20260702-b200multiled-ce27e3f3a5f6
To: Aaro Koskinen <aaro.koskinen@iki.fi>, 
 Kevin Hilman <khilman@baylibre.com>, Roger Quadros <rogerq@kernel.org>, 
 Tony Lindgren <tony@atomide.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Russell King <linux@armlinux.org.uk>
Cc: linux-omap@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Andreas Kemnade <andreas@kemnade.info>, Pavel Machek <pavel@ucw.cz>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=682; i=andreas@kemnade.info;
 h=from:subject:message-id; bh=SsHv7eglcq/3f807scK8C7Ri2u8BTa5D48XTbqPe5So=;
 b=owGbwMvMwCUm/rzkS6lq2x3G02pJDFluuZaXel0ebnDnbNh3ylGcbR1zj2jmYq5dZ3tnXpLYM
 nOBmZxNRykLgxgXg6yYIssvawW3TyrPcoOnRtjDzGFlAhnCwMUpABOp2sbwP297SPHZ5+ytwSX9
 xXbt+3YzGTWv9Ly7ePOKPxOOCncrZDEyPOo+OUO4Rp3DVv9X/vfJawS3Tl+itOrB1X+btDaZzCr
 8xQcA
X-Developer-Key: i=andreas@kemnade.info; a=openpgp;
 fpr=EEC0DB858E66C0DA70620AC07DBD6AC74DE29324

Combine the LED definitions into an RGB LED and add the drivers into
defconfig.
This has already been suggested a long time ago.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
Andreas Kemnade (2):
      ARM: dts: ti/omap: embt2ws: use mulit-led for RGB LED
      arm: omap2plus_defconfig: Enable multi-LED

 arch/arm/boot/dts/ti/omap/omap4-epson-embt2ws.dts | 13 ++++++++++---
 arch/arm/configs/omap2plus_defconfig              |  2 ++
 2 files changed, 12 insertions(+), 3 deletions(-)
---
base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
change-id: 20260702-b200multiled-ce27e3f3a5f6

Best regards,
--  
Andreas Kemnade <andreas@kemnade.info>

