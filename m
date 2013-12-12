From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 13/26] ARM: omap3.dtsi: add omapdss information
Date: Thu, 12 Dec 2013 10:38:34 +0200
Message-ID: <52A9760A.3000801@ti.com>
References: <1386160133-24026-1-git-send-email-tomi.valkeinen@ti.com> <20131205170514.GY26766@atomide.com> <52A5BB65.5050109@ti.com> <2364383.8GWpsWSoJu@avalon>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="mWFFWcicMRwCvQ5w2jVMLqKEcbjWdXraL"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:47189 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750873Ab3LLIik (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 12 Dec 2013 03:38:40 -0500
In-Reply-To: <2364383.8GWpsWSoJu@avalon>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org, Archit Taneja <archit@ti.com>, Darren Etheridge <detheridge@ti.com>

--mWFFWcicMRwCvQ5w2jVMLqKEcbjWdXraL
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2013-12-12 01:44, Laurent Pinchart wrote:

>> The DSS subdevices depend on the dss_core. dss_core has to be powered =
up
>> for any of the subdevices to work. This is done automatically by the
>> runtime PM when the subdevices are children of the dss_core.
>=20
> I'd like to get a clearer picture of the hardware here. The OMAP3 ISP i=
s=20
> organized in a seemingly similar way, with the hardware subdivided in h=
igh-
> level more-or-less independent modules. However, from a system point of=
 view,=20
> the ISP submodules are not standalone: they're part of the same power d=
omain=20
> as the ISP core, with subclocks management and interrupts being handled=
 by the=20
> ISP core. For those reasons we've modeled the ISP as a single platform =
device.
>=20
> Are the DSS submodules really independent, or are they organized simila=
rly ?=20
> For instance do they each have a clock handled by the OMAP core clock I=
P, or=20
> are the clocks gated by the DSS core ? Do they have interrupts routed t=
o the=20
> GIC, or does the DSS core driver demux the interrupts ?

The DSS is "interesting". The TRM for various OMAP versions are the best
source of information, there's integration section in the very beginning
of the DSS chapter.

We have the main dss_core (just DSS in the TRM, but for clarity we use
dss_core) module, which is kind of a wrapper/glue for all the
submodules. dss_core contains things like controlling muxes for signals
between submodules, or clocks coming from outside. And there's the DSS
power domain, containing all the DSS modules.

Then we have DISPC, which reads the pixel data, manipulates it, and
outputs raw RGB data to encoder submodules.

Then we have DSI, HDMI, RFBI, VENC encoder submodules. They all have
separate address spaces, some have dedicated PLLs, PHYs, and interrupts.

Then DPI, which I think is mostly just level shifters. It's really just
a port, as you say.

SDI is a bit unclear to me. The registers for it are in the dss_core.
There's only a few registers, but it does have a PHY and a PLL. But I
guess it's also more of a port than a separate module.

As for the clocks, I'm not sure what the actual point is that you want
to clarify. DSS gets one "main" func clock from PRCM, which is used by
DISPC and in some cases other submodules. But then we have dedicated DSI
and HDMI PLLs, which, at least in DSI's case, can be used to fully
satisfy DSI's clock needs. The PLLs can also be used for DISPC, so the
PRCM clock is not needed in all cases.

The interrupts, then. In OMAP4, DISPC, DSI1, DSI2 and HDMI each have
their own interrupt line. In OMAP3, DISPC and DSI shared the same
interrupt line. But in both OMAP4 and OMAP3 DISPC and DSI interrupt
status/enable is handled via the respective IP.

The DSS submodules also are not really designed together. For example,
the HDMI IP is from one vendor, not TI. And the HDMI IP is different in
OMAP4 and OMAP5. Most of the DSS IPs are, I believe, from TI. But it's
not like all the IPs were designed to work together, that's why we have
wrappers/glue blocks (e.g. around HDMI).

So, are they independent? I don't know =3D). I think they lean on the
independent side. dss_core is always needed for the submodules to work,
but for example DSI could be used without DISPC, using system DMA to
transfer data from memory to DSI. Not a very useful thing to do, but
still, there are dedicated DMA channels for that.

> If the submodules are not independent, would it make sense to have a si=
ngle DT=20
> node that would be matched with the DSS core driver ? You could list=20
> information about the submodules in subnodes, and possibly create platf=
orm=20
> devices internally in the DSS core, but a single platform device would =
be=20
> instantiated from DT, and the DSS core wouldn't need a "simple-bus" com=
patible=20
> string. My gut feeling is that this would be a better representation of=
 the=20
> hardware, but I might not known enough about the DSS and be completely =
wrong.

I have been wondering about this for a long time. The DSS modules have
dependencies, and splitting them into separate devices/drivers brings
the issue of probe order. We side-step that by having the virtual
omapdss driver add the drivers for DSS modules in proper order.

But then, I feel that they are quite independent and probably should be
separate devices. And we've had omap hwmods, which I believe force us to
have separate devices (although afaik hwmods are going away).

>>> BTW, for v3.15, I'm hoping to do patches where we deprecate ti,hwmods=

>>> property and do the lookup based on the compatible property instead ;=
)
>>> So from that point of view we need to get the device mapping right in=

>>> the .dtsi files, and don't want to start mixing up separate devices i=
nto
>>> single .dtsi entry.
>>
>> Hmm, was that just a general comment, or something that affects the DS=
S
>> DT data I have in my patch? As far as I understand, the DSS nodes
>> reflect the current hwmods correctly.
>>
>> With the exception that DPI and SDI do not have a matching hwmod, as
>> they are really part of dss_core/dispc. They are separate nodes as the=
y
>> are "video outputs" the same way as the other subnodes.
>>
>> I could perhaps remove the DPI and SDI nodes, and have them as direct
>> video ports from DISPC, but... That's easier said than done.
>=20
> DPI and SDI indeed seem like ports to me, node devices. Have you given =
the=20
> implementation a thought ? How difficult would it be ?

I have not though too much about the implementation. I'll spend some
time on that to see how it goes.

There's also the question where do the ports belong to. DISPC outputs
the pixels.

For DPI, I don't see dss_core really doing anything.

For SDI, the dss_core contains the control for the SDI PLL and PHY. But
SDI PLL and PHY are not parts of dss_core, just the control is done via
dss_core.

 Tomi



--mWFFWcicMRwCvQ5w2jVMLqKEcbjWdXraL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJSqXYKAAoJEPo9qoy8lh71HhcQAIG4mRfIIwDYnhMbujMmJCeb
whY8HzeepMxYB++y9SZdtIDUgFmjZVxfSkJ3Hx/qJz2HUK5/yo7mgh6UKKL0kOjR
t4wba25xwfBFeVNsd5qjOEORaz8qhqgKzXTOGHS9eYEt5OUtoe3nigCRqlqbg93p
UZZULBcklMolxxLbIHwcwYuZbILP37DqAscfsDwKKMi5hpq7l//JuOTT6BYr7sWx
0UIsBNVEPBVVNQ0Ib3aEHrcXz0r8801CPkqsjl2RfAGI4SrfyC9t5cQoWROW4dQA
a5fHpfsU1mJuwsW5eH1swpsx30BB5+80BwOWeOEqVA3SyHHccSe4sZUVnwRcktLO
52woTU47Ih7O27VGG0nsX03IH0dOAk1ypTHGdDC+cAWZ0lRKoXFPdhXSR1BXIi8A
wzVd7Ag6RqjmbxDuBLDw+KS3c+aQTRwE1+IHG6hp/Qs7ABsHece/SpDzGoN9IDZ/
62W/Z3mC+QiqFvmgTcGRPRJ9YB63z1Dwnw3tFVa2s3SMwIxDwa9RyQ20DCTs8sh2
pUqPuZMVaBhs7Nd0dHn962eofOK0BQrvHKzYpFagSB+sGYIIOq5HWWnW62x3vuRC
xH5e/VwydUbYu9uUwLKti1wjFuI6VU14RcvZ9fLkK3eaNTPLx0SVVbM2paaNfLZu
ApUA1Jft/r3w+zcciRTA
=hjAB
-----END PGP SIGNATURE-----

--mWFFWcicMRwCvQ5w2jVMLqKEcbjWdXraL--
