From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 6/6] OMAPDSS: HDMI: Create platform device to support
 audio
Date: Wed, 24 Oct 2012 07:29:19 +0300
Message-ID: <50876E9F.5010305@ti.com>
References: <1350350839-30408-1-git-send-email-ricardo.neri@ti.com> <1350350839-30408-7-git-send-email-ricardo.neri@ti.com> <5084F85C.9050508@ti.com> <5085E957.6060003@ti.com> <50866569.8010409@ti.com> <5086BB01.1080802@ti.com> <5086C333.9000801@ti.com> <5086D200.7000008@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigB1D33BD4FA707A106A4585BD"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:34574 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750827Ab2JXE30 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 24 Oct 2012 00:29:26 -0400
Received: from dlelxv30.itg.ti.com ([172.17.2.17])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id q9O4TQY6028020
	for <linux-omap@vger.kernel.org>; Tue, 23 Oct 2012 23:29:26 -0500
Received: from DLEE74.ent.ti.com (dlee74.ent.ti.com [157.170.170.8])
	by dlelxv30.itg.ti.com (8.13.8/8.13.8) with ESMTP id q9O4TQ5U015161
	for <linux-omap@vger.kernel.org>; Tue, 23 Oct 2012 23:29:26 -0500
In-Reply-To: <5086D200.7000008@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ricardo Neri <ricardo.neri@ti.com>
Cc: s-guiriec@ti.com, peter.ujfalusi@ti.com, b-cousson@ti.com, linux-omap@vger.kernel.org

--------------enigB1D33BD4FA707A106A4585BD
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2012-10-23 20:21, Ricardo Neri wrote:

>> If so, you could pass only that one address, instead of the whole HDMI=

>> register space?
> Yes, that could work. I thought about that but the common HDMI driver
> would have to know the the IP-specific register, which it should not.

Argh, of course...

> Perhaps the IP-specific register address can be passed by a IP-specific=

> function such as hdmi_get_audio_dma_port for the common HDMI driver to
> populate the resource.
>=20
> Btw, could this be another reason to convert the IP-specific libraries
> to drivers?

Yes, I think it makes more and more sense to do that.

> Even though this would allow our HDMI drivers to be more inline with
> what other HDMI drivers do, things like power management and interrupts=

> are still handled by DSS, unlike x86, for instance [1][2]. So the audio=

> drivers will still depend on DSS. Also, the register layout is differen=
t
> for OMAP5 and audio registers are even more scattered. Furthermore, the=

> common HDMI driver would have to know the IP-specific layout to know
> what register spaces expose to the audio driver (another reason to have=

> IP-specific drivers?). So I would vote for continuing using the omapdss=

> audio interface.

Okay.

I think your approach is ok for the time being. I don't like passing the
whole register space to the audio driver, but that's the best we can do
with the current driver.

Have you looked at converting to IP specific drivers? Any idea of the
effort? I'd like it to be done with the omap4 hdmi driver first, before
merging omap5 hdmi into the mainline, if at all possible.

 Tomi



--------------enigB1D33BD4FA707A106A4585BD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://www.enigmail.net/

iQIcBAEBAgAGBQJQh26jAAoJEPo9qoy8lh71kuEP/2lKyEGVjOgh7/DJ6fT8nAFb
d5csUfAKewQNf1GDzwYUc6jQjDd2Ir7RlU4fMh/za4aFQ7ZbJEP0a9HkdGbocX8d
5NrZqWL3lE0jzm+PGrY9Xxf6w4VRy2ekYTCkKdOYMdFUbxMznlzpaO9uJvzSX7jk
ExzVM4H0serP/cn8y3sGtPmoGtJaWbI/qrTghU0Jk2szFXTlnrhzenNPqviRoFN+
/ImW7FlNfHIhNFizV4lPvVOFXI6OkN9xuA7ylBdknA8aawL93pbmbu2uSUgK/NOV
3v5tv7uyMQL4JT23aebK6wXcoKGrq81d1Ngr6ZeTDMDMD6DsastjbjBO3Sajm9aD
5EyygRatlsxnLq8kvFHuY1OX7JG2jsgLLPpOMNNsKKPnuBATmXF0gORyXrfMjQJU
+DhZj+TAHPsmdW0/KbU0+NKPe+NntvQgDP7LUvm97S5yHL7kM8dKfgiBwkt2YP/Y
J58EzgK5Qu1pMJxhMbdMPrFCAOa+5Tvhr9NhoSWhODrA1dPZIbuRtx72u+kkOUfM
WDaSoVE2ohe/9nibgOPbq7C29E3K69TnJslgU7x/PT9YrltxpgVNsVkG4armjhat
SsOF+y0wA4X+g3G0C7QYF6qox+edbumSBh47ASkWZz2e879n4zZxA92Gwc4LKsTz
aM1ialOWk6lBZAL+qqka
=PEdT
-----END PGP SIGNATURE-----

--------------enigB1D33BD4FA707A106A4585BD--
