From: Mugunthan V N <mugunthanvnm-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 2/2] arm: dts: am4372: add spi alias for qspi
Date: Thu, 19 Nov 2015 12:31:02 +0530
Message-ID: <1447916462-1007-3-git-send-email-mugunthanvnm@ti.com>
References: <1447916462-1007-1-git-send-email-mugunthanvnm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1447916462-1007-1-git-send-email-mugunthanvnm-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Tom Rini <trini-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Mugunthan V N <mugunthanvnm-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Set the alias for qspi to spi0

Signed-off-by: Mugunthan V N <mugunthanvnm-l0cyMroinI0@public.gmane.org>
---
 arch/arm/boot/dts/am4372.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.dtsi
index d83ff9c..bb03b80 100644
--- a/arch/arm/boot/dts/am4372.dtsi
+++ b/arch/arm/boot/dts/am4372.dtsi
@@ -30,6 +30,7 @@
 		serial5 = &uart5;
 		ethernet0 = &cpsw_emac0;
 		ethernet1 = &cpsw_emac1;
+		spi0 = &qspi;
 	};
 
 	cpus {
-- 
2.6.2.280.g74301d6

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
