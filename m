From: Vimal Singh <vimal.newwork@gmail.com>
Subject: Re: [PATCH v2 1/2] omap3 nand: cleanup for not to use GPMC virtual
	address
Date: Fri, 14 May 2010 23:32:33 +0530
Message-ID: <AANLkTinGirx4-PPkpPhYEutbnN_uIPoYbA7BlUPCPnaK@mail.gmail.com>
References: <s-ghorai@ti.com> <1273850591-19040-1-git-send-email-s-ghorai@ti.com>
	<1273850591-19040-2-git-send-email-s-ghorai@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:40480 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758614Ab0ENSCz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 May 2010 14:02:55 -0400
Received: by pwi10 with SMTP id 10so742686pwi.19
        for <linux-omap@vger.kernel.org>; Fri, 14 May 2010 11:02:54 -0700 (PDT)
In-Reply-To: <1273850591-19040-2-git-send-email-s-ghorai@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sukumar Ghorai <s-ghorai@ti.com>
Cc: linux-omap@vger.kernel.org, Artem.Bityutskiy@nokia.com, tony@atomide.com, sakoman@gmail.com, linux-mtd@lists.infradead.org

On Fri, May 14, 2010 at 8:53 PM, Sukumar Ghorai <s-ghorai@ti.com> wrote=
:
[...]

> diff --git a/arch/arm/mach-omap2/gpmc-onenand.c b/arch/arm/mach-omap2=
/gpmc-onenand.c
> index 7bb6922..5d66817
> --- a/arch/arm/mach-omap2/gpmc-onenand.c
> +++ b/arch/arm/mach-omap2/gpmc-onenand.c
> @@ -301,7 +301,7 @@ static int omap2_onenand_set_sync_mode(struct oma=
p_onenand_platform_data *cfg,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(GPMC_=
CONFIG1_WAIT_READ_MON |
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 GPMC_=
CONFIG1_WAIT_PIN_SEL(0))) |
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0GPMC_CONFIG1_DEVIC=
ESIZE_16 |
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 GPMC_CONFIG1_DEVICE=
TYPE_NOR |
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 GPMC_CONFIG1_DEVICE=
TYPE(GPMC_DEVICETYPE_NOR) |
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0GPMC_CONFIG1_MUXAD=
DDATA);

Please do not dp OneNAND changes in NAND patch.

> diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
> index 5bc3ca0..a3fd1ed
> --- a/arch/arm/mach-omap2/gpmc.c
> +++ b/arch/arm/mach-omap2/gpmc.c
> @@ -29,27 +29,27 @@
> =A0#include <plat/sdrc.h>
>
> =A0/* GPMC register offsets */
> -#define GPMC_REVISION =A0 =A0 =A0 =A0 =A00x00
> -#define GPMC_SYSCONFIG =A0 =A0 =A0 =A0 0x10
> -#define GPMC_SYSSTATUS =A0 =A0 =A0 =A0 0x14
> -#define GPMC_IRQSTATUS =A0 =A0 =A0 =A0 0x18
> -#define GPMC_IRQENABLE =A0 =A0 =A0 =A0 0x1c
> -#define GPMC_TIMEOUT_CONTROL =A0 0x40
> -#define GPMC_ERR_ADDRESS =A0 =A0 =A0 0x44
> -#define GPMC_ERR_TYPE =A0 =A0 =A0 =A0 =A00x48
> -#define GPMC_CONFIG =A0 =A0 =A0 =A0 =A0 =A00x50
> -#define GPMC_STATUS =A0 =A0 =A0 =A0 =A0 =A00x54
> -#define GPMC_PREFETCH_CONFIG1 =A00x1e0
> -#define GPMC_PREFETCH_CONFIG2 =A00x1e4
> -#define GPMC_PREFETCH_CONTROL =A00x1ec
> -#define GPMC_PREFETCH_STATUS =A0 0x1f0
> -#define GPMC_ECC_CONFIG =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x1f4
> -#define GPMC_ECC_CONTROL =A0 =A0 =A0 0x1f8
> -#define GPMC_ECC_SIZE_CONFIG =A0 0x1fc
> -
> -#define GPMC_CS0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x60
> -#define GPMC_CS_SIZE =A0 =A0 =A0 =A0 =A0 0x30
> -
> +#define GPMC_REVISION =A0 =A0 =A0 =A0 =A0 0x00
> +#define GPMC_SYSCONFIG =A0 =A0 =A0 =A0 =A00x10
> +#define GPMC_SYSSTATUS =A0 =A0 =A0 =A0 =A00x14
> +#define GPMC_IRQSTATUS =A0 =A0 =A0 =A0 =A00x18
> +#define GPMC_IRQENABLE =A0 =A0 =A0 =A0 =A00x1c
> +#define GPMC_TIMEOUT_CONTROL =A0 =A00x40
> +#define GPMC_ERR_ADDRESS =A0 =A0 =A0 =A00x44
> +#define GPMC_ERR_TYPE =A0 =A0 =A0 =A0 =A0 0x48
> +#define GPMC_CONFIG =A0 =A0 =A0 =A0 =A0 =A0 0x50
> +#define GPMC_STATUS =A0 =A0 =A0 =A0 =A0 =A0 0x54
> +#define GPMC_PREFETCH_CONFIG1 =A0 0x1e0
> +#define GPMC_PREFETCH_CONFIG2 =A0 0x1e4
> +#define GPMC_PREFETCH_CONTROL =A0 0x1ec
> +#define GPMC_PREFETCH_STATUS =A0 =A00x1f0
> +#define GPMC_ECC_CONFIG =A0 =A0 =A0 =A0 0x1f4
> +#define GPMC_ECC_CONTROL =A0 =A0 =A0 =A00x1f8
> +#define GPMC_ECC_SIZE_CONFIG =A0 =A00x1fc
> +#define GPMC_ECC1_RESULT =A0 =A0 =A0 =A00x200
> +
> +#define GPMC_CS0_BASE =A0 =A0 =A0 =A0 =A00x60
> +#define GPMC_CS_SIZE =A0 =A0 =A0 =A0 =A0 =A00x30
> =A0#define GPMC_MEM_START =A0 =A0 =A0 =A0 0x00000000
> =A0#define GPMC_MEM_END =A0 =A0 =A0 =A0 =A0 0x3FFFFFFF
> =A0#define BOOT_ROM_SPACE =A0 =A0 =A0 =A0 0x100000 =A0 =A0 =A0 =A0/* =
1MB */
> @@ -108,11 +108,27 @@ static u32 gpmc_read_reg(int idx)
> =A0 =A0 =A0 =A0return __raw_readl(gpmc_base + idx);
> =A0}
>
> +static void gpmc_cs_write_byte(int cs, int idx, u8 val)
> +{
> + =A0 =A0 =A0 void __iomem *reg_addr;
> +
> + =A0 =A0 =A0 reg_addr =3D gpmc_base + GPMC_CS0_BASE + (cs * GPMC_CS_=
SIZE) + idx;
> + =A0 =A0 =A0 __raw_writeb(val, reg_addr);
> +}
> +
> +static u8 gpmc_cs_read_byte(int cs, int idx)
> +{
> + =A0 =A0 =A0 void __iomem *reg_addr;
> +
> + =A0 =A0 =A0 reg_addr =3D gpmc_base + GPMC_CS0_BASE + (cs * GPMC_CS_=
SIZE) + idx;
> + =A0 =A0 =A0 return __raw_readb(reg_addr);
> +}
> +

I do not think we need these functions.

> =A0void gpmc_cs_write_reg(int cs, int idx, u32 val)
> =A0{
> =A0 =A0 =A0 =A0void __iomem *reg_addr;
>
> - =A0 =A0 =A0 reg_addr =3D gpmc_base + GPMC_CS0 + (cs * GPMC_CS_SIZE)=
 + idx;
> + =A0 =A0 =A0 reg_addr =3D gpmc_base + GPMC_CS0_BASE + (cs * GPMC_CS_=
SIZE) + idx;
> =A0 =A0 =A0 =A0__raw_writel(val, reg_addr);
> =A0}
>
> @@ -120,7 +136,7 @@ u32 gpmc_cs_read_reg(int cs, int idx)
> =A0{
> =A0 =A0 =A0 =A0void __iomem *reg_addr;
>
> - =A0 =A0 =A0 reg_addr =3D gpmc_base + GPMC_CS0 + (cs * GPMC_CS_SIZE)=
 + idx;
> + =A0 =A0 =A0 reg_addr =3D gpmc_base + GPMC_CS0_BASE + (cs * GPMC_CS_=
SIZE) + idx;
> =A0 =A0 =A0 =A0return __raw_readl(reg_addr);
> =A0}
>
> @@ -419,6 +435,96 @@ void gpmc_cs_free(int cs)
> =A0EXPORT_SYMBOL(gpmc_cs_free);
>
> =A0/**
> + * gpmc_hwcontrol - hardware specific access (read/ write) to contro=
l
> + * @write: need 1 for configure; 0 for reading the complete register
> + * @cs: chip select number
> + * @cmd: Command type
> + * @wval: value/information to write
> + * @rval: pointer to get the value back
> + */
> +int gpmc_hwcontrol(int write, int cs, int cmd, int wval, int *rval)
> +{
> + =A0 =A0 =A0 u32 reg =3D 0;
> + =A0 =A0 =A0 u32 regval =3D 0;
> +
> + =A0 =A0 =A0 switch (cmd) {
> +
> + =A0 =A0 =A0 case GPMC_GET_SET_STATUS:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D GPMC_STATUS;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (write)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpmc_write_reg(GPMC_STA=
TUS, regval);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> +
> + =A0 =A0 =A0 case GPMC_GET_SET_IRQ_STATUS:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D GPMC_IRQSTATUS;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (write)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpmc_write_reg(GPMC_IRQ=
STATUS, regval);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> +
> + =A0 =A0 =A0 case GPMC_GET_PREF_STATUS:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D GPMC_PREFETCH_STATUS;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> +
> + =A0 =A0 =A0 case GPMC_CONFIG_WP:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D GPMC_CONFIG;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 regval =3D gpmc_read_reg(GPMC_CONFIG);
> + =A0 =A0 =A0 =A0 =A0 if (wval)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 regval &=3D ~GPMC_CONFI=
G_WRITEPROTECT; /* WP is ON */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 regval |=3D GPMC_CONFIG=
_WRITEPROTECT; =A0/* WP is OFF */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpmc_write_reg(reg, regval);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> +
> + =A0 =A0 =A0 case GPMC_CONFIG_RDY_BSY:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 #define WR_RD_PIN_MONITORING =A0 =A00x0=
0600000
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 regval =A0=3D gpmc_cs_read_reg(cs, GPMC=
_CS_CONFIG1);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 regval |=3D WR_RD_PIN_MONITORING;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpmc_cs_write_reg(cs, GPMC_CS_CONFIG1, =
regval);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> +
> + =A0 =A0 =A0 case GPMC_CONFIG_DEV_SIZE:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 regval =A0=3D gpmc_cs_read_reg(cs, GPMC=
_CS_CONFIG1);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 regval |=3D GPMC_CONFIG1_DEVICESIZE(wva=
l);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpmc_cs_write_reg(cs, GPMC_CS_CONFIG1, =
regval);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> +
> + =A0 =A0 =A0 case GPMC_CONFIG_DEV_TYPE:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 regval =A0=3D gpmc_cs_read_reg(cs, GPMC=
_CS_CONFIG1);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 regval |=3D GPMC_CONFIG1_DEVICETYPE(wva=
l);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (wval =3D=3D GPMC_DEVICETYPE_NOR)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 regval |=3D GPMC_CONFIG=
1_MUXADDDATA;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpmc_cs_write_reg(cs, GPMC_CS_CONFIG1, =
regval);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> +
> + =A0 =A0 =A0 case GPMC_NAND_COMMAND:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpmc_cs_write_byte(cs, GPMC_CS_NAND_COM=
MAND, wval);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> +
> + =A0 =A0 =A0 case GPMC_NAND_ADDRESS:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpmc_cs_write_byte(cs, GPMC_CS_NAND_ADD=
RESS, wval);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> +
> + =A0 =A0 =A0 case GPMC_NAND_DATA:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (write)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpmc_cs_write_byte(cs, =
GPMC_CS_NAND_DATA, wval);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *rval =3D gpmc_cs_read_=
byte(cs, GPMC_CS_NAND_DATA);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> +
> + =A0 =A0 =A0 default:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dump_stack();
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "not supported\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -1;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 if (!write && reg)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 *rval =3D gpmc_read_reg(reg);
> +
> + =A0 =A0 =A0 return 0;
> +}
> +EXPORT_SYMBOL(gpmc_hwcontrol);
> +
> +/**
> =A0* gpmc_prefetch_enable - configures and starts prefetch transfer
> =A0* @cs: nand cs (chip select) number
> =A0* @dma_mode: dma mode enable (1) or disable (0)
> @@ -466,15 +572,6 @@ void gpmc_prefetch_reset(void)
> =A0}
> =A0EXPORT_SYMBOL(gpmc_prefetch_reset);
>
> -/**
> - * gpmc_prefetch_status - reads prefetch status of engine
> - */
> -int =A0gpmc_prefetch_status(void)
> -{
> - =A0 =A0 =A0 return gpmc_read_reg(GPMC_PREFETCH_STATUS);
> -}
> -EXPORT_SYMBOL(gpmc_prefetch_status);
> -
> =A0static void __init gpmc_mem_init(void)
> =A0{
> =A0 =A0 =A0 =A0int cs;
> @@ -615,3 +712,86 @@ void omap3_gpmc_restore_context(void)
> =A0 =A0 =A0 =A0}
> =A0}
> =A0#endif /* CONFIG_ARCH_OMAP3 */
> +
> +/**
> + * gmpc_ecc_init - Initialize the HW ECC for NAND flash in GPMC cont=
roller
> + * @cs: Chip select number
> + * @ecc_size: bytes for which ECC will be generated
> + */
> +void gpmc_ecc_init(int cs, int ecc_size)
> +{
> + =A0 =A0 =A0 unsigned int val =3D 0x0;
> +
> + =A0 =A0 =A0 /* Read from ECC Control Register */
> + =A0 =A0 =A0 val =3D gpmc_read_reg(GPMC_ECC_CONTROL);
> +
> + =A0 =A0 =A0 /* Clear all ECC | Enable Reg1 */
> + =A0 =A0 =A0 val =3D ((0x00000001<<8) | 0x00000001);
> + =A0 =A0 =A0 gpmc_write_reg(GPMC_ECC_CONTROL, val);
> +
> + =A0 =A0 =A0 /* Read from ECC Size Config Register */
> + =A0 =A0 =A0 val =3D gpmc_read_reg(GPMC_ECC_SIZE_CONFIG);
> + =A0 =A0 =A0 /* ECCSIZE1=3D512 | Select eccResultsize[0-3] */
> + =A0 =A0 =A0 val =3D ((((ecc_size >> 1) - 1) << 22) | (0x0000000F));
> + =A0 =A0 =A0 gpmc_write_reg(GPMC_ECC_SIZE_CONFIG, val);
> +}
> +
> +/**
> + * gpmc_calcuate_ecc - Generate non-inverted ECC bytes.
> + * @cs: Chip select number
> + * @dat: The pointer to data on which ecc is computed
> + * @ecc_code: The ecc_code buffer
> + *
> + * Using noninverted ECC can be considered ugly since writing a blan=
k
> + * page ie. padding will clear the ECC bytes. This is no problem as =
long
> + * nobody is trying to write data on the seemingly unused page. Read=
ing
> + * an erased page will produce an ECC mismatch between generated and=
 read
> + * ECC bytes that has to be dealt with separately.
> + */
> +int gpmc_calculate_ecc(int cs, const u_char *dat, u_char *ecc_code)
> +{
> + =A0 =A0 =A0 unsigned int val =3D 0x0;
> +
> + =A0 =A0 =A0 /* Start Reading from HW ECC1_Result =3D 0x200 */
> + =A0 =A0 =A0 val =3D gpmc_read_reg(GPMC_ECC1_RESULT);
> + =A0 =A0 =A0 *ecc_code++ =3D val; =A0 =A0 =A0 =A0 =A0/* P128e, ..., =
P1e */
> + =A0 =A0 =A0 *ecc_code++ =3D val >> 16; =A0 =A0/* P128o, ..., P1o */
> + =A0 =A0 =A0 /* P2048o, P1024o, P512o, P256o, P2048e, P1024e, P512e,=
 P256e */
> + =A0 =A0 =A0 *ecc_code++ =3D ((val >> 8) & 0x0f) | ((val >> 20) & 0x=
f0);
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> +/**
> + * gpmc_enable_hwecc - This function enables the hardware ecc functi=
onality
> + * @cs: Chip select number
> + * @mode: Read/Write mode
> + * @dev_width: device bus width
> + */
> +void gpmc_enable_hwecc(int cs, int mode, int dev_width)
> +{
> + =A0 =A0 =A0 unsigned int val =3D gpmc_read_reg(GPMC_ECC_CONFIG);
> +
> + =A0 =A0 =A0 switch (mode) {
> + =A0 =A0 =A0 case GPMC_ECC_READ:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpmc_write_reg(GPMC_ECC_CONTROL, 0x101)=
;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* (ECC 16 or 8 bit col) | ( CS =A0) =A0=
| ECC Enable */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 val =3D (dev_width << 7) | (cs << 1) | =
(0x1);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 case GPMC_ECC_READSYN:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0gpmc_write_reg(GPMC_ECC_CONTROL, 0x1=
00);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* (ECC 16 or 8 bit col) | ( CS =A0) =A0=
| ECC Enable */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 val =3D (dev_width << 7) | (cs << 1) | =
(0x1);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 case GPMC_ECC_WRITE:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpmc_write_reg(GPMC_ECC_CONTROL, 0x101)=
;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* (ECC 16 or 8 bit col) | ( CS =A0) =A0=
| ECC Enable */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 val =3D (dev_width << 7) | (cs << 1) | =
(0x1);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 default:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_INFO "Error: Unrecognized M=
ode[%d]!\n", mode);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 gpmc_write_reg(GPMC_ECC_CONFIG, val);
> +}
> diff --git a/arch/arm/plat-omap/include/plat/gpmc.h b/arch/arm/plat-o=
map/include/plat/gpmc.h
> index 145838a..56e1407
> --- a/arch/arm/plat-omap/include/plat/gpmc.h
> +++ b/arch/arm/plat-omap/include/plat/gpmc.h
> @@ -25,10 +25,22 @@
> =A0#define GPMC_CS_NAND_ADDRESS =A0 0x20
> =A0#define GPMC_CS_NAND_DATA =A0 =A0 =A00x24
>
> -#define GPMC_CONFIG =A0 =A0 =A0 =A0 =A0 =A00x50
> -#define GPMC_STATUS =A0 =A0 =A0 =A0 =A0 =A00x54
> -#define GPMC_CS0_BASE =A0 =A0 =A0 =A0 =A00x60
> -#define GPMC_CS_SIZE =A0 =A0 =A0 =A0 =A0 0x30
> +/* Control Commands */
> +#define GPMC_GET_SET_STATUS =A0 =A00x00000001
> +#define GPMC_CONFIG_WP =A0 =A0 =A0 =A0 0x00000002
> +#define GPMC_CONFIG_RDY_BSY =A0 =A00x00000003
> +#define GPMC_CONFIG_DEV_SIZE =A0 0x00000004
> +#define GPMC_CONFIG_DEV_TYPE =A0 =A00x00000005
> +#define GPMC_NAND_COMMAND =A0 =A0 =A00x00000006
> +#define GPMC_NAND_ADDRESS =A0 =A0 =A00x00000007
> +#define GPMC_NAND_DATA =A0 =A0 =A0 =A0 0x00000008
> +#define GPMC_GET_PREF_STATUS =A0 0x00000009
> +#define GPMC_GET_SET_IRQ_STATUS =A0 =A0 =A0 =A00x0000000a
> +
> +/* ECC commands */
> +#define GPMC_ECC_READ =A0 =A0 =A0 =A0 =A00 /* Reset Hardware ECC for=
 read */
> +#define GPMC_ECC_WRITE =A0 =A0 =A0 =A0 1 /* Reset Hardware ECC for w=
rite */
> +#define GPMC_ECC_READSYN =A0 =A0 =A0 2 /* Reset before syndrom is re=
ad back */
>
> =A0#define GPMC_CONFIG1_WRAPBURST_SUPP =A0 =A0 (1 << 31)
> =A0#define GPMC_CONFIG1_READMULTIPLE_SUPP =A0(1 << 30)
> @@ -44,10 +56,7 @@
> =A0#define GPMC_CONFIG1_WAIT_MON_IIME(val) ((val & 3) << 18)
> =A0#define GPMC_CONFIG1_WAIT_PIN_SEL(val) =A0((val & 3) << 16)
> =A0#define GPMC_CONFIG1_DEVICESIZE(val) =A0 =A0((val & 3) << 12)
> -#define GPMC_CONFIG1_DEVICESIZE_16 =A0 =A0 =A0GPMC_CONFIG1_DEVICESIZ=
E(1)
> =A0#define GPMC_CONFIG1_DEVICETYPE(val) =A0 =A0((val & 3) << 10)
> -#define GPMC_CONFIG1_DEVICETYPE_NOR =A0 =A0 GPMC_CONFIG1_DEVICETYPE(=
0)
> -#define GPMC_CONFIG1_DEVICETYPE_NAND =A0 =A0GPMC_CONFIG1_DEVICETYPE(=
2)
> =A0#define GPMC_CONFIG1_MUXADDDATA =A0 =A0 =A0 =A0 (1 << 9)
> =A0#define GPMC_CONFIG1_TIME_PARA_GRAN =A0 =A0 (1 << 4)
> =A0#define GPMC_CONFIG1_FCLK_DIV(val) =A0 =A0 =A0(val & 3)
> @@ -56,6 +65,12 @@
> =A0#define GPMC_CONFIG1_FCLK_DIV4 =A0 =A0 =A0 =A0 =A0(GPMC_CONFIG1_FC=
LK_DIV(3))
> =A0#define GPMC_CONFIG7_CSVALID =A0 =A0 =A0 =A0 =A0 (1 << 6)
>
> +#define GPMC_DEVICETYPE_NOR =A0 =A00
> +#define GPMC_DEVICETYPE_NAND =A0 2
> +#define GPMC_CONFIG_WRITEPROTECT =A0 =A0 =A0 0x00000010
> +#define GPMC_CONFIG1_DEVICESIZE_16 =A0 =A0 GPMC_CONFIG1_DEVICESIZE(1=
)
> +
> +
> =A0/*
> =A0* Note that all values in this struct are in nanoseconds, while
> =A0* the register values are in gpmc_fck cycles.
> @@ -109,9 +124,14 @@ extern int gpmc_cs_reserved(int cs);
> =A0extern int gpmc_prefetch_enable(int cs, int dma_mode,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0unsigned int u32_count, int is_write);
> =A0extern void gpmc_prefetch_reset(void);
> -extern int gpmc_prefetch_status(void);
> =A0extern void omap3_gpmc_save_context(void);
> =A0extern void omap3_gpmc_restore_context(void);
> =A0extern void gpmc_init(void);
> +extern int gpmc_hwcontrol(int write, int cs, int cmd, int wval, int =
*rval);
> +
> +void gpmc_ecc_init(int cs, int ecc_size);
> +void gpmc_enable_hwecc(int cs, int mode, int dev_width);
> +int gpmc_calculate_ecc(int cs, const u_char *dat, u_char *ecc_code);
> +
>
> =A0#endif
> diff --git a/arch/arm/plat-omap/include/plat/nand.h b/arch/arm/plat-o=
map/include/plat/nand.h
> index f8efd54..6562cd0
> --- a/arch/arm/plat-omap/include/plat/nand.h
> +++ b/arch/arm/plat-omap/include/plat/nand.h
> @@ -21,13 +21,11 @@ struct omap_nand_platform_data {
> =A0 =A0 =A0 =A0int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (*dev_read=
y)(struct omap_nand_platform_data *);
> =A0 =A0 =A0 =A0int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dma_channe=
l;
> =A0 =A0 =A0 =A0unsigned long =A0 =A0 =A0 =A0 =A0 phys_base;
> - =A0 =A0 =A0 void __iomem =A0 =A0 =A0 =A0 =A0 =A0*gpmc_cs_baseaddr;
> - =A0 =A0 =A0 void __iomem =A0 =A0 =A0 =A0 =A0 =A0*gpmc_baseaddr;
> =A0 =A0 =A0 =A0int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 devsize;
> =A0};
>
> -/* size (4 KiB) for IO mapping */
> -#define =A0 =A0 =A0 =A0NAND_IO_SIZE =A0 =A0SZ_4K
> +/* minimum size for IO mapping */
> +#define =A0 =A0 =A0 =A0NAND_IO_SIZE =A0 =A04
>
> =A0#if defined(CONFIG_MTD_NAND_OMAP2) || defined(CONFIG_MTD_NAND_OMAP=
2_MODULE)
> =A0extern int gpmc_nand_init(struct omap_nand_platform_data *d);
> diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
> index 7545568..1858c42
> --- a/drivers/mtd/nand/omap2.c
> +++ b/drivers/mtd/nand/omap2.c
> @@ -23,12 +23,6 @@
> =A0#include <plat/gpmc.h>
> =A0#include <plat/nand.h>
>
> -#define GPMC_IRQ_STATUS =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x18
> -#define GPMC_ECC_CONFIG =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x1F4
> -#define GPMC_ECC_CONTROL =A0 =A0 =A0 0x1F8
> -#define GPMC_ECC_SIZE_CONFIG =A0 0x1FC
> -#define GPMC_ECC1_RESULT =A0 =A0 =A0 0x200
> -
> =A0#define =A0 =A0 =A0 =A0DRIVER_NAME =A0 =A0 "omap2-nand"
>
> =A0#define =A0 =A0 =A0 =A0NAND_WP_OFF =A0 =A0 0
> @@ -37,6 +31,7 @@
> =A0#define =A0 =A0 =A0 =A0GPMC_BUF_FULL =A0 0x00000001
> =A0#define =A0 =A0 =A0 =A0GPMC_BUF_EMPTY =A00x00000000
>
> +#ifdef CONFIG_MTD_NAND_OMAP_HWECC
> =A0#define NAND_Ecc_P1e =A0 =A0 =A0 =A0 =A0 (1 << 0)
> =A0#define NAND_Ecc_P2e =A0 =A0 =A0 =A0 =A0 (1 << 1)
> =A0#define NAND_Ecc_P4e =A0 =A0 =A0 =A0 =A0 (1 << 2)
> @@ -103,6 +98,7 @@
>
> =A0#define P4e_s(a) =A0 =A0 =A0 (TF(a & NAND_Ecc_P4e) =A0 =A0 =A0 =A0=
 =A0 << 0)
> =A0#define P4o_s(a) =A0 =A0 =A0 (TF(a & NAND_Ecc_P4o) =A0 =A0 =A0 =A0=
 =A0 << 1)
> +#endif /* CONFIG_MTD_NAND_OMAP_HWECC */

Why this ifdef macro?

>
> =A0#ifdef CONFIG_MTD_PARTITIONS
> =A0static const char *part_probes[] =3D { "cmdlinepart", NULL };
> @@ -139,34 +135,11 @@ struct omap_nand_info {
>
> =A0 =A0 =A0 =A0int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 gpmc_cs;
> =A0 =A0 =A0 =A0unsigned long =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 phys=
_base;
> - =A0 =A0 =A0 void __iomem =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*gp=
mc_cs_baseaddr;
> - =A0 =A0 =A0 void __iomem =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*gp=
mc_baseaddr;
> - =A0 =A0 =A0 void __iomem =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*na=
nd_pref_fifo_add;
> =A0 =A0 =A0 =A0struct completion =A0 =A0 =A0 =A0 =A0 =A0 =A0 comp;
> =A0 =A0 =A0 =A0int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 dma_ch;
> =A0};
>
> =A0/**
> - * omap_nand_wp - This function enable or disable the Write Protect =
feature
> - * @mtd: MTD device structure
> - * @mode: WP ON/OFF
> - */
> -static void omap_nand_wp(struct mtd_info *mtd, int mode)
> -{
> - =A0 =A0 =A0 struct omap_nand_info *info =3D container_of(mtd,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 struct omap_nand_info, mtd);
> -
> - =A0 =A0 =A0 unsigned long config =3D __raw_readl(info->gpmc_baseadd=
r + GPMC_CONFIG);
> -
> - =A0 =A0 =A0 if (mode)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 config &=3D ~(NAND_WP_BIT); =A0 =A0 =A0=
 /* WP is ON */
> - =A0 =A0 =A0 else
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 config |=3D (NAND_WP_BIT); =A0 =A0 =A0 =
=A0/* WP is OFF */
> -
> - =A0 =A0 =A0 __raw_writel(config, (info->gpmc_baseaddr + GPMC_CONFIG=
));
> -}
> -
> -/**
> =A0* omap_hwcontrol - hardware specific access to control-lines
> =A0* @mtd: MTD device structure
> =A0* @cmd: command to device
> @@ -181,31 +154,20 @@ static void omap_hwcontrol(struct mtd_info *mtd=
, int cmd, unsigned int ctrl)
> =A0{
> =A0 =A0 =A0 =A0struct omap_nand_info *info =3D container_of(mtd,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0struct omap_nand_info, mtd);
> - =A0 =A0 =A0 switch (ctrl) {
> - =A0 =A0 =A0 case NAND_CTRL_CHANGE | NAND_CTRL_CLE:
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 info->nand.IO_ADDR_W =3D info->gpmc_cs_=
baseaddr +
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 GPMC_CS_NAND_COMMAND;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 info->nand.IO_ADDR_R =3D info->gpmc_cs_=
baseaddr +
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 GPMC_CS_NAND_DATA;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> -
> - =A0 =A0 =A0 case NAND_CTRL_CHANGE | NAND_CTRL_ALE:
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 info->nand.IO_ADDR_W =3D info->gpmc_cs_=
baseaddr +
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 GPMC_CS_NAND_ADDRESS;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 info->nand.IO_ADDR_R =3D info->gpmc_cs_=
baseaddr +
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 GPMC_CS_NAND_DATA;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> -
> - =A0 =A0 =A0 case NAND_CTRL_CHANGE | NAND_NCE:
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 info->nand.IO_ADDR_W =3D info->gpmc_cs_=
baseaddr +
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 GPMC_CS_NAND_DATA;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 info->nand.IO_ADDR_R =3D info->gpmc_cs_=
baseaddr +
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 GPMC_CS_NAND_DATA;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> - =A0 =A0 =A0 }
>
> - =A0 =A0 =A0 if (cmd !=3D NAND_CMD_NONE)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 __raw_writeb(cmd, info->nand.IO_ADDR_W)=
;
> + =A0 =A0 =A0 if (cmd !=3D NAND_CMD_NONE) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ctrl & NAND_CLE) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpmc_hwcontrol(1, info-=
>gpmc_cs,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 GPMC_NAND_COMMAND, cmd, NULL);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else if (ctrl & NAND_ALE) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpmc_hwcontrol(1, info-=
>gpmc_cs,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 GPMC_NAND_ADDRESS, cmd, NULL);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else /* NAND_NCE */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpmc_hwcontrol(1, info-=
>gpmc_cs,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 GPMC_NAND_DATA, cmd, NULL);
> + =A0 =A0 =A0 }
> =A0}
>
> =A0/**
> @@ -229,14 +191,15 @@ static void omap_read_buf8(struct mtd_info *mtd=
, u_char *buf, int len)
> =A0*/
> =A0static void omap_write_buf8(struct mtd_info *mtd, const u_char *bu=
f, int len)
> =A0{
> - =A0 =A0 =A0 struct omap_nand_info *info =3D container_of(mtd,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 struct omap_nand_info, mtd);
> + =A0 =A0 =A0 u32 =A0 =A0 status;
> + =A0 =A0 =A0 struct nand_chip *nand =3D mtd->priv;
> =A0 =A0 =A0 =A0u_char *p =3D (u_char *)buf;
>
> =A0 =A0 =A0 =A0while (len--) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 iowrite8(*p++, info->nand.IO_ADDR_W);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 while (GPMC_BUF_EMPTY =3D=3D (readl(inf=
o->gpmc_baseaddr +
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 GPMC_STATUS) & GPMC_BUF_FULL));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 iowrite8(*p++, nand->IO_ADDR_W);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpmc_hwcontrol(0, 0, GPMC_GET_SET_STATU=
S, 0, &status);
If I am not mistaking, 2nd argument is 'cs', correct? And then, why
are you hard coding this?
Different boards will have NAND chip present at different 'cs'.
Please have a look at uses of 'gpmc_hwcontrol' elsewhere as well for th=
is.

Again, say, you got '(status & GPMC_BUF_FULL) !=3D GPMC_BUF_EMPTY', the=
n:

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 while (GPMC_BUF_EMPTY =3D=3D (status & =
GPMC_BUF_FULL))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ;

You got in an infinite loop here?

> =A0 =A0 =A0 =A0}
> =A0}
>
> @@ -261,18 +224,17 @@ static void omap_read_buf16(struct mtd_info *mt=
d, u_char *buf, int len)
> =A0*/
> =A0static void omap_write_buf16(struct mtd_info *mtd, const u_char * =
buf, int len)
> =A0{
> - =A0 =A0 =A0 struct omap_nand_info *info =3D container_of(mtd,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 struct omap_nand_info, mtd);
> + =A0 =A0 =A0 u32 =A0 =A0 status;
> + =A0 =A0 =A0 struct nand_chip *nand =3D mtd->priv;
> =A0 =A0 =A0 =A0u16 *p =3D (u16 *) buf;
>
> =A0 =A0 =A0 =A0/* FIXME try bursts of writesw() or DMA ... */
> =A0 =A0 =A0 =A0len >>=3D 1;
>
> =A0 =A0 =A0 =A0while (len--) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 iowrite16(*p++, info->nand.IO_ADDR_W);
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 while (GPMC_BUF_EMPTY =3D=3D (readl(inf=
o->gpmc_baseaddr +
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 GPMC_STATUS) & GPMC_BUF_FULL))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 iowrite16(*p++, nand->IO_ADDR_W);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpmc_hwcontrol(0, 0, GPMC_GET_SET_STATU=
S, 0, &status);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 while (GPMC_BUF_EMPTY =3D=3D (status & =
GPMC_BUF_FULL))

same as above.


--=20
Regards,
Vimal Singh
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
