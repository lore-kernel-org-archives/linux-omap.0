From: Mugunthan V N <mugunthanvnm-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 0/2] adding spi alias for qspi
Date: Thu, 19 Nov 2015 12:31:00 +0530
Message-ID: <1447916462-1007-1-git-send-email-mugunthanvnm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Tom Rini <trini-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Mugunthan V N <mugunthanvnm-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Adding missed spi alias for qspi which helps probe the qspi
device in U-Boot.

Mugunthan V N (2):
  dts: dra7: add spi alias for qspi
  arm: dts: am4372: add spi alias for qspi

 arch/arm/boot/dts/am4372.dtsi | 1 +
 arch/arm/boot/dts/dra7.dtsi   | 1 +
 2 files changed, 2 insertions(+)

-- 
2.6.2.280.g74301d6

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
