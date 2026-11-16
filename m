Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.177.127.194
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794855527;
	b=3b+vUGtYc3i6h8+SSWIXzlSPxp75Id3EfO1kKhEEihF38vURRvFJnmwA+CVt9dOw2Fg7
	 YdM4S0ga12iHD52IRQRlR5V6GgLVVRPDSuweu4HvFELRNqJuyHW7LuuRhCbN7QwEPB2Ao
	 GHEX5vHQxd9gjJhIV/NOXCZ8zVjMc7QyeF9WIUZHpBRt1JLgDwjtf0/fGc+ltldrU6UIu
	 uSydJaMw6EGEAZnlEjNPQ3VzQ1mmQJ6isfTqPJe0+s+SzTjIhYpCzNdbSzelKq7kE8UqO
	 Ehwh01OopBgloc/qkFXN/3BKSSLWxKAUS/awL1s+YFkWul63MwkIljRo/RjYvsF+PAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794855527;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Envelope-From;
	bh=OnERbGbeZyB4DLRh/yAtoGCkeRPa0jQKYunCmHKvjZ8=;
	b=yujnwTEYfwTpEnNl++y9CxFhOVbdZWD6EO9+qCn+qU4TH0kz2Z3g6ttsYTV6y8jEpAYA
	 hkJ+P4FfAZaeoKK8fZX37t9+SJosg/p30JP6dQu/S7lW8qjq4m8EhlFBpz+3L2hL0Lyn3
	 o0eBjjON6Xbeem3o0rCOlqboVbl6BcjfNDRlsNxsLCriRE7cIDu1FW7fX9c/YvXq+bJ2o
	 QYy2zc2uecyJGnEIe0jHmJH4P+UbeSRdCNaPdHJbpCNr7qQkw2XJew10i0CbTLq1SL48h
	 6vUcSnE8kXbbL9kymqTYH47Zn0e9SksrOV3QxyyhzKJSx7OrcoSf6lDIqCd0a9TmZYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chrispinetinega.com;
	spf=pass smtp.mailfrom=chrispinetinega.com;
	dkim=pass header.d=chrispinetinega.com header.i=@chrispinetinega.com header.a=rsa-sha256 header.s=default header.b=uQ6QP9qj;
	arc=none smtp.remote-ip=198.177.127.194
Received: from out-utut-a194.jellyfish.systems (out-utut-a194.jellyfish.systems [198.177.127.194])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8496E606A8A4
	for <linux-omap@vger.kernel.org>; Mon, 16 Nov 2026 18:58:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8496E606A8A4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chrispinetinega.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrispinetinega.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=chrispinetinega.com header.i=@chrispinetinega.com header.a=rsa-sha256 header.s=default header.b=uQ6QP9qj
Received: from mail.privateemail.com (unknown [62.8.90.37])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.privateemail.com (Postfix) with ESMTPSA id 4jSxvv4QzWz8sWS;
	Mon, 16 Nov 2026 18:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chrispinetinega.com;
	s=default; t=1794855506;
	bh=OnERbGbeZyB4DLRh/yAtoGCkeRPa0jQKYunCmHKvjZ8=;
	h=From:To:Cc:Subject:Date:From;
	b=uQ6QP9qjtMfL1xyoY0p5DQkJsjPV8GcHjzwZMLGFt2XTkFz+ZG8S3V/77PWtQkrtH
	 0LxHx0rVcj6KYhC0y0jQvPAx3ILqg0eWMdsS+39ewAbySmx3hvkl227W2auY6N5ad2
	 /pHr+D48jqFkGvahmcKAb9PasmQgSpoROoWksgWCN1dq+bMHzoGw06RFTX9ipKzJV8
	 AFwlADs93WWGtqBUcs/awBYtlfe0RjZ7ieEh2niLcdJjnJJGOgRTpyuyRBrrqb60P1
	 pEo6LRWrZuO2MjNbsDM1wbZ7WMxsDkDwH5/lfMEdL4+KiA8Mi3mZyPyUIZ/Xq5nxCo
	 Iuw4YpXlAhNsw==
From: Chrispine Tinega <dev@chrispinetinega.com>
To: Lee Jones <lee@kernel.org>
Cc: lgirdwood@gmail.com,
	broonie@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	aaro.koskinen@iki.fi,
	andreas@kemnade.info,
	khilman@baylibre.com,
	rogerq@kernel.org,
	tony@atomide.com,
	jerome.neanne@baylibre.com,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-omap@vger.kernel.org,
	mfd@lists.linux.dev,
	Chrispine Tinega <dev@chrispinetinega.com>
Subject: [PATCH v2 0/3] mfd: tps65219: Let a board run past the warm threshold
Date: Mon, 16 Nov 2026 21:58:08 +0300
Message-ID: <20261116185811.1907811-1-dev@chrispinetinega.com>
X-Mailer: git-send-email 2.53.0
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
X-Envelope-From: dev@chrispinetinega.com

The TPS65219 has four die temperature sensors, each with a warm and a
hot threshold. With a sensor's warm warning unmasked, the PMIC sequences
all its outputs down at the warm threshold, 110 to 130 C. With all four
masked, it only reports the warning and powers off at the hot threshold,
130 to 150 C. The masks come from NVM, so a board that wants the second
behaviour has to set them on every boot.

The BLIIoT ARMxy BL350, an AM6254 industrial controller rated to 85 C
ambient, ships a vendor kernel that does this from a devicetree flag.
This series adds a binding for it and the driver code, and corrects the
MASK_EFFECT macro on the way: it named bits 2:1 of MASK_CONFIG, which
are warm masks, instead of bits 6:5. Nothing used it yet.

The property is limited to the TPS65219. I have not checked the
MASK_CONFIG layout of the TPS65214 and TPS65215.

This series is build-tested for arm64 with W=1, and dt_binding_check
passes. It has not run on a board in this form. On a BL350, the
vendor's equivalent code sets the same four bits, and the PMIC reads
MASK_CONFIG = 0xef.

A runtime override, for a user who wants the PMIC to shut down at the
warm threshold anyway, is left for a follow-up once someone needs it.

Changes in v2:
- Patch 1: add the Fixes: tag. (Sashiko)
- Patch 2: the binding no longer says the operating system reacts to
  the warning, since nothing does today. Mark's Reviewed-by added.

v1: https://lore.kernel.org/all/20261114032457.3434248-1-dev@chrispinetinega.com/

Chrispine Tinega (3):
  mfd: tps65219: Correct the MASK_EFFECT field of MASK_CONFIG
  regulator: dt-bindings: ti,tps65219: Add ti,no-warm-shutdown
  mfd: tps65219: Keep running past the warm threshold when asked

 .../bindings/regulator/ti,tps65219.yaml           | 10 ++++++++++
 drivers/mfd/tps65219.c                            | 15 +++++++++++++++
 include/linux/mfd/tps65219.h                      |  8 ++++++--
 3 files changed, 31 insertions(+), 2 deletions(-)


base-commit: c92739a23a80f5f0a7c6f3c10aa792102d252ac4
-- 
2.53.0

