From: "Aguirre, Sergio" <saaguirre@ti.com>
Subject: RE: [RFC part1/2 merge][PATCH 08/10] omap3: 3630sdp: Explicitly
 enable all UARTs
Date: Wed, 3 Mar 2010 08:35:17 -0600
Message-ID: <A24693684029E5489D1D202277BE894453C0818A@dlee02.ent.ti.com>
References: <1267625925-22616-1-git-send-email-saaguirre@ti.com>
 <1267625925-22616-9-git-send-email-saaguirre@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="_002_A24693684029E5489D1D202277BE894453C0818Adlee02entticom_"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:60783 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754371Ab0CCOfT (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 3 Mar 2010 09:35:19 -0500
Received: from dlep33.itg.ti.com ([157.170.170.112])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id o23EZIpN003396
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 3 Mar 2010 08:35:18 -0600
Received: from dlep26.itg.ti.com (localhost [127.0.0.1])
	by dlep33.itg.ti.com (8.13.7/8.13.7) with ESMTP id o23EZIuo015807
	for <linux-omap@vger.kernel.org>; Wed, 3 Mar 2010 08:35:18 -0600 (CST)
Received: from dlee73.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id o23EZHNV000529
	for <linux-omap@vger.kernel.org>; Wed, 3 Mar 2010 08:35:18 -0600 (CST)
In-Reply-To: <1267625925-22616-9-git-send-email-saaguirre@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Aguirre, Sergio" <saaguirre@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

--_002_A24693684029E5489D1D202277BE894453C0818Adlee02entticom_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

> -----Original Message-----
> From: Aguirre, Sergio
> Sent: Wednesday, March 03, 2010 8:19 AM
> To: linux-omap@vger.kernel.org
> Cc: Aguirre, Sergio
> Subject: [RFC part1/2 merge][PATCH 08/10] omap3: 3630sdp: Explicitly
> enable all UARTs
>=20
> All UARTs seem physically reachable, so, enable them all.
>=20
> Signed-off-by: Sergio Aguirre <saaguirre@ti.com>
> ---
>  arch/arm/mach-omap2/board-3630sdp.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
>  mode change 100755 =3D> 100644 arch/arm/mach-omap2/board-3630sdp.c
>=20
> diff --git a/arch/arm/mach-omap2/board-3630sdp.c b/arch/arm/mach-
> omap2/board-3630sdp.c
> old mode 100755
> new mode 100644
> index 4386d2b..35df894
> --- a/arch/arm/mach-omap2/board-3630sdp.c
> +++ b/arch/arm/mach-omap2/board-3630sdp.c
> @@ -96,6 +96,7 @@ static struct omap_board_mux board_mux[] __initdata =3D=
 {
>  static void __init omap_sdp_init(void)
>  {
>  	omap3_mux_init(board_mux, OMAP_PACKAGE_CBP);
> +	omap_serial_init_allports();

Oops, forgot to change this one.

Please take attached one instead.

Regards,
Sergio

>  	zoom_peripherals_init();
>  	board_smc91x_init();
>  	enable_board_wakeup_source();
> --
> 1.6.3.3


--_002_A24693684029E5489D1D202277BE894453C0818Adlee02entticom_
Content-Type: application/octet-stream;
	name="0008-omap3-3630sdp-Explicitly-enable-all-UARTs.patch"
Content-Description: 0008-omap3-3630sdp-Explicitly-enable-all-UARTs.patch
Content-Disposition: attachment;
	filename="0008-omap3-3630sdp-Explicitly-enable-all-UARTs.patch"; size=1020;
	creation-date="Wed, 03 Mar 2010 08:33:57 GMT";
	modification-date="Wed, 03 Mar 2010 08:33:57 GMT"
Content-Transfer-Encoding: base64

RnJvbSA5MzllZmRmNDlkZTdiM2NjZDI3NGJhNjUxMTQ5ODE0ZWMxZmRhNmJlIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTZXJnaW8gQWd1aXJyZSA8c2FhZ3VpcnJlQHRpLmNvbT4KRGF0
ZTogTW9uLCAxIE1hciAyMDEwIDExOjUyOjM2IC0wNjAwClN1YmplY3Q6IFtSRkMgcGFydDEvMiBt
ZXJnZV1bUEFUQ0ggdjIgMDgvMTBdIG9tYXAzOiAzNjMwc2RwOiBFeHBsaWNpdGx5IGVuYWJsZSBh
bGwgVUFSVHMKCkFsbCBVQVJUcyBzZWVtIHBoeXNpY2FsbHkgcmVhY2hhYmxlLCBzbywgZW5hYmxl
IHRoZW0gYWxsLgoKU2lnbmVkLW9mZi1ieTogU2VyZ2lvIEFndWlycmUgPHNhYWd1aXJyZUB0aS5j
b20+Ci0tLQogYXJjaC9hcm0vbWFjaC1vbWFwMi9ib2FyZC0zNjMwc2RwLmMgfCAgICAxICsKIDEg
ZmlsZXMgY2hhbmdlZCwgMSBpbnNlcnRpb25zKCspLCAwIGRlbGV0aW9ucygtKQogbW9kZSBjaGFu
Z2UgMTAwNzU1ID0+IDEwMDY0NCBhcmNoL2FybS9tYWNoLW9tYXAyL2JvYXJkLTM2MzBzZHAuYwoK
ZGlmZiAtLWdpdCBhL2FyY2gvYXJtL21hY2gtb21hcDIvYm9hcmQtMzYzMHNkcC5jIGIvYXJjaC9h
cm0vbWFjaC1vbWFwMi9ib2FyZC0zNjMwc2RwLmMKb2xkIG1vZGUgMTAwNzU1Cm5ldyBtb2RlIDEw
MDY0NAppbmRleCA0Mzg2ZDJiLi4zOTkxMTdhCi0tLSBhL2FyY2gvYXJtL21hY2gtb21hcDIvYm9h
cmQtMzYzMHNkcC5jCisrKyBiL2FyY2gvYXJtL21hY2gtb21hcDIvYm9hcmQtMzYzMHNkcC5jCkBA
IC05Niw2ICs5Niw3IEBAIHN0YXRpYyBzdHJ1Y3Qgb21hcF9ib2FyZF9tdXggYm9hcmRfbXV4W10g
X19pbml0ZGF0YSA9IHsKIHN0YXRpYyB2b2lkIF9faW5pdCBvbWFwX3NkcF9pbml0KHZvaWQpCiB7
CiAJb21hcDNfbXV4X2luaXQoYm9hcmRfbXV4LCBPTUFQX1BBQ0tBR0VfQ0JQKTsKKwlvbWFwX3Nl
cmlhbF9pbml0KCk7CiAJem9vbV9wZXJpcGhlcmFsc19pbml0KCk7CiAJYm9hcmRfc21jOTF4X2lu
aXQoKTsKIAllbmFibGVfYm9hcmRfd2FrZXVwX3NvdXJjZSgpOwotLSAKMS42LjMuMwoK

--_002_A24693684029E5489D1D202277BE894453C0818Adlee02entticom_--
