From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH v2 13/14] ARM: DTS: am33xx: Use the new DT bindings for
 the eDMA3
Date: Fri, 4 Dec 2015 10:32:12 +0200
Message-ID: <56614F8C.9080106@ti.com>
References: <1444979892-31626-1-git-send-email-peter.ujfalusi@ti.com>
 <1444979892-31626-14-git-send-email-peter.ujfalusi@ti.com>
 <20151204005440.GE23396@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151204005440.GE23396@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: vinod.koul@intel.com, nsekhar@ti.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, dmaengine@vger.kernel.org, devicetree@vger.kernel.org, r.schwebel@pengutronix.de
List-Id: linux-omap@vger.kernel.org

On 12/04/2015 02:54 AM, Tony Lindgren wrote:
> Hi Peter,
>=20
> * Peter Ujfalusi <peter.ujfalusi@ti.com> [151016 00:23]:
>=20
> I noticed something while changing dm81xx to use the edma_xbar..
>=20
>> --- a/arch/arm/boot/dts/am33xx.dtsi
>> +++ b/arch/arm/boot/dts/am33xx.dtsi
>> +
>> +		edma_xbar: dma-router@44e10f90 {
>> +			compatible =3D "ti,am335x-edma-crossbar";
>> +			reg =3D <0x44e10f90 0x40>;
>> +
>> +			#dma-cells =3D <3>;
>> +			dma-requests =3D <32>;
>> +
>> +			dma-masters =3D <&edma>;
>>  		};
>=20
> The edma_xbar should now be just a child at offset 0xf90 under the
> scm: scm@210000. Can you please check the other patches too?

Thanks Tony,

I'll make sure they are in the correct place when resending them.

--=20
P=C3=A9ter
