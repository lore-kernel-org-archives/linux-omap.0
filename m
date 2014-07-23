From: Mugunthan V N <mugunthanvnm-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 0/3] Add DRA7xx CPSW Ethernet support in Device Tree
Date: Wed, 23 Jul 2014 18:54:39 +0530
Message-ID: <1406121882-32658-1-git-send-email-mugunthanvnm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mugunthan V N <mugunthanvnm-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Adding device tree entry for CPSW to make it work in Dual EMAC mode.

These patches were tested with DRA7 hwmod patches on top of linux-next.
The patches were already reviewed [1] and has been waiting for cross bar
and hwmod to be pulled in. Now since all dependent patches has already
pulled in, so reposting the patches again.

[1] https://lkml.org/lkml/2014/5/13/89

Mugunthan V N (3):
  pinctrl: dra7: dt-bindings: add pin off modes for dra7 SoC
  arm/dts: dra7xx: Add CPSW and MDIO module nodes for dra7xx
  arm/dts: dra7xx: Enable CPSW and MDIO for dra7xx EVM

 arch/arm/boot/dts/dra7-evm.dts    | 105 ++++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/dra7.dtsi       |  58 +++++++++++++++++++++
 include/dt-bindings/pinctrl/dra.h |   8 +++
 3 files changed, 171 insertions(+)

-- 
2.0.2.673.g9ab0882

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
