From: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 00/11] ARM: OMAP/DTS: dra7/72-evm/beagle-x15: Audio
 support
Date: Thu, 15 Oct 2015 10:08:37 +0300
Message-ID: <561F50F5.9060909@ti.com>
References: <1440400807-32274-1-git-send-email-peter.ujfalusi@ti.com>
 <55F68A60.6050900@ti.com> <20150914162851.GM4215@atomide.com>
 <20151012205732.GW23801@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20151012205732.GW23801-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Tony,

On 10/12/2015 11:57 PM, Tony Lindgren wrote:
> * Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> [150914 09:32]:
>> * Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org> [150914 01:54]:
>>> Hi Tony,
>>>
>>> On 08/24/2015 10:19 AM, Peter Ujfalusi wrote:
>>>> Hi,
>>>>
>>>> this series will enable analog audio (via onboard aic310x codec) f=
or dra7-evm,
>>>> dra72-evm and am57xx-beagle-x15 boards.
>>>> In these board McASP3 is connected to the codec and for the McASP3=
 we needed to
>>>> have the DMA crossbar in place since the request lines are not map=
ped by
>>>> default.
>>>
>>> Did you had a chance to look at this series?
>>
>> Looks OK to me, will look at it more once we have the fixes merged.
>>
>> Paul may have comments on the hwmod chage, looks like you forgot
>> to Cc him on it. Can you please resend that one with Paul in Cc?
>=20
> Applying all the dts changes into omap-for-v4.3/dt thanks. Paul
> can pick up the hwmod change then after reviewing it.

Thanks for taking the DTS patches, however if Paul agrees with the way =
I think we can handle the McASP in DRA7xx then the patch which adds the=
 mcasp3 node to dra7.dtsi needs to be replaced by:

=46rom b6733f9ca96a997fab3d0455783e875dd9ae032b Mon Sep 17 00:00:00 200=
1
=46rom: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
Date: Tue, 24 Feb 2015 15:12:59 +0200
Subject: [PATCH v2 03/12] ARM: DTS: dra7: Add McASP3 node

Signed-off-by: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
---
 arch/arm/boot/dts/dra7.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index 8fedddc35999..cde0a3cbf262 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -1404,6 +1404,21 @@
 			status =3D "disabled";
 		};
=20
+		mcasp3: mcasp@48468000 {
+			compatible =3D "ti,dra7-mcasp-audio";
+			ti,hwmods =3D "mcasp3";
+			reg =3D <0x48468000 0x2000>;
+			reg-names =3D "mpu";
+			interrupts =3D <GIC_SPI 151 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 150 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names =3D "tx", "rx";
+			dmas =3D <&sdma_xbar 133>, <&sdma_xbar 132>;
+			dma-names =3D "tx", "rx";
+			clocks =3D <&mcasp3_aux_gfclk_mux>, <&mcasp3_ahclkx_mux>;
+			clock-names =3D "fck", "ahclkx";
+			status =3D "disabled";
+		};
+
 		crossbar_mpu: crossbar@4a002a48 {
 			compatible =3D "ti,irq-crossbar";
 			reg =3D <0x4a002a48 0x130>;
--=20
2.6.1




--=20
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
