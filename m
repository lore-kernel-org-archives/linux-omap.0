From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: omap DSS fails with tft410 driver panel?
Date: Thu, 22 Nov 2012 10:47:33 +0200
Message-ID: <50ADE6A5.3030001@ti.com>
References: <CAFqH_50PVJdbX0CMwo9t3RuAhzi3q6jcBwzq2R3UFighkrF7iw@mail.gmail.com> <CAGDS+nmx8qFSx932TudMN6ikmZ=OGkbvrZuCV=Ump+HETkU-tw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigA85B669D7FCD7A99AB036A90"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:56144 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753581Ab2KVTCH (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 22 Nov 2012 14:02:07 -0500
In-Reply-To: <CAGDS+nmx8qFSx932TudMN6ikmZ=OGkbvrZuCV=Ump+HETkU-tw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Steve Sakoman <sakoman@gmail.com>
Cc: Enric Balletbo Serra <eballetbo@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Javier Martinez Canillas <javier@dowhile0.org>

--------------enigA85B669D7FCD7A99AB036A90
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2012-11-22 02:08, Steve Sakoman wrote:
> On Thu, Oct 11, 2012 at 8:58 AM, Enric Balletbo Serra
> <eballetbo@gmail.com> wrote:
>=20
>> I see that commit dac8eb5f (OMAPDSS: TFP410: rename dvi files to
>> tfp410) and commit 2e6f2ee7 (OMAPDSS: TFP410: rename dvi -> tfp410)
>> changes the panel driver used on some boards. I tested current
>> linux-next-20101011 kernel with my IGEPv2 board and DSS fails with
>> following error (see http://pastebin.com/VjPGCQDt for full log) :
>>
>>    [   21.222808] omapdss OVERLAY error: check_overlay: paddr cannot b=
e 0
>>    [   21.229583] omapdss OVERLAY error: check_overlay: paddr cannot b=
e 0
>>    [   21.236236] omapfb omapfb: setup_plane failed
>=20
> Was there ever any resolution to this issue?

Not that I know.

> I am seeing the same errors on Overo.  The video output actually
> works, but it appears that this error causes X to close and then
> restart repeatedly.
>=20
> I'll add the printk's to omapfb_setup_plane() that were requested by
> Tomi and report back.

How can I reproduce this? Is there a downloadable rootfs somewhere that
I could try?

Could you also copy full kernel boot log to pastebin or such?

 Tomi



--------------enigA85B669D7FCD7A99AB036A90
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBAgAGBQJQrealAAoJEPo9qoy8lh71N70P/31RLmNhK4/SHHUDbuFY0TP9
+jgbdANgMxrUK10GtPRCvTj1+0sjGzvGPX+31urZYgUlNhmvvlpKaRDRgcd27MrL
IbWdEh1+UMynf+MKfM5BUdusv1otyQuf188Q3e3YRxvSW2X021P+C2fDIEm9XH2/
QKrFTNa1fcn3Nw2+qgRW+vdYmOsDuMAtIvuPnNSbkcc46SCalm1qZjZJrNP4IbDT
yYjpf0cIuSWVybS307DLzY6r+nEROevgpXzBSYpfCEerS90ln5myvHkiRdc5yzIK
eoKUEAr/9IcoFVe6uZ17xOwXIFgrV4v0DDUtzBCgQlR6QYHnhqUe3bUU2AGJ1nw3
oKcYaHCFZU64nviKUrZepccmSX+tyRlPiB8TwlsCOVspMf3r2YmvTNqf7Bk1Uo7x
j16KTl55MIIcFEWw50b92wYVw56PWqXi6er9I8EvvDaxFVl5qMRdVtO4ByasvFOq
PrNmvHMQd7mrOQ5hXrrvH6g1g8+eIVv510OCw4qTXylwZHMH9rnetD2QXk3aHcfc
qit18SRwjp3QCC6KpI6exPE5tZuV/7HPWx6tvdgQzQXli7MCRn7MJFcT7ioSKd3D
vFj2u9iR/nK4NtkjOYuSXgbIsne2nxqiXn2uppSvsN/fKI3aOmtRGeCvlVYBR4gS
UAQVbnvWUQswNSHQjkvG
=7xl3
-----END PGP SIGNATURE-----

--------------enigA85B669D7FCD7A99AB036A90--
