From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [BISECTED] OMAP: DSS: clk rate mismatch
Date: Wed, 29 Jan 2014 11:10:30 +0200
Message-ID: <52E8C586.7040907@ti.com>
References: <52E697C0.6000202@gmail.com> <52E7614E.8010903@ti.com> <52E76EE0.2060006@ti.com> <52E7F451.7040708@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <52E7F451.7040708@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, linux-kernel@vger.kernel.org, pali.rohar@gmail.com, pavel@ucw.cz, chf.fritz@googlemail.com, nm@ti.com
List-Id: linux-omap@vger.kernel.org

On 01/28/2014 08:17 PM, Ivaylo Dimitrov wrote:
>
>
> On 28.01.2014 10:48, Tomi Valkeinen wrote:
>
>> I made a somewhat hacky quickfix for beagle. Applying that and the
>> clk-divider from the link above makes things work for me. However, as I
>> said, the issue with n900 might be different, but it'd be interesting to
>> hear if it has any effect.
>>
>>   Tomi
>>
>
> Applying those 2 patches doesn't help, still get exactly the same warning.
>
> Find attached my clk_summary (with my hacky patch applied, otherwise I
> cannot boot the device)
>
> Ivo

It looks like the omap36xx version of the omap96m_alwon_fck is modelled 
improperly in the dts files. I don't have access to omap36xx hardware 
myself, but give a try for the following patch:


From: Tero Kristo <t-kristo@ti.com>
Date: Wed, 29 Jan 2014 11:03:46 +0200
Subject: [PATCH] ARM: dts: omap36xx: fix omap96m_alwon_fck

OMAP36xx has different hardware implementation for the omap96m_alwon_fck
compared to other OMAP3 variants. Reflect this properly in the dts file.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
  arch/arm/boot/dts/omap36xx-clocks.dtsi |    9 +++++++++
  1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/omap36xx-clocks.dtsi 
b/arch/arm/boot/dts/omap36xx-clocks.dtsi
index 2fcf253..24ddf3f 100644
--- a/arch/arm/boot/dts/omap36xx-clocks.dtsi
+++ b/arch/arm/boot/dts/omap36xx-clocks.dtsi
@@ -88,3 +88,12 @@
  			 <&mcbsp4_ick>, <&uart4_fck>;
  	};
  };
+
+&omap_96m_alwon_fck {
+	compatible = "ti,divider-clock";
+	clocks = <&omap_192m_alwon_fck>;
+	ti,bit-shift = <12>;
+	ti,max-div = <2>;
+	reg = <0x0a40>;
+	ti,index-starts-at-one;
+};
-- 
1.7.9.5
