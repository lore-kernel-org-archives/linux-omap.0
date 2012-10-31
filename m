From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 09/12] OMAPDSS: hide dss_select_dispc_clk_source()
Date: Wed, 31 Oct 2012 09:17:04 +0200
Message-ID: <5090D070.6080804@ti.com>
References: <1351613409-21186-1-git-send-email-tomi.valkeinen@ti.com> <1351613409-21186-10-git-send-email-tomi.valkeinen@ti.com> <5090CB17.4070400@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigF70C82A61805621156D4D6C0"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:38603 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752836Ab2JaHRL (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 31 Oct 2012 03:17:11 -0400
In-Reply-To: <5090CB17.4070400@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, rob@ti.com

--------------enigF70C82A61805621156D4D6C0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2012-10-31 08:54, Archit Taneja wrote:
> On Tuesday 30 October 2012 09:40 PM, Tomi Valkeinen wrote:
>> dss.c currently exposes functions to configure the dispc source clock
>> and lcd source clock. There are configured separately from the output
>> drivers.
>>
>> However, there is no safe way for the output drivers to handle dispc
>> clock, as it's shared between the outputs. Thus, if, say, the DSI driv=
er
>> sets up DSI PLL and configures both the dispc and lcd clock sources to=

>> that DSI PLL, the resulting dispc clock could be too low for, say, HDM=
I.
>>
>> Thus the output drivers should really only be concerned about the lcd
>> clock, which is what the output drivers actually use. There's lot to d=
o
>> to clean up the dss clock handling, but this patch takes one step
>> forward and removes the use of dss_select_dispc_clk_source() from the
>> output drivers.
>>
>> After this patch, the output drivers only configure the lcd source
>> clock. On omap4+ the dispc src clock is never changed from the default=

>> PRCM source. On omap3, where the dispc and lcd clocks are actually the=

>> same, setting the lcd clock source sets the dispc clock source.
>=20
> Maybe we could have one call to dss_select_dispc_clk_source() in
> omap_dsshw_porbe(). This is not necessary now, but if we support a
> splash screen on bootloader, and skip the hwmod resets, we might want t=
o
> switch back our dispc clock source to PRCM if the output drivers don't
> to it. This is just a point though, we don't necessarily need it right =
now.

If we're showing the image from the bootloader, we can't change the
clock sources if we want to keep the display working. We either need to
accept and use the config the bootloader did, or reset the dss and start
over with our config.

But you're right, even if we don't support the splash screen from the
bootloader, we can't be sure if the dss hw was reset or not, and what
the clock source is. So it probably is safer to set the clock source at
probe time (and actually all other configs also).

 Tomi



--------------enigF70C82A61805621156D4D6C0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://www.enigmail.net/

iQIcBAEBAgAGBQJQkNB0AAoJEPo9qoy8lh71G28P/AuDyuGbogsfcRD0YVyReBIu
fs5mPzWr+ONeNHGwxAiUlTrmmN1ejhBlI/nikfdplsUjZvoMuHSDL03F/0kYdBON
+fzegCGbISpqAe8jksGa7NKXJbF2z5/1+jBssOvuSBDkraR8ePRTdGQpgf9JBy3G
YBFyeo9qc+eJ4i0XHfVNMM7INjgpj8NuH0sQSTpZXnJLvkV9EtpOs4/n+W+9sxW0
93ls1IrqLE9IdNjO7GCP6S+uUmu4STSC9iULmSUNVDNsMQl7UAOS2m+Vvk5z6IC9
km37Fl9VNLtYEFxhT5kLtBAhsPldX0DrH4AbJioAB0JhfhpwqXo6tqsTLj2v4nxC
auYdZJaqVXnAKVfGt/vMvPb/+wm9RNEBcqjSB1x/W0GNVwT4U+IpUORHzMCd1Bdz
TbQ+ufKO1ess1yQg2TyQ3Zwpfo324AMB7F3H7mHKROpydPO22on3OVho50/DgQJs
ubOHh0ZZllIoqIOSkWDpCz0eKKNnyFTzNxBIp7ooGxdrAkmLdxa+M+/XmABc1MJo
vjqkfCXaxqUYRYZz2Ds7byeSOgZevJRcKJwu7ykKfy7nsoKgDEHe6f0BglvhCZ9X
5tLDnODd6N9igcEJbekOeRNouQy2LKAmh9oS8aaSOkqFHm1Xd2oyKsyMar+mjdCJ
7Xlu4MPMJh2G/IgG398O
=gvaW
-----END PGP SIGNATURE-----

--------------enigF70C82A61805621156D4D6C0--
