From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 06/26] OMAPDSS: if dssdev->name==NULL, use alias
Date: Fri, 13 Dec 2013 14:01:22 +0200
Message-ID: <52AAF712.1030209@ti.com>
References: <1386160133-24026-1-git-send-email-tomi.valkeinen@ti.com> <1386160133-24026-7-git-send-email-tomi.valkeinen@ti.com> <37483030.ghHfzYFSnL@avalon> <10507960.9DXH4TSv2E@avalon> <52A968BD.20304@ti.com> <20131212100527.GA860@earth.universe> <52A9C470.2030102@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="CFkjO4ePuWtN8J1mDv5nXEpmwWoN6BJtO"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:60037 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752358Ab3LMMBf (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 13 Dec 2013 07:01:35 -0500
In-Reply-To: <52A9C470.2030102@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sebastian Reichel <sre@ring0.de>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org, Archit Taneja <archit@ti.com>, Darren Etheridge <detheridge@ti.com>, Tony Lindgren <tony@atomide.com>, Florian Vaussard <florian.vaussard@epfl.ch>

--CFkjO4ePuWtN8J1mDv5nXEpmwWoN6BJtO
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2013-12-12 16:13, Tomi Valkeinen wrote:
> On 2013-12-12 12:05, Sebastian Reichel wrote:
>> On Thu, Dec 12, 2013 at 09:41:49AM +0200, Tomi Valkeinen wrote:
>>>> A label property is still an option.
>>>
>>> Hmm, what do you mean? Label as in:
>>>
>>> foo : node {
>>> };
>>>
>>> Isn't that 'foo' label only visible in DT itself, as a shortcut?
>>
>> Some driver use a "label" property like this:
>>
>> foo : node {
>>     label =3D "lcd";
>>
>>     ...
>> };
>>
>> See for example
>>
>> Documentation/devicetree/bindings/leds/common.txt
>> Documentation/devicetree/bindings/mtd/partition.txt
>=20
> Ah, I see. That kind of label was actually the first thing I did when
> starting to work on DSS DT. But I removed it, as it didn't describe the=

> hardware and I didn't see others using anything similar.
>=20
> But I guess one could argue it does describe hardware, not in electrica=
l
> level but in conceptual level.
>=20
> The question is, do we need labeling for displays? For backward
> compatibility omapdss would need it, but in general? I'm quite content
> with having just display0, display1 etc. Using the alias node, those ca=
n
> be fixed and display0 is always the same display.

I came to the conclusion that it's better to add the label to keep
backward compatibility, especially as it was very easy to add.

So we'll have 'name' and 'alias' for each display (as we have already).

In the current non-DT boot (which is going away):

- 'alias' is created by omapdss dynamically (first display to be
registered is display0, etc.)
- 'name' comes from platform data

In the DT boot:

- 'alias' comes from the DT aliases node, or if there are no display
aliases, it's created the same way as to non-DT. The code presumes that
there either is a DT alias for all displays, or there are none.
- 'name' comes from 'label' property

In both non-DT and DT cases, if 'name' is NULL (i.e. not set in platform
data or no 'label' property), the alias is used as a name.

I think this works fine, and was a trivial change.

 Tomi



--CFkjO4ePuWtN8J1mDv5nXEpmwWoN6BJtO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJSqvcSAAoJEPo9qoy8lh71upcQAIG+Xj8jlNkjZx9AdeRaASCQ
Pg9N8vVRoAtyFEa5iJ5uL1RVwLNBKd/4RkS7iPNY8dXhNNetC3sL7VLEBCy4laPg
i1vepR5cku+z651eue6mm4K/T4iEZMJY0HI1Vd34Jspek+5OZJVN2YKNLTy2Fg62
X7GjZ42ZppFSMOqQ6oghy8DsmZNwa9QjATg8kOFbsA2QAFt1VD2QzDFS6p2mjLNh
naVqntcPLi2v2ApUbvzxDsmtqgwCX68ZbfSJy4w+P1giNtjsnJMj/mWSHXMhonrM
Pq984byBPbra76YdFibeQmKaMmz/F4Xu6C6En5/yUwzOwzPK/U3YqG1pfYT75yvG
xpLHGZvOWk6gZwsbGLQt92D43MM4QtbDXiUKX5Yslhle0gnEjhRZAhTYV76P+Zna
j8KEI42HKEz3A+DAQOEEEKsViIXHOJ6dGy1UC0VUvQ1DQYTLMGo5ElhoMPqcEDvG
IY4xw5woYfoch03q9DIVuTdVR1QyHDs4lSYxxA628UIix+4+jzfXkbHEqjAXKm+A
qFGhGpkXbcKGWgk3CP8lJo8iRSFY0wVBJHKsOx6ICfF7/9iz51/VFZVWMCcW6gPI
mkGfhGF3bRMD4OHoIJ0OKVwd/pCoT14P4Coa686EiSG1IOnGDoxO9dCImvSoh4ST
L0hEflg5NkRi5niI5gb7
=DT6L
-----END PGP SIGNATURE-----

--CFkjO4ePuWtN8J1mDv5nXEpmwWoN6BJtO--
