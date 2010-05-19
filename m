From: "Ghorai, Sukumar" <s-ghorai@ti.com>
Subject: RE: [PATCH v3 1/3] omap3 gpmc: functionality enhancement
Date: Wed, 19 May 2010 23:34:22 +0530
Message-ID: <2A3DCF3DA181AD40BDE86A3150B27B6B030D991D50@dbde02.ent.ti.com>
References: <s-ghorai@ti.com>
	 <1274181389-7488-1-git-send-email-s-ghorai@ti.com>
	 <1274181389-7488-2-git-send-email-s-ghorai@ti.com>
	 <AANLkTikFxtzDpiJvJjnuonM2urMJR1LDLafx5JtpC_bS@mail.gmail.com>
 <1274284094.6286.17.camel@thunk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:50725 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753309Ab0ESSEn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 May 2010 14:04:43 -0400
In-Reply-To: <1274284094.6286.17.camel@thunk>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vimal Singh <vimal.newwork@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, "tony@atomide.com" <tony@atomide.com>, "sakoman@gmail.com" <sakoman@gmail.com>, "mike@compulab.co.il" <mike@compulab.co.il>, "Artem.Bityutskiy@nokia.com" <Artem.Bityutskiy@nokia.com>, "peter.barada@gmail.com" <peter.barada@gmail.com>

Vimal,

> -----Original Message-----
> From: Peter Barada [mailto:peter.barada@gmail.com]
> Sent: 2010-05-19 21:18
> To: Vimal Singh
> Cc: Ghorai, Sukumar; linux-omap@vger.kernel.org; linux-
> mtd@lists.infradead.org; tony@atomide.com; sakoman@gmail.com;
> mike@compulab.co.il; Artem.Bityutskiy@nokia.com
> Subject: Re: [PATCH v3 1/3] omap3 gpmc: functionality enhancement
>
> On Wed, 2010-05-19 at 20:16 +0530, Vimal Singh wrote:
> > On Tue, May 18, 2010 at 4:46 PM, Sukumar Ghorai <s-ghorai@ti.com> wrote:
> > > few functions added in gpmc module and to be used by other drivers
> like NAND.
> > > E.g.: - ioctl function
> > >      - ecc functions
> > >
> > > Signed-off-by: Sukumar Ghorai <s-ghorai@ti.com>
> > > ---
> > >  arch/arm/mach-omap2/gpmc.c             |  246
> +++++++++++++++++++++++++++++++-
> > >  arch/arm/plat-omap/include/plat/gpmc.h |   35 ++++-
> > >  drivers/mtd/nand/omap2.c               |    4 +-
> > >  3 files changed, 274 insertions(+), 11 deletions(-)
> > >
> > > diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
> > > index 5bc3ca0..7e6d821
> > > --- a/arch/arm/mach-omap2/gpmc.c
> > > +++ b/arch/arm/mach-omap2/gpmc.c
> > > @@ -46,8 +46,9 @@
> > >  #define GPMC_ECC_CONFIG                0x1f4
> > >  #define GPMC_ECC_CONTROL       0x1f8
> > >  #define GPMC_ECC_SIZE_CONFIG   0x1fc
> > > +#define GPMC_ECC1_RESULT        0x200
> > >
> > > -#define GPMC_CS0               0x60
> > > +#define GPMC_CS0_BASE          0x60
> > >  #define GPMC_CS_SIZE           0x30
> > >
> > >  #define GPMC_MEM_START         0x00000000
> > > @@ -92,7 +93,9 @@ struct omap3_gpmc_regs {
> > >  static struct resource gpmc_mem_root;
> > >  static struct resource gpmc_cs_mem[GPMC_CS_NUM];
> > >  static DEFINE_SPINLOCK(gpmc_mem_lock);
> > > -static unsigned                gpmc_cs_map;
> > > +static unsigned        int gpmc_cs_map;        /* flag for cs which
> are initialized */
> > > +static int gpmc_pref_used = -EINVAL;   /* cs using prefetch engine */
> > > +static int gpmc_ecc_used = -EINVAL;    /* cs using ecc engine */
> > >
> > >  static void __iomem *gpmc_base;
> > >
> > > @@ -108,11 +111,27 @@ static u32 gpmc_read_reg(int idx)
> > >        return __raw_readl(gpmc_base + idx);
> > >  }
> > >
> > > +static void gpmc_cs_write_byte(int cs, int idx, u8 val)
> > > +{
> > > +       void __iomem *reg_addr;
> > > +
> > > +       reg_addr = gpmc_base + GPMC_CS0_BASE + (cs * GPMC_CS_SIZE) +
> idx;
> > > +       __raw_writeb(val, reg_addr);
> > > +}
> > > +
> > > +static u8 gpmc_cs_read_byte(int cs, int idx)
> > > +{
> > > +       void __iomem *reg_addr;
> > > +
> > > +       reg_addr = gpmc_base + GPMC_CS0_BASE + (cs * GPMC_CS_SIZE) +
> idx;
> > > +       return __raw_readb(reg_addr);
> > > +}
> > > +
> > >  void gpmc_cs_write_reg(int cs, int idx, u32 val)
> > >  {
> > >        void __iomem *reg_addr;
> > >
> > > -       reg_addr = gpmc_base + GPMC_CS0 + (cs * GPMC_CS_SIZE) + idx;
> > > +       reg_addr = gpmc_base + GPMC_CS0_BASE + (cs * GPMC_CS_SIZE) +
> idx;
> > >        __raw_writel(val, reg_addr);
> > >  }
> > >
> > > @@ -120,7 +139,7 @@ u32 gpmc_cs_read_reg(int cs, int idx)
> > >  {
> > >        void __iomem *reg_addr;
> > >
> > > -       reg_addr = gpmc_base + GPMC_CS0 + (cs * GPMC_CS_SIZE) + idx;
> > > +       reg_addr = gpmc_base + GPMC_CS0_BASE + (cs * GPMC_CS_SIZE) +
> idx;
> > >        return __raw_readl(reg_addr);
> > >  }
> > >
> > > @@ -419,8 +438,100 @@ void gpmc_cs_free(int cs)
> > >  EXPORT_SYMBOL(gpmc_cs_free);
> > >
> > >  /**
> > > + * gpmc_hwcontrol - hardware specific access (read/ write) control
> > > + * @cs: chip select number
> > > + * @cmd: command type
> > > + * @write: 1 for write; 0 for read
> > > + * @wval: value to write
> > > + * @rval: read pointer
> > > + */
> > > +int gpmc_hwcontrol(int cs, int cmd, int write, int wval, int *rval)
> > > +{
> > > +       u32 regval = 0;
> > > +
> > > +       if (!write && !rval)
> > > +               return -EINVAL;
> > > +
> > > +       switch (cmd) {
> > > +       case GPMC_STATUS_BUFFER:
> > > +               regval = gpmc_read_reg(GPMC_STATUS);
> > > +               /* 1 : buffer is available to write */
> > > +               *rval = regval & GPMC_STATUS_BUFF_EMPTY;
> > > +               break;
> > > +
> > > +       case GPMC_GET_SET_IRQ_STATUS:
> > > +               if (write)
> > > +                       gpmc_write_reg(GPMC_IRQSTATUS, wval);
> > > +               else
> > > +                       *rval = gpmc_read_reg(GPMC_IRQSTATUS);
> > > +               break;
> > > +
> > > +       case GPMC_PREFETCH_FIFO_CNT:
> > > +               regval = gpmc_read_reg(GPMC_PREFETCH_STATUS);
> > > +               *rval = GPMC_PREFETCH_STATUS_FIFO_CNT(regval);
> > > +               break;
> > > +
> > > +       case GPMC_PREFETCH_COUNT:
> > > +               regval = gpmc_read_reg(GPMC_PREFETCH_STATUS);
> > > +               *rval = GPMC_PREFETCH_STATUS_COUNT(regval);
> > > +               break;
> > > +
> > > +       case GPMC_CONFIG_WP:
> > > +               regval = gpmc_read_reg(GPMC_CONFIG);
> > > +               if (wval)
> > > +                       regval &= ~GPMC_CONFIG_WRITEPROTECT; /* WP is
> ON */
> > > +               else
> > > +                       regval |= GPMC_CONFIG_WRITEPROTECT;  /* WP is
> OFF */
> > > +               gpmc_write_reg(GPMC_CONFIG, regval);
> > > +               break;
> > > +
> > > +       case GPMC_CONFIG_RDY_BSY:
> > > +               regval  = gpmc_cs_read_reg(cs, GPMC_CS_CONFIG1);
> > > +               regval |= WR_RD_PIN_MONITORING;
> > > +               gpmc_cs_write_reg(cs, GPMC_CS_CONFIG1, regval);
> > > +               break;
> >
> > IIRC, at least in OMAP2/3, ready/busy pin is not in use (not connected).
>
> On the Logic OMAP3530 LV SOM and Torpedo modules, the R/B# pin of the
> NAND in the Micron mt29c2g4maklajg-6it POP part is connected to the
> WAIT0 pin on the OMAP3530 and I'm looking to use it to speed up NAND
> accesses
[Ghorai] So better keep this feature,
>
> > > +
> > > +       case GPMC_CONFIG_DEV_SIZE:
> > > +               regval  = gpmc_cs_read_reg(cs, GPMC_CS_CONFIG1);
> > > +               regval |= GPMC_CONFIG1_DEVICESIZE(wval);
> > > +               gpmc_cs_write_reg(cs, GPMC_CS_CONFIG1, regval);
> > > +               break;
> > > +
> > > +       case GPMC_CONFIG_DEV_TYPE:
> > > +               regval  = gpmc_cs_read_reg(cs, GPMC_CS_CONFIG1);
> > > +               regval |= GPMC_CONFIG1_DEVICETYPE(wval);
> > > +               if (wval == GPMC_DEVICETYPE_NOR)
> > > +                       regval |= GPMC_CONFIG1_MUXADDDATA;
> > > +               gpmc_cs_write_reg(cs, GPMC_CS_CONFIG1, regval);
> > > +               break;
> > > +
> > > +       case GPMC_NAND_COMMAND:
> > > +               gpmc_cs_write_byte(cs, GPMC_CS_NAND_COMMAND, wval);
> > > +               break;
> > > +
> > > +       case GPMC_NAND_ADDRESS:
> > > +               gpmc_cs_write_byte(cs, GPMC_CS_NAND_ADDRESS, wval);
> > > +               break;
> > > +
> > > +       case GPMC_NAND_DATA:
> > > +               if (write)
> > > +                       gpmc_cs_write_byte(cs, GPMC_CS_NAND_DATA,
> wval);
> > > +               else
> > > +                       *rval = gpmc_cs_read_byte(cs,
> GPMC_CS_NAND_DATA);
> > > +               break;
> > > +
> > > +       default:
> > > +               printk(KERN_ERR "gpmc_hwcontrol: Not supported\n");
> > > +               return -EINVAL;
> > > +       }
> > > +
> > > +       return 0;
> > > +}
> > > +EXPORT_SYMBOL(gpmc_hwcontrol);
> > > +
> > > +/**
> > >  * gpmc_prefetch_enable - configures and starts prefetch transfer
> > > - * @cs: nand cs (chip select) number
> > > + * @cs: cs (chip select) number
> > >  * @dma_mode: dma mode enable (1) or disable (0)
> > >  * @u32_count: number of bytes to be transferred
> > >  * @is_write: prefetch read(0) or write post(1) mode
> > > @@ -430,6 +541,11 @@ int gpmc_prefetch_enable(int cs, int dma_mode,
> > >  {
> > >        uint32_t prefetch_config1;
> > >
> > > +       if (gpmc_pref_used == -EINVAL)
> > > +               gpmc_pref_used = cs;
> > > +       else
> > > +               return -EBUSY;
> >
> > This is  not required. Prefetch engine has just one instance
> >
> > > +
> > >        if (!(gpmc_read_reg(GPMC_PREFETCH_CONTROL))) {
> >
> > and any prefetch request will be done only if above check passes.
> > Which actually checks if 'prefetch' is busy or not.
> > You can see in NAND driver (omap2.c) code, it understands that.
[Ghorai] Agree here and also you mentioned not to use the reset function. So will take all these as 4th patch for cleanup.
> >
> > >                /* Set the amount of bytes to be prefetched */
> > >                gpmc_write_reg(GPMC_PREFETCH_CONFIG2, u32_count);
> > > @@ -456,13 +572,20 @@ EXPORT_SYMBOL(gpmc_prefetch_enable);
> > >  /**
> > >  * gpmc_prefetch_reset - disables and stops the prefetch engine
> > >  */
> > > -void gpmc_prefetch_reset(void)
> > > +int gpmc_prefetch_reset(int cs)
> > >  {
> > > +       if (gpmc_pref_used == cs)
> > > +               gpmc_pref_used = -EINVAL;
> > > +       else
> > > +               return -EINVAL;
> > > +
> >
> > This is also not required. As, this function will be called only if
> > prefetch was used.
[Ghorai] Agree. Can you see this input too?
http://www.mail-archive.com/linux-omap@vger.kernel.org/msg28520.html

> >
> > >        /* Stop the PFPW engine */
> > >        gpmc_write_reg(GPMC_PREFETCH_CONTROL, 0x0);
> > >
> > >        /* Reset/disable the PFPW engine */
> > >        gpmc_write_reg(GPMC_PREFETCH_CONFIG1, 0x0);
> > > +
> > > +       return 0;
> > >  }
> > >  EXPORT_SYMBOL(gpmc_prefetch_reset);
> > >
> > > @@ -615,3 +738,114 @@ void omap3_gpmc_restore_context(void)
> > >        }
> > >  }
> > >  #endif /* CONFIG_ARCH_OMAP3 */
> > > +
> > > +/**
> > > + * gpmc_ecc_init - initialize hw ecc for device in GPMC controller
> > > + * @cs: chip select number
> > > + * @ecc_size: number of bytes for ecc generation
> > > + */
> > > +
> > > +int gpmc_ecc_init(int cs, int ecc_size)
> > > +{
> > > +       unsigned int val = 0x0;
> > > +
> > > +       /* check if ecc engine already by another cs */
> > > +       if (gpmc_ecc_used == -EINVAL)
> > > +               gpmc_ecc_used = cs;
> > > +       else
> > > +               return -EBUSY;
> > Here few things need be to consider:
> > 1. 'init' is supposed to done once for every instance of driver during
> probe
> > 2. But ECC engine, too, have only one instance at a time, So
> > 3. As long as all NAND chip are supposed to use same ECC machenism, we
> > can go for only one time 'init' for all drivers, perhaps in
> > gpmc_nand.c.
> > 4. But in case, different instances of driver (or NAND chip) requires
> > different ECC machenism (for ex. Hamming or BCH, or even with
> > different capabilities of error correction),
> > this will no longer vailid. Then rather we should have something like
> > 'gpmc_ecc_config' call to configer ECC engine for everytime a driver
> > needs it (something like as it is done for prefetch engine).
[Ghorai]
a. do you think it will reduce the throughput?
b. Moreover I think we will take this as 5th patch as cleanup/ improvemnt.
c. And how to know that ECC engine is in used other driver should not use it? Any bit to know that ecc engine is busy, as we check for prefetch?
d. any further input on http://www.mail-archive.com/linux-omap@vger.kernel.org/msg28520.html

> >
> > > +
> > > +       /* read ecc control register */
> > > +       val = gpmc_read_reg(GPMC_ECC_CONTROL);
> > > +
> > > +       /* clear ecc and enable bits */
> > > +       val = ((0x00000001<<8) | 0x00000001);
> > > +       gpmc_write_reg(GPMC_ECC_CONTROL, val);
> > > +
> > > +       /* Read from ECC Size Config Register */
> > > +       val = gpmc_read_reg(GPMC_ECC_SIZE_CONFIG);
> > > +
> > > +       /* program ecc and result sizes */
> > > +       val = ((((ecc_size >> 1) - 1) << 22) | (0x0000000F));
> > > +       gpmc_write_reg(GPMC_ECC_SIZE_CONFIG, val);
> > > +
> > > +       return 0;
> > > +}
> > > +
> > > +/**
> > > + * gpmc_calculate_ecc - generate non-inverted ecc bytes
> > > + * @cs: chip select number
> > > + * @dat: data pointer over which ecc is computed
> > > + * @ecc_code: ecc code buffer
> > > + *
> > > + * Using non-inverted ECC is considered ugly since writing a blank
> > > + * page (padding) will clear the ECC bytes. This is not a problem as
> long
> > > + * no one is trying to write data on the seemingly unused page.
> Reading
> > > + * an erased page will produce an ECC mismatch between generated and
> read
> > > + * ECC bytes that has to be dealt with separately.
> > > + */
> > > +int gpmc_calculate_ecc(int cs, const u_char *dat, u_char *ecc_code)
> > > +{
> > > +       unsigned int val = 0x0;
> > > +
> > > +       if (gpmc_ecc_used != cs)
> > > +               return -EINVAL;
> > > +
> > > +       /* read ecc result */
> > > +       val = gpmc_read_reg(GPMC_ECC1_RESULT);
> > > +       *ecc_code++ = val;          /* P128e, ..., P1e */
> > > +       *ecc_code++ = val >> 16;    /* P128o, ..., P1o */
> > > +       /* P2048o, P1024o, P512o, P256o, P2048e, P1024e, P512e, P256e
> */
> > > +       *ecc_code++ = ((val >> 8) & 0x0f) | ((val >> 20) & 0xf0);
> > > +
> > > +       return 0;
> > > +}
> > > +
> > > +/**
> > > + * gpmc_enable_hwecc - enable hardware ecc functionality
> > > + * @cs: chip select number
> > > + * @mode: read/write mode
> > > + * @dev_width: device bus width(1 for x16, 0 for x8)
> > > + */
> > > +int gpmc_enable_hwecc(int cs, int mode, int dev_width)
> > > +{
> > > +       unsigned int val;
> > > +
> > > +       if (gpmc_ecc_used != cs)
> > > +               return -EINVAL;
> > > +
> > > +       switch (mode) {
> > > +       case GPMC_ECC_READ:
> > > +               gpmc_write_reg(GPMC_ECC_CONTROL, 0x101);
> > > +               break;
> > > +       case GPMC_ECC_READSYN:
> > > +                gpmc_write_reg(GPMC_ECC_CONTROL, 0x100);
> > > +               break;
> > > +       case GPMC_ECC_WRITE:
> > > +               gpmc_write_reg(GPMC_ECC_CONTROL, 0x101);
> > > +               break;
> > > +       default:
> > > +               printk(KERN_INFO "Error: Unrecognized Mode[%d]!\n",
> mode);
> > > +               break;
> > > +       }
> > > +
> > > +       /* (ECC 16 or 8 bit col) | ( CS  )  | ECC Enable */
> > > +       val = (dev_width << 7) | (cs << 1) | (0x1);
> > > +       gpmc_write_reg(GPMC_ECC_CONFIG, val);
> > > +       return 0;
> > > +}
> > > +
> > > +/**
> > > + * gmpc_ecc_reset - release the HW ECC in GPMC controller
> > > + * @cs: Chip select number
> > > + */
> > > +int gpmc_ecc_reset(int cs)
> > > +{
> > > +       if (gpmc_ecc_used == cs)
> > > +               gpmc_ecc_used = -EINVAL;
> > > +       else
> > > +               return -EINVAL;
> > > +
> > > +       return 0;
> > > +}
> > > +
> > > diff --git a/arch/arm/plat-omap/include/plat/gpmc.h b/arch/arm/plat-
> omap/include/plat/gpmc.h
> > > index 145838a..67a3442
> > > --- a/arch/arm/plat-omap/include/plat/gpmc.h
> > > +++ b/arch/arm/plat-omap/include/plat/gpmc.h
> > > @@ -27,8 +27,24 @@
> > >
> > >  #define GPMC_CONFIG            0x50
> > >  #define GPMC_STATUS            0x54
> > > -#define GPMC_CS0_BASE          0x60
> > > -#define GPMC_CS_SIZE           0x30
> > > +
> > > +/* Control Commands */
> > > +#define GPMC_CONFIG_WP         0x00000001
> > > +#define GPMC_CONFIG_RDY_BSY    0x00000002
> > > +#define GPMC_CONFIG_DEV_SIZE   0x00000003
> > > +#define GPMC_CONFIG_DEV_TYPE   0x00000004
> > > +#define GPMC_NAND_COMMAND      0x00000005
> > > +#define GPMC_NAND_ADDRESS      0x00000006
> > > +#define GPMC_NAND_DATA         0x00000007
> > > +#define GPMC_STATUS_BUFFER     0x00000008 /* 1: buffer is available
> to write */
> > > +#define GPMC_PREFETCH_FIFO_CNT 0x00000009 /* bytes available in FIFO
> for r/w */
> > > +#define GPMC_PREFETCH_COUNT    0x0000000A /* remaining bytes to be
> read/write*/
> > > +#define GPMC_GET_SET_IRQ_STATUS        0x0000000B
> > > +
> > > +/* ECC commands */
> > > +#define GPMC_ECC_READ          0 /* Reset Hardware ECC for read */
> > > +#define GPMC_ECC_WRITE         1 /* Reset Hardware ECC for write */
> > > +#define GPMC_ECC_READSYN       2 /* Reset before syndrom is read back
> */
> > >
> > >  #define GPMC_CONFIG1_WRAPBURST_SUPP     (1 << 31)
> > >  #define GPMC_CONFIG1_READMULTIPLE_SUPP  (1 << 30)
> > > @@ -56,6 +72,14 @@
> > >  #define GPMC_CONFIG1_FCLK_DIV4          (GPMC_CONFIG1_FCLK_DIV(3))
> > >  #define GPMC_CONFIG7_CSVALID           (1 << 6)
> > >
> > > +#define GPMC_DEVICETYPE_NOR            0
> > > +#define GPMC_DEVICETYPE_NAND           2
> > > +#define GPMC_CONFIG_WRITEPROTECT       0x00000010
> > > +#define GPMC_STATUS_BUFF_EMPTY         0x00000001
> > > +#define WR_RD_PIN_MONITORING           0x00600000
> > > +#define GPMC_PREFETCH_STATUS_FIFO_CNT(val)     ((val & 0x7f000000) >>
> 24)
> > > +#define GPMC_PREFETCH_STATUS_COUNT(val)        (val & 0x00003fff)
> > > +
> > >  /*
> > >  * Note that all values in this struct are in nanoseconds, while
> > >  * the register values are in gpmc_fck cycles.
> > > @@ -108,10 +132,15 @@ extern int gpmc_cs_set_reserved(int cs, int
> reserved);
> > >  extern int gpmc_cs_reserved(int cs);
> > >  extern int gpmc_prefetch_enable(int cs, int dma_mode,
> > >                                        unsigned int u32_count, int
> is_write);
> > > -extern void gpmc_prefetch_reset(void);
> > > +extern int gpmc_prefetch_reset(int cs);
> > >  extern int gpmc_prefetch_status(void);
> > >  extern void omap3_gpmc_save_context(void);
> > >  extern void omap3_gpmc_restore_context(void);
> > >  extern void gpmc_init(void);
> > > +extern int gpmc_hwcontrol(int cs, int cmd, int write, int wval, int
> *rval);
> > >
> > > +int gpmc_ecc_init(int cs, int ecc_size);
> > > +int gpmc_enable_hwecc(int cs, int mode, int dev_width);
> > > +int gpmc_calculate_ecc(int cs, const u_char *dat, u_char *ecc_code);
> > > +int gpmc_ecc_reset(int cs);
> > >  #endif
> > > diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
> > > index 7545568..206406b
> > > --- a/drivers/mtd/nand/omap2.c
> > > +++ b/drivers/mtd/nand/omap2.c
> > > @@ -316,7 +316,7 @@ static void omap_read_buf_pref(struct mtd_info
> *mtd, u_char *buf, int len)
> > >                } while (len);
> > >
> > >                /* disable and stop the PFPW engine */
> > > -               gpmc_prefetch_reset();
> > > +               gpmc_prefetch_reset(info->gpmc_cs);
> > Not required. see above comments.
[Ghorai] agree and will take as 4th patch as cleanup and its not matching with patch description
> >
> > >        }
> > >  }
> > >
> > > @@ -360,7 +360,7 @@ static void omap_write_buf_pref(struct mtd_info
> *mtd,
> > >                }
> > >
> > >                /* disable and stop the PFPW engine */
> > > -               gpmc_prefetch_reset();
> > > +               gpmc_prefetch_reset(info->gpmc_cs);
> > Not required. see above comments.
[Ghorai] agree and will take as 4th patch as cleanup and its not matching with patch description
> > >        }
> > >  }
> > >
> > > --
> > > To unsubscribe from this list: send the line "unsubscribe linux-omap"
> in
> > > the body of a message to majordomo@vger.kernel.org
> > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > >
> >
> >
> >
>

