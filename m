From: Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 14/17] ARM: dts: Add missing gpu node and binding for
 omap4
Date: Tue, 29 Aug 2017 15:24:52 +0300
Message-ID: <e0c6447f-5a0f-b43a-7087-5ee37af2a1c1@ti.com>
References: <20170828211918.11573-1-tony@atomide.com>
 <20170828211918.11573-15-tony@atomide.com>
 <20170829090034.ytepjfv2jkkd2b3z@earth>
 <201708291135.v7TBZCHH020827@dflxv15.itg.ti.com>
 <20170829121041.dweciryplio5i4jr@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170829121041.dweciryplio5i4jr@earth>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Reichel <sebastian.reichel-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

=EF=BB=BF
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Bu=
siness ID: 0615521-4. Kotipaikka/Domicile: Helsinki

On 29/08/17 15:10, Sebastian Reichel wrote:

>> Do we even want to add SGX to the .dts? We don't have proper drivers for
>> SGX. If we ever do, who knows what kind of DT data they need. I know the
>> DT data for SGX in TI's kernel tree has changed at least once.
>=20
> I don't think reg or interrupts will be removed, so the properties
> added by Tony look pretty safe?. I guess if we ever have a driver

Maybe. At the moment we have this in TI's tree for DRA7:

gpu: gpu@56000000 {
	compatible =3D "ti,dra7-sgx544", "img,sgx544";
	reg =3D <0x56000000 0x10000>;
	reg-names =3D "gpu_ocp_base";
	interrupts =3D <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
	ti,hwmods =3D "gpu";
	clocks =3D <&l3_iclk_div>, <&gpu_core_gclk_mux>,
		<&gpu_hyd_gclk_mux>;
	clock-names =3D "iclk", "fclk1", "fclk2";
};

> it would need some more properties and would bail out. Having no
> DT data is does not load at all, the result is the same. OTOH having
> the node means the kernel can properly send the module to idle.

I just get uneasy when adding DT data that we're not really sure if it's
ok or not. I've been fighting with such data for ages. But, as you say,
this probably won't matter if the driver will just reject DT data that
doesn't have all the details.

If we need the DT node to idle SGX, and we don't even mean to actually
use an SGX driver with this data, it sounds fine to me.

 Tomi

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
