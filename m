From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCHv4 10/10] arm/dts: am57xx-beagle-x15.dts: add HDMI
Date: Wed, 3 Jun 2015 19:01:42 +0300
Message-ID: <556F24E6.7040003@ti.com>
References: <1433139798-23450-1-git-send-email-tomi.valkeinen@ti.com> <1433139798-23450-11-git-send-email-tomi.valkeinen@ti.com> <20150601215115.GH30984@atomide.com> <556EE463.6000502@ti.com> <20150603154438.GS30984@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="JXPV6iHnMxxUAve5CUl3XPg84BKEItJbI"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:38940 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752992AbbFCQCJ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 3 Jun 2015 12:02:09 -0400
In-Reply-To: <20150603154438.GS30984@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, paul@pwsan.com, Tero Kristo <t-kristo@ti.com>, Nishanth Menon <nm@ti.com>, devicetree@vger.kernel.org

--JXPV6iHnMxxUAve5CUl3XPg84BKEItJbI
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable



On 03/06/15 18:44, Tony Lindgren wrote:
> * Tomi Valkeinen <tomi.valkeinen@ti.com> [150603 04:28]:
>>
>>
>> On 02/06/15 00:51, Tony Lindgren wrote:
>>> * Tomi Valkeinen <tomi.valkeinen@ti.com> [150531 23:25]:
>>>> AM57xx Beagle X15 has a HDMI output. This patch adds the device tree=

>>>> nodes required for HDMI.
>>>
>>> This one does not seem to apply to linux next, did not look
>>> further where it conflicts.
>>
>> Looks like the change was also in -rc6. I've rebased my patches on -rc=
6,
>> and added the acks:
>>
>> git://git.kernel.org/pub/scm/linux/kernel/git/tomba/linux.git dra7-dss=
-arch
>=20
> OK, since there are no other merge conflicts that I'm aware of,
> it's best that you merge the whole branch. I've acked the patches,
> so for this one too:

Ok, I can do that, but isn't this more linux-arm stuff? All the driver
side code is already in the mainline.

 Tomi


--JXPV6iHnMxxUAve5CUl3XPg84BKEItJbI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJVbyTmAAoJEPo9qoy8lh71axgQAIP9/fDfhfEgQ8LHyPs+uxxw
IBJwMo01spuSEvxgFQKaDy9Q6hfBX1msFIC//YcqKeZlo3vQvuGNGEo77LZOIGZ/
DLaIMyi3lHdwLFXVBtUWBAzzG3qDwggn6HA/G4cOTBdEsZ67JuKUMudhn9zFc5Oy
Z+d/olv9/EykrGKxVAA73CUeqK8UmoBNnR6kSZ2PKmaecV9ZPEbuCPW3wiwKOQf7
dUkKxij1XYFVWnMJ8uoDnS9uYidyrL7Za9MErcHMGVmUe+KabiGTy+F1xJ9wwLNN
Jo9v6XQrwHfjB6kWeAqufweEWdVAeJWGB7TeLnddWLh4DxWijJdE99tEBcq6r660
Br5H30kMdcOEXguwUA0LxlWWpRV6eBEeKaj2qsDvgF6GLmyENj9GEl66UgETVNAz
RRuMeR23qrvwPJLuhBX7BESAQt7lH5DULOe+rNsOG933Dcizde/Ua6joIzqfDo0Z
myq3Prqm7IpuHDGi5WCOQ33NPrj/T2RAHr8avQDjdhUzBjkYhCE0J5vMVMAXXLb/
j0cy6iv4HLr4jo9VqezpWS1SGc2Vak/NrptPiIF7DmSjKPeLSTMRSKsfx5gSPRcr
/cBkpWPx3vzgMpSKkt5NAcW2PPcfI2Df6j7S0d3Hd3i+U18ueJE0YFC+1H1AY+Yi
lDvV8JGn23suMNsQwI6L
=nyOq
-----END PGP SIGNATURE-----

--JXPV6iHnMxxUAve5CUl3XPg84BKEItJbI--
