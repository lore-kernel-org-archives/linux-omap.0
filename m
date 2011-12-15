From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v3 4/4] ARM: omap: pass minimal SoC/board data for UART
 from dt
Date: Thu, 15 Dec 2011 13:37:22 -0800
Message-ID: <20111215213722.GV32251@atomide.com>
References: <1323863746-18145-1-git-send-email-rnayak@ti.com>
 <1323863746-18145-5-git-send-email-rnayak@ti.com>
 <20111214192509.GH32251@atomide.com>
 <4EE99923.4030902@ti.com>
 <4EE9C697.4010604@ti.com>
 <20111215211320.GU32251@atomide.com>
 <4EEA6686.3010504@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4EEA6686.3010504@ti.com>
Sender: linux-serial-owner@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: Rajendra Nayak <rnayak@ti.com>, linux-serial@vger.kernel.org, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, khilman@ti.com, govindraj.raja@ti.com, linux-arm-kernel@lists.infradead.org, linaro-dev@lists.linaro.org, patches@linaro.org, robherring2@gmail.com
List-Id: linux-omap@vger.kernel.org

* Cousson, Benoit <b-cousson@ti.com> [111215 12:56]:
> 
> Nit: The convention is without the 0x prefix.

OK will post an updated version as a reply to this
email.
 
> Beside that, that looks good top me. But I'll not be able to try it :-)

Boots fine with the following n8x0.dts patch. Currently
MMC of course won't mount and the file should be separate
for n800 and and n810.. So this patch is not yet quite
ready to go.

Regards,

Tony


From: Tony Lindgren <tony@atomide.com>
Date: Thu, 15 Dec 2011 13:04:31 -0800
Subject: [PATCH] arm/dts: Add minimal n8x0 device tree support

Add minimal n8x0 device tree support

Not-Signed-off-by: Tony Lindgren <tony@atomide.com>

--- /dev/null
+++ b/arch/arm/boot/dts/nokia-n8x0.dts
@@ -0,0 +1,17 @@
+/dts-v1/;
+
+/include/ "omap2.dtsi"
+
+/ {
+	model = "Nokia N8x0";
+	compatible = "nokia,n8x0", "ti,omap2420", "ti,omap2";
+
+	chosen {
+		bootargs = "root=/dev/mmcblk2p2 rw console=ttyO2,115200n8 debug earlyprintk";
+	};
+
+	memory {
+		device_type = "memory";
+		reg = <0x80000000 0x08000000>; /* 128 MB */
+	};
+};
