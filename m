From: vimal singh <vimal.newwork@gmail.com>
Subject: Re: [PATCH] OMAP3: Zoom2: provide default MTD partitions
Date: Thu, 27 Aug 2009 19:33:12 +0530
Message-ID: <ce9ab5790908270703o2ffd4b32kce208b87d3e69044@mail.gmail.com>
References: <1251374386-6733-1-git-send-email-mpetazzoni@mvista.com>
	<FCCFB4CDC6E5564B9182F639FC35608702F9A44CDF@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=001636b42ebd638a95047220080f
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yw0-f184.google.com ([209.85.211.184]:35889 "EHLO
	mail-yw0-f184.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751058AbZH0ODb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 27 Aug 2009 10:03:31 -0400
Received: by ywh14 with SMTP id 14so1440144ywh.1
        for <linux-omap@vger.kernel.org>; Thu, 27 Aug 2009 07:03:32 -0700 (PDT)
In-Reply-To: <FCCFB4CDC6E5564B9182F639FC35608702F9A44CDF@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pandita, Vikram" <vikram.pandita@ti.com>
Cc: Maxime Petazzoni <mpetazzoni@mvista.com>, "Singh, Vimal" <IMCEAEX-_O=TI_OU=BD_cn=Recipients_cn=x0094262@dlee86.itg.ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Rix, Tom" <trix@ti.com>

--001636b42ebd638a95047220080f
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Aug 27, 2009 at 7:16 PM, Pandita, Vikram<vikram.pandita@ti.com> wro=
te:
> Petazzoni/Vimal
>
>>-----Original Message-----
>>From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger.kern=
el.org] On Behalf Of Maxime
>>Petazzoni
>>Sent: Thursday, August 27, 2009 7:00 AM
>>To: linux-omap@vger.kernel.org
>>Subject: [PATCH] OMAP3: Zoom2: provide default MTD partitions
>>
>>This change introduces default MTD partitions for the Zoom-II board
>>NAND, inspired by the OMAP3 Beagle partitions and the OMAP3 Zoom2
>>partitions defined in OmapZoom.org's OMAP kernel.
>
> Thanks for putting this together for zoom2, however I NAK for now.
>
> Why?
>
> I know of an implementation by Vimal Singh that introduces a common flash=
 file for Zoom1 and Zoom2.
> There is reuse of code there.
>
> I have attached the patch by Vimal here (in-lining would be difficult)

I am attaching an updated patch, which is prepared on top of the patch
which I submitted for flash supports for OMAP2/3 SDP board:
http://marc.info/?l=3Dlinux-omap&m=3D125065707704826&w=3D2

-vimal

>
> Please discuss and get a converged approach on handling NAND partitions o=
n Zoom1 and Zoom2.
>
> Also the Systerm/User/Cache partition definitions are more from Android p=
erspective.
>
> Given that each system may have a different NAND partition requirement,
> have you looked at bootargs passing the MTD partition info: Eg:
>
> mtdparts=3Domap2-nand.0:512k@0(xloader),\
> 1536k@512k(bootloader),\
> 29m@2m(kernel),\
> 160m@32m(system),\
> 32m@192m(userdata),\
> 32m@224m(cache)
>
>
> Lets discuss the final approach on this list and try to close this soon.
>
> Thnx
>
>>
>>The size of the U-Boot environment partition was increased to 1MB, as
>>the previously smaller partition couldn't contain the U-Boot environment
>>correctly (erasing the next partition would erase the U-Boot env as
>>well).
>>
>>Finally, the "system" partition gets an increased size of 256MB to take
>>advantage of the size of the flash on the Zoom-II board.
>>
>>Signed-off-by: Maxime Petazzoni <mpetazzoni@mvista.com>
>>---
>> arch/arm/mach-omap2/board-zoom2.c | =A0 86 +++++++++++++++++++++++++++++=
++++++++
>> 1 files changed, 86 insertions(+), 0 deletions(-)
>>
>>diff --git a/arch/arm/mach-omap2/board-zoom2.c b/arch/arm/mach-omap2/boar=
d-zoom2.c
>>index 4d295d5..ce5a4d8 100644
>>--- a/arch/arm/mach-omap2/board-zoom2.c
>>+++ b/arch/arm/mach-omap2/board-zoom2.c
>>@@ -16,16 +16,101 @@
>> #include <linux/gpio.h>
>> #include <linux/i2c/twl4030.h>
>> #include <linux/regulator/machine.h>
>>+#include <linux/mtd/mtd.h>
>>+#include <linux/mtd/partitions.h>
>>+#include <linux/mtd/nand.h>
>>
>> #include <asm/mach-types.h>
>> #include <asm/mach/arch.h>
>>
>> #include <mach/common.h>
>>+#include <mach/nand.h>
>> #include <mach/usb.h>
>> #include <mach/keypad.h>
>>
>> #include "mmc-twl4030.h"
>>
>>+#define LDP3430_NAND_CS =A0 =A0 =A0 0
>>+#define GPMC_CS0_BASE 0x60
>>+#define GPMC_CS_SIZE =A00x30
>>+
>>+static struct mtd_partition zoom2_nand_partitions[] =3D {
>>+ =A0 =A0 =A0{
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0.name =A0 =A0 =A0 =A0 =A0 =3D "X-Loader-NAND=
",
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0.offset =A0 =A0 =A0 =A0 =3D 0,
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0.size =A0 =A0 =A0 =A0 =A0 =3D 4 * (64 * 2048=
), =A0 =A0 =A0/* 512kB */
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0.mask_flags =A0 =A0 =3D MTD_WRITEABLE, =A0 =
=A0 =A0 =A0/* force read-only */
>>+ =A0 =A0 =A0},
>>+ =A0 =A0 =A0{
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0.name =A0 =A0 =A0 =A0 =A0 =3D "U-Boot-NAND",
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0.offset =A0 =A0 =A0 =A0 =3D MTDPART_OFS_APPE=
ND, =A0 /* Offset =3D 0x80000 */
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0.size =A0 =A0 =A0 =A0 =A0 =3D 4 * (64 * 2048=
), =A0 =A0 =A0/* 512kB */
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0.mask_flags =A0 =A0 =3D MTD_WRITEABLE, =A0 =
=A0 =A0 =A0/* force read-only */
>>+ =A0 =A0 =A0},
>>+ =A0 =A0 =A0{
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0.name =A0 =A0 =A0 =A0 =A0 =3D "Boot Env-NAND=
",
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0.offset =A0 =A0 =A0 =A0 =3D MTDPART_OFS_APPE=
ND, =A0 /* Offset =3D 0x100000 */
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0.size =A0 =A0 =A0 =A0 =A0 =3D 8 * (64 * 2048=
), =A0 =A0 =A0/* 1MB */
>>+ =A0 =A0 =A0},
>>+ =A0 =A0 =A0{
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0.name =A0 =A0 =A0 =A0 =A0 =3D "Kernel-NAND",
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0.offset =A0 =A0 =A0 =A0 =3D MTDPART_OFS_APPE=
ND, =A0 /* Offset =3D 0x200000 */
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0.size =A0 =A0 =A0 =A0 =A0 =3D 32 * (64 * 204=
8), =A0 =A0 /* 4MB */
>>+ =A0 =A0 =A0},
>>+ =A0 =A0 =A0{
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0.name =A0 =A0 =A0 =A0 =A0 =3D "system",
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0.offset =A0 =A0 =A0 =A0 =3D MTDPART_OFS_APPE=
ND, =A0 /* Offset =3D 0x600000 */
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0.size =A0 =A0 =A0 =A0 =A0 =3D 2048 * (64 * 2=
048), =A0 /* 256MB */
>>+ =A0 =A0 =A0},
>>+ =A0 =A0 =A0{
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0.name =A0 =A0 =A0 =A0 =A0 =3D "userdata",
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0.offset =A0 =A0 =A0 =A0 =3D MTDPART_OFS_APPE=
ND, =A0 /* Offset =3D 0x10600000 */
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0.size =A0 =A0 =A0 =A0 =A0 =3D 512 * (64 * 20=
48), =A0 =A0/* 64MB */
>>+ =A0 =A0 =A0},
>>+ =A0 =A0 =A0{
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0.name =A0 =A0 =A0 =A0 =A0 =3D "cache",
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0.offset =A0 =A0 =A0 =A0 =3D MTDPART_OFS_APPE=
ND, =A0 /* Offset =3D 0x14600000 */
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0.size =A0 =A0 =A0 =A0 =A0 =3D 512 * (64 * 20=
48), =A0 =A0/* 64MB */
>>+ =A0 =A0 =A0},
>>+};
>>+
>>+/* NAND chip access: 16 bit */
>>+static struct omap_nand_platform_data zoom2_nand_data =3D {
>>+ =A0 =A0 =A0.parts =A0 =A0 =A0 =A0 =A0=3D zoom2_nand_partitions,
>>+ =A0 =A0 =A0.nr_parts =A0 =A0 =A0 =3D ARRAY_SIZE(zoom2_nand_partitions),
>>+ =A0 =A0 =A0.nand_setup =A0 =A0 =3D NULL,
>>+ =A0 =A0 =A0.dma_channel =A0 =A0=3D -1, =A0 =A0 =A0 =A0 =A0 /* disable D=
MA in OMAP NAND driver */
>>+ =A0 =A0 =A0.dev_ready =A0 =A0 =A0=3D NULL,
>>+};
>>+
>>+static struct resource zoom2_nand_resource =3D {
>>+ =A0 =A0 =A0.flags =A0 =A0 =A0 =A0 =A0=3D IORESOURCE_MEM,
>>+};
>>+
>>+static struct platform_device zoom2_nand_device =3D {
>>+ =A0 =A0 =A0.name =A0 =A0 =A0 =A0 =A0 =3D "omap2-nand",
>>+ =A0 =A0 =A0.id =A0 =A0 =A0 =A0 =A0 =A0 =3D 0,
>>+ =A0 =A0 =A0.dev =A0 =A0 =A0 =A0 =A0 =A0=3D {
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0.platform_data =3D &zoom2_nand_data,
>>+ =A0 =A0 =A0},
>>+ =A0 =A0 =A0.num_resources =A0=3D 1,
>>+ =A0 =A0 =A0.resource =A0 =A0 =A0 =3D &zoom2_nand_resource,
>>+};
>>+
>>+static void __init zoom2_flash_init(void)
>>+{
>>+ =A0 =A0 =A0u8 nandcs =3D LDP3430_NAND_CS;
>>+ =A0 =A0 =A0u32 gpmc_base_add =3D OMAP34XX_GPMC_VIRT;
>>+
>>+ =A0 =A0 =A0zoom2_nand_data.cs =3D nandcs;
>>+ =A0 =A0 =A0zoom2_nand_data.gpmc_cs_baseaddr =3D (void *)(gpmc_base_add =
+
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0GPMC_CS0_BASE + nandcs * GPM=
C_CS_SIZE);
>>+ =A0 =A0 =A0zoom2_nand_data.gpmc_baseaddr =3D (void *) (gpmc_base_add);
>>+
>>+ =A0 =A0 =A0if (platform_device_register(&zoom2_nand_device) < 0)
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0printk(KERN_ERR "Unable to register NAND dev=
ice!\n");
>>+}
>>+
>> /* Zoom2 has Qwerty keyboard*/
>> static int zoom2_twl4030_keymap[] =3D {
>> =A0 =A0 =A0 KEY(0, 0, KEY_E),
>>@@ -271,6 +356,7 @@ static void __init omap_zoom2_init(void)
>> =A0 =A0 =A0 omap_serial_init(&zoom2_uart_config);
>> =A0 =A0 =A0 omap_zoom2_debugboard_init();
>> =A0 =A0 =A0 usb_musb_init();
>>+ =A0 =A0 =A0zoom2_flash_init();
>> }
>>
>> static void __init omap_zoom2_map_io(void)
>>--
>>1.6.3.3.210.g29cb3
>>
>>--
>>To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>>the body of a message to majordomo@vger.kernel.org
>>More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
>

--001636b42ebd638a95047220080f
Content-Type: application/octet-stream; name="add_nand_support_zoom2.patch"
Content-Disposition: attachment; filename="add_nand_support_zoom2.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fyvke4z01

LS0tCiBhcmNoL2FybS9tYWNoLW9tYXAyL01ha2VmaWxlICAgICAgICAgICAgICAgIHwgICAgMiAK
IGFyY2gvYXJtL21hY2gtb21hcDIvYm9hcmQtbGRwLWZsYXNoLmMgICAgICAgfCAgMTk2ICsrKysr
KysrKysrKysrKysrKysrKysrKysrKysKIGFyY2gvYXJtL21hY2gtb21hcDIvYm9hcmQtbGRwLmMg
ICAgICAgICAgICAgfCAgICAyIAogYXJjaC9hcm0vbWFjaC1vbWFwMi9ib2FyZC16b29tMi5jICAg
ICAgICAgICB8ICAgIDIgCiBhcmNoL2FybS9wbGF0LW9tYXAvaW5jbHVkZS9tYWNoL2JvYXJkLWxk
cC5oIHwgICAzNiArKysrKwogYXJjaC9hcm0vcGxhdC1vbWFwL2luY2x1ZGUvbWFjaC9uYW5kLmgg
ICAgICB8ICAgIDEgCiA2IGZpbGVzIGNoYW5nZWQsIDIzOSBpbnNlcnRpb25zKCspCgpJbmRleDog
bGludXgtb21hcC0yLjYvYXJjaC9hcm0vbWFjaC1vbWFwMi9NYWtlZmlsZQo9PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09Ci0t
LSBsaW51eC1vbWFwLTIuNi5vcmlnL2FyY2gvYXJtL21hY2gtb21hcDIvTWFrZWZpbGUKKysrIGxp
bnV4LW9tYXAtMi42L2FyY2gvYXJtL21hY2gtb21hcDIvTWFrZWZpbGUKQEAgLTU0LDYgKzU0LDcg
QEAgb2JqLSQoQ09ORklHX01BQ0hfT01BUF9BUE9MTE9OKQkJKz0gYm9hcgogb2JqLSQoQ09ORklH
X01BQ0hfT01BUDNfQkVBR0xFKQkJKz0gYm9hcmQtb21hcDNiZWFnbGUubyBcCiAJCQkJCSAgIG1t
Yy10d2w0MDMwLm8KIG9iai0kKENPTkZJR19NQUNIX09NQVBfTERQKQkJKz0gYm9hcmQtbGRwLm8g
XAorCQkJCQkgICBib2FyZC1sZHAtZmxhc2gubyBcCiAJCQkJCSAgIG1tYy10d2w0MDMwLm8KIG9i
ai0kKENPTkZJR19NQUNIX09WRVJPKQkJKz0gYm9hcmQtb3Zlcm8ubyBcCiAJCQkJCSAgIG1tYy10
d2w0MDMwLm8KQEAgLTY5LDYgKzcwLDcgQEAgb2JqLSQoQ09ORklHX01BQ0hfTk9LSUFfUlg1MSkJ
CSs9IGJvYXJkLQogCQkJCQkgICBib2FyZC1yeDUxLXBlcmlwaGVyYWxzLm8gXAogCQkJCQkgICBt
bWMtdHdsNDAzMC5vCiBvYmotJChDT05GSUdfTUFDSF9PTUFQX1pPT00yKQkJKz0gYm9hcmQtem9v
bTIubyBcCisJCQkJCSAgIGJvYXJkLWxkcC1mbGFzaC5vIFwKIAkJCQkJICAgbW1jLXR3bDQwMzAu
byBcCiAJCQkJCSAgIGJvYXJkLXpvb20tZGVidWdib2FyZC5vCiAKSW5kZXg6IGxpbnV4LW9tYXAt
Mi42L2FyY2gvYXJtL21hY2gtb21hcDIvYm9hcmQtbGRwLWZsYXNoLmMKPT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQotLS0g
L2Rldi9udWxsCisrKyBsaW51eC1vbWFwLTIuNi9hcmNoL2FybS9tYWNoLW9tYXAyL2JvYXJkLWxk
cC1mbGFzaC5jCkBAIC0wLDAgKzEsMTk2IEBACisvKgorICogYXJjaC9hcm0vbWFjaC1vbWFwMi9i
b2FyZC1sZHAtZmxhc2guYworICoKKyAqIENvcHlyaWdodCAoQykgMjAwOC0wOSBUZXhhcyBJbnN0
cnVtZW50cyBJbmMuCisgKgorICogTW9kaWZpZWQgZnJvbSBtYWNoLW9tYXAyL2JvYXJkLTI0MzBz
ZHAtZmxhc2guYworICogQXV0aG9yKHMpOiBSb2hpdCBDaG9yYXJpYSA8cm9oaXRrY0B0aS5jb20+
CisgKiAgICAgICAgICAgIFZpbWFsIFNpbmdoIDx2aW1hbHNpbmdoQHRpLmNvbT4KKyAqCisgKiBU
aGlzIHByb2dyYW0gaXMgZnJlZSBzb2Z0d2FyZTsgeW91IGNhbiByZWRpc3RyaWJ1dGUgaXQgYW5k
L29yIG1vZGlmeQorICogaXQgdW5kZXIgdGhlIHRlcm1zIG9mIHRoZSBHTlUgR2VuZXJhbCBQdWJs
aWMgTGljZW5zZSB2ZXJzaW9uIDIgYXMKKyAqIHB1Ymxpc2hlZCBieSB0aGUgRnJlZSBTb2Z0d2Fy
ZSBGb3VuZGF0aW9uLgorICovCisKKyNpbmNsdWRlIDxsaW51eC9rZXJuZWwuaD4KKyNpbmNsdWRl
IDxsaW51eC9kZWxheS5oPgorI2luY2x1ZGUgPGxpbnV4L3BsYXRmb3JtX2RldmljZS5oPgorI2lu
Y2x1ZGUgPGxpbnV4L210ZC9tdGQuaD4KKyNpbmNsdWRlIDxsaW51eC9tdGQvcGFydGl0aW9ucy5o
PgorI2luY2x1ZGUgPGxpbnV4L210ZC9uYW5kLmg+CisjaW5jbHVkZSA8bGludXgvdHlwZXMuaD4K
KyNpbmNsdWRlIDxsaW51eC9pby5oPgorCisjaW5jbHVkZSA8YXNtL21hY2gvZmxhc2guaD4KKyNp
bmNsdWRlIDxtYWNoL2JvYXJkLmg+CisjaW5jbHVkZSA8bWFjaC9ncG1jLmg+CisjaW5jbHVkZSA8
bWFjaC9uYW5kLmg+CisKKyNpbmNsdWRlIDxtYWNoL2JvYXJkLWxkcC5oPgorCisjZGVmaW5lIE5B
TkRfQ01EX1VOTE9DSzEJMHgyMworI2RlZmluZSBOQU5EX0NNRF9VTkxPQ0syCTB4MjQKKy8qKgor
ICogQGJyaWVmIHBsYXRmb3JtIHNwZWNpZmljIHVubG9jayBmdW5jdGlvbgorICoKKyAqIEBwYXJh
bSBtdGQgLSBtdGQgaW5mbworICogQHBhcmFtIG9mcyAtIG9mZnNldCB0byBzdGFydCB1bmxvY2sg
ZnJvbQorICogQHBhcmFtIGxlbiAtIGxlbmd0aCB0byB1bmxvY2sKKyAqCisgKiBAcmV0dXJuIC0g
dW5sb2NrIHN0YXR1cworICovCitzdGF0aWMgaW50IG9tYXBfbGRwX25hbmRfdW5sb2NrKHN0cnVj
dCBtdGRfaW5mbyAqbXRkLCBsb2ZmX3Qgb2ZzLCBzaXplX3QgbGVuKQoreworCWludCByZXQgPSAw
OworCWludCBjaGlwbnI7CisJaW50IHN0YXR1czsKKwl1bnNpZ25lZCBsb25nIHBhZ2U7CisJc3Ry
dWN0IG5hbmRfY2hpcCAqdGhpcyA9IG10ZC0+cHJpdjsKKwlwcmludGsoS0VSTl9JTkZPICJuYW5k
X3VubG9jazogc3RhcnQ6ICUwOHgsIGxlbmd0aDogJWQhXG4iLAorCQkJKGludClvZnMsIChpbnQp
bGVuKTsKKworCS8qIHNlbGVjdCB0aGUgTkFORCBkZXZpY2UgKi8KKwljaGlwbnIgPSAoaW50KShv
ZnMgPj4gdGhpcy0+Y2hpcF9zaGlmdCk7CisJdGhpcy0+c2VsZWN0X2NoaXAobXRkLCBjaGlwbnIp
OworCS8qIGNoZWNrIHRoZSBXUCBiaXQgKi8KKwl0aGlzLT5jbWRmdW5jKG10ZCwgTkFORF9DTURf
U1RBVFVTLCAtMSwgLTEpOworCWlmICgodGhpcy0+cmVhZF9ieXRlKG10ZCkgJiAweDgwKSA9PSAw
KSB7CisJCXByaW50ayhLRVJOX0VSUiAibmFuZF91bmxvY2s6IERldmljZSBpcyB3cml0ZSBwcm90
ZWN0ZWQhXG4iKTsKKwkJcmV0ID0gLUVJTlZBTDsKKwkJZ290byBvdXQ7CisJfQorCisJaWYgKChv
ZnMgJiAobXRkLT53cml0ZXNpemUgLSAxKSkgIT0gMCkgeworCQlwcmludGsoS0VSTl9FUlIgIm5h
bmRfdW5sb2NrOiBTdGFydCBhZGRyZXNzIG11c3QgYmUiCisJCQkJImJlZ2lubmluZyBvZiBuYW5k
IHBhZ2UhXG4iKTsKKwkJcmV0ID0gLUVJTlZBTDsKKwkJZ290byBvdXQ7CisJfQorCisJaWYgKGxl
biA9PSAwIHx8IChsZW4gJiAobXRkLT53cml0ZXNpemUgLSAxKSkgIT0gMCkgeworCQlwcmludGso
S0VSTl9FUlIgIm5hbmRfdW5sb2NrOiBMZW5ndGggbXVzdCBiZSBhIG11bHRpcGxlIG9mICIKKwkJ
CQkibmFuZCBwYWdlIHNpemUhXG4iKTsKKwkJcmV0ID0gLUVJTlZBTDsKKwkJZ290byBvdXQ7CisJ
fQorCisJLyogc3VibWl0IGFkZHJlc3Mgb2YgZmlyc3QgcGFnZSB0byB1bmxvY2sgKi8KKwlwYWdl
ID0gKHVuc2lnbmVkIGxvbmcpKG9mcyA+PiB0aGlzLT5wYWdlX3NoaWZ0KTsKKwl0aGlzLT5jbWRm
dW5jKG10ZCwgTkFORF9DTURfVU5MT0NLMSwgLTEsIHBhZ2UgJiB0aGlzLT5wYWdlbWFzayk7CisK
KwkvKiBzdWJtaXQgQUREUkVTUyBvZiBMQVNUIHBhZ2UgdG8gdW5sb2NrICovCisJcGFnZSArPSAo
dW5zaWduZWQgbG9uZykoKG9mcyArIGxlbikgPj4gdGhpcy0+cGFnZV9zaGlmdCkgOworCXRoaXMt
PmNtZGZ1bmMobXRkLCBOQU5EX0NNRF9VTkxPQ0syLCAtMSwgcGFnZSAmIHRoaXMtPnBhZ2VtYXNr
KTsKKworCS8qIGNhbGwgd2FpdCByZWFkeSBmdW5jdGlvbiAqLworCXN0YXR1cyA9IHRoaXMtPndh
aXRmdW5jKG10ZCwgdGhpcyk7CisJdWRlbGF5KDEwMDApOworCS8qIHNlZSBpZiBkZXZpY2UgdGhp
bmtzIGl0IHN1Y2NlZWRlZCAqLworCWlmIChzdGF0dXMgJiAweDAxKSB7CisJCS8qIHRoZXJlIHdh
cyBhbiBlcnJvciAqLworCQlwcmludGsoS0VSTl9FUlIgIm5hbmRfdW5sb2NrOiBlcnJvciBzdGF0
dXMgPTB4JTA4eCAiLCBzdGF0dXMpOworCQlyZXQgPSAtRUlPOworCQlnb3RvIG91dDsKKwl9CisK
KyBvdXQ6CisJLyogZGUtc2VsZWN0IHRoZSBOQU5EIGRldmljZSAqLworCXRoaXMtPnNlbGVjdF9j
aGlwKG10ZCwgLTEpOworCXJldHVybiByZXQ7Cit9CisKK3N0YXRpYyBzdHJ1Y3QgbXRkX3BhcnRp
dGlvbiBsZHBfbmFuZF9wYXJ0aXRpb25zW10gPSB7CisJLyogQWxsIHRoZSBwYXJ0aXRpb24gc2l6
ZXMgYXJlIGxpc3RlZCBpbiB0ZXJtcyBvZiBOQU5EIGJsb2NrIHNpemUgKi8KKwl7CisJCS5uYW1l
CQk9ICJYLUxvYWRlci1OQU5EIiwKKwkJLm9mZnNldAkJPSAwLAorCQkuc2l6ZQkJPSA0ICogKDY0
ICogMjA0OCksCS8qIDUxMktCLCAweDgwMDAwICovCisJCS5tYXNrX2ZsYWdzCT0gTVREX1dSSVRF
QUJMRSwJLyogZm9yY2UgcmVhZC1vbmx5ICovCisJfSwKKwl7CisJCS5uYW1lCQk9ICJVLUJvb3Qt
TkFORCIsCisJCS5vZmZzZXQJCT0gTVREUEFSVF9PRlNfQVBQRU5ELAkvKiBPZmZzZXQgPSAweDgw
MDAwICovCisJCS5zaXplCQk9IDEwICogKDY0ICogMjA0OCksCS8qIDEuMjVNQiwgMHgxNDAwMDAg
Ki8KKwkJLm1hc2tfZmxhZ3MJPSBNVERfV1JJVEVBQkxFLAkvKiBmb3JjZSByZWFkLW9ubHkgKi8K
Kwl9LAorCXsKKwkJLm5hbWUJCT0gIkJvb3QgRW52LU5BTkQiLAorCQkub2Zmc2V0CQk9IE1URFBB
UlRfT0ZTX0FQUEVORCwgICAvKiBPZmZzZXQgPSAweDFjMDAwMCAqLworCQkuc2l6ZQkJPSAyICog
KDY0ICogMjA0OCksCS8qIDI1NktCLCAweDQwMDAwICovCisJfSwKKwl7CisJCS5uYW1lCQk9ICJL
ZXJuZWwtTkFORCIsCisJCS5vZmZzZXQJCT0gTVREUEFSVF9PRlNfQVBQRU5ELAkvKiBPZmZzZXQg
PSAweDAyMDAwMDAqLworCQkuc2l6ZQkJPSAyNDAgKiAoNjQgKiAyMDQ4KSwJLyogMzBNLCAweDFF
MDAwMDAgKi8KKwl9LAorI2lmZGVmIENPTkZJR19NQUNIX09NQVBfWk9PTTIKKwl7CisJCS5uYW1l
CQk9ICJzeXN0ZW0iLAorCQkub2Zmc2V0CQk9IE1URFBBUlRfT0ZTX0FQUEVORCwJLyogT2Zmc2V0
ID0gMHgyMDAwMDAwICovCisJCS5zaXplCQk9IDEyODAgKiAoNjQgKiAyMDQ4KSwgICAvKiAxNjBN
LCAweEEwMDAwMDAgKi8KKwl9LAorCXsKKwkJLm5hbWUJCT0gInVzZXJkYXRhIiwKKwkJLm9mZnNl
dAkJPSBNVERQQVJUX09GU19BUFBFTkQsCS8qIE9mZnNldCA9IDB4QzAwMDAwMCAqLworCQkuc2l6
ZQkJPSAyNTYgKiAoNjQgKiAyMDQ4KSwJLyogMzJNLCAweDIwMDAwMDAgKi8KKwl9LAorCXsKKwkJ
Lm5hbWUJCT0gImNhY2hlIiwKKwkJLm9mZnNldAkJPSBNVERQQVJUX09GU19BUFBFTkQsCS8qIE9m
ZnNldCA9IDB4RTAwMDAwMCAqLworCQkuc2l6ZQkJPSAyNTYgKiAoNjQgKiAyMDQ4KSwJLyogMzJN
LCAweDIwMDAwMDAgKi8KKwl9LAorI2Vsc2UKKwl7CisJCS5uYW1lCQk9ICJGaWxlIFN5c3RlbSAt
IE5BTkQiLAorCQkub2Zmc2V0CQk9IE1URFBBUlRfT0ZTX0FQUEVORCwJLyogT2Zmc2V0ID0gMHgy
MDAwMDAwICovCisJCS5zaXplCQk9IE1URFBBUlRfU0laX0ZVTEwsCS8qIDk2TUIsIDB4NjAwMDAw
MCAqLworCX0sCisjZW5kaWYKK307CisKKy8qIE5BTkQgY2hpcCBhY2Nlc3M6IDE2IGJpdCAqLwor
c3RhdGljIHN0cnVjdCBvbWFwX25hbmRfcGxhdGZvcm1fZGF0YSBsZHBfbmFuZF9kYXRhID0gewor
CS5wYXJ0cwkJPSBsZHBfbmFuZF9wYXJ0aXRpb25zLAorCS5ucl9wYXJ0cwk9IEFSUkFZX1NJWkUo
bGRwX25hbmRfcGFydGl0aW9ucyksCisJLm5hbmRfc2V0dXAJPSBOVUxMLAorCS5kbWFfY2hhbm5l
bAk9IC0xLAkJLyogZGlzYWJsZSBETUEgaW4gT01BUCBOQU5EIGRyaXZlciAqLworCS5kZXZfcmVh
ZHkJPSBOVUxMLAorCS51bmxvY2sJCT0gb21hcF9sZHBfbmFuZF91bmxvY2ssCit9OworCitzdGF0
aWMgc3RydWN0IHJlc291cmNlIGxkcF9uYW5kX3Jlc291cmNlID0geworCS5mbGFncwkJPSBJT1JF
U09VUkNFX01FTSwKK307CisKK3N0YXRpYyBzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlIGxkcF9uYW5k
X2RldmljZSA9IHsKKwkubmFtZQkJPSAib21hcDItbmFuZCIsCisJLmlkCQk9IDAsCisJLmRldgkJ
PSB7CisJLnBsYXRmb3JtX2RhdGEJPSAmbGRwX25hbmRfZGF0YSwKKwl9LAorCS5udW1fcmVzb3Vy
Y2VzCT0gMSwKKwkucmVzb3VyY2UJPSAmbGRwX25hbmRfcmVzb3VyY2UsCit9OworCisvKioKKyAq
IGxkcDQzMF9mbGFzaF9pbml0IC0gSWRlbnRpZnkgZGV2aWNlcyBjb25uZWN0ZWQgdG8gR1BNQyBh
bmQgcmVnaXN0ZXIuCisgKgorICogQHJldHVybiAtIHZvaWQuCisgKi8KK3ZvaWQgX19pbml0IGxk
cF9mbGFzaF9pbml0KHZvaWQpCit7CisJdTggbmFuZGNzID0gR1BNQ19DU19OVU0gKyAxOworCXUz
MiBncG1jX2Jhc2VfYWRkID0gT01BUDM0WFhfR1BNQ19WSVJUOworCisJLyogcG9wIG5hbmQgcGFy
dCAqLworCW5hbmRjcyA9IExEUDM0MzBfTkFORF9DUzsKKworCWxkcF9uYW5kX2RhdGEuY3MgPSBu
YW5kY3M7CisJbGRwX25hbmRfZGF0YS5ncG1jX2NzX2Jhc2VhZGRyID0gKHZvaWQgKikoZ3BtY19i
YXNlX2FkZCArCisJCQkJCUdQTUNfQ1MwX0JBU0UgKyBuYW5kY3MgKiBHUE1DX0NTX1NJWkUpOwor
CWxkcF9uYW5kX2RhdGEuZ3BtY19iYXNlYWRkciA9ICh2b2lkICopIChncG1jX2Jhc2VfYWRkKTsK
KworCWlmIChwbGF0Zm9ybV9kZXZpY2VfcmVnaXN0ZXIoJmxkcF9uYW5kX2RldmljZSkgPCAwKQor
CQlwcmludGsoS0VSTl9FUlIgIlVuYWJsZSB0byByZWdpc3RlciBOQU5EIGRldmljZVxuIik7Cit9
CisKSW5kZXg6IGxpbnV4LW9tYXAtMi42L2FyY2gvYXJtL21hY2gtb21hcDIvYm9hcmQtbGRwLmMK
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PQotLS0gbGludXgtb21hcC0yLjYub3JpZy9hcmNoL2FybS9tYWNoLW9tYXAyL2Jv
YXJkLWxkcC5jCisrKyBsaW51eC1vbWFwLTIuNi9hcmNoL2FybS9tYWNoLW9tYXAyL2JvYXJkLWxk
cC5jCkBAIC00Miw2ICs0Miw3IEBACiAjaW5jbHVkZSA8bWFjaC9jb250cm9sLmg+CiAjaW5jbHVk
ZSA8bWFjaC91c2IuaD4KICNpbmNsdWRlIDxtYWNoL2tleXBhZC5oPgorI2luY2x1ZGUgPG1hY2gv
Ym9hcmQtbGRwLmg+CiAKICNpbmNsdWRlICJtbWMtdHdsNDAzMC5oIgogCkBAIC0zODUsNiArMzg2
LDcgQEAgc3RhdGljIHZvaWQgX19pbml0IG9tYXBfbGRwX2luaXQodm9pZCkKIAlhZHM3ODQ2X2Rl
dl9pbml0KCk7CiAJb21hcF9zZXJpYWxfaW5pdCgmbGRwX3VhcnRfY29uZmlnKTsKIAl1c2JfbXVz
Yl9pbml0KCk7CisJbGRwX2ZsYXNoX2luaXQoKTsKIAogCXR3bDQwMzBfbW1jX2luaXQobW1jKTsK
IAkvKiBsaW5rIHJlZ3VsYXRvcnMgdG8gTU1DIGFkYXB0ZXJzICovCkluZGV4OiBsaW51eC1vbWFw
LTIuNi9hcmNoL2FybS9tYWNoLW9tYXAyL2JvYXJkLXpvb20yLmMKPT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQotLS0gbGlu
dXgtb21hcC0yLjYub3JpZy9hcmNoL2FybS9tYWNoLW9tYXAyL2JvYXJkLXpvb20yLmMKKysrIGxp
bnV4LW9tYXAtMi42L2FyY2gvYXJtL21hY2gtb21hcDIvYm9hcmQtem9vbTIuYwpAQCAtMjAsNiAr
MjAsNyBAQAogI2luY2x1ZGUgPGFzbS9tYWNoLXR5cGVzLmg+CiAjaW5jbHVkZSA8YXNtL21hY2gv
YXJjaC5oPgogCisjaW5jbHVkZSA8bWFjaC9ib2FyZC1sZHAuaD4KICNpbmNsdWRlIDxtYWNoL2Nv
bW1vbi5oPgogI2luY2x1ZGUgPG1hY2gvdXNiLmg+CiAjaW5jbHVkZSA8bWFjaC9rZXlwYWQuaD4K
QEAgLTI3MSw2ICsyNzIsNyBAQCBzdGF0aWMgdm9pZCBfX2luaXQgb21hcF96b29tMl9pbml0KHZv
aWQpCiAJb21hcF9zZXJpYWxfaW5pdCgmem9vbTJfdWFydF9jb25maWcpOwogCW9tYXBfem9vbTJf
ZGVidWdib2FyZF9pbml0KCk7CiAJdXNiX211c2JfaW5pdCgpOworCWxkcF9mbGFzaF9pbml0KCk7
CiB9CiAKIHN0YXRpYyB2b2lkIF9faW5pdCBvbWFwX3pvb20yX21hcF9pbyh2b2lkKQpJbmRleDog
bGludXgtb21hcC0yLjYvYXJjaC9hcm0vcGxhdC1vbWFwL2luY2x1ZGUvbWFjaC9ib2FyZC1sZHAu
aAo9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09Ci0tLSAvZGV2L251bGwKKysrIGxpbnV4LW9tYXAtMi42L2FyY2gvYXJtL3Bs
YXQtb21hcC9pbmNsdWRlL21hY2gvYm9hcmQtbGRwLmgKQEAgLTAsMCArMSwzNiBAQAorLyoKKyAq
IGFyY2gvYXJtL3BsYXQtb21hcC9pbmNsdWRlL21hY2gvYm9hcmQtbGRwLmgKKyAqCisgKiBIYXJk
d2FyZSBkZWZpbml0aW9ucyBmb3IgVEkgT01BUDMgTERQL1pPT00yLgorICoKKyAqIENvcHlyaWdo
dCAoQykgMjAwOC0wOSBUZXhhcyBJbnN0cnVtZW50cyBJbmMuCisgKgorICogVGhpcyBwcm9ncmFt
IGlzIGZyZWUgc29mdHdhcmU7IHlvdSBjYW4gcmVkaXN0cmlidXRlIGl0IGFuZC9vciBtb2RpZnkg
aXQKKyAqIHVuZGVyIHRoZSB0ZXJtcyBvZiB0aGUgR05VIEdlbmVyYWwgUHVibGljIExpY2Vuc2Ug
YXMgcHVibGlzaGVkIGJ5IHRoZQorICogRnJlZSBTb2Z0d2FyZSBGb3VuZGF0aW9uOyBlaXRoZXIg
dmVyc2lvbiAyIG9mIHRoZSBMaWNlbnNlLCBvciAoYXQgeW91cgorICogb3B0aW9uKSBhbnkgbGF0
ZXIgdmVyc2lvbi4KKyAqCisgKiBUSElTIFNPRlRXQVJFIElTIFBST1ZJREVEIGBgQVMgSVMnJyBB
TkQgQU5ZIEVYUFJFU1MgT1IgSU1QTElFRAorICogV0FSUkFOVElFUywgSU5DTFVESU5HLCBCVVQg
Tk9UIExJTUlURUQgVE8sIFRIRSBJTVBMSUVEIFdBUlJBTlRJRVMgT0YKKyAqIE1FUkNIQU5UQUJJ
TElUWSBBTkQgRklUTkVTUyBGT1IgQSBQQVJUSUNVTEFSIFBVUlBPU0UgQVJFIERJU0NMQUlNRUQu
IElOCisgKiBOTyBFVkVOVCBTSEFMTCBUSEUgQVVUSE9SIEJFIExJQUJMRSBGT1IgQU5ZIERJUkVD
VCwgSU5ESVJFQ1QsCisgKiBJTkNJREVOVEFMLCBTUEVDSUFMLCBFWEVNUExBUlksIE9SIENPTlNF
UVVFTlRJQUwgREFNQUdFUyAoSU5DTFVESU5HLCBCVVQKKyAqIE5PVCBMSU1JVEVEIFRPLCBQUk9D
VVJFTUVOVCBPRiBTVUJTVElUVVRFIEdPT0RTIE9SIFNFUlZJQ0VTOyBMT1NTIE9GCisgKiBVU0Us
IERBVEEsIE9SIFBST0ZJVFM7IE9SIEJVU0lORVNTIElOVEVSUlVQVElPTikgSE9XRVZFUiBDQVVT
RUQgQU5EIE9OCisgKiBBTlkgVEhFT1JZIE9GIExJQUJJTElUWSwgV0hFVEhFUiBJTiBDT05UUkFD
VCwgU1RSSUNUIExJQUJJTElUWSwgT1IgVE9SVAorICogKElOQ0xVRElORyBORUdMSUdFTkNFIE9S
IE9USEVSV0lTRSkgQVJJU0lORyBJTiBBTlkgV0FZIE9VVCBPRiBUSEUgVVNFIE9GCisgKiBUSElT
IFNPRlRXQVJFLCBFVkVOIElGIEFEVklTRUQgT0YgVEhFIFBPU1NJQklMSVRZIE9GIFNVQ0ggREFN
QUdFLgorICoKKyAqIFlvdSBzaG91bGQgaGF2ZSByZWNlaXZlZCBhIGNvcHkgb2YgdGhlIEdOVSBH
ZW5lcmFsIFB1YmxpYyBMaWNlbnNlIGFsb25nCisgKiB3aXRoIHRoaXMgcHJvZ3JhbTsgaWYgbm90
LCB3cml0ZSB0byB0aGUgRnJlZSBTb2Z0d2FyZSBGb3VuZGF0aW9uLCBJbmMuLAorICogNjc1IE1h
c3MgQXZlLCBDYW1icmlkZ2UsIE1BIDAyMTM5LCBVU0EuCisgKi8KKworI2lmbmRlZiBfX0FTTV9B
UkNIX09NQVBfTERQX0gKKyNkZWZpbmUgX19BU01fQVJDSF9PTUFQX0xEUF9ICisKK2V4dGVybiB2
b2lkIGxkcF9mbGFzaF9pbml0KHZvaWQpOworCisjZGVmaW5lIExEUDM0MzBfTkFORF9DUyAgICAg
ICAgICAgICAgIDAKKworI2VuZGlmIC8qIF9fQVNNX0FSQ0hfT01BUF9MRFBfSCAqLwpJbmRleDog
bGludXgtb21hcC0yLjYvYXJjaC9hcm0vcGxhdC1vbWFwL2luY2x1ZGUvbWFjaC9uYW5kLmgKPT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PQotLS0gbGludXgtb21hcC0yLjYub3JpZy9hcmNoL2FybS9wbGF0LW9tYXAvaW5jbHVk
ZS9tYWNoL25hbmQuaAorKysgbGludXgtb21hcC0yLjYvYXJjaC9hcm0vcGxhdC1vbWFwL2luY2x1
ZGUvbWFjaC9uYW5kLmgKQEAgLTE4LDYgKzE4LDcgQEAgc3RydWN0IG9tYXBfbmFuZF9wbGF0Zm9y
bV9kYXRhIHsKIAlpbnQJCQlucl9wYXJ0czsKIAlpbnQJCQkoKm5hbmRfc2V0dXApKHZvaWQgX19p
b21lbSAqKTsKIAlpbnQJCQkoKmRldl9yZWFkeSkoc3RydWN0IG9tYXBfbmFuZF9wbGF0Zm9ybV9k
YXRhICopOworCWludAkJCSgqdW5sb2NrKShzdHJ1Y3QgbXRkX2luZm8gKiwgbG9mZl90LCBzaXpl
X3QpOwogCWludAkJCWRtYV9jaGFubmVsOwogCXZvaWQgX19pb21lbQkJKmdwbWNfY3NfYmFzZWFk
ZHI7CiAJdm9pZCBfX2lvbWVtCQkqZ3BtY19iYXNlYWRkcjsK
--001636b42ebd638a95047220080f--
