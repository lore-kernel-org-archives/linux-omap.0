From: "Pandita, Vikram" <vikram.pandita@ti.com>
Subject: RE: [PATCH] OMAP3: Zoom2: provide default MTD partitions
Date: Thu, 27 Aug 2009 19:16:27 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC35608702F9A44CDF@dbde02.ent.ti.com>
References: <1251374386-6733-1-git-send-email-mpetazzoni@mvista.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="_002_FCCFB4CDC6E5564B9182F639FC35608702F9A44CDFdbde02enttico_"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:41482 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752676AbZH0Nsw (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 27 Aug 2009 09:48:52 -0400
In-Reply-To: <1251374386-6733-1-git-send-email-mpetazzoni@mvista.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Maxime Petazzoni <mpetazzoni@mvista.com>, "Singh, Vimal" <IMCEAEX-_O=TI_OU=BD_cn=Recipients_cn=x0094262@dlee86.itg.ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Rix, Tom" <trix@ti.com>

--_002_FCCFB4CDC6E5564B9182F639FC35608702F9A44CDFdbde02enttico_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Petazzoni/Vimal

>-----Original Message-----
>From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger.kerne=
l.org] On Behalf Of Maxime
>Petazzoni
>Sent: Thursday, August 27, 2009 7:00 AM
>To: linux-omap@vger.kernel.org
>Subject: [PATCH] OMAP3: Zoom2: provide default MTD partitions
>
>This change introduces default MTD partitions for the Zoom-II board
>NAND, inspired by the OMAP3 Beagle partitions and the OMAP3 Zoom2
>partitions defined in OmapZoom.org's OMAP kernel.

Thanks for putting this together for zoom2, however I NAK for now.

Why?

I know of an implementation by Vimal Singh that introduces a common flash f=
ile for Zoom1 and Zoom2.
There is reuse of code there.

I have attached the patch by Vimal here (in-lining would be difficult)

Please discuss and get a converged approach on handling NAND partitions on =
Zoom1 and Zoom2.

Also the Systerm/User/Cache partition definitions are more from Android per=
spective.

Given that each system may have a different NAND partition requirement,=20
have you looked at bootargs passing the MTD partition info: Eg:=20

mtdparts=3Domap2-nand.0:512k@0(xloader),\
1536k@512k(bootloader),\
29m@2m(kernel),\
160m@32m(system),\
32m@192m(userdata),\
32m@224m(cache)


Lets discuss the final approach on this list and try to close this soon.

Thnx

>
>The size of the U-Boot environment partition was increased to 1MB, as
>the previously smaller partition couldn't contain the U-Boot environment
>correctly (erasing the next partition would erase the U-Boot env as
>well).
>
>Finally, the "system" partition gets an increased size of 256MB to take
>advantage of the size of the flash on the Zoom-II board.
>
>Signed-off-by: Maxime Petazzoni <mpetazzoni@mvista.com>
>---
> arch/arm/mach-omap2/board-zoom2.c |   86 ++++++++++++++++++++++++++++++++=
+++++
> 1 files changed, 86 insertions(+), 0 deletions(-)
>
>diff --git a/arch/arm/mach-omap2/board-zoom2.c b/arch/arm/mach-omap2/board=
-zoom2.c
>index 4d295d5..ce5a4d8 100644
>--- a/arch/arm/mach-omap2/board-zoom2.c
>+++ b/arch/arm/mach-omap2/board-zoom2.c
>@@ -16,16 +16,101 @@
> #include <linux/gpio.h>
> #include <linux/i2c/twl4030.h>
> #include <linux/regulator/machine.h>
>+#include <linux/mtd/mtd.h>
>+#include <linux/mtd/partitions.h>
>+#include <linux/mtd/nand.h>
>
> #include <asm/mach-types.h>
> #include <asm/mach/arch.h>
>
> #include <mach/common.h>
>+#include <mach/nand.h>
> #include <mach/usb.h>
> #include <mach/keypad.h>
>
> #include "mmc-twl4030.h"
>
>+#define LDP3430_NAND_CS	0
>+#define GPMC_CS0_BASE	0x60
>+#define GPMC_CS_SIZE	0x30
>+
>+static struct mtd_partition zoom2_nand_partitions[] =3D {
>+	{
>+		.name		=3D "X-Loader-NAND",
>+		.offset		=3D 0,
>+		.size		=3D 4 * (64 * 2048),	/* 512kB */
>+		.mask_flags	=3D MTD_WRITEABLE,	/* force read-only */
>+	},
>+	{
>+		.name		=3D "U-Boot-NAND",
>+		.offset		=3D MTDPART_OFS_APPEND,	/* Offset =3D 0x80000 */
>+		.size		=3D 4 * (64 * 2048),	/* 512kB */
>+		.mask_flags	=3D MTD_WRITEABLE,	/* force read-only */
>+	},
>+	{
>+		.name		=3D "Boot Env-NAND",
>+		.offset		=3D MTDPART_OFS_APPEND,	/* Offset =3D 0x100000 */
>+		.size		=3D 8 * (64 * 2048),	/* 1MB */
>+	},
>+	{
>+		.name		=3D "Kernel-NAND",
>+		.offset		=3D MTDPART_OFS_APPEND,	/* Offset =3D 0x200000 */
>+		.size		=3D 32 * (64 * 2048),	/* 4MB */
>+	},
>+	{
>+		.name		=3D "system",
>+		.offset		=3D MTDPART_OFS_APPEND,	/* Offset =3D 0x600000 */
>+		.size		=3D 2048 * (64 * 2048),	/* 256MB */
>+	},
>+	{
>+		.name		=3D "userdata",
>+		.offset		=3D MTDPART_OFS_APPEND,	/* Offset =3D 0x10600000 */
>+		.size		=3D 512 * (64 * 2048),	/* 64MB */
>+	},
>+	{
>+		.name		=3D "cache",
>+		.offset		=3D MTDPART_OFS_APPEND,	/* Offset =3D 0x14600000 */
>+		.size		=3D 512 * (64 * 2048),	/* 64MB */
>+	},
>+};
>+
>+/* NAND chip access: 16 bit */
>+static struct omap_nand_platform_data zoom2_nand_data =3D {
>+	.parts		=3D zoom2_nand_partitions,
>+	.nr_parts	=3D ARRAY_SIZE(zoom2_nand_partitions),
>+	.nand_setup	=3D NULL,
>+	.dma_channel	=3D -1,		/* disable DMA in OMAP NAND driver */
>+	.dev_ready	=3D NULL,
>+};
>+
>+static struct resource zoom2_nand_resource =3D {
>+	.flags		=3D IORESOURCE_MEM,
>+};
>+
>+static struct platform_device zoom2_nand_device =3D {
>+	.name		=3D "omap2-nand",
>+	.id		=3D 0,
>+	.dev		=3D {
>+		.platform_data =3D &zoom2_nand_data,
>+	},
>+	.num_resources	=3D 1,
>+	.resource	=3D &zoom2_nand_resource,
>+};
>+
>+static void __init zoom2_flash_init(void)
>+{
>+	u8 nandcs =3D LDP3430_NAND_CS;
>+	u32 gpmc_base_add =3D OMAP34XX_GPMC_VIRT;
>+
>+	zoom2_nand_data.cs =3D nandcs;
>+	zoom2_nand_data.gpmc_cs_baseaddr =3D (void *)(gpmc_base_add +
>+			GPMC_CS0_BASE + nandcs * GPMC_CS_SIZE);
>+	zoom2_nand_data.gpmc_baseaddr =3D (void *) (gpmc_base_add);
>+
>+	if (platform_device_register(&zoom2_nand_device) < 0)
>+		printk(KERN_ERR "Unable to register NAND device!\n");
>+}
>+
> /* Zoom2 has Qwerty keyboard*/
> static int zoom2_twl4030_keymap[] =3D {
> 	KEY(0, 0, KEY_E),
>@@ -271,6 +356,7 @@ static void __init omap_zoom2_init(void)
> 	omap_serial_init(&zoom2_uart_config);
> 	omap_zoom2_debugboard_init();
> 	usb_musb_init();
>+	zoom2_flash_init();
> }
>
> static void __init omap_zoom2_map_io(void)
>--
>1.6.3.3.210.g29cb3
>
>--
>To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html


--_002_FCCFB4CDC6E5564B9182F639FC35608702F9A44CDFdbde02enttico_
Content-Type: application/octet-stream; name="add_nand_support_zoom2.patch"
Content-Description: add_nand_support_zoom2.patch
Content-Disposition: attachment; filename="add_nand_support_zoom2.patch";
	size=11067; creation-date="Thu, 27 Aug 2009 19:05:47 GMT";
	modification-date="Thu, 27 Aug 2009 19:05:47 GMT"
Content-Transfer-Encoding: base64

LS0tCiBhcmNoL2FybS9tYWNoLW9tYXAyL01ha2VmaWxlICAgICAgICAgICAgICAgIHwgICAgMiAK
IGFyY2gvYXJtL21hY2gtb21hcDIvYm9hcmQtbGRwLWZsYXNoLmMgICAgICAgfCAgMTk1ICsrKysr
KysrKysrKysrKysrKysrKysrKysrKysKIGFyY2gvYXJtL21hY2gtb21hcDIvYm9hcmQtbGRwLmMg
ICAgICAgICAgICAgfCAgICAyIAogYXJjaC9hcm0vbWFjaC1vbWFwMi9ib2FyZC16b29tMi5jICAg
ICAgICAgICB8ICAgIDIgCiBhcmNoL2FybS9wbGF0LW9tYXAvaW5jbHVkZS9tYWNoL2JvYXJkLWxk
cC5oIHwgICAzNiArKysrKwogYXJjaC9hcm0vcGxhdC1vbWFwL2luY2x1ZGUvbWFjaC9ncG1jLmgg
ICAgICB8ICAgIDIgCiBhcmNoL2FybS9wbGF0LW9tYXAvaW5jbHVkZS9tYWNoL25hbmQuaCAgICAg
IHwgICAgMSAKIDcgZmlsZXMgY2hhbmdlZCwgMjQwIGluc2VydGlvbnMoKykKCkluZGV4OiBrZXJu
ZWwtb21hcDMvYXJjaC9hcm0vbWFjaC1vbWFwMi9NYWtlZmlsZQo9PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09Ci0tLSBrZXJu
ZWwtb21hcDMub3JpZy9hcmNoL2FybS9tYWNoLW9tYXAyL01ha2VmaWxlCTIwMDktMDgtMjUgMTk6
NDg6MzkuMDAwMDAwMDAwICswNTMwCisrKyBrZXJuZWwtb21hcDMvYXJjaC9hcm0vbWFjaC1vbWFw
Mi9NYWtlZmlsZQkyMDA5LTA4LTI1IDE5OjUyOjI2LjAwMDAwMDAwMCArMDUzMApAQCAtNTUsNiAr
NTUsNyBAQAogb2JqLSQoQ09ORklHX01BQ0hfT01BUDNfQkVBR0xFKQkJKz0gYm9hcmQtb21hcDNi
ZWFnbGUubyBcCiAJCQkJCSAgIG1tYy10d2w0MDMwLm8KIG9iai0kKENPTkZJR19NQUNIX09NQVBf
TERQKQkJKz0gYm9hcmQtbGRwLm8gXAorCQkJCQkgICBib2FyZC1sZHAtZmxhc2gubyBcCiAJCQkJ
CSAgIG1tYy10d2w0MDMwLm8gXAogCQkJCQkgICBib2FyZC1sZHAtY2FtZXJhLm8KIG9iai0kKENP
TkZJR19NQUNIX09WRVJPKQkJKz0gYm9hcmQtb3Zlcm8ubyBcCkBAIC03MSw2ICs3Miw3IEBACiAJ
CQkJCSAgIGJvYXJkLXJ4NTEtcGVyaXBoZXJhbHMubyBcCiAJCQkJCSAgIG1tYy10d2w0MDMwLm8K
IG9iai0kKENPTkZJR19NQUNIX09NQVBfWk9PTTIpCQkrPSBib2FyZC16b29tMi5vIFwKKwkJCQkJ
ICAgYm9hcmQtbGRwLWZsYXNoLm8gXAogCQkJCQkgICBtbWMtdHdsNDAzMC5vIFwKIAkJCQkJICAg
Ym9hcmQtem9vbS1kZWJ1Z2JvYXJkLm8KIApJbmRleDoga2VybmVsLW9tYXAzL2FyY2gvYXJtL21h
Y2gtb21hcDIvYm9hcmQtbGRwLWZsYXNoLmMKPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQotLS0gL2Rldi9udWxsCTE5NzAt
MDEtMDEgMDA6MDA6MDAuMDAwMDAwMDAwICswMDAwCisrKyBrZXJuZWwtb21hcDMvYXJjaC9hcm0v
bWFjaC1vbWFwMi9ib2FyZC1sZHAtZmxhc2guYwkyMDA5LTA4LTI1IDE5OjUwOjA1LjAwMDAwMDAw
MCArMDUzMApAQCAtMCwwICsxLDE5NSBAQAorLyoKKyAqIGxpbnV4L2FyY2gvYXJtL21hY2gtb21h
cDIvYm9hcmQtbGRwLWZsYXNoLmMKKyAqCisgKiBDb3B5cmlnaHQgKEMpIDIwMDggVGV4YXMgSW5z
dHJ1bWVudHMgSW5jLgorICoKKyAqIE1vZGlmaWVkIGZyb20gbWFjaC1vbWFwMi9ib2FyZC0yNDMw
c2RwLWZsYXNoLmMKKyAqIEF1dGhvcjogUm9oaXQgQ2hvcmFyaWEgPHJvaGl0a2NAdGkuY29tPgor
ICoKKyAqIFRoaXMgcHJvZ3JhbSBpcyBmcmVlIHNvZnR3YXJlOyB5b3UgY2FuIHJlZGlzdHJpYnV0
ZSBpdCBhbmQvb3IgbW9kaWZ5CisgKiBpdCB1bmRlciB0aGUgdGVybXMgb2YgdGhlIEdOVSBHZW5l
cmFsIFB1YmxpYyBMaWNlbnNlIHZlcnNpb24gMiBhcworICogcHVibGlzaGVkIGJ5IHRoZSBGcmVl
IFNvZnR3YXJlIEZvdW5kYXRpb24uCisgKi8KKworI2luY2x1ZGUgPGxpbnV4L2tlcm5lbC5oPgor
I2luY2x1ZGUgPGxpbnV4L2RlbGF5Lmg+CisjaW5jbHVkZSA8bGludXgvcGxhdGZvcm1fZGV2aWNl
Lmg+CisjaW5jbHVkZSA8bGludXgvbXRkL210ZC5oPgorI2luY2x1ZGUgPGxpbnV4L210ZC9wYXJ0
aXRpb25zLmg+CisjaW5jbHVkZSA8bGludXgvbXRkL25hbmQuaD4KKyNpbmNsdWRlIDxsaW51eC90
eXBlcy5oPgorI2luY2x1ZGUgPGxpbnV4L2lvLmg+CisKKyNpbmNsdWRlIDxhc20vbWFjaC9mbGFz
aC5oPgorI2luY2x1ZGUgPG1hY2gvYm9hcmQuaD4KKyNpbmNsdWRlIDxtYWNoL2dwbWMuaD4KKyNp
bmNsdWRlIDxtYWNoL25hbmQuaD4KKworI2luY2x1ZGUgPG1hY2gvYm9hcmQtbGRwLmg+CisKKyNk
ZWZpbmUgTkFORF9DTURfVU5MT0NLMQkweDIzCisjZGVmaW5lIE5BTkRfQ01EX1VOTE9DSzIJMHgy
NAorLyoqCisgKiBAYnJpZWYgcGxhdGZvcm0gc3BlY2lmaWMgdW5sb2NrIGZ1bmN0aW9uCisgKgor
ICogQHBhcmFtIG10ZCAtIG10ZCBpbmZvCisgKiBAcGFyYW0gb2ZzIC0gb2Zmc2V0IHRvIHN0YXJ0
IHVubG9jayBmcm9tCisgKiBAcGFyYW0gbGVuIC0gbGVuZ3RoIHRvIHVubG9jaworICoKKyAqIEBy
ZXR1cm4gLSB1bmxvY2sgc3RhdHVzCisgKi8KK3N0YXRpYyBpbnQgb21hcF9sZHBfbmFuZF91bmxv
Y2soc3RydWN0IG10ZF9pbmZvICptdGQsIGxvZmZfdCBvZnMsIHNpemVfdCBsZW4pCit7CisJaW50
IHJldCA9IDA7CisJaW50IGNoaXBucjsKKwlpbnQgc3RhdHVzOworCXVuc2lnbmVkIGxvbmcgcGFn
ZTsKKwlzdHJ1Y3QgbmFuZF9jaGlwICp0aGlzID0gbXRkLT5wcml2OworCXByaW50ayhLRVJOX0lO
Rk8gIm5hbmRfdW5sb2NrOiBzdGFydDogJTA4eCwgbGVuZ3RoOiAlZCFcbiIsCisJCQkoaW50KW9m
cywgKGludClsZW4pOworCisJLyogc2VsZWN0IHRoZSBOQU5EIGRldmljZSAqLworCWNoaXBuciA9
IChpbnQpKG9mcyA+PiB0aGlzLT5jaGlwX3NoaWZ0KTsKKwl0aGlzLT5zZWxlY3RfY2hpcChtdGQs
IGNoaXBucik7CisJLyogY2hlY2sgdGhlIFdQIGJpdCAqLworCXRoaXMtPmNtZGZ1bmMobXRkLCBO
QU5EX0NNRF9TVEFUVVMsIC0xLCAtMSk7CisJaWYgKCh0aGlzLT5yZWFkX2J5dGUobXRkKSAmIDB4
ODApID09IDApIHsKKwkJcHJpbnRrKEtFUk5fRVJSICJuYW5kX3VubG9jazogRGV2aWNlIGlzIHdy
aXRlIHByb3RlY3RlZCFcbiIpOworCQlyZXQgPSAtRUlOVkFMOworCQlnb3RvIG91dDsKKwl9CisK
KwlpZiAoKG9mcyAmIChtdGQtPndyaXRlc2l6ZSAtIDEpKSAhPSAwKSB7CisJCXByaW50ayhLRVJO
X0VSUiAibmFuZF91bmxvY2s6IFN0YXJ0IGFkZHJlc3MgbXVzdCBiZSIKKwkJCQkiYmVnaW5uaW5n
IG9mIG5hbmQgcGFnZSFcbiIpOworCQlyZXQgPSAtRUlOVkFMOworCQlnb3RvIG91dDsKKwl9CisK
KwlpZiAobGVuID09IDAgfHwgKGxlbiAmIChtdGQtPndyaXRlc2l6ZSAtIDEpKSAhPSAwKSB7CisJ
CXByaW50ayhLRVJOX0VSUiAibmFuZF91bmxvY2s6IExlbmd0aCBtdXN0IGJlIGEgbXVsdGlwbGUg
b2YgIgorCQkJCSJuYW5kIHBhZ2Ugc2l6ZSFcbiIpOworCQlyZXQgPSAtRUlOVkFMOworCQlnb3Rv
IG91dDsKKwl9CisKKwkvKiBzdWJtaXQgYWRkcmVzcyBvZiBmaXJzdCBwYWdlIHRvIHVubG9jayAq
LworCXBhZ2UgPSAodW5zaWduZWQgbG9uZykob2ZzID4+IHRoaXMtPnBhZ2Vfc2hpZnQpOworCXRo
aXMtPmNtZGZ1bmMobXRkLCBOQU5EX0NNRF9VTkxPQ0sxLCAtMSwgcGFnZSAmIHRoaXMtPnBhZ2Vt
YXNrKTsKKworCS8qIHN1Ym1pdCBBRERSRVNTIG9mIExBU1QgcGFnZSB0byB1bmxvY2sgKi8KKwlw
YWdlICs9ICh1bnNpZ25lZCBsb25nKSgob2ZzICsgbGVuKSA+PiB0aGlzLT5wYWdlX3NoaWZ0KSA7
CisJdGhpcy0+Y21kZnVuYyhtdGQsIE5BTkRfQ01EX1VOTE9DSzIsIC0xLCBwYWdlICYgdGhpcy0+
cGFnZW1hc2spOworCisJLyogY2FsbCB3YWl0IHJlYWR5IGZ1bmN0aW9uICovCisJc3RhdHVzID0g
dGhpcy0+d2FpdGZ1bmMobXRkLCB0aGlzKTsKKwl1ZGVsYXkoMTAwMCk7CisJLyogc2VlIGlmIGRl
dmljZSB0aGlua3MgaXQgc3VjY2VlZGVkICovCisJaWYgKHN0YXR1cyAmIDB4MDEpIHsKKwkJLyog
dGhlcmUgd2FzIGFuIGVycm9yICovCisJCXByaW50ayhLRVJOX0VSUiAibmFuZF91bmxvY2s6IGVy
cm9yIHN0YXR1cyA9MHglMDh4ICIsIHN0YXR1cyk7CisJCXJldCA9IC1FSU87CisJCWdvdG8gb3V0
OworCX0KKworIG91dDoKKwkvKiBkZS1zZWxlY3QgdGhlIE5BTkQgZGV2aWNlICovCisJdGhpcy0+
c2VsZWN0X2NoaXAobXRkLCAtMSk7CisJcmV0dXJuIHJldDsKK30KKworc3RhdGljIHN0cnVjdCBt
dGRfcGFydGl0aW9uIGxkcF9uYW5kX3BhcnRpdGlvbnNbXSA9IHsKKwkvKiBBbGwgdGhlIHBhcnRp
dGlvbiBzaXplcyBhcmUgbGlzdGVkIGluIHRlcm1zIG9mIE5BTkQgYmxvY2sgc2l6ZSAqLworCXsK
KwkJLm5hbWUJCT0gIlgtTG9hZGVyLU5BTkQiLAorCQkub2Zmc2V0CQk9IDAsCisJCS5zaXplCQk9
IDQgKiAoNjQgKiAyMDQ4KSwJLyogNTEyS0IsIDB4ODAwMDAgKi8KKwkJLm1hc2tfZmxhZ3MJPSBN
VERfV1JJVEVBQkxFLAkvKiBmb3JjZSByZWFkLW9ubHkgKi8KKwl9LAorCXsKKwkJLm5hbWUJCT0g
IlUtQm9vdC1OQU5EIiwKKwkJLm9mZnNldAkJPSBNVERQQVJUX09GU19BUFBFTkQsCS8qIE9mZnNl
dCA9IDB4ODAwMDAgKi8KKwkJLnNpemUJCT0gMTAgKiAoNjQgKiAyMDQ4KSwJLyogMS4yNU1CLCAw
eDE0MDAwMCAqLworCQkubWFza19mbGFncwk9IE1URF9XUklURUFCTEUsCS8qIGZvcmNlIHJlYWQt
b25seSAqLworCX0sCisJeworCQkubmFtZQkJPSAiQm9vdCBFbnYtTkFORCIsCisJCS5vZmZzZXQJ
CT0gTVREUEFSVF9PRlNfQVBQRU5ELCAgIC8qIE9mZnNldCA9IDB4MWMwMDAwICovCisJCS5zaXpl
CQk9IDIgKiAoNjQgKiAyMDQ4KSwJLyogMjU2S0IsIDB4NDAwMDAgKi8KKwl9LAorCXsKKwkJLm5h
bWUJCT0gIktlcm5lbC1OQU5EIiwKKwkJLm9mZnNldAkJPSBNVERQQVJUX09GU19BUFBFTkQsCS8q
IE9mZnNldCA9IDB4MDIwMDAwMCovCisJCS5zaXplCQk9IDI0MCAqICg2NCAqIDIwNDgpLAkvKiAz
ME0sIDB4MUUwMDAwMCAqLworCX0sCisjaWZkZWYgQ09ORklHX01BQ0hfT01BUF9aT09NMgorCXsK
KwkJLm5hbWUJCT0gInN5c3RlbSIsCisJCS5vZmZzZXQJCT0gTVREUEFSVF9PRlNfQVBQRU5ELAkv
KiBPZmZzZXQgPSAweDIwMDAwMDAgKi8KKwkJLnNpemUJCT0gMTI4MCAqICg2NCAqIDIwNDgpLCAg
IC8qIDE2ME0sIDB4QTAwMDAwMCAqLworCX0sCisJeworCQkubmFtZQkJPSAidXNlcmRhdGEiLAor
CQkub2Zmc2V0CQk9IE1URFBBUlRfT0ZTX0FQUEVORCwJLyogT2Zmc2V0ID0gMHhDMDAwMDAwICov
CisJCS5zaXplCQk9IDI1NiAqICg2NCAqIDIwNDgpLAkvKiAzMk0sIDB4MjAwMDAwMCAqLworIAl9
LAorCXsKKwkJLm5hbWUJCT0gImNhY2hlIiwKKwkJLm9mZnNldAkJPSBNVERQQVJUX09GU19BUFBF
TkQsCS8qIE9mZnNldCA9IDB4RTAwMDAwMCAqLworCQkuc2l6ZQkJPSAyNTYgKiAoNjQgKiAyMDQ4
KSwJLyogMzJNLCAweDIwMDAwMDAgKi8KKyAJfSwKKyNlbHNlCisJeworCQkubmFtZQkJPSAiRmls
ZSBTeXN0ZW0gLSBOQU5EIiwKKwkJLm9mZnNldAkJPSBNVERQQVJUX09GU19BUFBFTkQsCS8qIE9m
ZnNldCA9IDB4MjAwMDAwMCAqLworCQkuc2l6ZQkJPSBNVERQQVJUX1NJWl9GVUxMLAkvKiA5Nk1C
LCAweDYwMDAwMDAgKi8KKwl9LAorI2VuZGlmCit9OworCisvKiBOQU5EIGNoaXAgYWNjZXNzOiAx
NiBiaXQgKi8KK3N0YXRpYyBzdHJ1Y3Qgb21hcF9uYW5kX3BsYXRmb3JtX2RhdGEgbGRwX25hbmRf
ZGF0YSA9IHsKKwkucGFydHMJCT0gbGRwX25hbmRfcGFydGl0aW9ucywKKwkubnJfcGFydHMJPSBB
UlJBWV9TSVpFKGxkcF9uYW5kX3BhcnRpdGlvbnMpLAorCS5uYW5kX3NldHVwCT0gTlVMTCwKKwku
ZG1hX2NoYW5uZWwJPSAtMSwJCS8qIGRpc2FibGUgRE1BIGluIE9NQVAgTkFORCBkcml2ZXIgKi8K
KwkuZGV2X3JlYWR5CT0gTlVMTCwKKwkudW5sb2NrCQk9IG9tYXBfbGRwX25hbmRfdW5sb2NrLAor
fTsKKworc3RhdGljIHN0cnVjdCByZXNvdXJjZSBsZHBfbmFuZF9yZXNvdXJjZSA9IHsKKwkuZmxh
Z3MJCT0gSU9SRVNPVVJDRV9NRU0sCit9OworCitzdGF0aWMgc3RydWN0IHBsYXRmb3JtX2Rldmlj
ZSBsZHBfbmFuZF9kZXZpY2UgPSB7CisJLm5hbWUJCT0gIm9tYXAyLW5hbmQiLAorCS5pZAkJPSAw
LAorCS5kZXYJCT0geworCS5wbGF0Zm9ybV9kYXRhCT0gJmxkcF9uYW5kX2RhdGEsCisJfSwKKwku
bnVtX3Jlc291cmNlcwk9IDEsCisJLnJlc291cmNlCT0gJmxkcF9uYW5kX3Jlc291cmNlLAorfTsK
KworLyoqCisgKiBsZHA0MzBfZmxhc2hfaW5pdCAtIElkZW50aWZ5IGRldmljZXMgY29ubmVjdGVk
IHRvIEdQTUMgYW5kIHJlZ2lzdGVyLgorICoKKyAqIEByZXR1cm4gLSB2b2lkLgorICovCit2b2lk
IF9faW5pdCBsZHBfZmxhc2hfaW5pdCh2b2lkKQoreworCXU4IG5hbmRjcyA9IEdQTUNfQ1NfTlVN
ICsgMTsKKwl1MzIgZ3BtY19iYXNlX2FkZCA9IE9NQVAzNFhYX0dQTUNfVklSVDsKKworCS8qIHBv
cCBuYW5kIHBhcnQgKi8KKwluYW5kY3MgPSBMRFAzNDMwX05BTkRfQ1M7CisKKwlsZHBfbmFuZF9k
YXRhLmNzID0gbmFuZGNzOworCWxkcF9uYW5kX2RhdGEuZ3BtY19jc19iYXNlYWRkciA9ICh2b2lk
ICopKGdwbWNfYmFzZV9hZGQgKworCQkJCQlHUE1DX0NTMF9CQVNFICsgbmFuZGNzICogR1BNQ19D
U19TSVpFKTsKKwlsZHBfbmFuZF9kYXRhLmdwbWNfYmFzZWFkZHIgPSAodm9pZCAqKSAoZ3BtY19i
YXNlX2FkZCk7CisKKwlpZiAocGxhdGZvcm1fZGV2aWNlX3JlZ2lzdGVyKCZsZHBfbmFuZF9kZXZp
Y2UpIDwgMCkKKwkJcHJpbnRrKEtFUk5fRVJSICJVbmFibGUgdG8gcmVnaXN0ZXIgTkFORCBkZXZp
Y2VcbiIpOworfQorCkluZGV4OiBrZXJuZWwtb21hcDMvYXJjaC9hcm0vbWFjaC1vbWFwMi9ib2Fy
ZC1sZHAuYwo9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09Ci0tLSBrZXJuZWwtb21hcDMub3JpZy9hcmNoL2FybS9tYWNoLW9t
YXAyL2JvYXJkLWxkcC5jCTIwMDktMDgtMjUgMTk6NDg6MzkuMDAwMDAwMDAwICswNTMwCisrKyBr
ZXJuZWwtb21hcDMvYXJjaC9hcm0vbWFjaC1vbWFwMi9ib2FyZC1sZHAuYwkyMDA5LTA4LTI1IDE5
OjUwOjA1LjAwMDAwMDAwMCArMDUzMApAQCAtNDIsNiArNDIsNyBAQAogI2luY2x1ZGUgPG1hY2gv
Y29udHJvbC5oPgogI2luY2x1ZGUgPG1hY2gvdXNiLmg+CiAjaW5jbHVkZSA8bWFjaC9rZXlwYWQu
aD4KKyNpbmNsdWRlIDxtYWNoL2JvYXJkLWxkcC5oPgogCiAjaW5jbHVkZSAibW1jLXR3bDQwMzAu
aCIKIApAQCAtNDA0LDYgKzQwNSw3IEBACiAJYWRzNzg0Nl9kZXZfaW5pdCgpOwogCW9tYXBfc2Vy
aWFsX2luaXQoJmxkcF91YXJ0X2NvbmZpZyk7CiAJdXNiX211c2JfaW5pdCgpOworCWxkcF9mbGFz
aF9pbml0KCk7CiAKIAl0d2w0MDMwX21tY19pbml0KG1tYyk7CiAJLyogbGluayByZWd1bGF0b3Jz
IHRvIE1NQyBhZGFwdGVycyAqLwpJbmRleDoga2VybmVsLW9tYXAzL2FyY2gvYXJtL21hY2gtb21h
cDIvYm9hcmQtem9vbTIuYwo9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09Ci0tLSBrZXJuZWwtb21hcDMub3JpZy9hcmNoL2Fy
bS9tYWNoLW9tYXAyL2JvYXJkLXpvb20yLmMJMjAwOS0wOC0yNSAxOTo0ODozOS4wMDAwMDAwMDAg
KzA1MzAKKysrIGtlcm5lbC1vbWFwMy9hcmNoL2FybS9tYWNoLW9tYXAyL2JvYXJkLXpvb20yLmMJ
MjAwOS0wOC0yNSAxOTo1MDowNS4wMDAwMDAwMDAgKzA1MzAKQEAgLTIyLDYgKzIyLDcgQEAKICNp
bmNsdWRlIDxhc20vbWFjaC9hcmNoLmg+CiAjaW5jbHVkZSA8YXNtL21hY2gvbWFwLmg+CiAKKyNp
bmNsdWRlIDxtYWNoL2JvYXJkLWxkcC5oPgogI2luY2x1ZGUgPG1hY2gvY29tbW9uLmg+CiAjaW5j
bHVkZSA8bWFjaC91c2IuaD4KICNpbmNsdWRlIDxtYWNoL2tleXBhZC5oPgpAQCAtMjc3LDYgKzI3
OCw3IEBACiAJb21hcF9zZXJpYWxfaW5pdCgmem9vbTJfdWFydF9jb25maWcpOwogCW9tYXBfem9v
bTJfZGVidWdib2FyZF9pbml0KCk7CiAJdXNiX211c2JfaW5pdCgpOworCWxkcF9mbGFzaF9pbml0
KCk7CiB9CiAKIHN0YXRpYyBzdHJ1Y3QgbWFwX2Rlc2Mgem9vbTJfaW9fZGVzY1tdIF9faW5pdGRh
dGEgPSB7CkluZGV4OiBrZXJuZWwtb21hcDMvYXJjaC9hcm0vcGxhdC1vbWFwL2luY2x1ZGUvbWFj
aC9ib2FyZC1sZHAuaAo9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09Ci0tLSAvZGV2L251bGwJMTk3MC0wMS0wMSAwMDowMDow
MC4wMDAwMDAwMDAgKzAwMDAKKysrIGtlcm5lbC1vbWFwMy9hcmNoL2FybS9wbGF0LW9tYXAvaW5j
bHVkZS9tYWNoL2JvYXJkLWxkcC5oCTIwMDktMDgtMjUgMTk6NTA6MDUuMDAwMDAwMDAwICswNTMw
CkBAIC0wLDAgKzEsMzYgQEAKKy8qCisgKiBhcmNoL2FybS9wbGF0LW9tYXAvaW5jbHVkZS9tYWNo
L2JvYXJkLWxkcC5oCisgKgorICogSGFyZHdhcmUgZGVmaW5pdGlvbnMgZm9yIFRJIE9NQVAzIExE
UC4KKyAqCisgKiBDb3B5cmlnaHQgKEMpIDIwMDggVGV4YXMgSW5zdHJ1bWVudHMgSW5jLgorICoK
KyAqIFRoaXMgcHJvZ3JhbSBpcyBmcmVlIHNvZnR3YXJlOyB5b3UgY2FuIHJlZGlzdHJpYnV0ZSBp
dCBhbmQvb3IgbW9kaWZ5IGl0CisgKiB1bmRlciB0aGUgdGVybXMgb2YgdGhlIEdOVSBHZW5lcmFs
IFB1YmxpYyBMaWNlbnNlIGFzIHB1Ymxpc2hlZCBieSB0aGUKKyAqIEZyZWUgU29mdHdhcmUgRm91
bmRhdGlvbjsgZWl0aGVyIHZlcnNpb24gMiBvZiB0aGUgTGljZW5zZSwgb3IgKGF0IHlvdXIKKyAq
IG9wdGlvbikgYW55IGxhdGVyIHZlcnNpb24uCisgKgorICogVEhJUyBTT0ZUV0FSRSBJUyBQUk9W
SURFRCBgYEFTIElTJycgQU5EIEFOWSBFWFBSRVNTIE9SIElNUExJRUQKKyAqIFdBUlJBTlRJRVMs
IElOQ0xVRElORywgQlVUIE5PVCBMSU1JVEVEIFRPLCBUSEUgSU1QTElFRCBXQVJSQU5USUVTIE9G
CisgKiBNRVJDSEFOVEFCSUxJVFkgQU5EIEZJVE5FU1MgRk9SIEEgUEFSVElDVUxBUiBQVVJQT1NF
IEFSRSBESVNDTEFJTUVELiBJTgorICogTk8gRVZFTlQgU0hBTEwgVEhFIEFVVEhPUiBCRSBMSUFC
TEUgRk9SIEFOWSBESVJFQ1QsIElORElSRUNULAorICogSU5DSURFTlRBTCwgU1BFQ0lBTCwgRVhF
TVBMQVJZLCBPUiBDT05TRVFVRU5USUFMIERBTUFHRVMgKElOQ0xVRElORywgQlVUCisgKiBOT1Qg
TElNSVRFRCBUTywgUFJPQ1VSRU1FTlQgT0YgU1VCU1RJVFVURSBHT09EUyBPUiBTRVJWSUNFUzsg
TE9TUyBPRgorICogVVNFLCBEQVRBLCBPUiBQUk9GSVRTOyBPUiBCVVNJTkVTUyBJTlRFUlJVUFRJ
T04pIEhPV0VWRVIgQ0FVU0VEIEFORCBPTgorICogQU5ZIFRIRU9SWSBPRiBMSUFCSUxJVFksIFdI
RVRIRVIgSU4gQ09OVFJBQ1QsIFNUUklDVCBMSUFCSUxJVFksIE9SIFRPUlQKKyAqIChJTkNMVURJ
TkcgTkVHTElHRU5DRSBPUiBPVEhFUldJU0UpIEFSSVNJTkcgSU4gQU5ZIFdBWSBPVVQgT0YgVEhF
IFVTRSBPRgorICogVEhJUyBTT0ZUV0FSRSwgRVZFTiBJRiBBRFZJU0VEIE9GIFRIRSBQT1NTSUJJ
TElUWSBPRiBTVUNIIERBTUFHRS4KKyAqCisgKiBZb3Ugc2hvdWxkIGhhdmUgcmVjZWl2ZWQgYSBj
b3B5IG9mIHRoZSBHTlUgR2VuZXJhbCBQdWJsaWMgTGljZW5zZSBhbG9uZworICogd2l0aCB0aGlz
IHByb2dyYW07IGlmIG5vdCwgd3JpdGUgdG8gdGhlIEZyZWUgU29mdHdhcmUgRm91bmRhdGlvbiwg
SW5jLiwKKyAqIDY3NSBNYXNzIEF2ZSwgQ2FtYnJpZGdlLCBNQSAwMjEzOSwgVVNBLgorICovCisK
KyNpZm5kZWYgX19BU01fQVJDSF9PTUFQX0xEUF9ICisjZGVmaW5lIF9fQVNNX0FSQ0hfT01BUF9M
RFBfSAorCitleHRlcm4gdm9pZCBsZHBfZmxhc2hfaW5pdCh2b2lkKTsKKworI2RlZmluZSBMRFAz
NDMwX05BTkRfQ1MgICAgICAgICAgICAgICAwCisKKyNlbmRpZiAvKiBfX0FTTV9BUkNIX09NQVBf
TERQX0ggKi8KSW5kZXg6IGtlcm5lbC1vbWFwMy9hcmNoL2FybS9wbGF0LW9tYXAvaW5jbHVkZS9t
YWNoL2dwbWMuaAo9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09Ci0tLSBrZXJuZWwtb21hcDMub3JpZy9hcmNoL2FybS9wbGF0
LW9tYXAvaW5jbHVkZS9tYWNoL2dwbWMuaAkyMDA5LTA4LTI1IDE5OjU3OjM1LjAwMDAwMDAwMCAr
MDUzMAorKysga2VybmVsLW9tYXAzL2FyY2gvYXJtL3BsYXQtb21hcC9pbmNsdWRlL21hY2gvZ3Bt
Yy5oCTIwMDktMDgtMjUgMTk6NTg6MjQuMDAwMDAwMDAwICswNTMwCkBAIC0yNyw2ICsyNyw4IEBA
CiAKICNkZWZpbmUgR1BNQ19DT05GSUcJCTB4NTAKICNkZWZpbmUgR1BNQ19TVEFUVVMJCTB4NTQK
KyNkZWZpbmUgR1BNQ19DUzBfQkFTRQkJMHg2MAorI2RlZmluZSBHUE1DX0NTX1NJWkUJCTB4MzAK
IAogI2RlZmluZSBHUE1DX0NPTkZJRzFfV1JBUEJVUlNUX1NVUFAgICAgICgxIDw8IDMxKQogI2Rl
ZmluZSBHUE1DX0NPTkZJRzFfUkVBRE1VTFRJUExFX1NVUFAgICgxIDw8IDMwKQpJbmRleDoga2Vy
bmVsLW9tYXAzL2FyY2gvYXJtL3BsYXQtb21hcC9pbmNsdWRlL21hY2gvbmFuZC5oCj09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT0KLS0tIGtlcm5lbC1vbWFwMy5vcmlnL2FyY2gvYXJtL3BsYXQtb21hcC9pbmNsdWRlL21hY2gv
bmFuZC5oCTIwMDktMDgtMjUgMTk6NDg6MzkuMDAwMDAwMDAwICswNTMwCisrKyBrZXJuZWwtb21h
cDMvYXJjaC9hcm0vcGxhdC1vbWFwL2luY2x1ZGUvbWFjaC9uYW5kLmgJMjAwOS0wOC0yNSAxOTo1
MDowNS4wMDAwMDAwMDAgKzA1MzAKQEAgLTE4LDYgKzE4LDcgQEAKIAlpbnQJCQlucl9wYXJ0czsK
IAlpbnQJCQkoKm5hbmRfc2V0dXApKHZvaWQgX19pb21lbSAqKTsKIAlpbnQJCQkoKmRldl9yZWFk
eSkoc3RydWN0IG9tYXBfbmFuZF9wbGF0Zm9ybV9kYXRhICopOworCWludAkJCSgqdW5sb2NrKShz
dHJ1Y3QgbXRkX2luZm8gKiwgbG9mZl90LCBzaXplX3QpOwogCWludAkJCWRtYV9jaGFubmVsOwog
CXZvaWQgX19pb21lbQkJKmdwbWNfY3NfYmFzZWFkZHI7CiAJdm9pZCBfX2lvbWVtCQkqZ3BtY19i
YXNlYWRkcjsK

--_002_FCCFB4CDC6E5564B9182F639FC35608702F9A44CDFdbde02enttico_--
