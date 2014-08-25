From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 1/3] pinctrl: bindings: Add OMAP pinctrl binding
Date: Mon, 25 Aug 2014 14:03:12 -0500
Message-ID: <20140825190311.GA21871@kahuna>
References: <1408716062-26055-1-git-send-email-nm@ti.com>
 <1408716062-26055-2-git-send-email-nm@ti.com>
 <20140825172506.GM17254@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140825172506.GM17254@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Tero Kristo <t-kristo@ti.com>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@deeprootsystems.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Keerthy <j-keerthy@ti.com>, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, devicetree@vger.kernel.org, Dave Gerlach <d-gerlach@ti.com>
List-Id: linux-omap@vger.kernel.org

On 10:25-20140825, Tony Lindgren wrote:
> * Nishanth Menon <nm@ti.com> [140822 07:03]:
> > Add basic skeleton of OMAP pinctrl bindings. This is compatible with
> > pinctrl,single bindings and is meant purely as a reference point.
> > 
> > Signed-off-by: Nishanth Menon <nm@ti.com>
> 
> Looks like you have ti,omap2420-padconf and ti,omap2430-padconf missing
> but after adding those too:
> 
> Acked-by: Tony Lindgren <tony@atomide.com>

I now see why I missed them:
arch/arm/boot/dts/omap2420.dtsi:                        compatible = "ti,omap2420-padconf", "pinctrl-single";
arch/arm/boot/dts/omap2430.dtsi:                        compatible = "ti,omap2430-padconf", "pinctrl-single";

These are the only two references to the compatible, there is no driver
matching being done, had missed it hence :( - Updated revision below
(with your ack). Unless there are anymore review comments OR you'd want
me to explicitly, I dont plan on reposting the following again.

---8<---
>From 74121c6a2524048eb02c3b33a25e13261edd2e99 Mon Sep 17 00:00:00 2001
From: Nishanth Menon <nm@ti.com>
Date: Thu, 22 May 2014 23:32:09 -0500
Subject: [PATCH V2] pinctrl: bindings: Add OMAP pinctrl binding

Add basic skeleton of OMAP pinctrl bindings. This is compatible with
pinctrl,single bindings and is meant purely as a reference point.

Acked-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
---
 .../bindings/pinctrl/ti,omap-pinctrl.txt           |   11 +++++++++++
 1 file changed, 11 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/ti,omap-pinctrl.txt

diff --git a/Documentation/devicetree/bindings/pinctrl/ti,omap-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/ti,omap-pinctrl.txt
new file mode 100644
index 0000000..b3b57fc
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/ti,omap-pinctrl.txt
@@ -0,0 +1,11 @@
+OMAP Pinctrl definitions
+
+Required properties:
+- compatible : Should be one of:
+  "ti,omap2420-padconf" - OMAP2420 compatible pinctrl
+  "ti,omap2430-padconf" - OMAP2430 compatible pinctrl
+  "ti,omap3-padconf" - OMAP3 compatible pinctrl
+  "ti,omap4-padconf" - OMAP4 compatible pinctrl
+  "ti,omap5-padconf" - OMAP5 compatible pinctrl
+
+See Documentation/devicetree/bindings/pinctrl/pinctrl-single.txt for further details.
-- 
1.7.9.5

-- 
Regards,
Nishanth Menon
