From: Vimal Singh <vimal.newwork@gmail.com>
Subject: Re: [PATCH v3 1/3] omap3 gpmc: functionality enhancement
Date: Wed, 19 May 2010 20:16:43 +0530
Message-ID: <AANLkTikFxtzDpiJvJjnuonM2urMJR1LDLafx5JtpC_bS@mail.gmail.com>
References: <s-ghorai@ti.com> <1274181389-7488-1-git-send-email-s-ghorai@ti.com>
	<1274181389-7488-2-git-send-email-s-ghorai@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:61005 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751999Ab0ESOrF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 May 2010 10:47:05 -0400
Received: by pxi18 with SMTP id 18so807683pxi.19
        for <linux-omap@vger.kernel.org>; Wed, 19 May 2010 07:47:03 -0700 (PDT)
In-Reply-To: <1274181389-7488-2-git-send-email-s-ghorai@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sukumar Ghorai <s-ghorai@ti.com>
Cc: linux-omap@vger.kernel.org, linux-mtd@lists.infradead.org, tony@atomide.com, sakoman@gmail.com, mike@compulab.co.il, Artem.Bityutskiy@nokia.com

On Tue, May 18, 2010 at 4:46 PM, Sukumar Ghorai <s-ghorai@ti.com> wrote=
:
> few functions added in gpmc module and to be used by other drivers li=
ke NAND.
> E.g.: - ioctl function
> =A0 =A0 =A0- ecc functions
>
> Signed-off-by: Sukumar Ghorai <s-ghorai@ti.com>
> ---
> =A0arch/arm/mach-omap2/gpmc.c =A0 =A0 =A0 =A0 =A0 =A0 | =A0246 ++++++=
+++++++++++++++++++++++++-
> =A0arch/arm/plat-omap/include/plat/gpmc.h | =A0 35 ++++-
> =A0drivers/mtd/nand/omap2.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A04 +-
> =A03 files changed, 274 insertions(+), 11 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
> index 5bc3ca0..7e6d821
> --- a/arch/arm/mach-omap2/gpmc.c
> +++ b/arch/arm/mach-omap2/gpmc.c
> @@ -46,8 +46,9 @@
> =A0#define GPMC_ECC_CONFIG =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x1f4
> =A0#define GPMC_ECC_CONTROL =A0 =A0 =A0 0x1f8
> =A0#define GPMC_ECC_SIZE_CONFIG =A0 0x1fc
> +#define GPMC_ECC1_RESULT =A0 =A0 =A0 =A00x200
>
> -#define GPMC_CS0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x60
> +#define GPMC_CS0_BASE =A0 =A0 =A0 =A0 =A00x60
> =A0#define GPMC_CS_SIZE =A0 =A0 =A0 =A0 =A0 0x30
>
> =A0#define GPMC_MEM_START =A0 =A0 =A0 =A0 0x00000000
> @@ -92,7 +93,9 @@ struct omap3_gpmc_regs {
> =A0static struct resource gpmc_mem_root;
> =A0static struct resource gpmc_cs_mem[GPMC_CS_NUM];
> =A0static DEFINE_SPINLOCK(gpmc_mem_lock);
> -static unsigned =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0gpmc_cs_map;
> +static unsigned =A0 =A0 =A0 =A0int gpmc_cs_map; =A0 =A0 =A0 =A0/* fl=
ag for cs which are initialized */
> +static int gpmc_pref_used =3D -EINVAL; =A0 /* cs using prefetch engi=
ne */
> +static int gpmc_ecc_used =3D -EINVAL; =A0 =A0/* cs using ecc engine =
*/
>
> =A0static void __iomem *gpmc_base;
>
> @@ -108,11 +111,27 @@ static u32 gpmc_read_reg(int idx)
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
> @@ -120,7 +139,7 @@ u32 gpmc_cs_read_reg(int cs, int idx)
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
> @@ -419,8 +438,100 @@ void gpmc_cs_free(int cs)
> =A0EXPORT_SYMBOL(gpmc_cs_free);
>
> =A0/**
> + * gpmc_hwcontrol - hardware specific access (read/ write) control
> + * @cs: chip select number
> + * @cmd: command type
> + * @write: 1 for write; 0 for read
> + * @wval: value to write
> + * @rval: read pointer
> + */
> +int gpmc_hwcontrol(int cs, int cmd, int write, int wval, int *rval)
> +{
> + =A0 =A0 =A0 u32 regval =3D 0;
> +
> + =A0 =A0 =A0 if (!write && !rval)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> +
> + =A0 =A0 =A0 switch (cmd) {
> + =A0 =A0 =A0 case GPMC_STATUS_BUFFER:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 regval =3D gpmc_read_reg(GPMC_STATUS);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* 1 : buffer is available to write */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 *rval =3D regval & GPMC_STATUS_BUFF_EMP=
TY;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> +
> + =A0 =A0 =A0 case GPMC_GET_SET_IRQ_STATUS:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (write)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpmc_write_reg(GPMC_IRQ=
STATUS, wval);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *rval =3D gpmc_read_reg=
(GPMC_IRQSTATUS);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> +
> + =A0 =A0 =A0 case GPMC_PREFETCH_FIFO_CNT:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 regval =3D gpmc_read_reg(GPMC_PREFETCH_=
STATUS);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 *rval =3D GPMC_PREFETCH_STATUS_FIFO_CNT=
(regval);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> +
> + =A0 =A0 =A0 case GPMC_PREFETCH_COUNT:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 regval =3D gpmc_read_reg(GPMC_PREFETCH_=
STATUS);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 *rval =3D GPMC_PREFETCH_STATUS_COUNT(re=
gval);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> +
> + =A0 =A0 =A0 case GPMC_CONFIG_WP:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 regval =3D gpmc_read_reg(GPMC_CONFIG);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (wval)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 regval &=3D ~GPMC_CONFI=
G_WRITEPROTECT; /* WP is ON */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 regval |=3D GPMC_CONFIG=
_WRITEPROTECT; =A0/* WP is OFF */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpmc_write_reg(GPMC_CONFIG, regval);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> +
> + =A0 =A0 =A0 case GPMC_CONFIG_RDY_BSY:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 regval =A0=3D gpmc_cs_read_reg(cs, GPMC=
_CS_CONFIG1);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 regval |=3D WR_RD_PIN_MONITORING;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpmc_cs_write_reg(cs, GPMC_CS_CONFIG1, =
regval);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;

IIRC, at least in OMAP2/3, ready/busy pin is not in use (not connected)=
=2E

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
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "gpmc_hwcontrol: Not su=
pported\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 return 0;
> +}
> +EXPORT_SYMBOL(gpmc_hwcontrol);
> +
> +/**
> =A0* gpmc_prefetch_enable - configures and starts prefetch transfer
> - * @cs: nand cs (chip select) number
> + * @cs: cs (chip select) number
> =A0* @dma_mode: dma mode enable (1) or disable (0)
> =A0* @u32_count: number of bytes to be transferred
> =A0* @is_write: prefetch read(0) or write post(1) mode
> @@ -430,6 +541,11 @@ int gpmc_prefetch_enable(int cs, int dma_mode,
> =A0{
> =A0 =A0 =A0 =A0uint32_t prefetch_config1;
>
> + =A0 =A0 =A0 if (gpmc_pref_used =3D=3D -EINVAL)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpmc_pref_used =3D cs;
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EBUSY;

This is  not required. Prefetch engine has just one instance

> +
> =A0 =A0 =A0 =A0if (!(gpmc_read_reg(GPMC_PREFETCH_CONTROL))) {

and any prefetch request will be done only if above check passes.
Which actually checks if 'prefetch' is busy or not.
You can see in NAND driver (omap2.c) code, it understands that.

> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Set the amount of bytes to be prefe=
tched */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0gpmc_write_reg(GPMC_PREFETCH_CONFIG2, =
u32_count);
> @@ -456,13 +572,20 @@ EXPORT_SYMBOL(gpmc_prefetch_enable);
> =A0/**
> =A0* gpmc_prefetch_reset - disables and stops the prefetch engine
> =A0*/
> -void gpmc_prefetch_reset(void)
> +int gpmc_prefetch_reset(int cs)
> =A0{
> + =A0 =A0 =A0 if (gpmc_pref_used =3D=3D cs)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpmc_pref_used =3D -EINVAL;
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> +

This is also not required. As, this function will be called only if
prefetch was used.

> =A0 =A0 =A0 =A0/* Stop the PFPW engine */
> =A0 =A0 =A0 =A0gpmc_write_reg(GPMC_PREFETCH_CONTROL, 0x0);
>
> =A0 =A0 =A0 =A0/* Reset/disable the PFPW engine */
> =A0 =A0 =A0 =A0gpmc_write_reg(GPMC_PREFETCH_CONFIG1, 0x0);
> +
> + =A0 =A0 =A0 return 0;
> =A0}
> =A0EXPORT_SYMBOL(gpmc_prefetch_reset);
>
> @@ -615,3 +738,114 @@ void omap3_gpmc_restore_context(void)
> =A0 =A0 =A0 =A0}
> =A0}
> =A0#endif /* CONFIG_ARCH_OMAP3 */
> +
> +/**
> + * gpmc_ecc_init - initialize hw ecc for device in GPMC controller
> + * @cs: chip select number
> + * @ecc_size: number of bytes for ecc generation
> + */
> +
> +int gpmc_ecc_init(int cs, int ecc_size)
> +{
> + =A0 =A0 =A0 unsigned int val =3D 0x0;
> +
> + =A0 =A0 =A0 /* check if ecc engine already by another cs */
> + =A0 =A0 =A0 if (gpmc_ecc_used =3D=3D -EINVAL)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpmc_ecc_used =3D cs;
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EBUSY;
Here few things need be to consider:
1. 'init' is supposed to done once for every instance of driver during =
probe
2. But ECC engine, too, have only one instance at a time, So
3. As long as all NAND chip are supposed to use same ECC machenism, we
can go for only one time 'init' for all drivers, perhaps in
gpmc_nand.c.
4. But in case, different instances of driver (or NAND chip) requires
different ECC machenism (for ex. Hamming or BCH, or even with
different capabilities of error correction),
this will no longer vailid. Then rather we should have something like
'gpmc_ecc_config' call to configer ECC engine for everytime a driver
needs it (something like as it is done for prefetch engine).

> +
> + =A0 =A0 =A0 /* read ecc control register */
> + =A0 =A0 =A0 val =3D gpmc_read_reg(GPMC_ECC_CONTROL);
> +
> + =A0 =A0 =A0 /* clear ecc and enable bits */
> + =A0 =A0 =A0 val =3D ((0x00000001<<8) | 0x00000001);
> + =A0 =A0 =A0 gpmc_write_reg(GPMC_ECC_CONTROL, val);
> +
> + =A0 =A0 =A0 /* Read from ECC Size Config Register */
> + =A0 =A0 =A0 val =3D gpmc_read_reg(GPMC_ECC_SIZE_CONFIG);
> +
> + =A0 =A0 =A0 /* program ecc and result sizes */
> + =A0 =A0 =A0 val =3D ((((ecc_size >> 1) - 1) << 22) | (0x0000000F));
> + =A0 =A0 =A0 gpmc_write_reg(GPMC_ECC_SIZE_CONFIG, val);
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> +/**
> + * gpmc_calculate_ecc - generate non-inverted ecc bytes
> + * @cs: chip select number
> + * @dat: data pointer over which ecc is computed
> + * @ecc_code: ecc code buffer
> + *
> + * Using non-inverted ECC is considered ugly since writing a blank
> + * page (padding) will clear the ECC bytes. This is not a problem as=
 long
> + * no one is trying to write data on the seemingly unused page. Read=
ing
> + * an erased page will produce an ECC mismatch between generated and=
 read
> + * ECC bytes that has to be dealt with separately.
> + */
> +int gpmc_calculate_ecc(int cs, const u_char *dat, u_char *ecc_code)
> +{
> + =A0 =A0 =A0 unsigned int val =3D 0x0;
> +
> + =A0 =A0 =A0 if (gpmc_ecc_used !=3D cs)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> +
> + =A0 =A0 =A0 /* read ecc result */
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
> + * gpmc_enable_hwecc - enable hardware ecc functionality
> + * @cs: chip select number
> + * @mode: read/write mode
> + * @dev_width: device bus width(1 for x16, 0 for x8)
> + */
> +int gpmc_enable_hwecc(int cs, int mode, int dev_width)
> +{
> + =A0 =A0 =A0 unsigned int val;
> +
> + =A0 =A0 =A0 if (gpmc_ecc_used !=3D cs)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> +
> + =A0 =A0 =A0 switch (mode) {
> + =A0 =A0 =A0 case GPMC_ECC_READ:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpmc_write_reg(GPMC_ECC_CONTROL, 0x101)=
;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 case GPMC_ECC_READSYN:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0gpmc_write_reg(GPMC_ECC_CONTROL, 0x1=
00);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 case GPMC_ECC_WRITE:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpmc_write_reg(GPMC_ECC_CONTROL, 0x101)=
;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 default:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_INFO "Error: Unrecognized M=
ode[%d]!\n", mode);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 /* (ECC 16 or 8 bit col) | ( CS =A0) =A0| ECC Enable */
> + =A0 =A0 =A0 val =3D (dev_width << 7) | (cs << 1) | (0x1);
> + =A0 =A0 =A0 gpmc_write_reg(GPMC_ECC_CONFIG, val);
> + =A0 =A0 =A0 return 0;
> +}
> +
> +/**
> + * gmpc_ecc_reset - release the HW ECC in GPMC controller
> + * @cs: Chip select number
> + */
> +int gpmc_ecc_reset(int cs)
> +{
> + =A0 =A0 =A0 if (gpmc_ecc_used =3D=3D cs)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpmc_ecc_used =3D -EINVAL;
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> diff --git a/arch/arm/plat-omap/include/plat/gpmc.h b/arch/arm/plat-o=
map/include/plat/gpmc.h
> index 145838a..67a3442
> --- a/arch/arm/plat-omap/include/plat/gpmc.h
> +++ b/arch/arm/plat-omap/include/plat/gpmc.h
> @@ -27,8 +27,24 @@
>
> =A0#define GPMC_CONFIG =A0 =A0 =A0 =A0 =A0 =A00x50
> =A0#define GPMC_STATUS =A0 =A0 =A0 =A0 =A0 =A00x54
> -#define GPMC_CS0_BASE =A0 =A0 =A0 =A0 =A00x60
> -#define GPMC_CS_SIZE =A0 =A0 =A0 =A0 =A0 0x30
> +
> +/* Control Commands */
> +#define GPMC_CONFIG_WP =A0 =A0 =A0 =A0 0x00000001
> +#define GPMC_CONFIG_RDY_BSY =A0 =A00x00000002
> +#define GPMC_CONFIG_DEV_SIZE =A0 0x00000003
> +#define GPMC_CONFIG_DEV_TYPE =A0 0x00000004
> +#define GPMC_NAND_COMMAND =A0 =A0 =A00x00000005
> +#define GPMC_NAND_ADDRESS =A0 =A0 =A00x00000006
> +#define GPMC_NAND_DATA =A0 =A0 =A0 =A0 0x00000007
> +#define GPMC_STATUS_BUFFER =A0 =A0 0x00000008 /* 1: buffer is availa=
ble to write */
> +#define GPMC_PREFETCH_FIFO_CNT 0x00000009 /* bytes available in FIFO=
 for r/w */
> +#define GPMC_PREFETCH_COUNT =A0 =A00x0000000A /* remaining bytes to =
be read/write*/
> +#define GPMC_GET_SET_IRQ_STATUS =A0 =A0 =A0 =A00x0000000B
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
> @@ -56,6 +72,14 @@
> =A0#define GPMC_CONFIG1_FCLK_DIV4 =A0 =A0 =A0 =A0 =A0(GPMC_CONFIG1_FC=
LK_DIV(3))
> =A0#define GPMC_CONFIG7_CSVALID =A0 =A0 =A0 =A0 =A0 (1 << 6)
>
> +#define GPMC_DEVICETYPE_NOR =A0 =A0 =A0 =A0 =A0 =A00
> +#define GPMC_DEVICETYPE_NAND =A0 =A0 =A0 =A0 =A0 2
> +#define GPMC_CONFIG_WRITEPROTECT =A0 =A0 =A0 0x00000010
> +#define GPMC_STATUS_BUFF_EMPTY =A0 =A0 =A0 =A0 0x00000001
> +#define WR_RD_PIN_MONITORING =A0 =A0 =A0 =A0 =A0 0x00600000
> +#define GPMC_PREFETCH_STATUS_FIFO_CNT(val) =A0 =A0 ((val & 0x7f00000=
0) >> 24)
> +#define GPMC_PREFETCH_STATUS_COUNT(val) =A0 =A0 =A0 =A0(val & 0x0000=
3fff)
> +
> =A0/*
> =A0* Note that all values in this struct are in nanoseconds, while
> =A0* the register values are in gpmc_fck cycles.
> @@ -108,10 +132,15 @@ extern int gpmc_cs_set_reserved(int cs, int res=
erved);
> =A0extern int gpmc_cs_reserved(int cs);
> =A0extern int gpmc_prefetch_enable(int cs, int dma_mode,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0unsigned int u32_count, int is_write);
> -extern void gpmc_prefetch_reset(void);
> +extern int gpmc_prefetch_reset(int cs);
> =A0extern int gpmc_prefetch_status(void);
> =A0extern void omap3_gpmc_save_context(void);
> =A0extern void omap3_gpmc_restore_context(void);
> =A0extern void gpmc_init(void);
> +extern int gpmc_hwcontrol(int cs, int cmd, int write, int wval, int =
*rval);
>
> +int gpmc_ecc_init(int cs, int ecc_size);
> +int gpmc_enable_hwecc(int cs, int mode, int dev_width);
> +int gpmc_calculate_ecc(int cs, const u_char *dat, u_char *ecc_code);
> +int gpmc_ecc_reset(int cs);
> =A0#endif
> diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
> index 7545568..206406b
> --- a/drivers/mtd/nand/omap2.c
> +++ b/drivers/mtd/nand/omap2.c
> @@ -316,7 +316,7 @@ static void omap_read_buf_pref(struct mtd_info *m=
td, u_char *buf, int len)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0} while (len);
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* disable and stop the PFPW engine */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpmc_prefetch_reset();
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpmc_prefetch_reset(info->gpmc_cs);
Not required. see above comments.

> =A0 =A0 =A0 =A0}
> =A0}
>
> @@ -360,7 +360,7 @@ static void omap_write_buf_pref(struct mtd_info *=
mtd,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* disable and stop the PFPW engine */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpmc_prefetch_reset();
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpmc_prefetch_reset(info->gpmc_cs);
Not required. see above comments.
> =A0 =A0 =A0 =A0}
> =A0}
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
