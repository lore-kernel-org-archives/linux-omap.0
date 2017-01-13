From: Ravi Babu <ravibabu-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 0/2] dra7x: dts update for increase in QSPI SPL parttion size
Date: Fri, 13 Jan 2017 18:10:32 +0530
Message-ID: <1484311234-21978-1-git-send-email-ravibabu@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, nsekhar-uAqBSO/uNfhBDgjK7y7TUQ@public.gmane.org, Ravi Babu <ravibabu-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

This patch updates the SPL partition size for QSPI for
dra7xx platforms.

Ravi Babu (2):
  ARM: dts: dra7-evm: increase QSPI SPL partition size
  ARM: dts: dra72x-evm: increase QSPI SPL partition size

 arch/arm/boot/dts/dra7-evm.dts          | 24 ++++++------------------
 arch/arm/boot/dts/dra72-evm-common.dtsi | 24 ++++++------------------
 2 files changed, 12 insertions(+), 36 deletions(-)

-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
