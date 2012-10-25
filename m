From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 6/6] OMAPDSS: HDMI: Create platform device to support
 audio
Date: Thu, 25 Oct 2012 17:54:31 +0300
Message-ID: <508952A7.3040800@ti.com>
References: <1350350839-30408-1-git-send-email-ricardo.neri@ti.com> <1350350839-30408-7-git-send-email-ricardo.neri@ti.com> <5084F85C.9050508@ti.com> <5085E957.6060003@ti.com> <50866569.8010409@ti.com> <5086BB01.1080802@ti.com> <5086C333.9000801@ti.com> <5086D200.7000008@ti.com> <50876E9F.5010305@ti.com> <50894D3F.6000701@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig4F89D7631C9D48D0512ED30B"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:42351 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933157Ab2JYOye (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Oct 2012 10:54:34 -0400
Received: from dlelxv30.itg.ti.com ([172.17.2.17])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id q9PEsXhR012884
	for <linux-omap@vger.kernel.org>; Thu, 25 Oct 2012 09:54:33 -0500
Received: from DFLE72.ent.ti.com (dfle72.ent.ti.com [128.247.5.109])
	by dlelxv30.itg.ti.com (8.13.8/8.13.8) with ESMTP id q9PEsXZI023362
	for <linux-omap@vger.kernel.org>; Thu, 25 Oct 2012 09:54:33 -0500
In-Reply-To: <50894D3F.6000701@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ricardo Neri <ricardo.neri@ti.com>
Cc: s-guiriec@ti.com, peter.ujfalusi@ti.com, b-cousson@ti.com, linux-omap@vger.kernel.org

--------------enig4F89D7631C9D48D0512ED30B
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2012-10-25 17:31, Ricardo Neri wrote:
>=20
>=20
> On 10/23/2012 11:29 PM, Tomi Valkeinen wrote:
>> On 2012-10-23 20:21, Ricardo Neri wrote:
>>
>>>> If so, you could pass only that one address, instead of the whole HD=
MI
>>>> register space?
>>> Yes, that could work. I thought about that but the common HDMI driver=

>>> would have to know the the IP-specific register, which it should not.=

>>
>> Argh, of course...
>>
>>> Perhaps the IP-specific register address can be passed by a IP-specif=
ic
>>> function such as hdmi_get_audio_dma_port for the common HDMI driver t=
o
>>> populate the resource.
>>>
>>> Btw, could this be another reason to convert the IP-specific librarie=
s
>>> to drivers?
>>
>> Yes, I think it makes more and more sense to do that.
>>
>>> Even though this would allow our HDMI drivers to be more inline with
>>> what other HDMI drivers do, things like power management and interrup=
ts
>>> are still handled by DSS, unlike x86, for instance [1][2]. So the aud=
io
>>> drivers will still depend on DSS. Also, the register layout is differ=
ent
>>> for OMAP5 and audio registers are even more scattered. Furthermore, t=
he
>>> common HDMI driver would have to know the IP-specific layout to know
>>> what register spaces expose to the audio driver (another reason to ha=
ve
>>> IP-specific drivers?). So I would vote for continuing using the omapd=
ss
>>> audio interface.
>>
>> Okay.
>>
>> I think your approach is ok for the time being. I don't like passing t=
he
>> whole register space to the audio driver, but that's the best we can d=
o
>> with the current driver.
>=20
> What about for now having a function in the IP library to be called fro=
m
> the common driver to determine the address of the port? Something like[=
1]:
>=20
>     res =3D platform_get_resource_byname(hdmi.pdev,
>                        IORESOURCE_MEM, "hdmi_wp");
>=20
>     aud_offset =3D hdmi.ip_data.ops->audio_get_dma_port_off();
>     aud_res[0].start =3D res->start + aud_offset;
>     aud_res[0].end =3D res->start + aud_offset + 3;

Yep, I think that looks quite clean. I wonder if there's a macro or func
to calculate the end position... It'd be more readable to set start and
size, instead if start and end.

>> Have you looked at converting to IP specific drivers? Any idea of the
>> effort? I'd like it to be done with the omap4 hdmi driver first, befor=
e
>> merging omap5 hdmi into the mainline, if at all possible.
>>
> As a first step, I have started implementing a separate driver for the
> TPD12S015 as you suggested in the past. For converting the IP libraries=


I'm not sure you can to the TPD as a separate driver currently. Or, at
least in the way I've imagined it to be. My thinking is that it should
be a "video entity" between OMAP's HDMI output and the HDMI monitor, but
we don't currently support these kind of chains. That's why I suggested
to just cleanly separate the TPD code in separate areas, and prefix the
funcs with tpd, etc.

What have you planned for it?

> into drivers, I still don't see how to keep them independent of omapdss=

> to be reusable by DaVinci platforms (but afaik they are not using our
> libraries anyways). Maybe, a thin compatibility layer for omapdss (the
> hdmi_panel)? I still don't  have a clear idea. :/

Yeah, I think we need quite a bit of restructuring to convert the IP
libs to drivers. Or more precisely, redirections.

What I imagine we'd have is some kind of hdmi_ops struct, containing
function pointers for the operations. These calls would go to IP driver.
The IP driver would create this struct at probe time, and register
itself somewhere.

Then hdmi panel driver would get this hdmi_ops pointer from the place
where it was registered to, and use it to call the functions.

 Tomi



--------------enig4F89D7631C9D48D0512ED30B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://www.enigmail.net/

iQIcBAEBAgAGBQJQiVKnAAoJEPo9qoy8lh71iLkQAKvWPQkHVhDt7gOhixuWn7Mh
+6GZDiXYSZpDg3iX9HQAf/yyC0QV615Xd5fimwl9FauiWjCnEuFmNrZDZSqmC/Z7
uq7ICpvO1C7bVsW550oDURZJaA9H71WkRW7MNJBifvJLpmXrnJTXuj1gBGqxswHS
Slajce/Q7t+KUOAbjNkS/jbm/crwS2prJHTprRh/4YPWGepGHB4pwJVjDXxt47Zy
JUg0umPwGGxJmXQos6spVGTkGHePegX+yqc07QGc1rQo665HgRG4kx0Qg/tRE5rm
7jI+/cei9XQlqgOLmNHTE/Jt0MLnUuHEyo6Sj3wcyqhw5CY7J/e02t+8rA0+D3/q
iFZ1k/GMGPiCqGRQFR93ou6LW6V5Gvh7IcVXscR20SmmtoRnHjm42G9sYAhVqNiB
bwCSGD4EKRdVymDtOoFZDe7Jxlm8WYEN0OTZa4GFgvBsUi4XZY0uXfSNhYcHwvKC
pJHR3d70xhEQKrSXIxOZHOmCwxPqy2eCP0cz8bk/z7F3e+IRwn0FEi8pwcu1K7Dk
vALfOWYjlwNDtg6rSKBDs/Tc2zjM4MKu34yUNi1WQlwtWKuhpC4M5jo0ajajI0ys
ZrqjTtJ/FhUhsQkE/wztGLPI44whK/213Qre2tDQ0Y2VjDTW8UvnHrX2T1jgMqC7
6Y9v7QDz2XOg7cXZsk7f
=R0Hn
-----END PGP SIGNATURE-----

--------------enig4F89D7631C9D48D0512ED30B--
