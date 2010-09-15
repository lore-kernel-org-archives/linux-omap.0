From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: [PATCH] omap: Update omap3_defconfig to work with SMP_ON_UP
Date: Wed, 15 Sep 2010 23:55:50 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02CD25FF3B@dbde02.ent.ti.com>
References: <20100817104414.19061.38999.stgit@baageli.muru.com>
 <20100906104413.GD20903@n2100.arm.linux.org.uk>
 <20100914185907.GG8647@atomide.com> <20100914190314.GH8647@atomide.com>
 <EAF47CD23C76F840A9E7FCE10091EFAB02CD25F7DB@dbde02.ent.ti.com>
 <20100914202743.GK8647@atomide.com>
 <EAF47CD23C76F840A9E7FCE10091EFAB02CD25F9E1@dbde02.ent.ti.com>
 <20100915161126.GS8647@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="_002_EAF47CD23C76F840A9E7FCE10091EFAB02CD25FF3Bdbde02enttico_"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:41754 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754370Ab0IOS0L (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 15 Sep 2010 14:26:11 -0400
In-Reply-To: <20100915161126.GS8647@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "bryan.wu@canonical.com" <bryan.wu@canonical.com>

--_002_EAF47CD23C76F840A9E7FCE10091EFAB02CD25FF3Bdbde02enttico_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

> -----Original Message-----
> From: Tony Lindgren [mailto:tony@atomide.com]
> Sent: Wednesday, September 15, 2010 9:41 PM
> To: Shilimkar, Santosh
> Cc: Russell King - ARM Linux; linux-arm-kernel@lists.infradead.org; linux=
-
> omap@vger.kernel.org; bryan.wu@canonical.com
> Subject: Re: [PATCH] omap: Update omap3_defconfig to work with SMP_ON_UP
>=20
> * Shilimkar, Santosh <santosh.shilimkar@ti.com> [100914 23:03]:
> > >
> > > Sounds like you're having these problems anyways and they
> > > are not related to the defconfigs?
> > >
> > Well the issues are because of defconfig but mostly fixable.
> > Will hold on my comments till I test the new defconfig on OMAP4.
>=20
> OK
>=20
> > > Considering Linus' earlier comments on the defconfigs, I don't
> > > see any reasonds not to merge this patch. If TI wants to fix up
> > > some other things, there's still about two weeks before -rc6.
> > >
> > Sure. I am just saying let's attempt to fix the remaining issues
> > and if it doesn't happen in next week, anyway this patch will
> > get merged.
>=20
> OK let's plan on doing that.
>=20
Here is the patch which fixes most of the omap4 issues with common
Omap3_defconfig.=20

To enable local Timers for es1.0, I made some progress but looks like=20
it needs more changes in generic code. Will have a look at it tomorrow.

The patch is on top of the patches being discussed here. It's boot-tested=20
with single image on OMAP3 and OMAP4 SMP.

>From 26c908cd9baf3cc0b22f04f29cbeb26e08ad05e8 Mon Sep 17 00:00:00 2001
From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Date: Wed, 15 Sep 2010 22:40:19 +0530
Subject: [PATCH] omap: Update and rename common defconfig for omap2plus dev=
ices

This patch addresses below things:
- Renaming existing omap3_defconfig which has OMAP2, OMAP3 and OMAP4 builds
  enabled to more appropriate name 'omap2plus_defconfig'
- L1 cache shift is suppose to be 5 on OMAP4 where as it is 6 on previous
  OMAPs. Keeping it to 5 is safer option for OMAP4 and previous OMAPs. For
  OMAP3 only build the shift would be still 6
- Enable needed Errata's for OMAP4 to work with DMA based device drivers
	CONFIG_PL310_ERRATA_588369=3Dy
	CONFIG_ARM_ERRATA_720789=3Dy
- Enable the Micrel ethernet controller
	CONFIG_KS8851=3Dy
	CONFIG_KS8851_MLL=3Dy

With above three changes, OMAP4 ethernet, mmc etc works reliably.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 .../{omap3_defconfig =3D> omap2plus_defconfig}       |    3 +++
 arch/arm/mach-omap2/Kconfig                        |    4 +++-
 2 files changed, 6 insertions(+), 1 deletions(-)
 rename arch/arm/configs/{omap3_defconfig =3D> omap2plus_defconfig} (99%)

diff --git a/arch/arm/configs/omap3_defconfig b/arch/arm/configs/omap2plus_=
defconfig
similarity index 99%
rename from arch/arm/configs/omap3_defconfig
rename to arch/arm/configs/omap2plus_defconfig
index 833a9bc..3d27dd0 100644
--- a/arch/arm/configs/omap3_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -53,6 +53,7 @@ CONFIG_MACH_SBC3530=3Dy
 CONFIG_MACH_OMAP_3630SDP=3Dy
 CONFIG_MACH_OMAP_4430SDP=3Dy
 CONFIG_ARM_THUMBEE=3Dy
+CONFIG_ARM_L1_CACHE_SHIFT=3D5
 CONFIG_NO_HZ=3Dy
 CONFIG_HIGH_RES_TIMERS=3Dy
 CONFIG_SMP=3Dy
@@ -139,6 +140,8 @@ CONFIG_SMSC_PHY=3Dy
 CONFIG_NET_ETHERNET=3Dy
 CONFIG_SMC91X=3Dy
 CONFIG_SMSC911X=3Dy
+CONFIG_KS8851=3Dy
+CONFIG_KS8851_MLL=3Dy
 CONFIG_LIBERTAS=3Dy
 CONFIG_LIBERTAS_USB=3Dy
 CONFIG_LIBERTAS_SDIO=3Dy
diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index b48bacf..bb85f24 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -35,7 +35,7 @@ config ARCH_OMAP3
 	default y
 	select CPU_V7
 	select USB_ARCH_HAS_EHCI
-	select ARM_L1_CACHE_SHIFT_6
+	select ARM_L1_CACHE_SHIFT_6 if !ARCH_OMAP4
=20
 config ARCH_OMAP4
 	bool "TI OMAP4"
@@ -43,6 +43,8 @@ config ARCH_OMAP4
 	depends on ARCH_OMAP2PLUS
 	select CPU_V7
 	select ARM_GIC
+	select PL310_ERRATA_588369
+	select ARM_ERRATA_720789
=20
 comment "OMAP Core Type"
 	depends on ARCH_OMAP2
--=20
1.6.0.4


--_002_EAF47CD23C76F840A9E7FCE10091EFAB02CD25FF3Bdbde02enttico_
Content-Type: application/octet-stream;
	name="0001-omap-Update-and-rename-common-defconfig-for-omap2pl.patch"
Content-Description: 0001-omap-Update-and-rename-common-defconfig-for-omap2pl.patch
Content-Disposition: attachment;
	filename="0001-omap-Update-and-rename-common-defconfig-for-omap2pl.patch";
	size=2501; creation-date="Thu, 16 Sep 2010 00:01:20 GMT";
	modification-date="Thu, 16 Sep 2010 00:01:20 GMT"
Content-Transfer-Encoding: base64

RnJvbSAyNmM5MDhjZDliYWYzY2MwYjIyZjA0ZjI5Y2JlYjI2ZTA4YWQwNWU4IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTYW50b3NoIFNoaWxpbWthciA8c2FudG9zaC5zaGlsaW1rYXJA
dGkuY29tPgpEYXRlOiBXZWQsIDE1IFNlcCAyMDEwIDIyOjQwOjE5ICswNTMwClN1YmplY3Q6IFtQ
QVRDSF0gb21hcDogVXBkYXRlIGFuZCByZW5hbWUgY29tbW9uIGRlZmNvbmZpZyBmb3Igb21hcDJw
bHVzIGRldmljZXMKClRoaXMgcGF0Y2ggYWRkcmVzc2VzIGJlbG93IHRoaW5ncwoKLSBSZW5hbWlu
ZyBleGlzdGluZyBvbWFwM19kZWZjb25maWcgd2hpY2ggaGFzIE9NQVAyLCBPTUFQMyBhbmQgT01B
UDQgYnVpbGRzCiAgZW5hYmxlZCB0byBtb3JlIGFwcHJvcHJpYXRlIG5hbWUgJ29tYXAycGx1c19k
ZWZjb25maWcnCi0gTDEgY2FjaGUgc2hpZnQgaXMgc3VwcG9zZSB0byBiZSA1IG9uIE9NQVA0IHdo
ZXJlIGFzIGl0IGlzIDYgb24gcHJldmlvdXMKICBPTUFQcy4gS2VlcGluZyBpdCB0byA1IGlzIHNh
ZmVyIG9wdGlvbiBmb3IgT01BUDQgYW5kIHByZXZpb3VzIE9NQVBzLiBGb3IKICBPTUFQMyBvbmx5
IGJ1aWxkIHRoZSBzaGlmdCB3b3VsZCBiZSBzdGlsbCA2Ci0gRW5hYmxlIG5lZWRlZCBFcnJhdGEn
cyBmb3IgT01BUDQgdG8gd29yayB3aXRoIERNQSBiYXNlZCBkZXZpY2UgZHJpdmVycwoJQ09ORklH
X1BMMzEwX0VSUkFUQV81ODgzNjk9eQoJQ09ORklHX0FSTV9FUlJBVEFfNzIwNzg5PXkKLSBFbmFi
bGUgdGhlIE1pY3JlbCBldGhlcm5ldCBjb250cm9sbGVyCglDT05GSUdfS1M4ODUxPXkKCUNPTkZJ
R19LUzg4NTFfTUxMPXkKCldpdGggYWJvdmUgdGhyZWUgY2hhbmdlcywgT01BUDQgZXRoZXJuZXQs
IG1tYyBldGMgd29ya3MgcmVsaWFibHkuCgpTaWduZWQtb2ZmLWJ5OiBTYW50b3NoIFNoaWxpbWth
ciA8c2FudG9zaC5zaGlsaW1rYXJAdGkuY29tPgotLS0KIC4uLi97b21hcDNfZGVmY29uZmlnID0+
IG9tYXAycGx1c19kZWZjb25maWd9ICAgICAgIHwgICAgMyArKysKIGFyY2gvYXJtL21hY2gtb21h
cDIvS2NvbmZpZyAgICAgICAgICAgICAgICAgICAgICAgIHwgICAgNCArKystCiAyIGZpbGVzIGNo
YW5nZWQsIDYgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbnMoLSkKIHJlbmFtZSBhcmNoL2FybS9j
b25maWdzL3tvbWFwM19kZWZjb25maWcgPT4gb21hcDJwbHVzX2RlZmNvbmZpZ30gKDk5JSkKCmRp
ZmYgLS1naXQgYS9hcmNoL2FybS9jb25maWdzL29tYXAzX2RlZmNvbmZpZyBiL2FyY2gvYXJtL2Nv
bmZpZ3Mvb21hcDJwbHVzX2RlZmNvbmZpZwpzaW1pbGFyaXR5IGluZGV4IDk5JQpyZW5hbWUgZnJv
bSBhcmNoL2FybS9jb25maWdzL29tYXAzX2RlZmNvbmZpZwpyZW5hbWUgdG8gYXJjaC9hcm0vY29u
Zmlncy9vbWFwMnBsdXNfZGVmY29uZmlnCmluZGV4IDgzM2E5YmMuLjNkMjdkZDAgMTAwNjQ0Ci0t
LSBhL2FyY2gvYXJtL2NvbmZpZ3Mvb21hcDNfZGVmY29uZmlnCisrKyBiL2FyY2gvYXJtL2NvbmZp
Z3Mvb21hcDJwbHVzX2RlZmNvbmZpZwpAQCAtNTMsNiArNTMsNyBAQCBDT05GSUdfTUFDSF9TQkMz
NTMwPXkKIENPTkZJR19NQUNIX09NQVBfMzYzMFNEUD15CiBDT05GSUdfTUFDSF9PTUFQXzQ0MzBT
RFA9eQogQ09ORklHX0FSTV9USFVNQkVFPXkKK0NPTkZJR19BUk1fTDFfQ0FDSEVfU0hJRlQ9NQog
Q09ORklHX05PX0haPXkKIENPTkZJR19ISUdIX1JFU19USU1FUlM9eQogQ09ORklHX1NNUD15CkBA
IC0xMzksNiArMTQwLDggQEAgQ09ORklHX1NNU0NfUEhZPXkKIENPTkZJR19ORVRfRVRIRVJORVQ9
eQogQ09ORklHX1NNQzkxWD15CiBDT05GSUdfU01TQzkxMVg9eQorQ09ORklHX0tTODg1MT15CitD
T05GSUdfS1M4ODUxX01MTD15CiBDT05GSUdfTElCRVJUQVM9eQogQ09ORklHX0xJQkVSVEFTX1VT
Qj15CiBDT05GSUdfTElCRVJUQVNfU0RJTz15CmRpZmYgLS1naXQgYS9hcmNoL2FybS9tYWNoLW9t
YXAyL0tjb25maWcgYi9hcmNoL2FybS9tYWNoLW9tYXAyL0tjb25maWcKaW5kZXggYjQ4YmFjZi4u
YmI4NWYyNCAxMDA2NDQKLS0tIGEvYXJjaC9hcm0vbWFjaC1vbWFwMi9LY29uZmlnCisrKyBiL2Fy
Y2gvYXJtL21hY2gtb21hcDIvS2NvbmZpZwpAQCAtMzUsNyArMzUsNyBAQCBjb25maWcgQVJDSF9P
TUFQMwogCWRlZmF1bHQgeQogCXNlbGVjdCBDUFVfVjcKIAlzZWxlY3QgVVNCX0FSQ0hfSEFTX0VI
Q0kKLQlzZWxlY3QgQVJNX0wxX0NBQ0hFX1NISUZUXzYKKwlzZWxlY3QgQVJNX0wxX0NBQ0hFX1NI
SUZUXzYgaWYgIUFSQ0hfT01BUDQKIAogY29uZmlnIEFSQ0hfT01BUDQKIAlib29sICJUSSBPTUFQ
NCIKQEAgLTQzLDYgKzQzLDggQEAgY29uZmlnIEFSQ0hfT01BUDQKIAlkZXBlbmRzIG9uIEFSQ0hf
T01BUDJQTFVTCiAJc2VsZWN0IENQVV9WNwogCXNlbGVjdCBBUk1fR0lDCisJc2VsZWN0IFBMMzEw
X0VSUkFUQV81ODgzNjkKKwlzZWxlY3QgQVJNX0VSUkFUQV83MjA3ODkKIAogY29tbWVudCAiT01B
UCBDb3JlIFR5cGUiCiAJZGVwZW5kcyBvbiBBUkNIX09NQVAyCi0tIAoxLjYuMC40Cgo=

--_002_EAF47CD23C76F840A9E7FCE10091EFAB02CD25FF3Bdbde02enttico_--
