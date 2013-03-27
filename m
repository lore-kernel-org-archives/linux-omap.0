From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 00/26] DSS device model change
Date: Wed, 27 Mar 2013 08:13:51 +0200
Message-ID: <51528E1F.9080608@ti.com>
References: <1364304836-18134-1-git-send-email-tomi.valkeinen@ti.com> <20130326171006.GG25575@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig3AA4A1E72A8EF3D7E35B9268"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:56818 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751526Ab3C0GN6 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 27 Mar 2013 02:13:58 -0400
In-Reply-To: <20130326171006.GG25575@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Archit Taneja <archit@ti.com>

--------------enig3AA4A1E72A8EF3D7E35B9268
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2013-03-26 19:10, Tony Lindgren wrote:
> * Tomi Valkeinen <tomi.valkeinen@ti.com> [130326 06:38]:
>> Hi,
>>
>> To make it possible to add DT support to DSS, and later use the Common=
 Display
>> Framework, we need to change the DSS device model. We currently have a=
 custom
>> dss bus, and omap_dss_devices on that bus, and the aim is to get rid o=
f that
>> bus.
>>
>> The panel devices will be converted occording to the control bus of th=
e panel.
>> For many panels this means that the panel device will become a platfor=
m_device.
>> For some, it means the panel devices become i2c or spi devices.
>>
>> This series takes the first step toward that goal. This series:
>>
>> * Converts DPI, HDMI and DSI outputs to work with new style panels
>> * Converts TFP410, Taal and generic-dpi panels to new model
>> * Converts Panda, 4430SDP and Overo boards to use the new panels
>>
>> The non-converted outputs and panels still work, so they can be conver=
ted in
>> stages.
>=20
> This is nice, it removes a merge dependency between ARM code and the dr=
iver :)

Yes. It does give me a few more gray hairs, though =3D). It'd be so much
easier to have all related changes in one clean patch series.

>> Note about board files: I only convert a few board files here for exam=
ple. I
>> have a branch with board file changes for all the affected board files=
=2E I did
>> not include them as they are more or less identical. If this series lo=
oks good,
>> I will create an independent branch for the arch/arm stuff, so it can =
be pulled
>> separately.
>=20
> Great looks good to me thanks.

To make the DSS work properly after this device model change, we also
need to solve the problem related to multiple display devices on the
same video bus.

Did the approach I suggested in

http://permalink.gmane.org/gmane.linux.ports.arm.omap/96039

look ok? Overo is the most complex one, I think the rest of the boards
that require changes have just LCD and DVI that conflict. But it still
means we'll have that kind of choice Kconfig option for all those boards.=


 Tomi



--------------enig3AA4A1E72A8EF3D7E35B9268
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBAgAGBQJRUo4jAAoJEPo9qoy8lh71G1EQAJXhywpZf+3u3h9Y330droOi
1wjhySzYUB+nwtwbwqPzFKF8myYjoqhZrpZiq9N53YNaAqQoMGpKHQNWphy5QKHw
pBT8VqC3eYEzkXchao56r5axSpJFxwJynhSnHHbrMnosncEDnr+Xk1DuhN6WtM3L
lGS9J6wnoO6v0U0ZMFkSjjv489A7SkLyadxBIZDX4TlDZ1/5yRylv9JhkDHZF/w4
ajASjn3DIj5LLmrTfefud3nZIcIpgwYuI+nDGpvGQngMSzZOJHw5omC3PIJTnJR0
Z9O5BiiM/t7/1exUaunGePNY+cLwSkx45Uf94CBfBhKHxinFD4kgXk2tBTssdSrI
4HOe6q0hfimF59kAubSQKRmcRXm0Tf/qLllEwQfIKilzmYftfnJLjDgRLazN8W3B
MRjhiNJbkGu2aMqpWK3+y8a3CqvMu13FNoErNT55449/1YFF46KBRMcJxgtPTep5
mJU+36hVJe9RcCFw9EOjwHdFtBJZEgRyYVrpPCiW71W9zzqZBCl3OuDVE75q+T+h
ArFf1LrvjuR8LlPOoc42I1z2BcbtaSFdDA90pQ4B2Aew7W8ulfizXVJmc+iR+4Jo
r15NiSCX3FEx5OKbHtFbckgKgWt9JQ9+jDw2rfZXHlyCvx6ok/jJ4Ffr8vVkWqt1
xEPjRN8aqVwOh2rsPi9G
=gQeQ
-----END PGP SIGNATURE-----

--------------enig3AA4A1E72A8EF3D7E35B9268--
