From: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Subject: Re: [PATCH typo-resend] mtd: omap: fix mtd devices not showing up
Date: Mon, 27 Oct 2014 16:27:45 -0300
Message-ID: <544E9CB1.5020804@vanguardiasur.com.ar>
References: <1414416749-19598-1-git-send-email-frans.klaver@xsens.com> <544E4F19.8060205@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="spPkB50II6gw6VBolBVLpcV72TnS0Ow5N"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f175.google.com ([209.85.212.175]:50590 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753518AbaJ0T3S (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 27 Oct 2014 15:29:18 -0400
Received: by mail-wi0-f175.google.com with SMTP id h11so5371934wiw.14
        for <linux-omap@vger.kernel.org>; Mon, 27 Oct 2014 12:29:17 -0700 (PDT)
In-Reply-To: <544E4F19.8060205@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>, Frans Klaver <frans.klaver@xsens.com>, Brian Norris <computersforpeace@gmail.com>
Cc: linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--spPkB50II6gw6VBolBVLpcV72TnS0Ow5N
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable



On 10/27/2014 10:56 AM, Roger Quadros wrote:
> Hi Frans,
>=20
> On 10/27/2014 03:32 PM, Frans Klaver wrote:
>> Since commit 6d178ef2fd5e ("mtd: nand: Move ELM driver and rename as
>> omap_elm"), I don't have any mtd devices present on my am335x. This
>> appears to be related to the link order of the omap_elm and omap2
>> objects. Fix it by swapping the two in the Makefile.
>=20

I wonder how is it possible that I didn't got this on my tests.

> Alternatively we could fix either elm_config() or omap_nand_probe() to
> return -EPROBE_DEFER in case the device is present but driver not yet p=
robed.
>=20

Yes, that's a good idea. Can't we do both? Getting a systematic deferred
probe sounds like a bit silly to me.
--=20
Ezequiel Garcia, VanguardiaSur
www.vanguardiasur.com.ar


--spPkB50II6gw6VBolBVLpcV72TnS0Ow5N
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUTpyxAAoJEIOKbhOEIHKiJZEP/21hauOXo1NGOp1d+FDK17iO
20Eh+V+EB3EwDyJdzS7kEkHAC9f8ub8P1Ld03AhTrKC1DLfqY4BRXk087mLQaUqY
fe6AycPSVf/ZoBhz5FcSjtwEOhgT5BrgEU28abV9Kn7Vn7/TmV0nTULvcZOeP2Nx
l7JBdoVWkcaXmQfua5PY5ivC0xmfbSHng1PZ6ndEMTCYrUZH5JrLltSevKHk/bur
Jk8Qbey8hbw+sLWhbIarRlDb1P/wlqS9W4C2csrLt9coiUXQlwxMwlWVyPS8VK+8
17y+3peRVQj0lhhuBw0zwFNsTDZOb+cE0E4/duARZxaY+NLNBlhOtyiLjRkCOvBr
y6ClDDmUrKEVRMclU+vPVzcTn5yWDA1Fdoq0BjflD1hhXnrT99aFei2Nyl+E7iiV
yHhB+Tf1vTdjTUE0b8I2Kb+Iu9OPAnSasr7z9fg/cwYGYJQSlUWUV/rvIL76CoQp
DfEwtHfBl9vi+MoVCcXladHhj+6xbsILa8c4K0hMxMbsKnUy9TeuoypGT71D0sil
cCnd3bs5QhNN6Vhaj/G/oNdf7wYNdXjhyThSn8Wxp/SBp/LBrM7NT01X9uuqLSfa
6SOf2a2/qXLjbJUTvoyf/N+P4lFO0YBHnrEBKvh6/yekMl32t+ieTpTV2JRhGQfH
8E+znllgwi62GiXABnqq
=fbAC
-----END PGP SIGNATURE-----

--spPkB50II6gw6VBolBVLpcV72TnS0Ow5N--
