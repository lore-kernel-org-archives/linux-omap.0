From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 1/2] dt-bindings: cpcap-battery: Add binding
Date: Wed, 31 May 2017 17:26:22 -0700
Message-ID: <20170601002621.GQ3730@atomide.com>
References: <20170601001921.11091-1-tony@atomide.com>
 <20170601001921.11091-2-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170601001921.11091-2-tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Marcel Partap <mpartap-hi6Y0CQ0nG0@public.gmane.org>, Michael Scott <michael.scott-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> [170531 17:23]:

Oh sorry, now I managed to leave out the description..
Updated binding patch below.

Regards,

Tony

8< ---------------
>From tony Mon Sep 17 00:00:00 2001
From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Date: Wed, 31 May 2017 17:10:13 -0700
Subject: [PATCH] dt-bindings: cpcap-battery: Add binding

Add binding for cpcap pmic battery.

Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Marcel Partap <mpartap-hi6Y0CQ0nG0@public.gmane.org>
Cc: Michael Scott <michael.scott-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
---
 .../bindings/power/supply/cpcap-battery.txt        | 27 ++++++++++++++++++++++
 1 file changed, 27 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/cpcap-battery.txt

diff --git a/Documentation/devicetree/bindings/power/supply/cpcap-battery.txt b/Documentation/devicetree/bindings/power/supply/cpcap-battery.txt
new file mode 100644
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/cpcap-battery.txt
@@ -0,0 +1,27 @@
+Motorola CPCAP PMIC battery driver binding
+
+Required properties:
+- compatible: Shall be "motorola,cpcap-battery"
+- interrupts: Interrupt specifier for each name in interrupt-names
+- interrupt-names: Should contain the following entries:
+		   "lowbph", "lowbpl", "chrgcurr1", "battdetb"
+- io-channels: IIO ADC channel specifier for each name in io-channel-names
+- io-channel-names: Should contain the following entries:
+		    "battdetb", "battp", "chg_isense", "batti"
+
+Example:
+
+cpcap_battery: battery {
+	compatible = "motorola,cpcap-battery";
+	interrupts-extended = <
+		&cpcap 5 0 &cpcap 3 0
+		&cpcap 20 0 &cpcap 54 0
+	>;
+	interrupt-names =
+		"lowbph", "lowbpl",
+		"chrgcurr1", "battdetb";
+	io-channels = <&cpcap_adc 0 &cpcap_adc 1
+		       &cpcap_adc 5 &cpcap_adc 6>;
+	io-channel-names = "battdetb", "battp",
+			   "chg_isense", "batti";
+};
-- 
2.13.0
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
