From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: [PATCH 1/3] ARM: mmu: Setup MT_MEMORY and MT_MEMORY_NONACHED	L1
 entries
Date: Mon, 9 Aug 2010 14:49:09 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02C6552EDC@dbde02.ent.ti.com>
References: <1281262672-27626-1-git-send-email-santosh.shilimkar@ti.com>
 <20100808113403.GA23623@n2100.arm.linux.org.uk>
 <EAF47CD23C76F840A9E7FCE10091EFAB02C64A2363@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="_002_EAF47CD23C76F840A9E7FCE10091EFAB02C6552EDCdbde02enttico_"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:53330 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755840Ab0HIJT0 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 9 Aug 2010 05:19:26 -0400
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02C64A2363@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

--_002_EAF47CD23C76F840A9E7FCE10091EFAB02C6552EDCdbde02enttico_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Shilimkar, Santosh
> Sent: Sunday, August 08, 2010 5:16 PM
> To: Russell King - ARM Linux
> Cc: linux-omap@vger.kernel.org; linux-arm-kernel@lists.infradead.org
> Subject: RE: [PATCH 1/3] ARM: mmu: Setup MT_MEMORY and MT_MEMORY_NONACHED
> L1 entries
>=20
> > -----Original Message-----
> > From: Russell King - ARM Linux [mailto:linux@arm.linux.org.uk]
> > Sent: Sunday, August 08, 2010 5:04 PM
> > To: Shilimkar, Santosh
> > Cc: linux-omap@vger.kernel.org; linux-arm-kernel@lists.infradead.org
> > Subject: Re: [PATCH 1/3] ARM: mmu: Setup MT_MEMORY and
> MT_MEMORY_NONACHED
> > L1 entries
> >
> > On Sun, Aug 08, 2010 at 03:47:52PM +0530, Santosh Shilimkar wrote:
> > > @@ -475,6 +486,9 @@ static void __init build_mem_type_table(void)
> > >  	mem_types[MT_LOW_VECTORS].prot_l1 |=3D ecc_mask;
> > >  	mem_types[MT_HIGH_VECTORS].prot_l1 |=3D ecc_mask;
> > >  	mem_types[MT_MEMORY].prot_sect |=3D ecc_mask | cp->pmd;
> > > +	mem_types[MT_MEMORY].prot_pte |=3D kern_pgprot;
> > > +	mem_types[MT_MEMORY_NONCACHED].prot_sect |=3D ecc_mask | cp->pmd;
> > > +	mem_types[MT_MEMORY_NONCACHED].prot_pte |=3D kern_pgprot;
> >
> > This is wrong - it will result in the non-cached memory mapped in as
> > sections having the same cache settings as MT_MEMORY - in other
> > words, probably write back.
> You are right. Will fix this in next version.
>=20
Updated version with Russell's comments incorporated.

--------------------------------------------------------------------
>From 23d712c1846d78bdb09979087261911e5d80f014 Mon Sep 17 00:00:00 2001
From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Date: Sun, 8 Aug 2010 12:05:25 +0530
Subject: [PATCH 1/3 v2] ARM: mmu: Setup MT_MEMORY and MT_MEMORY_NONCACHED L=
1 entries

This patch populates the L1 entries for MT_MEMORY and MT_MEMORY_NONCACHED
types so that at boot-up, we can map memories outside system memory
at page level granularity

Previously the mapping was limiting to section level, which creates
unnecessary additional mapping for which physical memory may not
present. On the newer ARM with speculation, this is dangerous and can
result in untraceable aborts.

The patch is based on inputs from Russell King

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Russell King <linux@arm.linux.org.uk>
---
arch/arm/mm/mmu.c |   17 +++++++++++++++--
 1 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index 6e1c4f6..3e986a6 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -246,6 +246,9 @@ static struct mem_type mem_types[] =3D {
 		.domain    =3D DOMAIN_USER,
 	},
 	[MT_MEMORY] =3D {
+		.prot_pte  =3D L_PTE_PRESENT | L_PTE_YOUNG | L_PTE_DIRTY |
+				L_PTE_USER | L_PTE_EXEC,
+		.prot_l1   =3D PMD_TYPE_TABLE,
 		.prot_sect =3D PMD_TYPE_SECT | PMD_SECT_AP_WRITE,
 		.domain    =3D DOMAIN_KERNEL,
 	},
@@ -254,6 +257,9 @@ static struct mem_type mem_types[] =3D {
 		.domain    =3D DOMAIN_KERNEL,
 	},
 	[MT_MEMORY_NONCACHED] =3D {
+		.prot_pte  =3D L_PTE_PRESENT | L_PTE_YOUNG | L_PTE_DIRTY |
+				L_PTE_USER | L_PTE_EXEC | L_PTE_MT_BUFFERABLE,
+		.prot_l1   =3D PMD_TYPE_TABLE,
 		.prot_sect =3D PMD_TYPE_SECT | PMD_SECT_AP_WRITE,
 		.domain    =3D DOMAIN_KERNEL,
 	},
@@ -411,9 +417,12 @@ static void __init build_mem_type_table(void)
 	 * Enable CPU-specific coherency if supported.
 	 * (Only available on XSC3 at the moment.)
 	 */
-	if (arch_is_coherent() && cpu_is_xsc3())
+	if (arch_is_coherent() && cpu_is_xsc3()) {
 		mem_types[MT_MEMORY].prot_sect |=3D PMD_SECT_S;
-
+		mem_types[MT_MEMORY].prot_pte |=3D L_PTE_SHARED;
+		mem_types[MT_MEMORY_NONCACHED].prot_sect |=3D PMD_SECT_S;
+		mem_types[MT_MEMORY_NONCACHED].prot_pte |=3D L_PTE_SHARED;
+	}
 	/*
 	 * ARMv6 and above have extended page tables.
 	 */
@@ -438,7 +447,9 @@ static void __init build_mem_type_table(void)
 		mem_types[MT_DEVICE_CACHED].prot_sect |=3D PMD_SECT_S;
 		mem_types[MT_DEVICE_CACHED].prot_pte |=3D L_PTE_SHARED;
 		mem_types[MT_MEMORY].prot_sect |=3D PMD_SECT_S;
+		mem_types[MT_MEMORY].prot_pte |=3D L_PTE_SHARED;
 		mem_types[MT_MEMORY_NONCACHED].prot_sect |=3D PMD_SECT_S;
+		mem_types[MT_MEMORY_NONCACHED].prot_pte |=3D L_PTE_SHARED;
 #endif
 	}
=20
@@ -475,6 +486,8 @@ static void __init build_mem_type_table(void)
 	mem_types[MT_LOW_VECTORS].prot_l1 |=3D ecc_mask;
 	mem_types[MT_HIGH_VECTORS].prot_l1 |=3D ecc_mask;
 	mem_types[MT_MEMORY].prot_sect |=3D ecc_mask | cp->pmd;
+	mem_types[MT_MEMORY].prot_pte |=3D kern_pgprot;
+	mem_types[MT_MEMORY_NONCACHED].prot_sect |=3D ecc_mask;
 	mem_types[MT_ROM].prot_sect |=3D cp->pmd;
=20
 	switch (cp->pmd) {
--=20
1.6.0.4


--_002_EAF47CD23C76F840A9E7FCE10091EFAB02C6552EDCdbde02enttico_
Content-Type: application/octet-stream;
	name="0001-ARM-mmu-Setup-MT_MEMORY-and-MT_MEMORY_NONCACHED-L1.patch"
Content-Description: 0001-ARM-mmu-Setup-MT_MEMORY-and-MT_MEMORY_NONCACHED-L1.patch
Content-Disposition: attachment;
	filename="0001-ARM-mmu-Setup-MT_MEMORY-and-MT_MEMORY_NONCACHED-L1.patch";
	size=3089; creation-date="Mon, 09 Aug 2010 14:49:33 GMT";
	modification-date="Mon, 09 Aug 2010 14:49:33 GMT"
Content-Transfer-Encoding: base64

RnJvbSAyM2Q3MTJjMTg0NmQ3OGJkYjA5OTc5MDg3MjYxOTExZTVkODBmMDE0IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTYW50b3NoIFNoaWxpbWthciA8c2FudG9zaC5zaGlsaW1rYXJA
dGkuY29tPgpEYXRlOiBTdW4sIDggQXVnIDIwMTAgMTI6MDU6MjUgKzA1MzAKU3ViamVjdDogW1BB
VENIIDEvMyB2Ml0gQVJNOiBtbXU6IFNldHVwIE1UX01FTU9SWSBhbmQgTVRfTUVNT1JZX05PTkNB
Q0hFRCBMMSBlbnRyaWVzCgpUaGlzIHBhdGNoIHBvcHVsYXRlcyB0aGUgTDEgZW50cmllcyBmb3Ig
TVRfTUVNT1JZIGFuZCBNVF9NRU1PUllfTk9OQ0FDSEVECnR5cGVzIHNvIHRoYXQgYXQgYm9vdC11
cCwgd2UgY2FuIG1hcCBtZW1vcmllcyBvdXRzaWRlIHN5c3RlbSBtZW1vcnkKYXQgcGFnZSBsZXZl
bCBncmFudWxhcml0eQoKUHJldmlvdXNseSB0aGUgbWFwcGluZyB3YXMgbGltaXRpbmcgdG8gc2Vj
dGlvbiBsZXZlbCwgd2hpY2ggY3JlYXRlcwp1bm5lY2Vzc2FyeSBhZGRpdGlvbmFsIG1hcHBpbmcg
Zm9yIHdoaWNoIHBoeXNpY2FsIG1lbW9yeSBtYXkgbm90CnByZXNlbnQuIE9uIHRoZSBuZXdlciBB
Uk0gd2l0aCBzcGVjdWxhdGlvbiwgdGhpcyBpcyBkYW5nZXJvdXMgYW5kIGNhbgpyZXN1bHQgaW4g
dW50cmFjZWFibGUgYWJvcnRzLgoKVGhlIHBhdGNoIGlzIGJhc2VkIG9uIGlucHV0cyBmcm9tIFJ1
c3NlbGwgS2luZwoKU2lnbmVkLW9mZi1ieTogU2FudG9zaCBTaGlsaW1rYXIgPHNhbnRvc2guc2hp
bGlta2FyQHRpLmNvbT4KQ2M6IFJ1c3NlbGwgS2luZyA8bGludXhAYXJtLmxpbnV4Lm9yZy51az4K
LS0tClVwZGF0ZWQgdmVyaW9uIHdpdGggUk1LJ3MgY29tbWVudHMuCiBhcmNoL2FybS9tbS9tbXUu
YyB8ICAgMTcgKysrKysrKysrKysrKysrLS0KIDEgZmlsZXMgY2hhbmdlZCwgMTUgaW5zZXJ0aW9u
cygrKSwgMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9hcmNoL2FybS9tbS9tbXUuYyBiL2Fy
Y2gvYXJtL21tL21tdS5jCmluZGV4IDZlMWM0ZjYuLjNlOTg2YTYgMTAwNjQ0Ci0tLSBhL2FyY2gv
YXJtL21tL21tdS5jCisrKyBiL2FyY2gvYXJtL21tL21tdS5jCkBAIC0yNDYsNiArMjQ2LDkgQEAg
c3RhdGljIHN0cnVjdCBtZW1fdHlwZSBtZW1fdHlwZXNbXSA9IHsKIAkJLmRvbWFpbiAgICA9IERP
TUFJTl9VU0VSLAogCX0sCiAJW01UX01FTU9SWV0gPSB7CisJCS5wcm90X3B0ZSAgPSBMX1BURV9Q
UkVTRU5UIHwgTF9QVEVfWU9VTkcgfCBMX1BURV9ESVJUWSB8CisJCQkJTF9QVEVfVVNFUiB8IExf
UFRFX0VYRUMsCisJCS5wcm90X2wxICAgPSBQTURfVFlQRV9UQUJMRSwKIAkJLnByb3Rfc2VjdCA9
IFBNRF9UWVBFX1NFQ1QgfCBQTURfU0VDVF9BUF9XUklURSwKIAkJLmRvbWFpbiAgICA9IERPTUFJ
Tl9LRVJORUwsCiAJfSwKQEAgLTI1NCw2ICsyNTcsOSBAQCBzdGF0aWMgc3RydWN0IG1lbV90eXBl
IG1lbV90eXBlc1tdID0gewogCQkuZG9tYWluICAgID0gRE9NQUlOX0tFUk5FTCwKIAl9LAogCVtN
VF9NRU1PUllfTk9OQ0FDSEVEXSA9IHsKKwkJLnByb3RfcHRlICA9IExfUFRFX1BSRVNFTlQgfCBM
X1BURV9ZT1VORyB8IExfUFRFX0RJUlRZIHwKKwkJCQlMX1BURV9VU0VSIHwgTF9QVEVfRVhFQyB8
IExfUFRFX01UX0JVRkZFUkFCTEUsCisJCS5wcm90X2wxICAgPSBQTURfVFlQRV9UQUJMRSwKIAkJ
LnByb3Rfc2VjdCA9IFBNRF9UWVBFX1NFQ1QgfCBQTURfU0VDVF9BUF9XUklURSwKIAkJLmRvbWFp
biAgICA9IERPTUFJTl9LRVJORUwsCiAJfSwKQEAgLTQxMSw5ICs0MTcsMTIgQEAgc3RhdGljIHZv
aWQgX19pbml0IGJ1aWxkX21lbV90eXBlX3RhYmxlKHZvaWQpCiAJICogRW5hYmxlIENQVS1zcGVj
aWZpYyBjb2hlcmVuY3kgaWYgc3VwcG9ydGVkLgogCSAqIChPbmx5IGF2YWlsYWJsZSBvbiBYU0Mz
IGF0IHRoZSBtb21lbnQuKQogCSAqLwotCWlmIChhcmNoX2lzX2NvaGVyZW50KCkgJiYgY3B1X2lz
X3hzYzMoKSkKKwlpZiAoYXJjaF9pc19jb2hlcmVudCgpICYmIGNwdV9pc194c2MzKCkpIHsKIAkJ
bWVtX3R5cGVzW01UX01FTU9SWV0ucHJvdF9zZWN0IHw9IFBNRF9TRUNUX1M7Ci0KKwkJbWVtX3R5
cGVzW01UX01FTU9SWV0ucHJvdF9wdGUgfD0gTF9QVEVfU0hBUkVEOworCQltZW1fdHlwZXNbTVRf
TUVNT1JZX05PTkNBQ0hFRF0ucHJvdF9zZWN0IHw9IFBNRF9TRUNUX1M7CisJCW1lbV90eXBlc1tN
VF9NRU1PUllfTk9OQ0FDSEVEXS5wcm90X3B0ZSB8PSBMX1BURV9TSEFSRUQ7CisJfQogCS8qCiAJ
ICogQVJNdjYgYW5kIGFib3ZlIGhhdmUgZXh0ZW5kZWQgcGFnZSB0YWJsZXMuCiAJICovCkBAIC00
MzgsNyArNDQ3LDkgQEAgc3RhdGljIHZvaWQgX19pbml0IGJ1aWxkX21lbV90eXBlX3RhYmxlKHZv
aWQpCiAJCW1lbV90eXBlc1tNVF9ERVZJQ0VfQ0FDSEVEXS5wcm90X3NlY3QgfD0gUE1EX1NFQ1Rf
UzsKIAkJbWVtX3R5cGVzW01UX0RFVklDRV9DQUNIRURdLnByb3RfcHRlIHw9IExfUFRFX1NIQVJF
RDsKIAkJbWVtX3R5cGVzW01UX01FTU9SWV0ucHJvdF9zZWN0IHw9IFBNRF9TRUNUX1M7CisJCW1l
bV90eXBlc1tNVF9NRU1PUlldLnByb3RfcHRlIHw9IExfUFRFX1NIQVJFRDsKIAkJbWVtX3R5cGVz
W01UX01FTU9SWV9OT05DQUNIRURdLnByb3Rfc2VjdCB8PSBQTURfU0VDVF9TOworCQltZW1fdHlw
ZXNbTVRfTUVNT1JZX05PTkNBQ0hFRF0ucHJvdF9wdGUgfD0gTF9QVEVfU0hBUkVEOwogI2VuZGlm
CiAJfQogCkBAIC00NzUsNiArNDg2LDggQEAgc3RhdGljIHZvaWQgX19pbml0IGJ1aWxkX21lbV90
eXBlX3RhYmxlKHZvaWQpCiAJbWVtX3R5cGVzW01UX0xPV19WRUNUT1JTXS5wcm90X2wxIHw9IGVj
Y19tYXNrOwogCW1lbV90eXBlc1tNVF9ISUdIX1ZFQ1RPUlNdLnByb3RfbDEgfD0gZWNjX21hc2s7
CiAJbWVtX3R5cGVzW01UX01FTU9SWV0ucHJvdF9zZWN0IHw9IGVjY19tYXNrIHwgY3AtPnBtZDsK
KwltZW1fdHlwZXNbTVRfTUVNT1JZXS5wcm90X3B0ZSB8PSBrZXJuX3BncHJvdDsKKwltZW1fdHlw
ZXNbTVRfTUVNT1JZX05PTkNBQ0hFRF0ucHJvdF9zZWN0IHw9IGVjY19tYXNrOwogCW1lbV90eXBl
c1tNVF9ST01dLnByb3Rfc2VjdCB8PSBjcC0+cG1kOwogCiAJc3dpdGNoIChjcC0+cG1kKSB7Ci0t
IAoxLjYuMC40Cgo=

--_002_EAF47CD23C76F840A9E7FCE10091EFAB02C6552EDCdbde02enttico_--
