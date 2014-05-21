From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] ARM: dts: duovero-parlor: Add HDMI output
Date: Wed, 21 May 2014 11:26:10 +0300
Message-ID: <537C6322.2000101@ti.com>
References: <1400595946-1294-1-git-send-email-florian.vaussard@epfl.ch> <CAGhQ9VxtJwrKzW77mo=y9_gvCRW_8TJEp90OVN+YPg2RpC=b_w@mail.gmail.com> <537C6082.2000405@epfl.ch>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="l1J1rcoqrcM7het9HeBlXSpF90hC1vUc1"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:38205 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752139AbaEUI0o (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 21 May 2014 04:26:44 -0400
In-Reply-To: <537C6082.2000405@epfl.ch>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: florian.vaussard@epfl.ch, Joachim Eastwood <manabian@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, devicetree@vger.kernel.org

--l1J1rcoqrcM7het9HeBlXSpF90hC1vUc1
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 21/05/14 11:14, Florian Vaussard wrote:

>> I think Parlor has one and the "hdmi-connector" binding now supports
>> it. See Tomi's 3.16/fbdev-omap branch.
>>
>=20
> Looking into the details, the HPD pin of the parlor board is connected
> to the OMAP4 HDMI IP. The LINK_CONNECT and LINK_DISCONNECT events are
> managed by hdmi_irq_handler() in hdmi4.c to turn on/off the PHY's power=
=2E
> So there is no need to use the hgp-gpios binding of "hdmi-connector"
> IMHO. Correct me if I am wrong, as the public TRM is pretty thin
> regarding the OMAP4 HDMI IP.

The PHY's link-connect and disconnect are a separate thing, not really
related to the HPD.

The hdmi_hpd pin on OMAP should be configured to GPIO mode, and the GPIO
should be handled by the hdmi-connector.

The HDMI driver doesn't have support for the HDMI IP's HPD, and if I
recall right, the HDMI IP's HPD was not without problems. And afaik it
doesn't really bring anything, a normal GPIO does the job just fine.

 Tomi



--l1J1rcoqrcM7het9HeBlXSpF90hC1vUc1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTfGMmAAoJEPo9qoy8lh71Va4QAIccpqJHEGCiJ1Nxec+Q3R1s
qqMKIpkaU2wnlYisf5qU94MxOIXAHaIQLZI8qKd0hwLj/2ApLs01dYRrGh35hE4M
RYJ9Y1fTwya6nWCg0lnXyjn/M32bUaBM8PsMrAwdPXbqTOhf7/HgSCIorVd3AlrK
iMQhd1LMwyXwXESRt223NnL76m+ZLb4HD4bqBczSKpg/lxAcbzm2w9pIKrgytuxK
c1iEH3WLaBhaJ1eVRADoIcqJ+wcvL4ermN9qK5Onlx6lt9PQKxV6zgnRFirb34UH
+Rc9gRl/LPSCvCefSxjeC91sCkYOqKNcwfQ7zX8VLO+CSr4sgtKVoA2+32DU8Deh
R1DjNHRNvJzAxzpkRorOTcUFJn4A4lClIuifPrV0v/Nt8TWOtgW50IMhnyfLF71j
GeIw4/afwaYTqwK21ARnkHc03+57iQwVZhobommkoo43w1rEVsKbY+84WoJBPkLw
5nhSg6OYn/jzww1zsfcm8tHPXSCPTmCAlwfBoWHWoIYo3TzxnOrQTcpk2NqKc28c
NyDo7xdBvjvkLwtLFdNoYxC2kY50MG6HWdywoVqj+geiAEX9uR5LJ6V16i9qqgSl
xbD/lB/ugzh7MPPJe8Y1ed43/w3HJybCu8p3Q0yqhrntdne8+dD3bT+rs44SC0TJ
3H+0wzD1aJAdWLyGiTB5
=xIzT
-----END PGP SIGNATURE-----

--l1J1rcoqrcM7het9HeBlXSpF90hC1vUc1--
