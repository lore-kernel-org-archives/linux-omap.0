From: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 6/6] ARM: dts: dra7-evm: Mark uart1 rxd as wakeup capable
Date: Mon, 8 Sep 2014 13:47:27 -0500
Message-ID: <20140908184727.GA2103@kahuna>
References: <1408716235-26164-1-git-send-email-nm@ti.com>
 <1408716235-26164-7-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1408716235-26164-7-git-send-email-nm-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>, Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Cc: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>, Santosh Shilimkar <santosh.shilimkar-l0cyMroinI0@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 09:03-20140822, Nishanth Menon wrote:
>  	status = "okay";
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&uart1_pins>;
> +	interrupts-extended = <&gic GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH
> +			       &dra7_pmx_core 0x3e0>;
^^
Thanks to Lee Jones pointing this out to me in a different context[1]
I made the wrong usage. Fixing the syntax to stay in sync with
Documentation/devicetree/bindings/interrupt-controller/interrupts.txt

[1] http://marc.info/?l=linux-omap&m=140930980325273&w=2

-----8<----
>From c3c284ebd2b8d5535abf297ef7537b2caa7fe67b Mon Sep 17 00:00:00 2001
From: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
Date: Fri, 6 Jun 2014 20:53:22 -0500
Subject: [PATCH V2 6/6] ARM: dts: dra7-evm: Mark uart1 rxd as wakeup capable

Mark rxd as wakeupcapable for 115200n8 no hardware-flow control
configuration. If h/w flow control is being used, then rts/cts
appropriately should be used.

Signed-off-by: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
---
 arch/arm/boot/dts/dra7-evm.dts |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/dra7-evm.dts b/arch/arm/boot/dts/dra7-evm.dts
index 50f8022..08434c7 100644
--- a/arch/arm/boot/dts/dra7-evm.dts
+++ b/arch/arm/boot/dts/dra7-evm.dts
@@ -303,6 +303,8 @@
 	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart1_pins>;
+	interrupts-extended = <&gic GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH>,
+			      <&dra7_pmx_core 0x3e0>;
 };
 
 &uart2 {
-- 
1.7.9.5


-- 
Regards,
Nishanth Menon
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
