From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH 5/5] OMAP3EVM: Kconfig option added for selection
 between SVIDEO and CVBS
Date: Fri, 18 Dec 2009 09:43:37 +0530
Message-ID: <19F8576C6E063C45BE387C64729E73940449F43A93@dbde02.ent.ti.com>
References: <hvaibhav@ti.com>
	<1261063176-20101-1-git-send-email-hvaibhav@ti.com>
 <20091217084245.9faaa19c.randy.dunlap@oracle.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="_002_19F8576C6E063C45BE387C64729E73940449F43A93dbde02enttico_"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:41778 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751470AbZLREOH (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 17 Dec 2009 23:14:07 -0500
In-Reply-To: <20091217084245.9faaa19c.randy.dunlap@oracle.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: "tomi.valkeinen@nokia.com" <tomi.valkeinen@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-fbdev-devel@lists.sourceforge.net" <linux-fbdev-devel@lists.sourceforge.net>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>

--_002_19F8576C6E063C45BE387C64729E73940449F43A93dbde02enttico_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable


> -----Original Message-----
> From: Randy Dunlap [mailto:randy.dunlap@oracle.com]
> Sent: Thursday, December 17, 2009 10:13 PM
> To: Hiremath, Vaibhav
> Cc: tomi.valkeinen@nokia.com; linux-omap@vger.kernel.org; linux-
> fbdev-devel@lists.sourceforge.net; linux-fbdev@vger.kernel.org
> Subject: Re: [PATCH 5/5] OMAP3EVM: Kconfig option added for
> selection between SVIDEO and CVBS
>=20
> On Thu, 17 Dec 2009 20:49:36 +0530 hvaibhav@ti.com wrote:
>=20
> > From: Vaibhav Hiremath <hvaibhav@ti.com>
> >
> > Config option added to arch/arm/plat-omap/Kconfig for selection
> > of S-Video and Composite output interfaces. The default
> configuration would
> > be S-Video.
> >
> > Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
> > ---
> >  arch/arm/mach-omap2/board-omap3evm.c |    4 ++++
> >  drivers/video/omap2/dss/Kconfig      |   15 +++++++++++++++
> >  2 files changed, 19 insertions(+), 0 deletions(-)
> >
> > diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-
> omap2/board-omap3evm.c
> > index e615254..549e58e 100644
> > --- a/arch/arm/mach-omap2/board-omap3evm.c
> > +++ b/arch/arm/mach-omap2/board-omap3evm.c
> > @@ -275,7 +275,11 @@ static struct omap_dss_device
> omap3_evm_tv_device =3D {
> >  	.name			=3D "tv",
> >  	.driver_name		=3D "venc",
> >  	.type			=3D OMAP_DISPLAY_TYPE_VENC,
> > +#if defined(CONFIG_OMAP2_VENC_OUT_TYPE_SVIDEO)
> >  	.phy.venc.type		=3D OMAP_DSS_VENC_TYPE_SVIDEO,
> > +#elif defined(CONFIG_OMAP2_VENC_OUT_TYPE_COMPOSITE)
> > +	.u.venc.type		=3D OMAP_DSS_VENC_TYPE_COMPOSITE,
>=20
> 	.u or .phy ?
>=20
[Hiremath, Vaibhav] Good catch; and this must be last minute cleanup of pat=
ch for submission. I have attached updated/fixed version here with this mai=
l.

Thanks,
Vaibhav
> > +#endif
> >  	.platform_enable	=3D omap3_evm_enable_tv,
> >  	.platform_disable	=3D omap3_evm_disable_tv,
> >  };
>=20
>=20
>=20
> ---
> ~Randy

--_002_19F8576C6E063C45BE387C64729E73940449F43A93dbde02enttico_
Content-Type: application/octet-stream;
	name="OMAP-DSS2-Kconfig-option-added-for-selection-betwee.patch"
Content-Description: OMAP-DSS2-Kconfig-option-added-for-selection-betwee.patch
Content-Disposition: attachment;
	filename="OMAP-DSS2-Kconfig-option-added-for-selection-betwee.patch";
	size=2020; creation-date="Fri, 18 Dec 2009 09:41:38 GMT";
	modification-date="Fri, 18 Dec 2009 09:41:38 GMT"
Content-Transfer-Encoding: base64

RnJvbSAxY2U0ZWRlMzZiMGU4NDkwN2YxYmQ0YTgyM2QwYjY2NjFkZWFkNDZmIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBWYWliaGF2IEhpcmVtYXRoIDxodmFpYmhhdkB0aS5jb20+CkRh
dGU6IFdlZCwgMjUgTm92IDIwMDkgMTk6MzE6NTQgKzA1MzAKU3ViamVjdDogW1BBVENIXSBPTUFQ
OkRTUzI6IEtjb25maWcgb3B0aW9uIGFkZGVkIGZvciBzZWxlY3Rpb24gYmV0d2VlbiBTVklERU8g
YW5kIENWQlMKCkNvbmZpZyBvcHRpb24gYWRkZWQgdG8gYXJjaC9hcm0vcGxhdC1vbWFwL0tjb25m
aWcgZm9yIHNlbGVjdGlvbgpvZiBTLVZpZGVvIGFuZCBDb21wb3NpdGUgb3V0cHV0IGludGVyZmFj
ZXMuIFRoZSBkZWZhdWx0IGNvbmZpZ3VyYXRpb24gd291bGQKYmUgUy1WaWRlby4KClNpZ25lZC1v
ZmYtYnk6IFZhaWJoYXYgSGlyZW1hdGggPGh2YWliaGF2QHRpLmNvbT4KLS0tCiBhcmNoL2FybS9t
YWNoLW9tYXAyL2JvYXJkLW9tYXAzZXZtLmMgfCAgICA0ICsrKysKIGRyaXZlcnMvdmlkZW8vb21h
cDIvZHNzL0tjb25maWcgICAgICB8ICAgMTUgKysrKysrKysrKysrKysrCiAyIGZpbGVzIGNoYW5n
ZWQsIDE5IGluc2VydGlvbnMoKyksIDAgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvYXJjaC9h
cm0vbWFjaC1vbWFwMi9ib2FyZC1vbWFwM2V2bS5jIGIvYXJjaC9hcm0vbWFjaC1vbWFwMi9ib2Fy
ZC1vbWFwM2V2bS5jCmluZGV4IGU2MTUyNTQuLjlkMjc2MTAgMTAwNjQ0Ci0tLSBhL2FyY2gvYXJt
L21hY2gtb21hcDIvYm9hcmQtb21hcDNldm0uYworKysgYi9hcmNoL2FybS9tYWNoLW9tYXAyL2Jv
YXJkLW9tYXAzZXZtLmMKQEAgLTI3NSw3ICsyNzUsMTEgQEAgc3RhdGljIHN0cnVjdCBvbWFwX2Rz
c19kZXZpY2Ugb21hcDNfZXZtX3R2X2RldmljZSA9IHsKIAkubmFtZQkJCT0gInR2IiwKIAkuZHJp
dmVyX25hbWUJCT0gInZlbmMiLAogCS50eXBlCQkJPSBPTUFQX0RJU1BMQVlfVFlQRV9WRU5DLAor
I2lmIGRlZmluZWQoQ09ORklHX09NQVAyX1ZFTkNfT1VUX1RZUEVfU1ZJREVPKQogCS5waHkudmVu
Yy50eXBlCQk9IE9NQVBfRFNTX1ZFTkNfVFlQRV9TVklERU8sCisjZWxpZiBkZWZpbmVkKENPTkZJ
R19PTUFQMl9WRU5DX09VVF9UWVBFX0NPTVBPU0lURSkKKwkucGh5LnZlbmMudHlwZQkJPSBPTUFQ
X0RTU19WRU5DX1RZUEVfQ09NUE9TSVRFLAorI2VuZGlmCiAJLnBsYXRmb3JtX2VuYWJsZQk9IG9t
YXAzX2V2bV9lbmFibGVfdHYsCiAJLnBsYXRmb3JtX2Rpc2FibGUJPSBvbWFwM19ldm1fZGlzYWJs
ZV90diwKIH07CmRpZmYgLS1naXQgYS9kcml2ZXJzL3ZpZGVvL29tYXAyL2Rzcy9LY29uZmlnIGIv
ZHJpdmVycy92aWRlby9vbWFwMi9kc3MvS2NvbmZpZwppbmRleCA3MWQ4ZGVjLi41YjdhOGJjIDEw
MDY0NAotLS0gYS9kcml2ZXJzL3ZpZGVvL29tYXAyL2Rzcy9LY29uZmlnCisrKyBiL2RyaXZlcnMv
dmlkZW8vb21hcDIvZHNzL0tjb25maWcKQEAgLTM2LDYgKzM2LDIxIEBAIGNvbmZpZyBPTUFQMl9E
U1NfVkVOQwogICAgICAgICBkZWZhdWx0IHkKIAloZWxwCiAJICBPTUFQIFZpZGVvIEVuY29kZXIg
c3VwcG9ydC4KK2Nob2ljZQorCXByb21wdCBPTUFQMl9WRU5DX09VVF9UWVBFCisJZGVwZW5kcyBv
biBPTUFQMl9EU1NfVkVOQworCWRlZmF1bHQgT01BUDJfVkVOQ19PVVRfVFlQRV9TVklERU8KKwor
Y29uZmlnIE9NQVAyX1ZFTkNfT1VUX1RZUEVfU1ZJREVPCisJYm9vbCAiVXNlIFMtVmlkZW8gb3V0
cHV0IGludGVyZmFjZSIKKwloZWxwCisJICBTZWxlY3QgdGhpcyBvcHRpb24gaWYgeW91IHdhbnQg
dG8gY2hvb3NlIFRWIG91dCBvdmVyIFMtVmlkZW8KKworY29uZmlnIE9NQVAyX1ZFTkNfT1VUX1RZ
UEVfQ09NUE9TSVRFCisJYm9vbCAiVXNlIENvbXBvc2l0ZSBvdXRwdXQgaW50ZXJmYWNlIgorCWhl
bHAKKwkgIFNlbGVjdCB0aGlzIG9wdGlvbiBpZiB5b3Ugd2FudCB0byBjaG9vc2UgVFYgb3V0IG92
ZXIgQ29tcG9zaXRlCitlbmRjaG9pY2UKIAogY29uZmlnIE9NQVAyX0RTU19TREkKIAlib29sICJT
REkgc3VwcG9ydCIKLS0gCjEuNi4yLjQKCg==

--_002_19F8576C6E063C45BE387C64729E73940449F43A93dbde02enttico_--
