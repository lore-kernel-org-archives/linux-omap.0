From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] OMAPDSS: HDMI: fix missing unlock on error in hdmi_dump_regs()
Date: Mon, 22 Oct 2012 09:53:58 +0300
Message-ID: <5084ED86.5060100@ti.com>
References: <CAPgLHd--5Y4cq3ieoRSueg-i0boqRa4JqRPL7+cJ0UfesunjoQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig8B566BE12835B26E2E58A777"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:45500 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753027Ab2JVGyO (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 22 Oct 2012 02:54:14 -0400
In-Reply-To: <CAPgLHd--5Y4cq3ieoRSueg-i0boqRa4JqRPL7+cJ0UfesunjoQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Wei Yongjun <weiyj.lk@gmail.com>
Cc: FlorianSchandinat@gmx.de, yongjun_wei@trendmicro.com.cn, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

--------------enig8B566BE12835B26E2E58A777
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2012-10-21 15:54, Wei Yongjun wrote:
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
>=20
> Add the missing unlock on the error handling path in function
> hdmi_dump_regs().
>=20
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> ---
> no test
> ---
>  drivers/video/omap2/dss/hdmi.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/dss/h=
dmi.c
> index a48a7dd..8c9b8b3 100644
> --- a/drivers/video/omap2/dss/hdmi.c
> +++ b/drivers/video/omap2/dss/hdmi.c
> @@ -644,8 +644,10 @@ static void hdmi_dump_regs(struct seq_file *s)
>  {
>  	mutex_lock(&hdmi.lock);
> =20
> -	if (hdmi_runtime_get())
> +	if (hdmi_runtime_get()) {
> +		mutex_unlock(&hdmi.lock);
>  		return;
> +	}
> =20
>  	hdmi.ip_data.ops->dump_wrapper(&hdmi.ip_data, s);
>  	hdmi.ip_data.ops->dump_pll(&hdmi.ip_data, s);
>=20

Thanks, applied to omapdss tree.

 Tomi




--------------enig8B566BE12835B26E2E58A777
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://www.enigmail.net/

iQIcBAEBAgAGBQJQhO2KAAoJEPo9qoy8lh71mCIP/0AmolMUIuWbMyFRyPCALqeI
ILVDdRCHF22oRLJMmdaHeVKEOyDprA+90b3+hzKQygNcqGI8SryHtD4YAkQaosi8
bB246chDNnm3f3CpfR64aJHBzZ2A/kSJxTiW5wUEj+sUdxijbS5s9MRZtdA/aCkh
tepuagDGejrcjLl2U978rOj5rY6I2mwMztuYlmRHe/Fpz1d3KOfjKRq2TS7bNBe5
H4Mqx6796JP2uUtq98pH9y+NKmcIHIRMSIrygvbDKva0PYnuoms2HKNChHUq3lNL
ijcNHkmUsAISPUiyL2J6r4/7b5685P2xJh9b+V/J7X91p3IgkugpDosfi7vA7xwT
pyMwsUKFd9ge05VF+uLZuQT0iwMbYaamrEeM6rk3B4F/RyLPP7xZWtdvaM0F6Von
2PmpJs2TqXwdOFFwEOZf1wMVS1vTBwVgV3iMz/2Tl2YfpgitY0Oht/WSUsgEkoac
9oJe/A/rVwYrU5QJ0vLqyiCXr6vnFROosVa1NKB/23HBoZcodi9SNxV4oUBAa2fk
TToE/o9KvISCkl5BREDB0TY1crPu9kcljlkMrHbz8DZwqOMDpjMZ9F4zpezbgXPB
00zlLchdjUq0vJuJAKgU47wDQ5XxU/MoPDyNAf116d7B3vlrJK2L27NdOIlN4OJ5
wBDY5beaFZApz/iTp9Hp
=XKAn
-----END PGP SIGNATURE-----

--------------enig8B566BE12835B26E2E58A777--
