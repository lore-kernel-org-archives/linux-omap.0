From: "Kumar, Purushotam" <purushotam@ti.com>
Subject: RE: [PATCH] OMAP3:devices.c: Enabling 4-bit for SD card
Date: Mon, 14 Jul 2008 17:26:59 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB5930111B215C5@dbde02.ent.ti.com>
References: <200806161302.m5GD2Xg4007641@india.ti.com>
 <20080623124703.GW7741@atomide.com>
 <B85A65D85D7EB246BE421B3FB0FBB59301118F2774@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="_002_B85A65D85D7EB246BE421B3FB0FBB5930111B215C5dbde02enttico_"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:60061 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752973AbYGNL5j (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 14 Jul 2008 07:57:39 -0400
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59301118F2774@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Kumar, Purushotam" <purushotam@ti.com>, Tony Lindgren <tony@atomide.com>, Purushotam Kumar <a0876542@india.ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Gole, Anant" <anantgole@ti.com>

--_002_B85A65D85D7EB246BE421B3FB0FBB5930111B215C5dbde02enttico_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Tony,

I updated patch for MMC1 and MMC2 and also refreshed the patch.
I am attaching patch with this mail.

Regards,
Purushotam

> -----Original Message-----
> From: Kumar, Purushotam
> Sent: Wednesday, June 25, 2008 3:34 PM
> To: Tony Lindgren; Purushotam Kumar
> Cc: linux-omap@vger.kernel.org; Gole, Anant
> Subject: RE: [PATCH] OMAP3:devices.c: Enabling 4-bit for SD card
>
> > -----Original Message-----
> > From: Tony Lindgren [mailto:tony@atomide.com]
> > Sent: Monday, June 23, 2008 6:17 PM
> > To: Purushotam Kumar
> > Cc: linux-omap@vger.kernel.org; Gole, Anant
> > Subject: Re: [PATCH] OMAP3:devices.c: Enabling 4-bit for SD card
> >
> > * Purushotam Kumar <a0876542@india.ti.com> [080616 16:03]:
> > > OMAP3:devices.c:Enabling 4-bit for SD card
> > >
> > > SD card was working in 1-bit mode.This patch will configure SD card i=
n
> > > 4-bit mode and hence performance  will increase.
> > >
> > > Signed-off-by: Purushotam Kumar <purushotam@ti.com>
> > > Acked-by: Madhusudhan Chikkature Rajashekar <madhu.cr@ti.com>
> > > ---
> > >  arch/arm/plat-omap/devices.c |    4 +++-
> > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > >
> > > Index: linux-omap-2.6/arch/arm/plat-omap/devices.c
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > --- linux-omap-2.6.orig/arch/arm/plat-omap/devices.c
> > > +++ linux-omap-2.6/arch/arm/plat-omap/devices.c
> > > @@ -292,8 +292,10 @@ static void __init omap_init_mmc(void)
> > >       mmc =3D &mmc_conf->mmc[0];
> > >
> > >       if (cpu_is_omap2430() || cpu_is_omap34xx()) {
> > > -             if (mmc->enabled)
> > > +             if (mmc->enabled) {
> > > +                     mmc1_data.conf =3D *mmc;
> > >                       (void) platform_device_register(&mmc_omap_devic=
e1);
> > > +             }
> > >
> > >  #if defined(CONFIG_ARCH_OMAP2430) || defined(CONFIG_ARCH_OMAP34XX)
> > >               mmc =3D &mmc_conf->mmc[1];
> >
> > I guess this should be also done for mmc2_data.conf?
> >
> > Tony
>
> I agree with you that it is required to be done for MMC2 as well.
> Please push this patch for MMC1 and I will submit other patch latter for =
MMC2.
>
> Regards,
> Purushotam

--_002_B85A65D85D7EB246BE421B3FB0FBB5930111B215C5dbde02enttico_
Content-Type: application/octet-stream; name="enable_sd_4bit.patch"
Content-Description: enable_sd_4bit.patch
Content-Disposition: attachment; filename="enable_sd_4bit.patch"; size=1121;
	creation-date="Mon, 14 Jul 2008 17:21:45 GMT";
	modification-date="Mon, 14 Jul 2008 17:21:45 GMT"
Content-Transfer-Encoding: base64

T01BUDM6ZGV2aWNlcy5jOkVuYWJsaW5nIDQtYml0IGZvciBTRCBjYXJkCgpTRCBjYXJkIHdhcyB3
b3JraW5nIGluIDEtYml0IG1vZGUuVGhpcyBwYXRjaCB3aWxsIGNvbmZpZ3VyZSBTRCBjYXJkIGlu
IAo0LWJpdCBtb2RlIGFuZCBoZW5jZSBwZXJmb3JtYW5jZSAgd2lsbCBpbmNyZWFzZS4KClNpZ25l
ZC1vZmYtYnk6IFB1cnVzaG90YW0gS3VtYXIgPHB1cnVzaG90YW1AdGkuY29tPgpBY2tlZC1ieTog
TWFkaHVzdWRoYW4gQ2hpa2thdHVyZSBSYWphc2hla2FyIDxtYWRodS5jckB0aS5jb20+Ci0tLQog
YXJjaC9hcm0vcGxhdC1vbWFwL2RldmljZXMuYyB8ICAgIDggKysrKysrLS0KIDEgZmlsZSBjaGFu
Z2VkLCA2IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCgpJbmRleDogbGludXgtb21hcC0y
LjYvYXJjaC9hcm0vcGxhdC1vbWFwL2RldmljZXMuYwo9PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09Ci0tLSBsaW51eC1vbWFw
LTIuNi5vcmlnL2FyY2gvYXJtL3BsYXQtb21hcC9kZXZpY2VzLmMKKysrIGxpbnV4LW9tYXAtMi42
L2FyY2gvYXJtL3BsYXQtb21hcC9kZXZpY2VzLmMKQEAgLTI5NiwxMyArMjk2LDE3IEBAIHN0YXRp
YyB2b2lkIF9faW5pdCBvbWFwX2luaXRfbW1jKHZvaWQpCiAJbW1jID0gJm1tY19jb25mLT5tbWNb
MF07CiAKIAlpZiAoY3B1X2lzX29tYXAyNDMwKCkgfHwgY3B1X2lzX29tYXAzNHh4KCkpIHsKLQkJ
aWYgKG1tYy0+ZW5hYmxlZCkKKwkJaWYgKG1tYy0+ZW5hYmxlZCkgeworCQkJbW1jMV9kYXRhLmNv
bmYgPSAqbW1jOwogCQkJKHZvaWQpIHBsYXRmb3JtX2RldmljZV9yZWdpc3RlcigmbW1jX29tYXBf
ZGV2aWNlMSk7CisJCX0KIAogI2lmIGRlZmluZWQoQ09ORklHX0FSQ0hfT01BUDI0MzApIHx8IGRl
ZmluZWQoQ09ORklHX0FSQ0hfT01BUDM0WFgpCiAJCW1tYyA9ICZtbWNfY29uZi0+bW1jWzFdOwot
CQlpZiAobW1jLT5lbmFibGVkKQorCQlpZiAobW1jLT5lbmFibGVkKSB7CisJCQltbWMyX2RhdGEu
Y29uZiA9ICptbWM7CiAJCQkodm9pZCkgcGxhdGZvcm1fZGV2aWNlX3JlZ2lzdGVyKCZtbWNfb21h
cF9kZXZpY2UyKTsKKwkJfQogI2VuZGlmCiAKIAkJcmV0dXJuOwo=

--_002_B85A65D85D7EB246BE421B3FB0FBB5930111B215C5dbde02enttico_--
