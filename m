Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795088296;
	b=4wMk7MnDFUN3ImKYwIWGUMPJGGZn1SQamf0fqsf0WMvkl0E4mOgsKq8wdSGF+mAMW82w
	 QSb4DBMEYhj9P9+/qWU9/qyYppwRMIFldk5X4CASPxv3IzB4MCum6TAjyNEYcR7URH5NM
	 NTcEfomgbzJQWWirn5iZkdcFzEndSqrknvLdOzEREcm/YzVC/XybnAQyj5aE+GVPcCmZw
	 uluENr1Khm6XziIcsKcIr2ImC/r4NUveTMwU18DuI5Y1DrfHE+BaLfg6UxOI8BO1t662w
	 HvR8HsrOCeDbtlWui3Hl+GdQvl4jdrFGF2U2TJt/EQdjNDHoIcvRuMo5EBYIE/drnEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795088296;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=xVm1Ce6+fBSIOk0u3Q7iybNIMr5QVFe+QKMMIi0en+w=;
	b=KZcwRhmgugaEfoISVbLxVyZwyeC18TLRkxOcn4GhzPFnntdKZxQTZbTWbaFw4HLEMneF
	 A1IvklIM7mDa2pLRzbTda3aMqvqBFZtOHePpvmYTIIO/bP9KlqUbm4wbXW0A8Jvy57MPr
	 xLiFgOKTn/HS/S5l86hkj8N0PxcVRsc2wnr8WVIiXh1Pr9j66It25XztEzv44EoZn4sDI
	 5zf1IbSlW+VzJEfbkVqWEBk13nzgFvyDBYO7YjoNekVqb0Q+OQgElQf0+f13BwrBhAFsR
	 QQ9HB/HfIiBC2rXtO72UB4sVBGLZL9mY1gn1GOCKZbSocS9ol+ksdBECv9P/Hv2zLwg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=WiJTMP4l;
	arc=none smtp.remote-ip=185.246.84.56
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCC88606A32A
	for <linux-omap@vger.kernel.org>; Thu, 19 Nov 2026 11:38:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BCC88606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=WiJTMP4l
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id DBCF91A170C;
	Thu, 19 Nov 2026 11:38:13 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id A3D2460237;
	Thu, 19 Nov 2026 11:38:13 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D8C6D11BC1049;
	Thu, 19 Nov 2026 12:38:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1795088287; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=xVm1Ce6+fBSIOk0u3Q7iybNIMr5QVFe+QKMMIi0en+w=;
	b=WiJTMP4lvtAY5cepu4nPJOnIfRD3+YqY3lShoC7++c6DmhX4L35I4tQmQgdlbyEc6bR498
	yx2GlNRdAhlJo+HVCHookO0baA50CymOI69Q+3MgFAr6qpWdbiGPhjJXrtthfXZ2JVwe1S
	4Qz2NeJgT3mgSDeq4LQ28u83vadYixj/wN3o5yc0dYKPEt8MKpv+CARD7QNNipDSN6pDW1
	7Cn91QHtV7sRMjC2PNz3p8oqQomGShFnM+N4Pb8QPibJA1IkfHad/Z2WZoglfLSo0tH+Z2
	sqoO6rJ5J9UL/j6/NpPFAo5kY8SNvfAJBb+sn2GX8rau4bXlOoUhMCXC3L9i7g==
From: Herve Codina <herve.codina@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Kalle Niemi <kaleposti@gmail.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Aaro Koskinen <aaro.koskinen@iki.fi>,
	Andreas Kemnade <andreas@kemnade.info>,
	Kevin Hilman <khilman@baylibre.com>,
	Roger Quadros <rogerq@kernel.org>,
	Tony Lindgren <tony@atomide.com>,
	Russell King <linux@armlinux.org.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Johan Hovold <johan@kernel.org>
Cc: linux-omap@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	driver-core@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Allan Nielsen <allan.nielsen@microchip.com>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	Daniel Machon <daniel.machon@microchip.com>,
	Steen Hegelund <steen.hegelund@microchip.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Herve Codina <herve.codina@bootlin.com>
Subject: [PATCH v11 0/5] lan966x pci device: Add support for SFPs, simple-bus part
Date: Thu, 19 Nov 2026 12:37:51 +0100
Message-ID: <20261119113758.603074-1-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Post: <mailto:linux-omap@vger.kernel.org>
List-Help: <mailto:linux-omap+help@vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-omap+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

Previously, I sent a big picture series adding support for SFP ports
available on the LAN966x PCI device [0].

In this series patches touch several parts and sub-system in the kernel.
Reviews have be done and it makes sense to split the series and send
parts separately.

This current series is the extraction of patches related to the
simple-bus driver. It has to be seen as a continuation of the big
picture series but related to this specific simple-bus part.

Patch 1 fixes an already existing issue reported by Sashiko.
Patch 2 removes the no more useful remove() function.

Patch 3 depopulates devices populated at probe() when the driver is
unbound.

Patch 4 prepares TI OMAP bus-only devices to be populated by the
simple-pm-bus probe().

Patch 5 makes the simple-bus driver compatible with fw_devlink
expectation consisting in creating its child devices at probe.

[0] https://lore.kernel.org/all/20260325143555.451852-1-herve.codina@bootlin.com/

Best regards,
Hervé

Changes:

v10 -> v11
  v10: https://lore.kernel.org/all/20261119110014.582363-6-herve.codina@bootlin.com/

  - Patches 1..4
    No change

  - Patch 5
    Fix commit mentioned in Fixes tag.

v9 -> v10
  v9: https://lore.kernel.org/all/20261109140916.90625-1-herve.codina@bootlin.com/

  - Patches 1..3
    No change

  - Patch 4 (new patch in v10)
    Prepares TI OMAP bus-only devices to be populated by the
    simple-pm-bus probe(). This fixes an issue reported by Sashiko
    related auxdata lookup table dropped in simple_pm_bus_probe().

  - Patch 5 (patch 4 in v9)
    Use of_platform_default_populate() instead of of_platform_populate()
    for bus-only devices to fix the 'unpopulated grandchildren in
    simple_pm_bus_populate()' issue reported by Sashiko.
    Add Fixes tag.

v8 -> v9
  v8: https://lore.kernel.org/all/20260630102717.413501-1-herve.codina@bootlin.com/

  Rebase on top of v7.4-rc1

  - Patch 1 (new patch in v9)
    Fix an issue reported by Sashiko related to possible inconsistencies
    between operations done at probe() and the ones done at remove().

  - Patch 2 (new patch in v9)
    Fully remove the remove() function.

  - Patch 3
    Changed the way depopulate is performed and use devres feature.
    Took into account a pm_runtime possible issue (reported by Sashiko)
    related to async pm_request_idle() triggered when all child devices
    are removed from the bus.

  - Patch 4
    Use devres feature.

v7 -> v8
  v7: https://lore.kernel.org/all/20260511155902.34534-1-herve.codina@bootlin.com/

  Rebase on top of v7.2-rc1
  No nother changes

v6 -> v7

  Rebase on top of v7.1-rc1

  - Patch 1
    No changes

  - Patch 2
    Fix conflict due to device_has_driver_override() introduction.

Older iterations:
  Patches 4 and 5 in the big picture series
  https://lore.kernel.org/all/20260325143555.451852-1-herve.codina@bootlin.com/

Herve Codina (5):
  bus: simple-pm-bus: Avoid inconsistencies between probe() and remove()
  bus: simple-pm-bus: Remove the remove() function
  bus: simple-pm-bus: Remove child devices when the bus is unbound
  ARM: OMAP2+: pdata-quirks: Pass auxdata for simple-bus devices
  bus: simple-pm-bus: Populate child nodes at probe

 arch/arm/mach-omap2/pdata-quirks.c |  1 +
 drivers/bus/simple-pm-bus.c        | 92 ++++++++++++++++++++++--------
 2 files changed, 70 insertions(+), 23 deletions(-)

-- 
2.56.0

