Received: from server.couthit.com (server.couthit.com [162.240.164.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 440623C9ED6;
	Tue, 28 Apr 2026 07:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.240.164.96
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777361405; cv=none; b=o/EpGidwdNXfKYagHgo8QyLQlEO5iqFZmpNvd2wNhNP09xzuyJLaVEBDl+STvUywy+Vmg1Aq5n3O7TiVvYp8wA2xS9A577X/aeA7iaNq0nNv1uyJs/ssBoZRT+bP3fdnTZB54RgQb1/777QR/Jv51OWrS4Qzck+i53vIghFYHM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777361405; c=relaxed/simple;
	bh=77phWsaigQmSYE4bT5DU9fTaMkciOvN27E52vUWUBNI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bH2HAWVioIYuyUF8IpBi4OxE6ZeIBlNjcsOv+I8Kv0nJ6/71oEKNKyOyVE/vvA3vwe8vtSYYFDIHeza7msdtBJ65nACuR5iGCw+46vInSQqVXdS9ijPWOs9zQrgBrQ6nvaRrIbaE8j6LwPIRHQnEaEfzJV6kiF4DTw8tCax4x2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=couthit.com; spf=pass smtp.mailfrom=couthit.com; dkim=pass (2048-bit key) header.d=couthit.com header.i=@couthit.com header.b=YPoiHbCx; arc=none smtp.client-ip=162.240.164.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=couthit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=couthit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=couthit.com header.i=@couthit.com header.b="YPoiHbCx"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=couthit.com
	; s=default; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject
	:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=5LBdL41YcH/krzzVhyyE3Vtp0Kla/ikLLpLRIkmMtI0=; b=YPoiHbCxXzMK6L4OIpCrpb51q5
	t4A5VVrsiGzd5eE14J0FD9xpOSDrOQgM4snezahqOdtkOZXVaLg1zWW3oBCiPif3/r0AILOF9/4ZQ
	nX2sTfhcQm2JBdX+etP3qnwUAwPVKZ+3TKZ4GC1H8g+yhrQ06j5sSfqj0sev2ZYprN6ZTfaT+/lpT
	6IocEYKpySGzAltAiE/kft/YD8OXhlvBwSPoGi+nWcuvrVPj8AFNUSHY/+vRNUILHWegkB9Pbzh+5
	X+Da1ZqpbJo8Nls/q7hni99ALvDXWap5GEzaqu7JpTXy8i0XhvcLDV1PMDQOZDIxHT6l47wKfaYyY
	uGFk+xog==;
Received: from [115.246.246.98] (port=30876 helo=cypher.couthit.local)
	by server.couthit.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.1)
	(envelope-from <parvathi@couthit.com>)
	id 1wHclA-0000000GFVv-3Ahw;
	Tue, 28 Apr 2026 03:21:33 -0400
From: Parvathi Pudi <parvathi@couthit.com>
To: nm@ti.com,
	vigneshr@ti.com,
	afd@ti.com,
	khilman@baylibre.com,
	rogerq@kernel.org,
	tony@atomide.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	richardcochran@gmail.com,
	aaro.koskinen@iki.fi,
	andreas@kemnade.info
Cc: linux-omap@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	andrew@lunn.ch,
	danishanwar@ti.com,
	pratheesh@ti.com,
	j-rameshbabu@ti.com,
	praneeth@ti.com,
	srk@ti.com,
	rogerq@ti.com,
	krishna@couthit.com,
	mohan@couthit.com,
	pmohan@couthit.com,
	basharath@couthit.com,
	parvathi@couthit.com
Subject: [PATCH v7 0/3] Add support for ICSSM Ethernet on AM57x, AM437x, and AM335x
Date: Tue, 28 Apr 2026 12:47:26 +0530
Message-ID: <20260428072046.3022679-1-parvathi@couthit.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - server.couthit.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - couthit.com
X-Get-Message-Sender-Via: server.couthit.com: authenticated_id: parvathi@couthit.com
X-Authenticated-Sender: server.couthit.com: parvathi@couthit.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 

Hi,

This series adds support for ICSSM Ethernet on Texas Instruments AM57x,
AM437x and AM335x platforms.

The AM57x and AM437x IDKs support two PRU-ICSS instances, each consisting
of two PRU cores, with each PRU-ICSS instance capable of handling two
Ethernet ports. For the AM57x platforms, the PRU-ICSS2 node has been added
to the am57xx-idk-common.dtsi, while for the AM437x platform, the PRU-ICSS1
node has been added to the am437x-idk-evm.dts.

The AM335x ICE features a single PRU-ICSS instance. A new device tree overlay
source file, am335x-icev2-prueth-overlay.dtso, has been introduced to define the
PRU-ICSS node for the AM335x platform.

This is v7 of the patch series [v1]. This series is based on the latest
next-20260427 linux-next.

Changes from v6 to v7 :

*) No code changes were made, only the version was updated.
*) Rebased the series on latest linux-next.

Changes from v5 to v6 :

*) Addressed Kevin Hilman, Krzysztof and Andrew lunn comments on patch 3 of
the series.
*) Fixed an issue with overlaying "output-low" property in "mux-mii-hog"
sub-node under "gpio3" node.
*) Rebased the series on latest linux-next.

Changes from v4 to v5 :

*) Addressed Andrew Davis's comments on patch 2 of the series.
*) Addressed Andrew Lunn and Nikolaus Schaller comments on patch 2 of the series.
*) Rebased the series on latest linux-next.

Changes from v3 to v4 :

*) No code changes were made, only the version was updated.
*) Rebased the series on latest linux-next.

Changes from v2 to v3 :

*) Addressed Andrew Davis's comment by placing PRUETH nodes in a new overlay file
am335x-icev2-prueth-overlay.dtso.
*) Rebased the series on latest linux-next.

Changes from v1 to v2 :

*) Addressed Andrew Lunn's comment on patch 1 of the series.
*) Addressed MD Danish Anwar comment on patch 1 of the series.
*) Rebased the series on latest linux-next.

[v1] https://lore.kernel.org/all/20251013125401.1435486-1-parvathi@couthit.com/
[v2] https://lore.kernel.org/all/20251103124820.1679167-1-parvathi@couthit.com/
[v3] https://lore.kernel.org/all/20251217130715.1327138-1-parvathi@couthit.com/
[v4] https://lore.kernel.org/all/20260105162546.1809714-1-parvathi@couthit.com/
[v5] https://lore.kernel.org/all/20260307122641.738450-1-parvathi@couthit.com/
[v6] https://lore.kernel.org/all/20260402073853.2170099-1-parvathi@couthit.com/

Thanks and Regards,
Parvathi

Roger Quadros (3):
  arm: dts: ti: Add device tree support for PRU-ICSS on AM57xx
  arm: dts: ti: Add device tree support for PRU-ICSS on AM437x
  arm: dts: ti: Add device tree support for PRU-ICSS on AM335x

 arch/arm/boot/dts/ti/omap/Makefile            |   4 +
 .../ti/omap/am335x-icev2-prueth-overlay.dtso  | 156 ++++++++++++++++++
 arch/arm/boot/dts/ti/omap/am33xx-l4.dtsi      |  11 ++
 arch/arm/boot/dts/ti/omap/am4372.dtsi         |  11 ++
 arch/arm/boot/dts/ti/omap/am437x-idk-evm.dts  | 103 +++++++++++-
 arch/arm/boot/dts/ti/omap/am57-pruss.dtsi     |  11 ++
 arch/arm/boot/dts/ti/omap/am571x-idk.dts      |   8 +-
 arch/arm/boot/dts/ti/omap/am572x-idk.dts      |  10 +-
 arch/arm/boot/dts/ti/omap/am574x-idk.dts      |  10 +-
 .../boot/dts/ti/omap/am57xx-idk-common.dtsi   |  61 +++++++
 10 files changed, 375 insertions(+), 10 deletions(-)
 create mode 100644 arch/arm/boot/dts/ti/omap/am335x-icev2-prueth-overlay.dtso

-- 
2.43.0

