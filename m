From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v4 3/6] Documentation: DT: Document twl4030-madc-battery
 bindings
Date: Wed, 11 Mar 2015 09:44:42 -0700
Message-ID: <20150311164442.GA5264@atomide.com>
References: <1426022847-30912-1-git-send-email-marek@goldelico.com>
 <1426022847-30912-4-git-send-email-marek@goldelico.com>
 <20150311152414.GX5264@atomide.com>
 <844740CD-C95B-4411-A2C8-4906F58DBEE8@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <844740CD-C95B-4411-A2C8-4906F58DBEE8-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Dr. H. Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Cc: Marek Belisko <marek-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>, Benoit Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Dr. H. Nikolaus Schaller <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org> [150311 09:17]:
> Hi,
>=20
> Am 11.03.2015 um 16:24 schrieb Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>:
>=20
> > Hi,
> >=20
> > * Marek Belisko <marek-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org> [150310 14:28]:
> >> Signed-off-by: Marek Belisko <marek-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
> >> ---
> >> .../bindings/power_supply/twl4030_madc_battery.txt | 43 ++++++++++=
++++++++++++
> >> 1 file changed, 43 insertions(+)
> >> create mode 100644 Documentation/devicetree/bindings/power_supply/=
twl4030_madc_battery.txt
> >>=20
> >> diff --git a/Documentation/devicetree/bindings/power_supply/twl403=
0_madc_battery.txt b/Documentation/devicetree/bindings/power_supply/twl=
4030_madc_battery.txt
> >> new file mode 100644
> >> index 0000000..d3dd9d8
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/power_supply/twl4030_madc_=
battery.txt
> >> @@ -0,0 +1,43 @@
> >> +twl4030_madc_battery
> >> +
> >> +Required properties:
> >> + - compatible : "ti,twl4030-madc-battery"
> >> + - capacity-uah : battery capacity in uAh
> >> + - ti,volt-to-capacity-charging-map : list of voltage(mV):level(%=
) values
> >> +	for charging calibration (see example)
> >> + - ti,volt-to-capacity-discharging-map : list of voltage(mV):leve=
l(%) values
> >> +	for discharging calibration (see example)
> >> + - io-channels: Should contain IIO channel specifiers
> >> +	for each element in io-channel-names.
> >> +- io-channel-names: Should contain the following values:
> >> + * "temp" - The ADC channel for temperature reading
> >> + * "ichg" - The ADC channel for battery charging status
> >> + * "vbat" - The ADC channel to measure the battery voltage
> >> +
> >> +Example:
> >> +	madc-battery {
> >> +		compatible =3D "ti,twl4030-madc-battery";
> >> +		capacity-uah =3D <1200000>;
> >> +		ti,volt-to-capacity-charging-map =3D <4200 100>,
> >> +					        <4100 75>,
> >> +					        <4000 55>,
> >> +					        <3900 25>,
> >> +					        <3800 5>,
> >> +					        <3700 2>,
> >> +					        <3600 1>,
> >> +					        <3300 0>;
> >> +
> >> +		ti,volt-to-capacity-discharging-map =3D <4200 100>
> >> +						   <4100 95>,
> >> +						   <4000 70>,
> >> +						   <3800 50>,
> >> +						   <3700 10>,
> >> +						   <3600 5>,
> >> +						   <3300 0>;
> >> +		io-channels =3D <&twl_madc 1>,
> >> +	                      <&twl_madc 10>,
> >> +			      <&twl_madc 12>;
> >> +		io-channel-names =3D "temp",
> >> +		                   "ichg",
> >> +		                   "vbat";
> >> +	};
> >=20
> > Rather than just making platform_data into device tree properties..
> >=20
> > Can't you hide the these custom properties behind the compatible fl=
ag?
> >=20
> > You can initialize that data in the driver based on the compatible
> > flag and the match data.
> >=20
> > This makes sense if you can group things to similar configurations.
>=20
> Maybe I have not completely understood your proposal.
>=20
> Do you mean to go back to have big parameter tables for each device/b=
attery
> combination in the driver code and the compatible flag (e.g. compatib=
le =3D =E2=80=9Cboard17=E2=80=9D)
> chooses the right data set for the charging map and channels?

If you can somehow group them, then yes. Not for every board if there
are many of them naturally.
=20
> I thought this is what the DT was introduced for - to have the same d=
river=20
> code but adapt to different boards depending on hardware variations.

Yeah but you also need to consider the issues related to introducing
new device tree properties. The device tree properties introduced
should be generic where possible.

> And batteries have very different characteristics and vary between de=
vices=E2=80=A6

Right. Maybe that has been already agreed on to use capacity-uah for
batteries in general? In that case I have not problem with that as
it's a generic property :)
=20
> The charging maps are depending on the battery type connected to the =
twl4030
> and which madc channel is which value is also a little hardware depen=
dent
> (although the twl4030 doesn=E2=80=99t give much choice).

Just to consider alternatives before introducing driver specific
property for the maps.. Maybe here you could have few different type
of maps and select something safe by default? Of course it could be thi=
s
is higly board specific, I think some devices may be able to run below
3.3V for example..
=20
> And moving this information into the driver for each board that uses =
it
> would blow up the code.

Right, I'm not saying we should build databases into the kernel drivers=
=2E
Just trying to avoid introducing driver specific properties unless
really needed :)

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
