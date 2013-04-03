From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 00/33] OMAPDSS: platform_enable/disable callback removal
 from panel drivers
Date: Wed, 3 Apr 2013 15:28:08 +0300
Message-ID: <515C2058.8030402@ti.com>
References: <1360765345-19312-1-git-send-email-archit@ti.com> <20130213164647.GF7144@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig8C68F38AD37C7426C75A6C7D"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:60957 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762367Ab3DCM2L (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 3 Apr 2013 08:28:11 -0400
In-Reply-To: <20130213164647.GF7144@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Archit Taneja <archit@ti.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

--------------enig8C68F38AD37C7426C75A6C7D
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Tony,

On 2013-02-13 18:46, Tony Lindgren wrote:
> * Archit Taneja <archit@ti.com> [130213 06:26]:
>> init functions in omap board files request panel specific gpios, and p=
rovide
>> functions which omapdss panel drivers call to enable or disable them.
>>
>> Instead of the board files requesting these gpios, they should just pa=
ss the
>> platform specific data(like the gpio numbers), the panel should retrie=
ve the
>> platform data and request the gpios. Doing this prevents the need of t=
he panel
>> driver calling platform functions in board files.
>>
>> Panel drivers have their own platform data struct, and the board files=
 populate
>> these structs and pass the pointer to the 'data' field of omap_dss_dev=
ice. This
>> work will make it easier for the panel drivers be more adaptable to th=
e
>> DT model.
>>
>> There is also removal of passing panel reset_gpio numbers through
>> omap_dss_device struct directly, reset gpios are passed through platfo=
rm data
>> only.
>=20
> To avoid merge conflicts and dependencies between drivers and core
> Soc code, please break thes kind of patches into following parts:
>=20
> 1. Any platform_data header changes needed so both I and Tomi
>    can pull it in as needed.
>=20
> 2. Changes to DSS drivers. Please keep stubs around for the
>    board specific callback functions so omap2plus_defconfig
>    won't break with just #1 merged into arm soc tree.
>=20
> 3. All the arch/arm/*omap* changes based on #1 above to
>    drop obsolete callback functions and add new pdata if still
>    needed. This needs to build and boot on #1 so I can merge
>    this in via arm soc tree.
>=20
> 4. Any .dts changes needed.

Tony, I've split these patches as follows:

Platform data header file changes:
git://gitorious.org/linux-omap-dss2/linux.git 3.10/0-dss-headers

Board file changes (based on header changes):
git://gitorious.org/linux-omap-dss2/linux.git 3.10-lo/board-cleanup

DSS panel changes (based on header changes):
git://gitorious.org/linux-omap-dss2/linux.git 3.10/1-panel-cleanup

Removing unused fields from header files (based on panel changes):
git://gitorious.org/linux-omap-dss2/linux.git 3.10/2-late-panel-cleanup

The 2-late-panel-cleanup breaks compilation if the arch changes are not
merged, so I'll leave that until they have been merged.

Do you mind if I add the board-cleanup branch temporarily to omapdss's
for-next, to simplify testing? When everything looks ok, I'll remove it
and pass the branch to you to be handled through l-o.

 Tomi



--------------enig8C68F38AD37C7426C75A6C7D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBAgAGBQJRXCBYAAoJEPo9qoy8lh71D+EP/A9J/rALoWB485tRw+vmwFpq
+8+IKFQweBA69kMWKG36EPdueNFQc1nv3xyltyv99sjuZlZ1vXS/dVp+Hxez1/Of
S+E3etnEW5M3Ltf3y1UtDaHllWWq710mPn6F20tQxL9Z9m2x/W43eSzL/NSfoCp5
ssmbNDR5yJSH4yvvHHkVAMM8099F0D/WdPDmEDKNQwVHgTLGgNb45xGnPoWLha2k
3OAVcLgVcL1auzs6RI1vDGPix6G3CxtcdG0Phan+iX9fKzE2xlLhIyiOOvm0ekIm
0/tOsqBq0esFoXipaQGEaIwr5FsPEEiLU09deCTKjzw3bLbbawj3FGlkJWXe66kf
lkW+71neI/JA+nRbiGhJAjJBMu0haM0hF6Xa2S3IGl1URIhFFEcy2RSLRv9w2ugr
F/xBo+7WeosFy8XMSxLK0C39dJfcHmFtrKVVwb0p/9sKMdXjKxOVcSjNxIvDw0ta
T9I4mWEo6tWAkOBysigG7R8/vA8+1NYv9YZyCz+ZVQJO1qVkblxapJCOAG/UQkuD
dYVTh9jeY7HZHZvvkLE9TlLCpKEzi+2ax14MVGm3KjAWo6v5maj/6f2plDZ+690W
Zo3vdmoCwzXIo7bbBp7kzIx+rkp0Su1+EF72M4jIbjU27Gyimb5CoVD5WY/GtXAy
aeZemDSJMEaU115FagiO
=LrHN
-----END PGP SIGNATURE-----

--------------enig8C68F38AD37C7426C75A6C7D--
