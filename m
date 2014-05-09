From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 0/4] OMAPDSS: Add support for panel ls037v7dw01
Date: Fri, 9 May 2014 12:34:03 +0300
Message-ID: <536CA10B.9040702@ti.com>
References: <1398815562-24113-1-git-send-email-tony@atomide.com> <20140505184138.GB15463@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="B2b105InfVMfGnj26AW1mIrEGS8NasbhO"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:45645 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752669AbaEIJe2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 9 May 2014 05:34:28 -0400
In-Reply-To: <20140505184138.GB15463@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, linux-arm-kernel@lists.infradead.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org

--B2b105InfVMfGnj26AW1mIrEGS8NasbhO
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 05/05/14 21:41, Tony Lindgren wrote:
> * Tony Lindgren <tony@atomide.com> [140429 16:53]:
>> Hi all,
>>
>> Here are few patches to add devicetree support for panel ls037v7dw01
>> that's found on many omap3 boards. They seem to be often mis-configure=
d
>> as various panel dpi entries, but really should be move to use panel
>> ls037v7dw01 instead. This panel is found at least on the omap3 sdp,
>> ldp, omap3 evm and few other development boards.
>=20
> Tomi, assuming no more comments, do you want to pick up the first
> three patches of this series? I can queue the .dts changes or you
> can also set up a separate .dts changes branch for DSS that I can
> merge in too.

If it's all the same to you, I'd like to collect all display related
arch/arm/ patches into my tree, and I'll send you a merge request when
it's stable.

I already have OMAP5 and AM43xx stuff there.

 Tomi



--B2b105InfVMfGnj26AW1mIrEGS8NasbhO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTbKELAAoJEPo9qoy8lh71Wm0P/04/5kITL2Ga250U0XuM1p2x
ZOgwhvv5886Z+WiuRZnXwg5G99NvFwPTTC1q172oFj2uOwOUNDAYfVALK5YNHLBR
odNxx4Qanlug0G0LZktrNkcGx6JuTONZhyCZs2LwXURohoU9SeM6elN4or/APNjK
GMM1LVoeQ2wTntX/PLwcQYNDrTjqq9ZYfhP7j/N0p4r6CTMYAbA6KpDHXGkD2O4i
06/NMlTMeaykMcivyf+yvbCEZRr/Fv8ffKae7aUsPS5TwATnW/BRB+9lzjdx+jsc
FIPWJy+z1FZTvWKtO4dVCbxVwhdA+LKIoJSfJUc9bKrJfiNWyJoYWpi2lyHduNNT
wrF1UY8xPkVB4K9jEJMwyU8QaG8xF6K2o01QHUlmZ0moFUNFAt/Y+SQglf17et2o
qKaGZgQMtKoPvKKZhZN1K+wOuGjIuYxpVBPpEDE6rDpjNdmmok7mSxeMZ6RYEI3U
vVmPaRJwpgTr4ouW9BL3usHgeysB36jCxklPyds0DnUiGkuPVjIP+9rBcb9W45k0
3LhlL7mA3B/6I6ZfTUOPlHCIexYh/3VP1aer6vJgWwXd5Fs5rqbFf0XXZWt0t3Qz
7aTdLE4Ntndu9pcTh0i/NX509mIGBpjHRuwhAn5p3rrDq9ZDev1WN7FsIcDKc6Qp
ypuzDGZuKDP8nBp/ebgx
=lnIj
-----END PGP SIGNATURE-----

--B2b105InfVMfGnj26AW1mIrEGS8NasbhO--
