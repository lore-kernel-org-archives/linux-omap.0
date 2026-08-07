Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7BD938C2A7
	for <linux-omap@vger.kernel.org>; Fri,  7 Aug 2026 03:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786074890; cv=none; b=SY7n/b3fWLoXty6y2FOq8ukiETqZFCO0/yP59LbET/wV+b8d+14EilkpUi61mcbLsqDajGuOrehetqny7qJ6JQbfJFF+QvLth7NsI/s4egHEe9nnzlYqos1P7TS44nfyTbE65sou5smpxBSq9HFZX/wWzEgbVEVMXXkbFpxLjgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786074890; c=relaxed/simple;
	bh=0sH4sURiae0LHASZoJFMCPq/NTJJVHw/k0CxfIhRpZo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=D73SwwYm7DBExRPEEiPJT2jZbTZgzyFre856lIO2iDX0Q9NRnyKpbOcuQtGL0hrM0FxLnzyoG1sRuQvuTSi/Ia8xqtcrPSjVdKyrIKJvpzExoVjm1VqcTOJSlSECYEd/ulWiVNF6Jcb3FT6lbnRaogiCUhXuzKNyG7b+UQKVz+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a8/AoMmR; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a8/AoMmR"
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7e9eaf04bfaso1139683a34.1
        for <linux-omap@vger.kernel.org>; Thu, 06 Aug 2026 20:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786074882; x=1786679682; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=t14qXgKevhPrX1GfuAl+ko962gn6h1nlXvsALSBC/vw=;
        b=a8/AoMmRtD3twye/cfBzEQp/YTjDwz0k/OQylAiszi6ndWoupfg17V84QjA1FeTI87
         YOlV7105+DW/TIluWjuVUu4XCmRk1Mm5onx3ehU0xlmOnBh79BJWBcz7LOatXZ/yr5VF
         Gvr4EBVzBhOFLlbyZd8XlcWMnvtnSxqhqmu4R+iMnIAUP1Vdb0e0jZeH6HyIFdubd+fJ
         f4oPAu3xu4Y3GBCLtaZXW9pEABlesTyktyoFshGsWpeGaLLNGe00n46H4Qon8Aly1LIH
         p0pPEfldU3a8lDPSIrShOSkx9cXaMEQgvL8XPfIxfRD6BKlfEpjJKD8JtYzW7/fCBL9d
         wIUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786074882; x=1786679682;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=t14qXgKevhPrX1GfuAl+ko962gn6h1nlXvsALSBC/vw=;
        b=AfrsP7k7AXXNmBAfnHNDNH7LGXWsMLaqjNHX/d9ehNWgSgeoXxpfmRKGMIiIPIr9Vo
         yubgr0sP/G2/dEj+C514pzdjwDsQiJ1aosner4leopCbiu1TMMKtZOi8QMZe30cyCn6N
         Cru+8oADZiAHZEGih5FnCT+scw9OPFmV6AiD9TpUEhYYhKmQ435BmHf3mIY1B1SBWATZ
         ts/naXonFfRK4yDb3uuCBEizkK56EsSDxF9MmRF0nj4jFAmERZMiy6dFitD6ZE+qJ3L0
         m5rhE05uu4KYtb1fWxr471hYyWBRnhPbpNNt3i/IMn7ihB/YJQykYykDeUS/Uh8bMC0F
         gsHQ==
X-Forwarded-Encrypted: i=1; AHgh+RoYJfQb/fA8Yb3NOu63lFGUIrPkJvL/uvk+/6vRS4TaEeGvbPKQQ4ViMviyLImwIEFLT2YzvgF2XDbW@vger.kernel.org
X-Gm-Message-State: AOJu0YygsQCJGCgP3SMb/ti0voCGbG+KaVWg94wexIj0fZdnYyYgLADo
	FaOd7HGBdkY13lh3kYV2T+NwW8Ii9UMa1EQ1xzNTu6Xu3q85ZR/EexLd
X-Gm-Gg: AR+sD119yhwaYUV28OHfnSA25D6gD1vA7c1nMwarwXqftQYpuYrCVOAvEcyEYgI+cc/
	Dwo/gMN7GcUN7wY2nFDkEcfLUtEHfa6cYI/G69biTKLOUYhSiwBV0QA0cZRrwcaYsXmxTYcK2Zv
	avOVXjyIoSRnqGRz4b0Vs001EtModUVWLTQilL7el4iB3nRXZXbjrf++EXuD58D7LHjyfjIGIMH
	XICPqNuz/1GZFYIEpItPKXmZE4+Z6A36ut4IJEMRZRBQO8VIXUxHSkQVBEELfsRYBJxkvNwoWmA
	3vlfze2p14JEzQpBJ8ix0c7Ldzez23tZuka0QgI7GiROllOsrhEI1Hbu5p3Iu80YrUi7nndNRx2
	dwZp9YctwCxVPiGCgM8+JtuNDOaxYW4QScA5zoGOGZjFZTClFKzHdk3JigEtEdBVnh+tPXII9Cp
	PU3dG5P/UBMYLNMOD5b1mbdE+bRiKHapU52Jp/zWibOAMgsh/Wt0bJFQtEA/vg6NYs+woxRSQDq
	XF47DQtGG89SGOKmcpf5DIJIOqLSL0geCPfIaELidW+1b8iL/xJQiHAvPF/hbQkgbCW4vZDZtQq
	udIFBL8P9JLA+zEdU3h8ee6suObDBidhD0aLFK/YhjbzC9laPjyx4ZoWor63wrwLdmV3xl3Ygmw
	e/jYHcMnDGv8QbvSz
X-Received: by 2002:a05:6820:8590:20b0:6ae:a950:9faa with SMTP id 006d021491bc7-6aea950a10fmr5010366eaf.10.1786074881652;
        Thu, 06 Aug 2026 20:54:41 -0700 (PDT)
Received: from [127.0.1.1] (184-96-154-59.hlrn.qwest.net. [184.96.154.59])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6b02bbc41bbsm1329339eaf.3.2026.08.06.20.54.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 20:54:41 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Subject: [PATCH net-next v4 0/4] net: mdio: support dynamic OF device
 changes
Date: Thu, 06 Aug 2026 21:54:19 -0600
Message-Id: <20260806-submit-mdio-of-dynamic-v2-v4-0-4beb0c50d5ba@gmail.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/43OwQ6CMAwG4FcxO1szNkDw5HsYDzA6qHGbYZNAC
 O/uwAsnY9JL0/5fOzOPPaFnl8PMehzIk7OxSY8HprrKtgjUxJ4JLnJecAn+XRsKYBpy4DQ0k60
 MKRgElDzLuaqSrKxLFvOvHjWNm31jFgNYHAO7fyeReaAKK73uduSD66ftjUFsiT8uxuKgiyJNt
 ExE2pyvranoeVLObHcGuZeyX5KMUpJrqVRRyprjXlqW5QPvBs4UKAEAAA==
X-Change-ID: 20260803-submit-mdio-of-dynamic-v2-90560ca159b9
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Florian Fainelli <f.fainelli@gmail.com>, 
 Richard Cochran <richardcochran@gmail.com>, Rob Herring <robh@kernel.org>, 
 Saravana Kannan <saravanak@kernel.org>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Jonas Gorski <jonas.gorski@gmail.com>, Vladimir Oltean <olteanv@gmail.com>, 
 Ciprian Regus <ciprian.regus@analog.com>, 
 Andreas Larsson <andreas@gaisler.com>, Mark Einon <mark.einon@gmail.com>, 
 Iyappan Subramanian <iyappan@os.amperecomputing.com>, 
 Keyur Chudgar <keyur@os.amperecomputing.com>, 
 Michael Chan <michael.chan@broadcom.com>, 
 =?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Doug Berger <opendmb@gmail.com>, Pavan Chebbi <pavan.chebbi@broadcom.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>, 
 Conor Dooley <conor.dooley@microchip.com>, Wei Fang <wei.fang@nxp.com>, 
 Frank Li <frank.li@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>, 
 Jijie Shao <shaojijie@huawei.com>, Jian Shen <shenjian15@huawei.com>, 
 Bryan Whitehead <bryan.whitehead@microchip.com>, 
 UNGLinuxDriver@microchip.com, Vladimir Zapolskiy <vz@mleia.com>, 
 Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>, 
 Parthiban Veerasooran <parthiban.veerasooran@microchip.com>, 
 Timur Tabi <timur@kernel.org>, nic_swsd@realtek.com, 
 Byungho An <bh74.an@samsung.com>, 
 Steve Glendinning <steve.glendinning@shawell.net>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 FUJITA Tomonori <fujita.tomonori@gmail.com>, 
 Siddharth Vadapalli <s-vadapalli@ti.com>, Roger Quadros <rogerq@kernel.org>, 
 Jiawen Wu <jiawenwu@trustnetic.com>, 
 Mengyuan Lou <mengyuanlou@net-swift.com>, 
 Thangaraj Samynathan <Thangaraj.S@microchip.com>, 
 Sebastian Reichel <sre@kernel.org>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, James Hilliard <james.hilliard1@gmail.com>, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-stm32@st-md-mailman.stormreply.com, linux-omap@vger.kernel.org, 
 linux-usb@vger.kernel.org, linux-pm@vger.kernel.org
X-Mailer: b4 0.15.2

MDIO buses enumerate firmware children only when the bus is registered. A
later devicetree overlay or status transition is ignored, unlike on I2C and
SPI buses. Supporting live reconfiguration also means that population and
removal can race address scanning, PHY attachment and bus teardown.

This is generic OF_DYNAMIC support for MDIO buses. It contains no
Allwinner H616 or X-Powers AC200/AC300-specific behavior and does not
depend on either platform; H616 hardware was used only as the runtime
test platform.

Patch 1 fixes an existing lifetime bug exposed while auditing those races:
PHY attach and detach paths cache the MDIO bus but read its owner after
dropping their PHY device reference. Cache the owner before that lifetime
boundary.

Patch 2 factors fixed-address child registration and legacy PHY scanning
into helpers shared by initial and dynamic population.

Patch 3 serializes MDIO device-map changes, reserves addresses while
registration is in progress, publishes devices only after registration
completes, and coordinates scans, attachment, removal and bus teardown.
Firmware removal is exclusive with registration, scanning and other
firmware changes. Map readers use RCU to acquire device references;
mdiobus_get_phy() and the PHY iterators now return referenced PHYs, and all
in-tree callers release or retain those references explicitly. Removed PHY
generations can therefore be reclaimed when their actual users finish,
without removing dynamic PHY deletion or accumulating retired objects until
bus teardown. Attachment waits for another task's pending publication and
defers same-task recursive attachment.

Patch 4 adds the OF reconfiguration notifier. It supports fixed-address
PHYs and generic MDIO devices, scanned PHY addresses, and Ethernet PHY
packages. It preflights overlay removal before firmware nodes disappear
and refuses removal of attached or in-flight PHYs, including while another
MDIO map operation is still completing.

Strict checkpatch reports only its expected MAINTAINERS warning for the two
required lookup-ownership updates in the obsolete AX88796 driver. Changed
objects were build-tested with W=1 using x86_64 allmodconfig under GCC,
arm64 defconfig under LLVM, native MIPS and SPARC configurations for
architecture-specific callers, and minimal arm64 configurations covering
CONFIG_OF_DYNAMIC=n and CONFIG_OF_DYNAMIC=y with CONFIG_OF_OVERLAY=n. No
new compiler warning was emitted.

Runtime testing used an Allwinner H616 board with AC300, booted from SD. A
forced-ID test PHY completed 700 notifier-driven add/remove/re-add cycles.
Every cycle raced standalone attachment against the interval between
device_add() visibility and MDIO-map publication, held a referenced lookup
across removal, verified that no core reference remained, released the last
reference and re-added the same address. A generic MDIO device completed 150
add/remove cycles. Removal of the attached AC300 PHY was rejected while its
driver, carrier and traffic remained active. Testing also covered rejection
of an out-of-range fixed address, removal of an unrelated non-MDIO overlay,
20 complete MAC/MDIO teardown and recreation cycles, another PHY and generic
MDIO stress run after bus recreation, and bidirectional link traffic. No
refcount, RCU, use-after-free or lock warning occurred.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes in v4:
- make PHY map lookups reference-counted and RCU-protected
- update every in-tree mdiobus_get_phy() and PHY iterator caller for the
  referenced lookup contract
- reclaim dynamically removed PHY generations after their users release
  them instead of retaining every generation until bus teardown
- wait for concurrent map publication before attaching a PHY and defer
  same-task recursive attachment
- handle a missing VSC8584 base PHY without dereferencing NULL
- use RCU-safe map access while checking a dynamic removal scope
- Link to v3: https://patch.msgid.link/20260805-submit-mdio-of-dynamic-v2-v3-0-16f3cc893b0e@gmail.com

Changes in v3:
- add a preparatory fix for MDIO bus-owner lifetime handling
- make teardown take a device reference and honor removal ownership
- use one checked callback for normal and dynamic internal removal
- publish map entries only after device registration completes
- route the remaining direct map reader through mdiobus_get_phy()
- retire only PHY devices which have a borrowed-pointer lookup API
- make firmware removal exclusive with registration, scanning and other
  firmware changes
- preserve existing error handling while propagating package population
  conflicts
- allow global overlay removal to ignore unrelated nodes and absent MDIO
  buses
- annotate the recursive notifier lock owner accesses for KCSAN
- avoid an OF/MDIO lock inversion during overlay preflight
- refuse overlay removal while another MDIO map change is active
- propagate removal-transaction conflicts from the OF notifier
- do not treat malformed fixed addresses as addressless PHYs
- rebase onto current net-next
- Link to v2: https://patch.msgid.link/20260803-submit-mdio-of-dynamic-v2-v2-0-f8841f3124d7@gmail.com

Changes in v2:
- split the generic MDIO work from the ACx00 series
- rebase onto current net-next
- move touched declarations to function scope for netdev style
- Link to v1: https://patch.msgid.link/20260802-submit-acx00-of-dynamic-v1-v1-0-0a53cd9e21cc@gmail.com

To: Andrew Lunn <andrew@lunn.ch>
To: Heiner Kallweit <hkallweit1@gmail.com>
To: Russell King <linux@armlinux.org.uk>
To: "David S. Miller" <davem@davemloft.net>
To: Eric Dumazet <edumazet@google.com>
To: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
To: Florian Fainelli <f.fainelli@gmail.com>
To: Richard Cochran <richardcochran@gmail.com>
To: Rob Herring <robh@kernel.org>
To: Saravana Kannan <saravanak@kernel.org>
To: Florian Fainelli <florian.fainelli@broadcom.com>
To: Jonas Gorski <jonas.gorski@gmail.com>
To: Vladimir Oltean <olteanv@gmail.com>
To: Ciprian Regus <ciprian.regus@analog.com>
To: Andreas Larsson <andreas@gaisler.com>
To: Mark Einon <mark.einon@gmail.com>
To: Iyappan Subramanian <iyappan@os.amperecomputing.com>
To: Keyur Chudgar <keyur@os.amperecomputing.com>
To: Michael Chan <michael.chan@broadcom.com>
To: Rafał Miłecki <rafal@milecki.pl>
To: Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
To: Doug Berger <opendmb@gmail.com>
To: Pavan Chebbi <pavan.chebbi@broadcom.com>
To: Théo Lebrun <theo.lebrun@bootlin.com>
To: Conor Dooley <conor.dooley@microchip.com>
To: Wei Fang <wei.fang@nxp.com>
To: Frank Li <frank.li@nxp.com>
To: Shenwei Wang <shenwei.wang@nxp.com>
To: Jijie Shao <shaojijie@huawei.com>
To: Jian Shen <shenjian15@huawei.com>
To: Bryan Whitehead <bryan.whitehead@microchip.com>
To: UNGLinuxDriver@microchip.com
To: Vladimir Zapolskiy <vz@mleia.com>
To: Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>
To: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
To: Timur Tabi <timur@kernel.org>
To: nic_swsd@realtek.com
To: Byungho An <bh74.an@samsung.com>
To: Steve Glendinning <steve.glendinning@shawell.net>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Maxime Coquelin <mcoquelin.stm32@gmail.com>
To: Alexandre Torgue <alexandre.torgue@foss.st.com>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Roger Quadros <rogerq@kernel.org>
To: Jiawen Wu <jiawenwu@trustnetic.com>
To: Mengyuan Lou <mengyuanlou@net-swift.com>
To: Thangaraj Samynathan <Thangaraj.S@microchip.com>
To: Sebastian Reichel <sre@kernel.org>
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: imx@lists.linux.dev
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-stm32@st-md-mailman.stormreply.com
Cc: linux-omap@vger.kernel.org
Cc: linux-usb@vger.kernel.org
Cc: linux-pm@vger.kernel.org

---
James Hilliard (4):
      net: phy: cache MDIO bus owner before dropping PHY reference
      net: mdio: factor out OF child registration helpers
      net: mdio: make device map changes hotplug-safe
      net: mdio: support dynamic OF device changes

 drivers/net/dsa/b53/b53_common.c                   |   9 +-
 drivers/net/ethernet/8390/ax88796.c                |   2 +
 drivers/net/ethernet/adi/adin1140.c                |   6 +-
 drivers/net/ethernet/aeroflex/greth.c              |   2 +
 drivers/net/ethernet/agere/et131x.c                |  10 +-
 drivers/net/ethernet/amd/au1000_eth.c              |  27 +-
 drivers/net/ethernet/apm/xgene-v2/mdio.c           |   8 +-
 drivers/net/ethernet/broadcom/b44.c                |   6 +
 drivers/net/ethernet/broadcom/bgmac-bcma.c         |   1 +
 drivers/net/ethernet/broadcom/genet/bcmmii.c       |   4 +
 drivers/net/ethernet/broadcom/sb1250-mac.c         |   8 +-
 drivers/net/ethernet/broadcom/tg3.c                |  32 +-
 drivers/net/ethernet/broadcom/tg3.h                |   1 +
 drivers/net/ethernet/cadence/macb_main.c           |   1 +
 drivers/net/ethernet/engleder/tsnep_main.c         |   4 +
 drivers/net/ethernet/ethoc.c                       |  14 +-
 drivers/net/ethernet/faraday/ftgmac100.c           |   8 +-
 drivers/net/ethernet/freescale/fec_main.c          |  14 +-
 drivers/net/ethernet/hisilicon/hibmcge/hbg_mdio.c  |   8 +
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    |  10 +-
 drivers/net/ethernet/lantiq_etop.c                 |   8 +-
 .../ethernet/mellanox/mlxbf_gige/mlxbf_gige_main.c |   2 +
 drivers/net/ethernet/microchip/lan743x_main.c      |   1 +
 drivers/net/ethernet/nxp/lpc_eth.c                 |  10 +-
 drivers/net/ethernet/oa_tc6.c                      |   3 +
 drivers/net/ethernet/qualcomm/emac/emac-phy.c      |   7 -
 drivers/net/ethernet/rdc/r6040.c                   |  10 +-
 drivers/net/ethernet/realtek/r8169_main.c          |  15 +-
 drivers/net/ethernet/samsung/sxgbe/sxgbe_mdio.c    |   1 +
 drivers/net/ethernet/smsc/smsc911x.c               |   6 +-
 drivers/net/ethernet/smsc/smsc9420.c               |  10 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  |   1 +
 drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c  |   2 +
 drivers/net/ethernet/tehuti/tn40_phy.c             |   5 +-
 drivers/net/ethernet/ti/davinci_emac.c             |  20 +-
 drivers/net/ethernet/toshiba/tc35815.c             |   8 +-
 drivers/net/ethernet/wangxun/ngbe/ngbe_mdio.c      |   8 +
 drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c     |   8 +
 drivers/net/mdio/of_mdio.c                         | 514 +++++++++++++++++++--
 drivers/net/phy/mdio_bus.c                         |  46 +-
 drivers/net/phy/mdio_bus_provider.c                | 141 ++++--
 drivers/net/phy/mdio_device.c                      | 238 +++++++++-
 drivers/net/phy/mscc/mscc_ptp.c                    |  50 +-
 drivers/net/phy/phy_device.c                       | 151 ++++--
 drivers/net/phy/phylib-internal.h                  |   4 +-
 drivers/net/usb/asix_devices.c                     |   4 +
 drivers/net/usb/lan78xx.c                          |   7 +-
 drivers/net/usb/smsc95xx.c                         |   2 +
 drivers/power/reset/linkstation-poweroff.c         |   1 +
 include/linux/mdio.h                               |   4 +-
 include/linux/phy.h                                |  34 +-
 net/dsa/user.c                                     |  12 +-
 52 files changed, 1239 insertions(+), 269 deletions(-)
---
base-commit: a23b36233d4103def55dc8cf65698106d0bd1e62
change-id: 20260803-submit-mdio-of-dynamic-v2-90560ca159b9

Best regards,
--  
James Hilliard <james.hilliard1@gmail.com>

