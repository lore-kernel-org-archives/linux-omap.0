From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH-Fix] OMAP: Add DSI regulator supply to OMAP3EVM board
 file
Date: Thu, 11 Mar 2010 14:48:39 +0530
Message-ID: <19F8576C6E063C45BE387C64729E7394044DD32B4F@dbde02.ent.ti.com>
References: <hvaibhav@ti.com>
	 <1268297717-8062-1-git-send-email-hvaibhav@ti.com>
 <1268297945.28571.81.camel@tubuntu.research.nokia.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="_002_19F8576C6E063C45BE387C64729E7394044DD32B4Fdbde02enttico_"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:58300 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754156Ab0CKJSs (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 11 Mar 2010 04:18:48 -0500
In-Reply-To: <1268297945.28571.81.camel@tubuntu.research.nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>

--_002_19F8576C6E063C45BE387C64729E7394044DD32B4Fdbde02enttico_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable


> -----Original Message-----
> From: Tomi Valkeinen [mailto:tomi.valkeinen@nokia.com]
> Sent: Thursday, March 11, 2010 2:29 PM
> To: Hiremath, Vaibhav
> Cc: linux-omap@vger.kernel.org; tony@atomide.com
> Subject: Re: [PATCH-Fix] OMAP: Add DSI regulator supply to OMAP3EVM board
> file
>=20
> Hi,
>=20
> On Thu, 2010-03-11 at 09:55 +0100, ext hvaibhav@ti.com wrote:
> > From: Vaibhav Hiremath <hvaibhav@ti.com>
> >
> > With recent changes happened in OMAP2/3 DSS library for regulator
> interface, it
> > is required to define DSI regulator supply, without this DSS (in turn
> Fbdev)
> > fails to get regulator.
> >
> > Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
> > ---
> >  arch/arm/mach-omap2/board-omap3evm.c |   16 +++++++++++-----
> >  1 files changed, 11 insertions(+), 5 deletions(-)
> >
> > diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-
> omap2/board-omap3evm.c
> > index 017bb2f..a05de10 100644
> > --- a/arch/arm/mach-omap2/board-omap3evm.c
> > +++ b/arch/arm/mach-omap2/board-omap3evm.c
> > @@ -514,9 +514,15 @@ static struct regulator_init_data omap3_evm_vdac =
=3D {
> >  };
> >
> >  /* VPLL2 for digital video outputs */
> > -static struct regulator_consumer_supply omap3_evm_vpll2_supply =3D {
> > -	.supply		=3D "vdvi",
> > -	.dev		=3D &omap3_evm_lcd_device.dev,
> > +static struct regulator_consumer_supply omap3_evm_vpll2_supplies[] =3D=
 {
> > +	{
> > +		.supply		=3D "vdvi",
> > +		.dev		=3D &omap3_evm_lcd_device.dev,
> > +	},
>=20
> Are you sure vdvi is required by the panel? At least the panel in
> 3430SDP doesn't require it.
[Hiremath, Vaibhav] As I mentioned before also, we don't need vdvi supply f=
or OMAP3EVM. Infact there is no supply like vdvi coming out of TWL4030
Since it was being used in panel file I had defined it. But now I can see t=
hat we are no longer using vdvi supply, so I can safely remove this supply.=
 Thanks for pointing me to this.

I have created another patch which will replace the vdvi with vdds_dsi regu=
lator supply; I have tested it on OMAP3EVM.

Please merge this patch, without this OMAP3EVM DSS/Fbdev will fail in regul=
ator_get.

Thanks,
Vaibhav


>=20
>  Tomi
>=20


--_002_19F8576C6E063C45BE387C64729E7394044DD32B4Fdbde02enttico_
Content-Type: application/octet-stream;
	name="0001-OMAP-Replace-vdvi-with-vdds_dsi-regulator-supply-in.patch"
Content-Description: 0001-OMAP-Replace-vdvi-with-vdds_dsi-regulator-supply-in.patch
Content-Disposition: attachment;
	filename="0001-OMAP-Replace-vdvi-with-vdds_dsi-regulator-supply-in.patch";
	size=1152; creation-date="Thu, 11 Mar 2010 14:47:23 GMT";
	modification-date="Thu, 11 Mar 2010 14:47:23 GMT"
Content-Transfer-Encoding: base64

RnJvbSA1YWQ3M2NkYTU4M2I0ZmFiNWUzM2Y5NTVkZDllNDFjZDcyNWVlZjM5IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBWYWliaGF2IEhpcmVtYXRoIDxodmFpYmhhdkB0aS5jb20+CkRh
dGU6IFRodSwgMTEgTWFyIDIwMTAgMTQ6MDU6MjkgKzA1MzAKU3ViamVjdDogW1BBVENIXSBPTUFQ
OiBSZXBsYWNlIHZkdmkgd2l0aCB2ZGRzX2RzaSByZWd1bGF0b3Igc3VwcGx5IGluIE9NQVAzRVZN
IGJvYXJkIGZpbGUKCldpdGggcmVjZW50IGNoYW5nZXMgaGFwcGVuZWQgaW4gT01BUDIvMyBEU1Mg
bGlicmFyeSBmb3IgcmVndWxhdG9yIGludGVyZmFjZSwgaXQKaXMgcmVxdWlyZWQgdG8gZGVmaW5l
IERTSSByZWd1bGF0b3Igc3VwcGx5LCBhbmQgc2luY2Ugd2UgZG9uJ3QgbmVlZCBWRFZJCnN1cHBs
eSBzbyByZW1vdmUgaXQuCgpTaWduZWQtb2ZmLWJ5OiBWYWliaGF2IEhpcmVtYXRoIDxodmFpYmhh
dkB0aS5jb20+Ci0tLQogYXJjaC9hcm0vbWFjaC1vbWFwMi9ib2FyZC1vbWFwM2V2bS5jIHwgICAg
NCArKy0tCiAxIGZpbGVzIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkK
CmRpZmYgLS1naXQgYS9hcmNoL2FybS9tYWNoLW9tYXAyL2JvYXJkLW9tYXAzZXZtLmMgYi9hcmNo
L2FybS9tYWNoLW9tYXAyL2JvYXJkLW9tYXAzZXZtLmMKaW5kZXggMDE3YmIyZi4uZWExMDE0YiAx
MDA2NDQKLS0tIGEvYXJjaC9hcm0vbWFjaC1vbWFwMi9ib2FyZC1vbWFwM2V2bS5jCisrKyBiL2Fy
Y2gvYXJtL21hY2gtb21hcDIvYm9hcmQtb21hcDNldm0uYwpAQCAtNTE1LDggKzUxNSw4IEBAIHN0
YXRpYyBzdHJ1Y3QgcmVndWxhdG9yX2luaXRfZGF0YSBvbWFwM19ldm1fdmRhYyA9IHsKIAogLyog
VlBMTDIgZm9yIGRpZ2l0YWwgdmlkZW8gb3V0cHV0cyAqLwogc3RhdGljIHN0cnVjdCByZWd1bGF0
b3JfY29uc3VtZXJfc3VwcGx5IG9tYXAzX2V2bV92cGxsMl9zdXBwbHkgPSB7Ci0JLnN1cHBseQkJ
PSAidmR2aSIsCi0JLmRldgkJPSAmb21hcDNfZXZtX2xjZF9kZXZpY2UuZGV2LAorCS5zdXBwbHkJ
CT0gInZkZHNfZHNpIiwKKwkuZGV2CQk9ICZvbWFwM19ldm1fZHNzX2RldmljZS5kZXYsCiB9Owog
CiBzdGF0aWMgc3RydWN0IHJlZ3VsYXRvcl9pbml0X2RhdGEgb21hcDNfZXZtX3ZwbGwyID0gewot
LSAKMS42LjIuNAoK

--_002_19F8576C6E063C45BE387C64729E7394044DD32B4Fdbde02enttico_--
