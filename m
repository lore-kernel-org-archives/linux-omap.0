From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: DSS display-new custom enable/disable hooks
Date: Thu, 26 Sep 2013 11:20:49 +0300
Message-ID: <5243EE61.3000408@ti.com>
References: <CAAfyv349Xjt7Wy-R34OW81SzmUX-1WhfVZdbhWVDoOXpUKa9ug@mail.gmail.com> <52427ECA.1080500@ti.com> <CAAfyv37sSa=7x=p1wgX+Rhdxh=WMB4DhmC9ZQMpxB_rb30Aurw@mail.gmail.com> <3A4BA9B4-262C-4F0A-95B7-D243065D01BA@goldelico.com> <52429F06.6030609@ti.com> <307BD8A2-738A-4A66-8FD5-98C37AD4BCA3@goldelico.com> <5242BFEA.1090200@ti.com> <9172D29D-118B-4B6F-A454-BD359C5D97D4@goldelico.com> <5242EBB7.2090006@ti.com> <A88E32D7-26DC-4E22-A30D-098F174EB896@goldelico.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="pv2RqSGtSOdG1arr57OKMnnECPFlrp3s3"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:58981 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751018Ab3IZIU7 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 26 Sep 2013 04:20:59 -0400
In-Reply-To: <A88E32D7-26DC-4E22-A30D-098F174EB896@goldelico.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Dr. H. Nikolaus Schaller" <hns@goldelico.com>
Cc: linux-omap@vger.kernel.org, Belisko Marek <marek.belisko@gmail.com>

--pv2RqSGtSOdG1arr57OKMnnECPFlrp3s3
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 25/09/13 19:11, Dr. H. Nikolaus Schaller wrote:

> Hm. I a not sure if this model is complete if it ends at the physical c=
onnector.
> But that would be a different topic.

Yes, we currently model the components that exist on the board. I've
toyed with the idea of hotplugging a monitor "entity" after the
connector. There's nothing in the model that would strictly prevent
that, but hotplug in general would require more work.

> Well, I understand it that way:
>=20
> RAM -> DISPC -> Video Encoder -> DAC-Stage (the DAC and an output ampli=
fier within the OMAP chip) -> OMAP pins -> external amplifier (OPA) -> ph=
ysical Connector -> cable -> TVset connector -> some more processing -> p=
anel/screen -> Consumer
>=20
> or simplified to the most important parts:
>=20
> DISPC -> Video Encoder -> DAC-Stage -> external amplifier -> physical C=
onnector

Well, this brings up the question, how small parts is it necessary to
split the pipeline.

For example, DISPC consists of multiple stages. In theory, we could
model all those stages with individual SW entities. In practice, that
doesn't really give us anything, they are always one whole entity, DISPC.=


I think the same applies for VENC. There's no need to separate DAC from
VENC, they are always one whole entity (as far as I see).

Now, you could argue that DISPC and VENC (and the other DSS components)
also form one whole entity, the DSS. But here the difference is that we
already have different versions of DSS, that have different components.
Some don't have VENC, etc. But in all the different DSS versions, VENC
and DAC go together.

> the external amplifier is something specific to our board so that we ha=
ve to insert it into the pipeline.
>=20
> As you said above, if it would not have any controls we wouldn't have t=
o care about it. But it needs to be enabled/disabled.

Note also that even if there weren't any controls (like gpios), the
components usually require power. On one board the power could come from
VBAT or some other "always on" source, but on some other, the regulator
needs to be turned on. So even if there are no controls, there could be
need for a driver.

That said, it feels a bit silly to have a driver, whose only function
would be to turn on one regulator...

> The other controls are:
>=20
> "Bypass" means to bypass something in the DAC-Stage
> "AC" means to modify the DAC-Stage output level.
> "Invert" is probably a property of the VENC or could also be part of th=
e DAC stage (I don't know).
>=20
> BTW: I have seen a CAUTION block that describes in the last section how=
 some registers
> must be set to avoid current leakage. That should be done (if not yet) =
in the suspend
> code.

Yes, I don't think we manage VENC very well at the moment.

>> VENC outputs a video signal, and obviously any register changes requir=
ed
>> which affect the signal need to be done directly or indirectly by the
>> VENC driver.
>>
>> If OPA requires an inverted signal, it's between VENC and OPA to handl=
e
>> that. Connector is not involved.
>=20
> So we are not really missing an OPA362 driver but the DAC Stage driver =
within the DM3730 SoC.

As I said, I think we can consider DAC as part of VENC.

And I think we are really missing OPA362 driver. OPA requires someone to
control the enable GPIO (and maybe the regulators), and OPA driver is
the only logical place for those.

> And a mechanism that enabling/disabling the "tv" display automatically =
enables/disables
> all those stages + including an external OPA362.
>=20
> This raises some questions: So how can such a pipeline be individually =
set up
> by platform data? How does enable/disable work along the chain?

The pipeline is setup in the board file. Each component is given
component specific parameters, and the name of its source component.

Enable/disable works "backwards". Omapfb (or some other component) calls
enable on the last entity in the pipeline (connector in this case). The
connector driver in turn calls enable on its source entity, which would
be OPA. And so on.

> The OPA itself then should also participate in suspend/resume. Well, th=
at
> would be something important for proper power management. Only then
> we can make sure the OPA is disabled correctly.

There isn't really anything to suspend/resume on that level. If the
display is enabled, it stays enabled, there's no automatic suspend. If
there's a system suspend, omapfb (or similar component) will disable the
displays.

So it's only about enable/disable on this level.

> But then I would not call it opa362 driver but "external-video-amplifie=
r"
> with an enable-gpio that can be defined in the platform data or -1 if i=
t is not
> required. In the latter case the driver simply does nothing functional.=


Well, this is perhaps a bit about semantics, but it is a driver for
OPA362 hardware. Sure, we can make a more generic driver if we see that
there are other external amps that have very similar controls. But it's
still an OPA362 driver, but it would also be OPA123, OPA321, etc. driver.=


Making it "external-video-amplifier" driver is probably taking it too
far. We don't know what kind of amps there are. Maybe some are
controlled via i2c. Dumping all the different functionality for
different amps into one driver would just make one messy driver.

>> The question here is how to handle the above. Should OPA driver reques=
t
>> VENC driver to invert the signal? Or should VENC driver just be passed=

>> parameters from the board code making it invert the signal?
>=20
> Well, I think that it is the responsibility of those who have designed =
such a
> board and they have to configure the drivers for each pipeline stage in=
 a
> consistent way (i.e. if one is inverted the other should be as well, un=
less
> they want to see an inverted signal).
>=20
> Your idea of the OPA driver notifying the VENC driver would introduce a=
n
> information flow that does not exist at all in hardware. I.e. there is =
no "invert me"-wire
> in either direction. And that inversion could even happen behind the co=
nnector...

Well, there doesn't need to be a hardware information flow that would
match the SW. In fact, if there was, there would be no need for the SW
to do it.

Consider this:

DPI output (i.e. parallel RGB) and a DPI panel, connected with 24
datalines. The panel can be controlled via i2c, and you can send
commands to it to function in 16 or 24 bit modes. Here I think it makes
sense that when the user, via some method, commands the panel to use 16
bit mode, the panel driver would send the command to the panel hardware
and would then tell the DPI output to use 16 datalines. There's no
"use-16-bit"-wire from the panel.

I know there are different schools of thought how (and by who) the above
should happen, but that's the model current used in omap display drivers.=


That said, if the feature, "invert" in this case, never needs to be
changed at runtime, there's no real reason to have that kind of method
for OPA to change the inversion. So the board file could just pass the
invert flag as a parameter to VENC.

> Now how can we proceed?
>=20
> For the moment we could try to get the DEVCONF1 setup into the board_in=
it
> until a DAC Stage driver and some platform independent API for DEVCONF1=

> modifications exists.

Well, as I don't see the need for the DAC driver, I would just add the
function pointers to change DEVCONF1 to struct omap_dss_board_info.
Also, the flags to enable/disable invert, bypass and AC would be added
to the same struct.

Note that at the moment we have just struct omap_dss_board_info, which
is platform data for the whole DSS driver, i.e. we don't have separate
platform data for VENC. That will probably change at some point in the
future.

> For the external amplifier (OPA362) enable, we can write a simple drive=
r (it just
> needs to control a GPIO whose number is passed from the platform data).=


Yes, and also the regulator code to handle V+.

> What I don't know is how such a driver should be integrated into the pi=
peline

Look at the board files. The display components there have "source"
field, which points to the source component in the pipeline.

> and by which means it gets notified that the "tv" display is enabled/di=
sabled/suspended/resumed.
> Or does it simply receive its individual enable/disable calls?

OPA would receive enable from the Connector driver. And OPA would need
to call enable in the VENC driver.

> And is this similar to configuring and running the TFP410 driver? Then,=
 we could
> try to take parts of that driver.

Yes, TFP410 can be used as an example.

> And if I understand the TFP410 -> DVI example correctly such drivers ar=
e chained
> and share the same video timings (even if they are not relevant for a s=
pecific stage)?

No, they don't (need to) share the video timings. The TFP410 example
does share, because there are no real buffers or such in the pipeline
which would allow to change the timings. But in some cases there are
line buffers, and there, for example, the horizontal blanking intervals
may be changed. And sometimes there are full frame buffers, in which
case the timings can change totally.

 Tomi



--pv2RqSGtSOdG1arr57OKMnnECPFlrp3s3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJSQ+5lAAoJEPo9qoy8lh71r0QQAKuzaZNjxnNjkyzynNTey+xW
46/El5seQ004QrfAhjIarv7L7MbhbDbcI6JjeKLeSHgO5sXAkWflSYRkowECTQIi
6wuFKnUnFSI84VOVjMMxIlyFCBbebrO6dC+0s0gRjeu4taCbWU7C9aQkDhF965RS
cwNt7KZDlTdLwKuaFspiyebR5nWScSexx7al+V61rjLBydG7sYlsQVDHeaDBwvHG
NtGaetbuJiUfu+96fMwqhrdzSoG+B79eZ/wnHejjGunfTUbfsBR2XMs58LKKEhkN
oKIwmCzyeQA9rZU5RdSUJXiKMfwJIus72MoOXIKKM1CF0nziDxdXDdz6L96Ubuhb
NTYwr9bXwtfwb/V50f69uEfLFQIdjVRlOrykGwnQeQJVpGbL/w/AqHRc378axtgR
0FpII6wGqM1IZ67dlYxyijm+qNbYBHzzmDEBCG6LzaBeXF0NdETtIg1k/VwkFBMV
cCM+8ZOd29JOdr05l7TfJINQQpDZRMRP/SpEfk4qWF5rKsRPoxxraCBjS/T3CZRl
688UrEueNKDfmR6LuVX6zkxoizYb7DMK92i2dIga0G0WcFS7wIBq98gZ6GRSuMEy
PDcXXuurwLdokTiWiezuHM1j2uJoxxMavduTgNZjrSXvbh2lkZmxi2RCkMece4NP
sRNiQn0yNmvSTlHMtlOl
=uHnQ
-----END PGP SIGNATURE-----

--pv2RqSGtSOdG1arr57OKMnnECPFlrp3s3--
