From: "H. Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Subject: Re: [PATCH] ARM: dts: Configure omap5 AESS
Date: Tue, 14 Jan 2020 19:29:10 +0100
Message-ID: <632E66D6-47EF-44CF-BF02-B0F5A215D904@goldelico.com>
References: <20200114150937.18304-1-tony@atomide.com> <52905C15-A2D1-4372-9781-D602D0B274B6@goldelico.com> <20200114164613.GR5885@atomide.com> <D51230C4-2642-4388-959F-313A3382AB99@goldelico.com> <20200114171634.GS5885@atomide.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20200114171634.GS5885-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, =?utf-8?Q?Beno=C3=AEt_Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Matthijs van Duin <matthijsvanduin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>, Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org


> Am 14.01.2020 um 18:16 schrieb Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>:
>=20
> * H. Nikolaus Schaller <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org> [200114 17:05]:
>>> Am 14.01.2020 um 17:46 schrieb Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>:
>>> Care to clarify what you have in mind? The module is generic, aess
>>> device will be the child node.
>>=20
>> The existing driver is hooked into the sound root-node and looks for =
a
>> ti,aess =3D <&aess>; link:
>>=20
>> / {
>> 	sound: sound {
>> 		compatible =3D "ti,abe-twl6040";
>> 		ti,model =3D "omap5-uevm";
>>=20
>> 		ti,jack-detection;
>> 		ti,mclk-freq =3D <19200000>;
>>=20
>> 		ti,mcpdm =3D <&mcpdm>;
>> 		ti,mcbsp1 =3D <&mcbsp1>;
>> 		ti,mcbsp2 =3D <&mcbsp2>;
>> 		ti,mcbsp3 =3D <&mcbsp3>;
>>=20
>> 		ti,twl6040 =3D <&twl6040>;
>> 		ti,aess =3D <&aess>;
>>=20
>> 		...
>> 	};
>> };
>>=20
>> Well, this could be simply wrong... I.e. the aess node should request
>> all the phandles to mcpdm and mcbsps because it is connected to.
>=20
> The aess label above should be in the child aess node, not in the
> target-module.
>=20
>> Or it is right to use the sound node to "connect" all subsystems.
>=20
> Sounds like that's all taken care of nowadays with the generic
> graph binding:
>=20
> Documentation/devicetree/bindings/graph.txt
>=20
> See also snd-soc-audio-graph-card and various users for it:
>=20
> Documentation/devicetree/bindings/sound/audio-graph-card.txt

Ok. Will become a major rework of the driver...
On the other hand the audio graph library could simplify a lot of =
things.

>=20
>> Then the "aess" core could also become the child node of the =
target-module:
>>=20
>> target-module@f1000 {			/* 0x401f1000, ap 32 =
20.0 */
>> 	...
>> 	aess: aess {
>> 		compatible =3D "ti,aess";
>> 		status =3D "disabled";
>> 	};
>> };
>=20
> Yeah this is how it should be :)
>=20
>> Although it looks better this way, it may make it even one step
>> more difficult to resurrect the old code...
>=20
> Well the old phandles and properties should work the same, just put =
them
> into the child aess node. No need to stuff anything else there at the
> target-module level AFAIK.

What it might need is to make the aess driver a completely separate =
module
loaded identified through the compatible record.

>=20
>> And DT maintainers are not happy with otherwise undefined compatible
>> definitions.
>>=20
>> So maybe:
>>=20
>> target-module@f1000 {			/* 0x401f1000, ap 32 =
20.0 */
>> 	...
>>=20
>> 	aess: aess {
>> 		/* revisit
>> 		compatible =3D "ti,aess";
>> 		status =3D "disabled";
>> 		*/
>> 	};
>> };
>=20
> But we have no binding and no driver for the aess at this point..

That is why I propose a comment around it...
But I am not sure if empty nodes are even allowed.

> If and when the aess driver work the child node can be just added :)

Yes, surely. So it is up to you to decide.

Best regards,
Nikolaus
