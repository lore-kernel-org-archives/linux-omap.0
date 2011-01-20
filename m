From: Vimal Singh <vimal.newwork@gmail.com>
Subject: Re: [PATCH] omap3: nand: bch ecc support added
Date: Thu, 20 Jan 2011 20:47:25 +0530
Message-ID: <AANLkTin3pRkqLkQ_J1iTtqr0M+iz5V25S9ZwJc9+T0VW@mail.gmail.com>
References: <1295518680-8737-1-git-send-email-s-ghorai@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:57088 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755760Ab1ATPRp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 20 Jan 2011 10:17:45 -0500
Received: by pva4 with SMTP id 4so113584pva.19
        for <linux-omap@vger.kernel.org>; Thu, 20 Jan 2011 07:17:45 -0800 (PST)
In-Reply-To: <1295518680-8737-1-git-send-email-s-ghorai@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sukumar Ghorai <s-ghorai@ti.com>
Cc: linux-omap@vger.kernel.org, linux-mtd@lists.infradead.org, linux-arm-kernel@lists.infradead.org, "Kamat, Nishant" <nskamat@ti.com>

Hi Ghorai,

I am the initial author of this patch. And I guess this patch still
uses most of my work.


Thanks and Regards,
Vimal

On Thu, Jan 20, 2011 at 3:48 PM, Sukumar Ghorai <s-ghorai@ti.com> wrote=
:
> bch error correction (t=3D4 and t=3D8) for 512 bytes support added.
> Tested in omap-3630 es-1.1 silicon.
>
> Need to select the bch-ecc from board file. E.g.
> arch/arm/mach-omap2/board-flash.c: board_nand_init()
> board_nand_data.ecc_opt =3D OMAP_ECC_BCH4_CODE_HW
>
> This patch has dependency on -
> http://www.mail-archive.com/linux-omap@vger.kernel.org/msg42658.html
>
> Signed-off-by: Sukumar Ghorai <s-ghorai@ti.com>
> ---
> =A0arch/arm/mach-omap2/gpmc.c =A0 =A0 =A0 =A0 =A0 =A0 | =A0126 ++++++=
++---
> =A0arch/arm/plat-omap/include/plat/gpmc.h | =A0 =A06 +-
> =A0drivers/mtd/nand/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A01 +
> =A0drivers/mtd/nand/omap2.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0119 ++++=
++++--
> =A0drivers/mtd/nand/omap_bch_decoder.c =A0 =A0| =A0393 ++++++++++++++=
++++++++++++++++++
> =A05 files changed, 583 insertions(+), 62 deletions(-)
> =A0create mode 100644 drivers/mtd/nand/omap_bch_decoder.c
>
> diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
> index 29c9732..91cfdca 100644
> --- a/arch/arm/mach-omap2/gpmc.c
> +++ b/arch/arm/mach-omap2/gpmc.c
> @@ -48,6 +48,7 @@
> =A0#define GPMC_ECC_CONTROL =A0 =A0 =A0 0x1f8
> =A0#define GPMC_ECC_SIZE_CONFIG =A0 0x1fc
> =A0#define GPMC_ECC1_RESULT =A0 =A0 =A0 =A00x200
> +#define GPMC_ECC_BCH_RESULT_0 =A00x240
>
> =A0#define GPMC_CS0_OFFSET =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x60
> =A0#define GPMC_CS_SIZE =A0 =A0 =A0 =A0 =A0 0x30
> @@ -94,7 +95,6 @@ static struct resource =A0 =A0 =A0 =A0gpmc_mem_root=
;
> =A0static struct resource gpmc_cs_mem[GPMC_CS_NUM];
> =A0static DEFINE_SPINLOCK(gpmc_mem_lock);
> =A0static unsigned int gpmc_cs_map; =A0 =A0 =A0 /* flag for cs which =
are initialized */
> -static int gpmc_ecc_used =3D -EINVAL; =A0 =A0/* cs using ecc engine =
*/
>
> =A0static void __iomem *gpmc_base;
>
> @@ -832,52 +832,77 @@ void omap3_gpmc_restore_context(void)
>
> =A0/**
> =A0* gpmc_enable_hwecc - enable hardware ecc functionality
> + * @ecc_type: ecc type e.g. Hamming, BCH
> =A0* @cs: chip select number
> =A0* @mode: read/write mode
> =A0* @dev_width: device bus width(1 for x16, 0 for x8)
> =A0* @ecc_size: bytes for which ECC will be generated
> =A0*/
> -int gpmc_enable_hwecc(int cs, int mode, int dev_width, int ecc_size)
> +int gpmc_enable_hwecc(int ecc_type, int cs, int mode,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int dev_width, int ecc_=
size)
> =A0{
> - =A0 =A0 =A0 unsigned int val;
> -
> - =A0 =A0 =A0 /* check if ecc module is in used */
> - =A0 =A0 =A0 if (gpmc_ecc_used !=3D -EINVAL)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> -
> - =A0 =A0 =A0 gpmc_ecc_used =3D cs;
> -
> - =A0 =A0 =A0 /* clear ecc and enable bits */
> - =A0 =A0 =A0 val =3D ((0x00000001<<8) | 0x00000001);
> - =A0 =A0 =A0 gpmc_write_reg(GPMC_ECC_CONTROL, val);
> -
> - =A0 =A0 =A0 /* program ecc and result sizes */
> - =A0 =A0 =A0 val =3D ((((ecc_size >> 1) - 1) << 22) | (0x0000000F));
> - =A0 =A0 =A0 gpmc_write_reg(GPMC_ECC_SIZE_CONFIG, val);
> + =A0 =A0 =A0 unsigned int bch_mod =3D 0, bch_wrapmode =3D 0, eccsize=
1 =3D 0, eccsize0 =3D 0;
> + =A0 =A0 =A0 unsigned int ecc_conf_val =3D 0, ecc_size_conf_val =3D =
0;
>
> =A0 =A0 =A0 =A0switch (mode) {
> =A0 =A0 =A0 =A0case GPMC_ECC_READ:
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpmc_write_reg(GPMC_ECC_CONTROL, 0x101)=
;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ecc_type =3D=3D OMAP_ECC_BCH4_CODE_=
HW) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 eccsize1 =3D 0xD; eccsi=
ze0 =3D 0x48;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bch_mod =3D 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bch_wrapmode =3D 0x09;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else if (ecc_type =3D=3D OMAP_ECC_BCH=
8_CODE_HW) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 eccsize1 =3D 0x1A; eccs=
ize0 =3D 0x18;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bch_mod =3D 1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bch_wrapmode =3D 0x04;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 eccsize1 =3D ((ecc_size=
 >> 1) - 1) << 22;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> +
> =A0 =A0 =A0 =A0case GPMC_ECC_READSYN:
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0gpmc_write_reg(GPMC_ECC_CONTROL, 0x1=
00);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> +
> =A0 =A0 =A0 =A0case GPMC_ECC_WRITE:
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpmc_write_reg(GPMC_ECC_CONTROL, 0x101)=
;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ecc_type =3D=3D OMAP_ECC_BCH4_CODE_=
HW) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 eccsize1 =3D 0x20; eccs=
ize0 =3D 0x00;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bch_mod =3D 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bch_wrapmode =3D 0x06;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else if (ecc_type =3D=3D OMAP_ECC_BCH=
8_CODE_HW) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 eccsize1 =3D 0x20; eccs=
ize0 =3D 0x00;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bch_mod =3D 1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bch_wrapmode =3D 0x06;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 eccsize1 =3D ((ecc_size=
 >> 1) - 1) << 22;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> +
> =A0 =A0 =A0 =A0default:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0printk(KERN_INFO "Error: Unrecognized =
Mode[%d]!\n", mode);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 /* (ECC 16 or 8 bit col) | ( CS =A0) =A0| ECC Enable */
> - =A0 =A0 =A0 val =3D (dev_width << 7) | (cs << 1) | (0x1);
> - =A0 =A0 =A0 gpmc_write_reg(GPMC_ECC_CONFIG, val);
> + =A0 =A0 =A0 /* clear ecc and enable bits */
> + =A0 =A0 =A0 if ((ecc_type =3D=3D OMAP_ECC_BCH4_CODE_HW) ||
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 (ecc_type =3D=3D OMAP_ECC_BCH8_CODE_HW)=
) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpmc_write_reg(GPMC_ECC_CONTROL, 0x0000=
0001);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ecc_size_conf_val =3D (eccsize1 << 22) =
| (eccsize0 << 12);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ecc_conf_val =3D ((0x01 << 16) | (bch_m=
od << 12)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | (bch_wrapmode << 8) |=
 (dev_width << 7)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | (0x03 << 4) | (cs << =
1) | (0x1));
> + =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpmc_write_reg(GPMC_ECC_CONTROL, 0x0000=
0101);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ecc_size_conf_val =3D (eccsize1 << 22) =
| 0x0000000F;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ecc_conf_val =3D (dev_width << 7) | (cs=
 << 1) | (0x1);
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 gpmc_write_reg(GPMC_ECC_SIZE_CONFIG, ecc_size_conf_val)=
;
> + =A0 =A0 =A0 gpmc_write_reg(GPMC_ECC_CONFIG, ecc_conf_val);
> + =A0 =A0 =A0 gpmc_write_reg(GPMC_ECC_CONTROL, 0x00000101);
> +
> =A0 =A0 =A0 =A0return 0;
> =A0}
>
> =A0/**
> =A0* gpmc_calculate_ecc - generate non-inverted ecc bytes
> + * @ecc_type: ecc type e.g. Hamming, BCH
> =A0* @cs: chip select number
> =A0* @dat: data pointer over which ecc is computed
> =A0* @ecc_code: ecc code buffer
> @@ -888,20 +913,51 @@ int gpmc_enable_hwecc(int cs, int mode, int dev=
_width, int ecc_size)
> =A0* an erased page will produce an ECC mismatch between generated an=
d read
> =A0* ECC bytes that has to be dealt with separately.
> =A0*/
> -int gpmc_calculate_ecc(int cs, const u_char *dat, u_char *ecc_code)
> +int gpmc_calculate_ecc(int ecc_type, int cs,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 const u_char *dat, u_ch=
ar *ecc_code)
> =A0{
> - =A0 =A0 =A0 unsigned int val =3D 0x0;
> -
> - =A0 =A0 =A0 if (gpmc_ecc_used !=3D cs)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> + =A0 =A0 =A0 unsigned int reg;
> + =A0 =A0 =A0 unsigned int val1 =3D 0x0, val2 =3D 0x0;
> + =A0 =A0 =A0 unsigned int val3 =3D 0x0, val4 =3D 0x0;
> + =A0 =A0 =A0 int i;
>
> - =A0 =A0 =A0 /* read ecc result */
> - =A0 =A0 =A0 val =3D gpmc_read_reg(GPMC_ECC1_RESULT);
> - =A0 =A0 =A0 *ecc_code++ =3D val; =A0 =A0 =A0 =A0 =A0/* P128e, ..., =
P1e */
> - =A0 =A0 =A0 *ecc_code++ =3D val >> 16; =A0 =A0/* P128o, ..., P1o */
> - =A0 =A0 =A0 /* P2048o, P1024o, P512o, P256o, P2048e, P1024e, P512e,=
 P256e */
> - =A0 =A0 =A0 *ecc_code++ =3D ((val >> 8) & 0x0f) | ((val >> 20) & 0x=
f0);
> + =A0 =A0 =A0 if ((ecc_type =3D=3D OMAP_ECC_BCH4_CODE_HW) ||
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 (ecc_type =3D=3D OMAP_ECC_BCH8_CODE_HW)=
) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (i =3D 0; i < 4; i++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Reading HW ECC_BCH=
_Results
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* 0x240-0x24C, 0x250=
-0x25C, 0x260-0x26C, 0x270-0x27C
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D =A0GPMC_ECC_BCH=
_RESULT_0 + (0x10 * i);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 val1 =3D gpmc_read_reg(=
reg);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 val2 =3D gpmc_read_reg(=
reg + 4);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ecc_type =3D=3D OMA=
P_ECC_BCH8_CODE_HW) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 val3 =3D=
 gpmc_read_reg(reg + 8);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 val4 =3D=
 gpmc_read_reg(reg + 12);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *ecc_co=
de++ =3D (val4 & 0xFF);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *ecc_co=
de++ =3D ((val3 >> 24) & 0xFF);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *ecc_co=
de++ =3D ((val3 >> 16) & 0xFF);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *ecc_co=
de++ =3D ((val3 >> 8) & 0xFF);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *ecc_co=
de++ =3D (val3 & 0xFF);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *ecc_co=
de++ =3D ((val2 >> 24) & 0xFF);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *ecc_code++ =3D ((val2 =
>> 16) & 0xFF);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *ecc_code++ =3D ((val2 =
>> 8) & 0xFF);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *ecc_code++ =3D (val2 &=
 0xFF);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *ecc_code++ =3D ((val1 =
>> 24) & 0xFF);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *ecc_code++ =3D ((val1 =
>> 16) & 0xFF);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *ecc_code++ =3D ((val1 =
>> 8) & 0xFF);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *ecc_code++ =3D (val1 &=
 0xFF);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* read ecc result */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 val1 =3D gpmc_read_reg(GPMC_ECC1_RESULT=
);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 *ecc_code++ =3D val1; =A0 =A0 =A0 =A0 =A0=
/* P128e, ..., P1e */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 *ecc_code++ =3D val1 >> 16; =A0 =A0/* P=
128o, ..., P1o */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* P2048o, P1024o, P512o, P256o, P2048e=
, P1024e, P512e, P256e */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 *ecc_code++ =3D ((val1 >> 8) & 0x0f) | =
((val1 >> 20) & 0xf0);
> + =A0 =A0 =A0 }
>
> - =A0 =A0 =A0 gpmc_ecc_used =3D -EINVAL;
> =A0 =A0 =A0 =A0return 0;
> =A0}
> diff --git a/arch/arm/plat-omap/include/plat/gpmc.h b/arch/arm/plat-o=
map/include/plat/gpmc.h
> index 49aea09..838c185 100644
> --- a/arch/arm/plat-omap/include/plat/gpmc.h
> +++ b/arch/arm/plat-omap/include/plat/gpmc.h
> @@ -92,6 +92,8 @@ enum omap_ecc {
> =A0 =A0 =A0 =A0OMAP_ECC_HAMMING_CODE_HW, /* gpmc to detect the error =
*/
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* 1-bit ecc: stored at begining of sp=
are area as romcode */
> =A0 =A0 =A0 =A0OMAP_ECC_HAMMING_CODE_HW_ROMCODE, /* gpmc method & rom=
code layout */
> + =A0 =A0 =A0 OMAP_ECC_BCH4_CODE_HW, /* gpmc bch detection & s/w meth=
od correction */
> + =A0 =A0 =A0 OMAP_ECC_BCH8_CODE_HW, /* gpmc bch detection & s/w meth=
od correction */
> =A0};
>
> =A0/*
> @@ -156,6 +158,6 @@ extern int gpmc_cs_configure(int cs, int cmd, int=
 wval);
> =A0extern int gpmc_nand_read(int cs, int cmd);
> =A0extern int gpmc_nand_write(int cs, int cmd, int wval);
>
> -int gpmc_enable_hwecc(int cs, int mode, int dev_width, int ecc_size)=
;
> -int gpmc_calculate_ecc(int cs, const u_char *dat, u_char *ecc_code);
> +int gpmc_enable_hwecc(int ecc, int cs, int mode, int dev_width, int =
ecc_size);
> +int gpmc_calculate_ecc(int ecc, int cs, const u_char *dat, u_char *e=
cc_code);
> =A0#endif
> diff --git a/drivers/mtd/nand/Makefile b/drivers/mtd/nand/Makefile
> index 8ad6fae..ae02711 100644
> --- a/drivers/mtd/nand/Makefile
> +++ b/drivers/mtd/nand/Makefile
> @@ -29,6 +29,7 @@ obj-$(CONFIG_MTD_NAND_NDFC) =A0 =A0 =A0 =A0 =A0 +=3D=
 ndfc.o
> =A0obj-$(CONFIG_MTD_NAND_ATMEL) =A0 =A0 =A0 =A0 =A0 +=3D atmel_nand.o
> =A0obj-$(CONFIG_MTD_NAND_GPIO) =A0 =A0 =A0 =A0 =A0 =A0+=3D gpio.o
> =A0obj-$(CONFIG_MTD_NAND_OMAP2) =A0 =A0 =A0 =A0 =A0 +=3D omap2.o
> +obj-$(CONFIG_MTD_NAND_OMAP2) =A0 =A0 =A0 =A0 =A0 +=3D omap_bch_decod=
er.o
> =A0obj-$(CONFIG_MTD_NAND_CM_X270) =A0 =A0 =A0 =A0 +=3D cmx270_nand.o
> =A0obj-$(CONFIG_MTD_NAND_PXA3xx) =A0 =A0 =A0 =A0 =A0+=3D pxa3xx_nand.=
o
> =A0obj-$(CONFIG_MTD_NAND_TMIO) =A0 =A0 =A0 =A0 =A0 =A0+=3D tmio_nand.=
o
> diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
> index 4e33972..14c7dfe 100644
> --- a/drivers/mtd/nand/omap2.c
> +++ b/drivers/mtd/nand/omap2.c
> @@ -98,6 +98,8 @@
> =A0static const char *part_probes[] =3D { "cmdlinepart", NULL };
> =A0#endif
>
> +int decode_bch(int select_4_8, unsigned char *ecc, unsigned int *err=
_loc);
> +
> =A0/* oob info generated runtime depending on ecc algorithm and layou=
t selected */
> =A0static struct nand_ecclayout omap_oobinfo;
> =A0/* Define some generic bad / good block scan pattern which are use=
d
> @@ -130,7 +132,8 @@ struct omap_nand_info {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0OMAP_NAND_IO_WRITE, =A0 =A0 /* write *=
/
> =A0 =A0 =A0 =A0} iomode;
> =A0 =A0 =A0 =A0u_char =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0*buf;
> - =A0 =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 buf_len;
> + =A0 =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 buf_len;
> + =A0 =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 ecc_opt;
> =A0};
>
> =A0/**
> @@ -529,7 +532,6 @@ static void omap_read_buf_irq_pref(struct mtd_inf=
o *mtd, u_char *buf, int len)
> =A0 =A0 =A0 =A0struct omap_nand_info *info =3D container_of(mtd,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0struct omap_nand_info, mtd);
> =A0 =A0 =A0 =A0int ret =3D 0;
> -
> =A0 =A0 =A0 =A0if (len <=3D mtd->oobsize) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap_read_buf_pref(mtd, buf, len);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return;
> @@ -803,6 +805,8 @@ static int omap_correct_data(struct mtd_info *mtd=
, u_char *dat,
> =A0 =A0 =A0 =A0struct omap_nand_info *info =3D container_of(mtd, stru=
ct omap_nand_info,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mtd);
> =A0 =A0 =A0 =A0int blockCnt =3D 0, i =3D 0, ret =3D 0;
> + =A0 =A0 =A0 int j, eccsize, eccflag, count;
> + =A0 =A0 =A0 unsigned int err_loc[8];
>
> =A0 =A0 =A0 =A0/* Ex NAND_ECC_HW12_2048 */
> =A0 =A0 =A0 =A0if ((info->nand.ecc.mode =3D=3D NAND_ECC_HW) &&
> @@ -811,16 +815,57 @@ static int omap_correct_data(struct mtd_info *m=
td, u_char *dat,
> =A0 =A0 =A0 =A0else
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0blockCnt =3D 1;
>
> - =A0 =A0 =A0 for (i =3D 0; i < blockCnt; i++) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (memcmp(read_ecc, calc_ecc, 3) !=3D =
0) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D omap_compare_ec=
c(read_ecc, calc_ecc, dat);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret < 0)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return =
ret;
> + =A0 =A0 =A0 switch (info->ecc_opt) {
> + =A0 =A0 =A0 case OMAP_ECC_HAMMING_CODE_HW:
> + =A0 =A0 =A0 case OMAP_ECC_HAMMING_CODE_HW_ROMCODE:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (i =3D 0; i < blockCnt; i++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (memcmp(read_ecc, ca=
lc_ecc, 3) !=3D 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D=
 omap_compare_ecc(read_ecc, calc_ecc, dat);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret=
 < 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 return ret;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 read_ecc +=3D 3;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 calc_ecc +=3D 3;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dat =A0 =A0 =A0+=3D 512=
;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 read_ecc +=3D 3;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 calc_ecc +=3D 3;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dat =A0 =A0 =A0+=3D 512;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> +
> + =A0 =A0 =A0 case OMAP_ECC_BCH4_CODE_HW:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 eccsize =3D 7;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpmc_calculate_ecc(info->ecc_opt, info-=
>gpmc_cs, dat, calc_ecc);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (i =3D 0; i < blockCnt; i++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* check if any ecc err=
or */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 eccflag =3D 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (j =3D 0; (j < eccs=
ize) && (eccflag =3D=3D 0); j++)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (cal=
c_ecc[j] !=3D 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 eccflag =3D 1;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (eccflag =3D=3D 1) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 eccflag=
 =3D 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (j =
=3D 0; (j < eccsize) &&
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 (eccflag =3D=3D 0); j++)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 if (read_ecc[j] !=3D 0xFF)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 eccflag =3D 1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 count =3D 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (eccflag =3D=3D 1)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 count =3D=
 decode_bch(0, calc_ecc, err_loc);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (j =3D 0; j < count=
; j++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (err=
_loc[j] < 4096)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 dat[err_loc[j] >> 3] ^=3D
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 1 << (err_loc[j] & 7);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* else=
, not interested to correct ecc */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 calc_ecc =3D calc_ecc +=
 eccsize;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 read_ecc =3D read_ecc +=
 eccsize;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dat +=3D 512;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> =A0 =A0 =A0 =A0}
> +
> =A0 =A0 =A0 =A0return 0;
> =A0}
>
> @@ -841,7 +886,7 @@ static int omap_calculate_ecc(struct mtd_info *mt=
d, const u_char *dat,
> =A0{
> =A0 =A0 =A0 =A0struct omap_nand_info *info =3D container_of(mtd, stru=
ct omap_nand_info,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mtd);
> - =A0 =A0 =A0 return gpmc_calculate_ecc(info->gpmc_cs, dat, ecc_code)=
;
> + =A0 =A0 =A0 return gpmc_calculate_ecc(info->ecc_opt, info->gpmc_cs,=
 dat, ecc_code);
> =A0}
>
> =A0/**
> @@ -856,7 +901,8 @@ static void omap_enable_hwecc(struct mtd_info *mt=
d, int mode)
> =A0 =A0 =A0 =A0struct nand_chip *chip =3D mtd->priv;
> =A0 =A0 =A0 =A0unsigned int dev_width =3D (chip->options & NAND_BUSWI=
DTH_16) ? 1 : 0;
>
> - =A0 =A0 =A0 gpmc_enable_hwecc(info->gpmc_cs, mode, dev_width, info-=
>nand.ecc.size);
> + =A0 =A0 =A0 gpmc_enable_hwecc(info->ecc_opt, info->gpmc_cs, mode,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_wid=
th, info->nand.ecc.size);
> =A0}
>
> =A0/**
> @@ -953,6 +999,7 @@ static int __devinit omap_nand_probe(struct platf=
orm_device *pdev)
> =A0 =A0 =A0 =A0info->mtd.priv =A0 =A0 =A0 =A0 =A0=3D &info->nand;
> =A0 =A0 =A0 =A0info->mtd.name =A0 =A0 =A0 =A0 =A0=3D dev_name(&pdev->=
dev);
> =A0 =A0 =A0 =A0info->mtd.owner =A0 =A0 =A0 =A0 =3D THIS_MODULE;
> + =A0 =A0 =A0 info->ecc_opt =A0 =A0 =A0 =A0 =A0 =3D pdata->ecc_opt;
>
> =A0 =A0 =A0 =A0info->nand.options =A0 =A0 =A0=3D pdata->devsize;
> =A0 =A0 =A0 =A0info->nand.options =A0 =A0 =A0|=3D NAND_SKIP_BBTSCAN;
> @@ -991,7 +1038,6 @@ static int __devinit omap_nand_probe(struct plat=
form_device *pdev)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0info->nand.waitfunc =3D omap_wait;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0info->nand.chip_delay =3D 50;
> =A0 =A0 =A0 =A0}
> -
> =A0 =A0 =A0 =A0switch (pdata->xfer_type) {
> =A0 =A0 =A0 =A0case NAND_OMAP_PREFETCH_POLLED:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0info->nand.read_buf =A0 =3D omap_read_=
buf_pref;
> @@ -1052,10 +1098,17 @@ static int __devinit omap_nand_probe(struct p=
latform_device *pdev)
> =A0 =A0 =A0 =A0/* selsect the ecc type */
> =A0 =A0 =A0 =A0if (pdata->ecc_opt =3D=3D OMAP_ECC_HAMMING_CODE_DEFAUL=
T)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0info->nand.ecc.mode =3D NAND_ECC_SOFT;
> - =A0 =A0 =A0 else if ((pdata->ecc_opt =3D=3D OMAP_ECC_HAMMING_CODE_H=
W) ||
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 (pdata->ecc_opt =3D=3D OMAP_ECC_HAMMING=
_CODE_HW_ROMCODE)) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 info->nand.ecc.bytes =A0 =A0 =A0 =A0 =A0=
 =A0=3D 3;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 info->nand.ecc.size =A0 =A0 =A0 =A0 =A0=
 =A0 =3D 512;
> + =A0 =A0 =A0 else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (pdata->ecc_opt =3D=3D OMAP_ECC_BCH4=
_CODE_HW) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 info->nand.ecc.bytes =A0=
 =A0=3D 4*7;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 info->nand.ecc.size =A0=
 =A0 =3D 4*512;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else if (pdata->ecc_opt =3D=3D OMAP_E=
CC_BCH8_CODE_HW) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 info->nand.ecc.bytes =A0=
 =A0=3D 13;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 info->nand.ecc.size =A0=
 =A0 =3D 4*512;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 info->nand.ecc.bytes =A0=
 =A0=3D 3;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 info->nand.ecc.size =A0=
 =A0 =3D 512;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0info->nand.ecc.calculate =A0 =A0 =A0 =A0=
=3D omap_calculate_ecc;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0info->nand.ecc.hwctl =A0 =A0 =A0 =A0 =A0=
 =A0=3D omap_enable_hwecc;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0info->nand.ecc.correct =A0 =A0 =A0 =A0=
 =A0=3D omap_correct_data;
> @@ -1073,8 +1126,8 @@ static int __devinit omap_nand_probe(struct pla=
tform_device *pdev)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 /* rom code layout */
> - =A0 =A0 =A0 if (pdata->ecc_opt =3D=3D OMAP_ECC_HAMMING_CODE_HW_ROMC=
ODE) {
> + =A0 =A0 =A0 /* select ecc lyout */
> + =A0 =A0 =A0 if (info->nand.ecc.mode !=3D NAND_ECC_SOFT) {
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (info->nand.options & NAND_BUSWIDTH=
_16)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0offset =3D 2;
> @@ -1082,15 +1135,31 @@ static int __devinit omap_nand_probe(struct p=
latform_device *pdev)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0offset =3D 1;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0info->nand.badblock_pa=
ttern =3D &bb_descrip_flashbased;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_oobinfo.eccbytes =3D 3 * (info->mt=
d.oobsize/16);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (i =3D 0; i < omap_oobinfo.eccbytes=
; i++)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_oobinfo.eccpos[i] =
=3D i+offset;
>
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_oobinfo.oobfree->offset =3D offset=
 + omap_oobinfo.eccbytes;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_oobinfo.oobfree->length =3D info->=
mtd.oobsize -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 (offset + omap_oobinfo.eccbytes);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (info->mtd.oobsize =3D=3D 64)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_oobinfo.eccbytes =3D=
 info->nand.ecc.bytes *
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 2048/info->nand.ecc.size;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_oobinfo.eccbytes =3D=
 info->nand.ecc.bytes;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (pdata->ecc_opt =3D=3D OMAP_ECC_HAMM=
ING_CODE_HW_ROMCODE) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (i =3D 0; i < omap_=
oobinfo.eccbytes; i++)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_oo=
binfo.eccpos[i] =3D i + offset;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_oobinfo.oobfree->o=
ffset =3D
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 offset + omap_oobinfo.eccbytes;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_oobinfo.oobfree->l=
ength =3D info->mtd.oobsize -
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 offset - omap_oobinfo.eccbytes;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
>
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_oobinfo.oobfree->o=
ffset =3D offset;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_oobinfo.oobfree->l=
ength =3D info->mtd.oobsize -
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 offset - omap_oobinfo.eccbytes;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 offset =3D info->mtd.oo=
bsize - omap_oobinfo.eccbytes;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (i =3D 0; i < omap_=
oobinfo.eccbytes; i++)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_oo=
binfo.eccpos[i] =3D i + offset;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0info->nand.ecc.layout =3D &omap_oobinf=
o;
> +
> =A0 =A0 =A0 =A0}
>
> =A0#ifdef CONFIG_MTD_PARTITIONS
> diff --git a/drivers/mtd/nand/omap_bch_decoder.c b/drivers/mtd/nand/o=
map_bch_decoder.c
> new file mode 100644
> index 0000000..da42bda
> --- /dev/null
> +++ b/drivers/mtd/nand/omap_bch_decoder.c
> @@ -0,0 +1,393 @@
> +/*
> + * drivers/mtd/nand/omap_omap_bch_decoder.c
> + *
> + * Whole BCH ECC Decoder (Post hardware generated syndrome decoding)
> + *
> + * Copyright (c) 2007 Texas Instruments
> + *
> + * Author: Sukumar Ghorai <s-ghorai@ti.com
> + * =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Michael Fillinger <m-fillinger@ti.=
com>
> + *
> + * This program is free software; you can redistribute it and/or mod=
ify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +#undef DEBUG
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +
> +#define mm =A0 =A0 =A0 =A0 =A0 =A0 13
> +#define kk_shorten =A0 =A0 4096
> +#define nn =A0 =A0 =A0 =A0 =A0 =A0 8191 =A0 =A0/* Length of codeword=
, n =3D 2**mm - 1 */
> +
> +#define PPP =A0 =A00x201B =A0/* Primary Polynomial : x^13 + x^4 + x^=
3 + x + 1 */
> +#define P =A0 =A0 =A00x001B =A0/* With omitted x^13 */
> +#define POLY =A0 12 =A0 =A0 =A0/* degree of the primary Polynomial l=
ess one */
> +
> +/**
> + * mpy_mod_gf - GALOIS field multiplier
> + * Input =A0: A(x), B(x)
> + * Output : A(x)*B(x) mod P(x)
> + */
> +static unsigned int mpy_mod_gf(unsigned int a, unsigned int b)
> +{
> + =A0 =A0 =A0 unsigned int R =3D 0;
> + =A0 =A0 =A0 unsigned int R1 =3D 0;
> + =A0 =A0 =A0 unsigned int k =3D 0;
> +
> + =A0 =A0 =A0 for (k =3D 0; k < mm; k++) {
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 R =3D (R << 1) & 0x1FFE;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (R1 =3D=3D 1)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 R ^=3D P;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (((a >> (POLY - k)) & 1) =3D=3D 1)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 R ^=3D b;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (k < POLY)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 R1 =3D (R >> POLY) & 1;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 return R;
> +}
> +
> +/**
> + * chien - CHIEN search
> + *
> + * @location - Error location vector pointer
> + *
> + * Inputs =A0: ELP(z)
> + * =A0 =A0 =A0 =A0 =A0No. of found errors
> + * =A0 =A0 =A0 =A0 =A0Size of input codeword
> + * Outputs : Up to 8 locations
> + * =A0 =A0 =A0 =A0 =A0No. of errors
> + */
> +static int chien(unsigned int select_4_8, int err_nums,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigne=
d int err[], unsigned int *location)
> +{
> + =A0 =A0 =A0 int i, count; /* Number of dectected errors */
> + =A0 =A0 =A0 /* Contains accumulation of evaluation at x^i (i:1->8) =
*/
> + =A0 =A0 =A0 unsigned int gammas[8] =3D {0};
> + =A0 =A0 =A0 unsigned int alpha;
> + =A0 =A0 =A0 unsigned int bit, ecc_bits;
> + =A0 =A0 =A0 unsigned int elp_sum;
> +
> + =A0 =A0 =A0 ecc_bits =3D (select_4_8 =3D=3D 0) ? 52 : 104;
> +
> + =A0 =A0 =A0 /* Start evaluation at Alpha**8192 and decreasing */
> + =A0 =A0 =A0 for (i =3D 0; i < 8; i++)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 gammas[i] =3D err[i];
> +
> + =A0 =A0 =A0 count =3D 0;
> + =A0 =A0 =A0 for (i =3D 1; (i <=3D nn) && (count < err_nums); i++) {
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Result of evaluation at root */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 elp_sum =3D 1 ^ gammas[0] ^ gammas[1] ^
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 gammas[=
2] ^ gammas[3] ^
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 gammas[=
4] ^ gammas[5] ^
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 gammas[=
6] ^ gammas[7];
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 alpha =3D PPP >> 1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 gammas[0] =3D mpy_mod_gf(gammas[0], alp=
ha);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 alpha =3D mpy_mod_gf(alpha, (PPP >> 1))=
; =A0/* x alphha^-2 */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 gammas[1] =3D mpy_mod_gf(gammas[1], alp=
ha);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 alpha =3D mpy_mod_gf(alpha, (PPP >> 1))=
; =A0/* x alphha^-2 */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 gammas[2] =3D mpy_mod_gf(gammas[2], alp=
ha);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 alpha =3D mpy_mod_gf(alpha, (PPP >> 1))=
; =A0/* x alphha^-3 */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 gammas[3] =3D mpy_mod_gf(gammas[3], alp=
ha);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 alpha =3D mpy_mod_gf(alpha, (PPP >> 1))=
; =A0/* x alphha^-4 */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 gammas[4] =3D mpy_mod_gf(gammas[4], alp=
ha);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 alpha =3D mpy_mod_gf(alpha, (PPP >> 1))=
; =A0/* x alphha^-5 */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 gammas[5] =3D mpy_mod_gf(gammas[5], alp=
ha);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 alpha =3D mpy_mod_gf(alpha, (PPP >> 1))=
; =A0/* x alphha^-6 */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 gammas[6] =3D mpy_mod_gf(gammas[6], alp=
ha);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 alpha =3D mpy_mod_gf(alpha, (PPP >> 1))=
; =A0/* x alphha^-7 */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 gammas[7] =3D mpy_mod_gf(gammas[7], alp=
ha);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (elp_sum =3D=3D 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* calculate bit positi=
on in main data area */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bit =3D ((i-1) & ~7)|(7=
-((i-1) & 7));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (i >=3D 2 * ecc_bits=
)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 locatio=
n[count++] =3D
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 kk_shorten - (bit - 2 * ecc_bits) - 1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 /* Failure: No. of detected errors !=3D No. or correcte=
d errors */
> + =A0 =A0 =A0 if (count !=3D err_nums) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 count =3D -1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "BCH decoding failed\n"=
);
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 for (i =3D 0; i < count; i++)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_debug("%d ", location[i]);
> +
> + =A0 =A0 =A0 return count;
> +}
> +
> +/* synd : 16 Syndromes
> + * return: gamaas - Coefficients to the error polynomial
> + * return: : Number of detected errors
> +*/
> +static unsigned int berlekamp(unsigned int select_4_8,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned int synd[], un=
signed int err[])
> +{
> + =A0 =A0 =A0 int loop, iteration;
> + =A0 =A0 =A0 unsigned int LL =3D 0; =A0 =A0 =A0 =A0 =A0 =A0/* Detect=
ed errors */
> + =A0 =A0 =A0 unsigned int d =3D 0; =A0 =A0 /* Distance between Syndr=
omes and ELP[n](z) */
> + =A0 =A0 =A0 unsigned int invd =3D 0; =A0 =A0 =A0 =A0 =A0/* Inverse =
of d */
> + =A0 =A0 =A0 /* Intermediate ELP[n](z).
> + =A0 =A0 =A0 =A0* Final ELP[n](z) is Error Location Polynomial
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 unsigned int gammas[16] =3D {0};
> + =A0 =A0 =A0 /* Intermediate normalized ELP[n](z) : D[n](z) */
> + =A0 =A0 =A0 unsigned int D[16] =3D {0};
> + =A0 =A0 =A0 /* Temporary value that holds an ELP[n](z) coefficient =
*/
> + =A0 =A0 =A0 unsigned int next_gamma =3D 0;
> +
> + =A0 =A0 =A0 int e =3D 0;
> + =A0 =A0 =A0 unsigned int sign =3D 0;
> + =A0 =A0 =A0 unsigned int u =3D 0;
> + =A0 =A0 =A0 unsigned int v =3D 0;
> + =A0 =A0 =A0 unsigned int C1 =3D 0, C2 =3D 0;
> + =A0 =A0 =A0 unsigned int ss =3D 0;
> + =A0 =A0 =A0 unsigned int tmp_v =3D 0, tmp_s =3D 0;
> + =A0 =A0 =A0 unsigned int tmp_poly;
> +
> + =A0 =A0 =A0 /*-------------- Step 0 ------------------*/
> + =A0 =A0 =A0 for (loop =3D 0; loop < 16; loop++)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 gammas[loop] =3D 0;
> + =A0 =A0 =A0 gammas[0] =3D 1;
> + =A0 =A0 =A0 D[1] =3D 1;
> +
> + =A0 =A0 =A0 iteration =3D 0;
> + =A0 =A0 =A0 LL =3D 0;
> + =A0 =A0 =A0 while ((iteration < ((select_4_8+1)*2*4)) &&
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (LL <=3D ((select_4_8+1=
)*4))) {
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_debug("\nIteration.............%d\n"=
, iteration);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 d =3D 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Step: 0 */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (loop =3D 0; loop <=3D LL; loop++) =
{
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tmp_poly =3D mpy_mod_gf=
(
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 gammas[loop], synd[iteration - loop]);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 d ^=3D tmp_poly;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_debug("%02d. s=3D0 L=
L=3D%x poly %x\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 loop, LL, tmp_poly);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Step 1: 1 cycle only to perform inve=
rsion */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 v =3D d << 1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 e =3D -1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 sign =3D 1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ss =3D 0x2000;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 invd =3D 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 u =3D PPP;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (loop =3D 0; (d !=3D 0) && (loop <=3D=
 (2 * POLY)); loop++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_debug("%02d. s=3D1 L=
L=3D%x poly NULL\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 loop, LL);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 C1 =3D (v >> 13) & 1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 C2 =3D C1 & sign;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sign ^=3D C2 ^ (e =3D=3D=
 0);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tmp_v =3D v;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tmp_s =3D ss;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (C1 =3D=3D 1) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 v ^=3D =
u;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ss ^=3D=
 invd;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 v =3D (v << 1) & 0x3FFF=
;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (C2 =3D=3D 1) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 u =3D t=
mp_v;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 invd =3D=
 tmp_s;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 e =3D -=
e;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 invd >>=3D 1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 e--;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (loop =3D 0; (d !=3D 0) && (loop <=3D=
 (iteration + 1)); loop++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Step 2
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Interleaved with S=
tep 3, if L<(n-k)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* invd: Update of EL=
P[n](z) =3D ELP[n-1](z) - d.D[n-1](z)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Holds value of ELP c=
oefficient until precedent
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* value does not hav=
e to be used anymore
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tmp_poly =3D mpy_mod_gf=
(d, D[loop]);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_debug("%02d. s=3D2 L=
L=3D%x poly %x\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 loop, LL, tmp_poly);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 next_gamma =3D gammas[l=
oop] ^ tmp_poly;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((2 * LL) < (iterati=
on + 1)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Inte=
rleaving with Step 3
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* fo=
r parallelized update of ELP(z) and D(z)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Upda=
te of ELP(z) only -> stay in Step 2 */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 gammas[=
loop] =3D next_gamma;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (loo=
p =3D=3D (iteration + 1)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 /* to step 4 */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 break;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Step 3
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Always interleaved=
 with Step 2 (case when L<(n-k))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Update of D[n-1](z=
) =3D ELP[n-1](z)/d
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 D[loop] =3D mpy_mod_gf(=
gammas[loop], invd);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_debug("%02d. s=3D3 L=
L=3D%x poly %x\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 loop, LL, D[loop]);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Can safely update EL=
P[n](z) */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 gammas[loop] =3D next_g=
amma;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (loop =3D=3D (iterat=
ion + 1)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* If u=
pdate finished */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 LL =3D =
iteration - LL + 1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* to s=
tep 4 */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Else, interleaving t=
o step 2*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Step 4: Update D(z): i:0->L */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Final update of D[n](z) =3D D[n](z).=
z*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (loop =3D 0; loop < 15; loop++) /* =
Left Shift */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 D[15 - loop] =3D D[14 -=
 loop];
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 D[0] =3D 0;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 iteration++;
> + =A0 =A0 =A0 } /* while */
> +
> + =A0 =A0 =A0 /* Processing finished, copy ELP to final registers : 0=
->2t-1*/
> + =A0 =A0 =A0 for (loop =3D 0; loop < 8; loop++)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err[loop] =3D gammas[loop+1];
> +
> + =A0 =A0 =A0 pr_debug("\n Err poly:");
> + =A0 =A0 =A0 for (loop =3D 0; loop < 8; loop++)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_debug("0x%x ", err[loop]);
> +
> + =A0 =A0 =A0 return LL;
> +}
> +
> +/*
> + * syndrome - Generate syndrome components from hw generate syndrome
> + * r(x) =3D c(x) + e(x)
> + * s(x) =3D c(x) mod g(x) + e(x) mod g(x) =3D =A0e(x) mod g(x)
> + * so receiver checks if the syndrome s(x) =3D r(x) mod g(x) is equa=
l to zero.
> + * unsigned int s[16]; - Syndromes
> + */
> +static void syndrome(unsigned int select_4_8,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 unsigned char *ecc, unsigned int syn[])
> +{
> + =A0 =A0 =A0 unsigned int k, l, t;
> + =A0 =A0 =A0 unsigned int alpha_bit, R_bit;
> + =A0 =A0 =A0 int ecc_pos, ecc_min;
> +
> + =A0 =A0 =A0 /* 2t-1 =3D 15 (for t=3D8) minimal polynomials of the f=
irst 15 powers of a
> + =A0 =A0 =A0 =A0* primitive elemmants of GF(m); Even powers minimal =
polynomials are
> + =A0 =A0 =A0 =A0* duplicate of odd powers' minimal polynomials.
> + =A0 =A0 =A0 =A0* Odd powers of alpha (1 to 15)
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 unsigned int pow_alpha[8] =3D {0x0002, 0x0008, 0x0020, =
0x0080,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x02=
00, 0x0800, 0x001B, 0x006C};
> +
> + =A0 =A0 =A0 pr_debug("\n ECC[0..n]: ");
> + =A0 =A0 =A0 for (k =3D 0; k < 13; k++)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_debug("0x%x ", ecc[k]);
> +
> + =A0 =A0 =A0 if (select_4_8 =3D=3D 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 t =3D 4;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ecc_pos =3D 55; /* bits(52-bits): 55->4=
 */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ecc_min =3D 4;
> + =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 t =3D 8;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ecc_pos =3D 103; /* bits: 103->0 */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ecc_min =3D 0;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 /* total numbber of syndrom to be used is 2t */
> + =A0 =A0 =A0 /* Step1: calculate the odd syndrome(s) */
> + =A0 =A0 =A0 R_bit =3D ((ecc[ecc_pos/8] >> (7 - ecc_pos%8)) & 1);
> + =A0 =A0 =A0 ecc_pos--;
> + =A0 =A0 =A0 for (k =3D 0; k < t; k++)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 syn[2 * k] =3D R_bit;
> +
> + =A0 =A0 =A0 while (ecc_pos >=3D ecc_min) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 R_bit =3D ((ecc[ecc_pos/8] >> (7 - ecc_=
pos%8)) & 1);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ecc_pos--;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (k =3D 0; k < t; k++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Accumulate value of =
x^i at alpha^(2k+1) */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (R_bit =3D=3D 1)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 syn[2*k=
] ^=3D pow_alpha[k];
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Compute a**(2k+1), u=
sing LSFR */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (l =3D 0; l < (2 * =
k + 1); l++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 alpha_b=
it =3D (pow_alpha[k] >> POLY) & 1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pow_alp=
ha[k] =3D (pow_alpha[k] << 1) & 0x1FFF;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (alp=
ha_bit =3D=3D 1)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 pow_alpha[k] ^=3D P;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 /* Step2: calculate the even syndrome(s)
> + =A0 =A0 =A0 =A0* Compute S(a), where a is an even power of alpha
> + =A0 =A0 =A0 =A0* Evenry even power of primitive element has the sam=
e minimal
> + =A0 =A0 =A0 =A0* polynomial as some odd power of elemets.
> + =A0 =A0 =A0 =A0* And based on S(a^2) =3D S^2(a)
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 for (k =3D 0; k < t; k++)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 syn[2*k+1] =3D mpy_mod_gf(syn[k], syn[k=
]);
> +
> + =A0 =A0 =A0 pr_debug("\n Syndromes: ");
> + =A0 =A0 =A0 for (k =3D 0; k < 16; k++)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_debug("0x%x ", syn[k]);
> +}
> +
> +/**
> + * decode_bch - BCH decoder for 4- and 8-bit error correction
> + *
> + * @ecc - ECC syndrome generated by hw BCH engine
> + * @err_loc - pointer to error location array
> + *
> + * This function does post sydrome generation (hw generated) decodin=
g
> + * for:-
> + * Dimension of Galoise Field: m =3D 13
> + * Length of codeword: n =3D 2**m - 1
> + * Number of errors that can be corrected: 4- or 8-bits
> + * Length of information bit: kk =3D nn - rr
> + */
> +int decode_bch(int select_4_8, unsigned char *ecc, unsigned int *err=
_loc)
> +{
> + =A0 =A0 =A0 int no_of_err;
> + =A0 =A0 =A0 unsigned int syn[16] =3D {0,}; =A0 =A0/* 16 Syndromes *=
/
> + =A0 =A0 =A0 unsigned int err_poly[8] =3D {0,};
> + =A0 =A0 =A0 /* Coefficients to the error polynomial
> + =A0 =A0 =A0 =A0* ELP(x) =3D 1 + err0.x + err1.x^2 + ... + err7.x^8
> + =A0 =A0 =A0 =A0*/
> +
> + =A0 =A0 =A0 /* Decoting involes three steps
> + =A0 =A0 =A0 =A0* 1. Compute the syndrom from teh received codeword,
> + =A0 =A0 =A0 =A0* 2. Find the error location polynomial from a set o=
f equations
> + =A0 =A0 =A0 =A0* =A0 =A0 derived from the syndrome,
> + =A0 =A0 =A0 =A0* 3. Use the error location polynomial to identify e=
rrants bits,
> + =A0 =A0 =A0 =A0*
> + =A0 =A0 =A0 =A0* And correcttion done by bit flips using error loca=
iton and expected
> + =A0 =A0 =A0 =A0* to be outseide of this implementation.
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 syndrome(select_4_8, ecc, syn);
> + =A0 =A0 =A0 no_of_err =3D berlekamp(select_4_8, syn, err_poly);
> + =A0 =A0 =A0 if (no_of_err <=3D (4 << select_4_8))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 no_of_err =3D chien(select_4_8, no_of_e=
rr, err_poly, err_loc);
> +
> + =A0 =A0 =A0 return no_of_err;
> +}
> +EXPORT_SYMBOL(decode_bch);
> +
> --
> 1.7.0.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>



--=20
Regards,
Vimal Singh
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
