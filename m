Received: from server.couthit.com (server.couthit.com [162.240.164.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C22F359A88;
	Sat,  7 Mar 2026 12:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.240.164.96
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772886607; cv=none; b=bpYq2PUaIx4diSfUkDWKGp+5inaVV0PZcBL2XbSQqL7hwfQ9bySQVzD78U5Jg+N4oSiZTMAUShegsUmMmYSDSCTTVN/fulflt1F0vzyS2XfXJ+OJq7ZrZGrZ3suM1kGCKfLRlW5tFUcdxlCyepa+sULwzCvtKMG3OwFbAnssxHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772886607; c=relaxed/simple;
	bh=Tg9Q/0Nbc+j06wnP0bVZPU0nw4ZmZpWyPOXlNZNjaeM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jXGPZUdJOb41RIHhHjppt/2jNYSI5rEMXAbvDAEbClYNd6F+dpASvqykmGLo3qdFM0wbRMTsCn+4Z/rf1jQZW9Z730WqGUaw6gCtTk35rXwvP7O9p+/I7PS9WWHE/flKJHxpwqq//x44PHwDgb5O4TEbJqTrtVP2HX2gw3L83oE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=couthit.com; spf=pass smtp.mailfrom=couthit.com; dkim=pass (2048-bit key) header.d=couthit.com header.i=@couthit.com header.b=a8YyQ0Cz; arc=none smtp.client-ip=162.240.164.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=couthit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=couthit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=couthit.com header.i=@couthit.com header.b="a8YyQ0Cz"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=couthit.com
	; s=default; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject
	:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=I35XriUiN/oytfODBA+lqS4SWsmZqu02BclJOKAhPXs=; b=a8YyQ0CzePznFSW2vk+QLqQM8g
	R6wGOJetHMCz9h59y8ELv2xoUeAnQIIjznbCN9j9YauQlvbylpC/Ih+ZUtELrazou5J+mPof7D79u
	EN4FGqZfWvqOtXzyBalVWR4rywERHO0R9+FCvqxBFvDKrsWEHGDKxYB1+1WNfsUmtUYnF9kcbQQR5
	2ytAMl/9LU+NhIPzpTk9/pWoGkc005OSHn7m3IUPOW8e20CylvitL763NhXG6TpXk8MTKAl3g1cWo
	M+Jq0bas6r53SrcleMSowyfoK5i5eBDch34cYCuySJEtKsFlYoJMVbQvPq6IrKJ0EPYUlKm6/bvEd
	Dn7DZ25w==;
Received: from [122.175.9.182] (port=64662 helo=cypher.couthit.local)
	by server.couthit.com with esmtpa (Exim 4.98.1)
	(envelope-from <parvathi@couthit.com>)
	id 1vyql4-00000000pP7-1N6x;
	Sat, 07 Mar 2026 07:27:50 -0500
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
	m-malladi@ti.com,
	krishna@couthit.com,
	mohan@couthit.com,
	pmohan@couthit.com,
	basharath@couthit.com,
	parvathi@couthit.com
Subject: [PATCH v5 0/3] Add support for ICSSM Ethernet on AM57x, AM437x, and AM335x
Date: Sat,  7 Mar 2026 17:53:54 +0530
Message-ID: <20260307122641.738450-1-parvathi@couthit.com>
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

This is v5 of the patch series [v1].  It addresses comments made on [v4].
This series is based on the latest next-20260306 linux-next.

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

Thanks and regards,
Parvathi.

Roger Quadros (3):
  arm: dts: ti: Add device tree support for PRU-ICSS on AM57xx
  arm: dts: ti: Add device tree support for PRU-ICSS on AM437x
  arm: dts: ti: Add device tree support for PRU-ICSS on AM335x

 arch/arm/boot/dts/ti/omap/Makefile            |   5 +
 .../ti/omap/am335x-icev2-prueth-overlay.dtso  | 149 ++++++++++++++++++
 arch/arm/boot/dts/ti/omap/am33xx-l4.dtsi      |  11 ++
 arch/arm/boot/dts/ti/omap/am4372.dtsi         |  11 ++
 arch/arm/boot/dts/ti/omap/am437x-idk-evm.dts  | 103 +++++++++++-
 arch/arm/boot/dts/ti/omap/am57-pruss.dtsi     |  11 ++
 arch/arm/boot/dts/ti/omap/am571x-idk.dts      |   8 +-
 arch/arm/boot/dts/ti/omap/am572x-idk.dts      |  10 +-
 arch/arm/boot/dts/ti/omap/am574x-idk.dts      |  10 +-
 .../boot/dts/ti/omap/am57xx-idk-common.dtsi   |  61 +++++++
 10 files changed, 369 insertions(+), 10 deletions(-)
 create mode 100644 arch/arm/boot/dts/ti/omap/am335x-icev2-prueth-overlay.dtso

-- 
2.43.0

