From: Dmitry Lifshitz <lifshitz-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
Subject: [PATCH V2 17/19] ARM: dts: am57xx: compulab-sb-som: add HDMI connector
Date: Tue,  1 Dec 2015 20:03:19 +0200
Message-ID: <1448993001-19495-18-git-send-email-lifshitz@compulab.co.il>
References: <1448433590-1399-1-git-send-email-lifshitz@compulab.co.il>
 <1448993001-19495-1-git-send-email-lifshitz@compulab.co.il>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1448993001-19495-1-git-send-email-lifshitz-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Toni Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Igor Grinberg <grinberg-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>, Nikita Kiryanov <nikita-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, Dmitry Lifshitz <lifshitz-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Add HDMI connector node without a valid input endpoint.

CompuLab SB-SOM is a carrier board, hence the endpoint
should be added in the board DT with a valid HDMI output.

Signed-off-by: Dmitry Lifshitz <lifshitz-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
Acked-by: Igor Grinberg <grinberg-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
---

  v2:

   * No fuctional changes
   * Reformat subject

 arch/arm/boot/dts/compulab-sb-som.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/compulab-sb-som.dtsi b/arch/arm/boot/dts/compulab-sb-som.dtsi
index 402a143..93d7e23 100644
--- a/arch/arm/boot/dts/compulab-sb-som.dtsi
+++ b/arch/arm/boot/dts/compulab-sb-som.dtsi
@@ -39,4 +39,11 @@
 			pixelclk-active = <1>;
 		};
 	};
+
+	hdmi_conn: connector@0 {
+		compatible = "hdmi-connector";
+		label = "hdmi";
+
+		type = "a";
+	};
 };
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
