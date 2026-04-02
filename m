Received: from server.couthit.com (server.couthit.com [162.240.164.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D723D319617;
	Thu,  2 Apr 2026 07:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.240.164.96
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775115579; cv=none; b=PEzMWVandaiZ0rwKGseeMJve3Te/fTwk0efHyTtOCHqH/WoLu9AVIwh7FJFGdK0nfQ+5eR33RW37RcKg39yTb99c+OeQ+XNgUVsW+CATmQaPVdQsiaaSVqWkYGbHgCTWr6G/rLEXOKgpViYxVW+4JCHAWte2WWNv9EuflqqRqpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775115579; c=relaxed/simple;
	bh=gnvpVfDftXsB3RJD3NVskRhFgm1HMxcHfQQzF6NBK0s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nz9wW7eUEhkedYJ800YiZbxV54ztTBF6oTYCJ4YnCRi6EVQNCxuLiHRRxZrOZyFAbOCQecHttgkUIgoe+gbmdXx7UN/qXQkTp4UA/1APf2qpNKJyWMW9xLQCVgAjVmjx0puISQab2gC1vqEIkkJLM0amKEpshqjwXU9lSh2EDVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=couthit.com; spf=pass smtp.mailfrom=couthit.com; dkim=pass (2048-bit key) header.d=couthit.com header.i=@couthit.com header.b=ygx/P6W8; arc=none smtp.client-ip=162.240.164.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=couthit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=couthit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=couthit.com header.i=@couthit.com header.b="ygx/P6W8"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=couthit.com
	; s=default; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject
	:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=r3tdzkWJahXLy+LSWRvKEXHEAOI6oc2062GByuofHNo=; b=ygx/P6W8Owm60eaZ5CRaN8imYa
	zTJmeabhw7A00BTwXae2bCtNX+vHgxkgXTkyGqfsTQ5L4e1fuXOGpZwHTTYxh2ZAxtQkn04PDJ+7O
	eilNEEF8nyGCmSZXdEmDdzQhN9k+GHC4T2i38jix5JcdklDwE23bIGOUBhn8hOd3zxAM1y8iRyWIY
	Va4RPvZVHpVzqhOhDETBS/qIARLuetdr/7B2lOSwfJBEsOxQPUvz7crK+p+1bRfI68wotjRWhIgkK
	TmhW+RSiSt19TuPX7nMakMiXRv8lgFg5our+gqbF5J5WSUcFQgzGTsStKvKsX4xjt3okbauzpAiHB
	AaqigIeA==;
Received: from [115.246.246.98] (port=16281 helo=cypher.couthit.local)
	by server.couthit.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.1)
	(envelope-from <parvathi@couthit.com>)
	id 1w8CeG-00000008LE4-1RTM;
	Thu, 02 Apr 2026 03:39:28 -0400
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
Cc: andrew@lunn.ch,
	linux-omap@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
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
Subject: [PATCH v6 0/3] Add support for ICSSM Ethernet on AM57x, AM437x, and AM335x
Date: Thu,  2 Apr 2026 13:06:38 +0530
Message-ID: <20260402073853.2170099-1-parvathi@couthit.com>
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

This is v6 of the patch series [v1].  It addresses comments made on [v5].
This series is based on the latest next-20260401 linux-next.

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

