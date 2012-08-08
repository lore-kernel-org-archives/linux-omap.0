From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: OMAP: Configuring CONTROL_DEVCONF0 register via DT with pinctrl
Date: Wed, 08 Aug 2012 14:53:16 +0300
Message-ID: <5022532C.9060804@ti.com>
References: <501262B5.1080004@ti.com> <20120807111041.GY11011@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog123.obsmtp.com ([74.125.149.149]:51133 "EHLO
	na3sys009aog123.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756170Ab2HHLxR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 Aug 2012 07:53:17 -0400
Received: by obhx4 with SMTP id x4so1085122obh.28
        for <linux-omap@vger.kernel.org>; Wed, 08 Aug 2012 04:53:15 -0700 (PDT)
In-Reply-To: <20120807111041.GY11011@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, "Cousson, Benoit" <b-cousson@ti.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, Grant Likely <grant.likely@secretlab.ca>

On 08/07/2012 02:10 PM, Tony Lindgren wrote:
> You need to also consider that CONTROL_DEVCONF0 has the MMC/SDIO modu=
le input
> clock selection. So pinctrl-single binding would have to be expanded =
to also
> support one-bit-per-mux type registers in addition to one-register-pe=
r-mux
> registers. And then this could also be used for the MMC/SDIO module i=
nput clock.

Or if the clock selection for MMC/SDIO also static on a board we can ju=
st do
the mux config once, configuring McBSP1 and MMC/SDIO at the same time?

>> In .dtsi file of the SoC:
>>
>> control_devconf0: pinmux@48002274 {
>> 	compatible =3D "pinctrl-single";
>> 	reg =3D <0x48002274 4>;	/* Single register */
>> 	#address-cells =3D <1>;
>> 	#size-cells =3D <0>;
>> 	pinctrl-single,register-width =3D <32>;
>> 	pinctrl-single,function-mask =3D <0x5F>;
>> };
>=20
> The pinctrl-single,function-mask is for all the registers in the rang=
e,
> we also need something to specify the device specific mux bits.

Yes, I understand that.
I think this all depends if we want to change the mux configurations ru=
ntime,
on the fly as well. If it is only done once at boot time why not just s=
et up
the register (mux) as the board design dictates?

>> In the .dts file of the board which needs to change the CLKR/FSR con=
figuration:
>>
>> &control_devconf0 {
>> 	pinctrl-names =3D "default";
>> 	pinctrl-0 =3D <&mcbsp1_pins>;
>>
>> 	mcbsp1_pins: pinmux_mcbsp1_pins {
>> 		pinctrl-single,pins =3D <0x00 0x18>; /* CLKR/FSR from CLKX/FSX
>> 						    * pin */
>> 	};
>>
>> };
>=20
> I think adding support for one-bit-per-mux would require adding somet=
hing
> like this for the binding:
>=20
>  	mcbsp1_pins: pinmux_mcbsp1_pins {
> 		/*                   offset bits mask */
>  		pinctrl-single,bits =3D <0x00 0x18 0x18>;
> 	};
>=20
> As otherwise you would not know which bits to clear for alternative
> named modes. Or got any better ideas?

I was also thought that this type of feature might be useful at some po=
int in
pinctrl.
However if we have static mux configuration on a boards vendors can set=
 up the
mux for their devices using the currently available bindings.


--=20
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
