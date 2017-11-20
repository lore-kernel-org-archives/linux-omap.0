From: "H. Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Subject: Re: [PATCH v4 4/5] DTS: gta04: add serdev node for w2sg00x4
Date: Mon, 20 Nov 2017 06:29:46 +0100
Message-ID: <DB98ED72-7151-4230-934D-B4FFEC7A397F@goldelico.com>
References: <cover.1510781875.git.hns@goldelico.com> <02dde546157359316eebe8e90f5f1de7177bbffa.1510781876.git.hns@goldelico.com> <20171117170857.GO28152@atomide.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20171117170857.GO28152-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, =?utf-8?Q?Beno=C3=AEt_Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Kevin Hilman <khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, =?utf-8?Q?Andreas_F=C3=A4rber?= <afaerber-l3A5Bk7waGM@public.gmane.org>, Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, letux-kernel-S0jZdbWzriLCfDggNXIi3w@public.gmane.org, kernel-Jl6IXVxNIMRxAtABVqVhTwC/G2K4zDHf@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi Tony,

> Am 17.11.2017 um 18:08 schrieb Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>:
>=20
> * H. Nikolaus Schaller <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org> [171115 21:41]:
>> GTA04 has a W2SG0004/84 connected to UART2 of the OMAP3
>> processor. A GPIO can pulse the on/off toggle switch.
>>=20
>> The VSIM regulator is used to power on/off the LNA of an external
>> active GPS antenna so that a driver can turn the LNA off if GPS is
>> not needed to save battery energy.
>>=20
>> Signed-off-by: H. Nikolaus Schaller <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
>> ---
>> arch/arm/boot/dts/omap3-gta04.dtsi | 6 ++++++
>> 1 file changed, 6 insertions(+)
>>=20
>> diff --git a/arch/arm/boot/dts/omap3-gta04.dtsi =
b/arch/arm/boot/dts/omap3-gta04.dtsi
>> index 4504908c23fe..e967d738aaaf 100644
>> --- a/arch/arm/boot/dts/omap3-gta04.dtsi
>> +++ b/arch/arm/boot/dts/omap3-gta04.dtsi
>> @@ -477,6 +477,12 @@
>> &uart2 {
>> 	pinctrl-names =3D "default";
>> 	pinctrl-0 =3D <&uart2_pins>;
>> +
>> +	gps: gps {
>> +		compatible =3D "wi2wi,w2sg0004";
>> +		lna-supply =3D <&vsim>;   /* LNA regulator */
>> +		enable-gpios =3D <&gpio5 17 GPIO_ACTIVE_HIGH>;    /* =
GPIO_145: trigger for turning on/off w2sg0004 */
>> +	};
>> };
>=20
> How about move the comment above the node to avoid long lines?
> Or just change it to gpio_145 for the comment as the property
> is already enable-gpios?
>=20
> Regards,
>=20
> Tony

Done so that it will be included in next version.

BR and thanks,
Nikolaus

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
