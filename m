From: vimal singh <vimal.newwork@gmail.com>
Subject: Re: [PATCH-v3 1:2] [MTD][NAND]omap: Adding support for nand
	prefetch-read and post-write, in MPU mode.
Date: Tue, 11 Aug 2009 11:15:45 +0530
Message-ID: <ce9ab5790908102245r28224bf5nfa2a1b22267767fe@mail.gmail.com>
References: <61339.192.168.10.89.1247226725.squirrel@dbdmail.itg.ti.com>
	<48097.192.168.10.89.1247232736.squirrel@dbdmail.itg.ti.com>
	<60361.192.168.10.89.1247482584.squirrel@dbdmail.itg.ti.com>
	<20090810162734.GH1938@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <20090810162734.GH1938@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
	<mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
	<mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: linux-mtd-bounces@lists.infradead.org
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, dedekind@infradead.org, linux-kernel@vger.kernel.org, david-b@pacbell.net, linux-mtd@lists.infradead.org, vimal singh <vimalsingh@ti.com>, dwmw2@infradead.org
List-Id: linux-omap@vger.kernel.org

On Mon, Aug 10, 2009 at 9:57 PM, Tony Lindgren<tony@atomide.com> wrote:
> * vimal singh <vimalsingh@ti.com> [090713 13:56]:
>> Patch updated for ' ioreadX / iowriteX and ioreadX_rep / iowriteX_rep' a=
s per
>> David Brownell's comment. I updated 'omap_(read/write)_buf16' fucntions =
also
>> for this.
>>
>> -vimal
>>
>> This patch adds prefetch support to access nand flash in mpu mode.
>> This patch also adds 8-bit nand support (omap_read/write_buf8).
>> Prefetch can be used for both 8- and 16-bit devices.
>>
>> Signed-off-by: Vimal Singh <vimalsingh@ti.com>
>
> Sorry for the delay. I've looked at the GPMC part, and that now looks OK
> to me. So I'm OK for this to get integrated via the MTD list.
>
> Acked-by: Tony Lindgren <tony@atomide.com>
>

Can you give your ack to below patch too?

http://lists.infradead.org/pipermail/linux-mtd/2009-July/026373.html

>
>> ---
>>
>> ---
>> =A0arch/arm/mach-omap2/gpmc.c =A0 =A0 =A0 =A0 =A0 =A0 | =A0 63 +++++++++=
+++
>> =A0arch/arm/plat-omap/include/mach/gpmc.h | =A0 =A04
>> =A0drivers/mtd/nand/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A08 +
>> =A0drivers/mtd/nand/omap2.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0161 +++++++=
++++++++++++++++++++++++--
>> =A04 files changed, 226 insertions(+), 10 deletions(-)
>>
>> Index: mtd-2.6/arch/arm/mach-omap2/gpmc.c
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> --- mtd-2.6.orig/arch/arm/mach-omap2/gpmc.c
>> +++ mtd-2.6/arch/arm/mach-omap2/gpmc.c
>> @@ -57,6 +57,11 @@
>> =A0#define GPMC_CHUNK_SHIFT =A0 =A0 24 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* 16 =
MB */
>> =A0#define GPMC_SECTION_SHIFT =A0 28 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* 128 M=
B */
>>
>> +#define PREFETCH_FIFOTHRESHOLD =A0 =A0 =A0 (0x40 << 8)
>> +#define CS_NUM_SHIFT =A0 =A0 =A0 =A0 24
>> +#define ENABLE_PREFETCH =A0 =A0 =A0 =A0 =A0 =A0 =A0(0x1 << 7)
>> +#define DMA_MPU_MODE =A0 =A0 =A0 =A0 2
>> +
>> =A0static struct resource =A0 =A0 =A0 gpmc_mem_root;
>> =A0static struct resource =A0 =A0 =A0 gpmc_cs_mem[GPMC_CS_NUM];
>> =A0static DEFINE_SPINLOCK(gpmc_mem_lock);
>> @@ -386,6 +391,63 @@ void gpmc_cs_free(int cs)
>> =A0}
>> =A0EXPORT_SYMBOL(gpmc_cs_free);
>>
>> +/**
>> + * gpmc_prefetch_enable - configures and starts prefetch transfer
>> + * @cs: nand cs (chip select) number
>> + * @dma_mode: dma mode enable (1) or disable (0)
>> + * @u32_count: number of bytes to be transferred
>> + * @is_write: prefetch read(0) or write post(1) mode
>> + */
>> +int gpmc_prefetch_enable(int cs, int dma_mode,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned int u=
32_count, int is_write)
>> +{
>> + =A0 =A0 uint32_t prefetch_config1;
>> +
>> + =A0 =A0 if (!(gpmc_read_reg(GPMC_PREFETCH_CONTROL))) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* Set the amount of bytes to be prefetched */
>> + =A0 =A0 =A0 =A0 =A0 =A0 gpmc_write_reg(GPMC_PREFETCH_CONFIG2, u32_coun=
t);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* Set dma/mpu mode, the prefetch read / post =
write and
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* enable the engine. Set which cs is has re=
quested for.
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
>> + =A0 =A0 =A0 =A0 =A0 =A0 prefetch_config1 =3D ((cs << CS_NUM_SHIFT) |
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 PREFETCH_FIFOTHRESHOLD |
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 ENABLE_PREFETCH |
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 (dma_mode << DMA_MPU_MODE) |
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 (0x1 & is_write));
>> + =A0 =A0 =A0 =A0 =A0 =A0 gpmc_write_reg(GPMC_PREFETCH_CONFIG1, prefetch=
_config1);
>> + =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EBUSY;
>> + =A0 =A0 }
>> + =A0 =A0 /* =A0Start the prefetch engine */
>> + =A0 =A0 gpmc_write_reg(GPMC_PREFETCH_CONTROL, 0x1);
>> +
>> + =A0 =A0 return 0;
>> +}
>> +EXPORT_SYMBOL(gpmc_prefetch_enable);
>> +
>> +/**
>> + * gpmc_prefetch_reset - disables and stops the prefetch engine
>> + */
>> +void gpmc_prefetch_reset(void)
>> +{
>> + =A0 =A0 /* Stop the PFPW engine */
>> + =A0 =A0 gpmc_write_reg(GPMC_PREFETCH_CONTROL, 0x0);
>> +
>> + =A0 =A0 /* Reset/disable the PFPW engine */
>> + =A0 =A0 gpmc_write_reg(GPMC_PREFETCH_CONFIG1, 0x0);
>> +}
>> +EXPORT_SYMBOL(gpmc_prefetch_reset);
>> +
>> +/**
>> + * gpmc_prefetch_status - reads prefetch status of engine
>> + */
>> +int =A0gpmc_prefetch_status(void)
>> +{
>> + =A0 =A0 return gpmc_read_reg(GPMC_PREFETCH_STATUS);
>> +}
>> +EXPORT_SYMBOL(gpmc_prefetch_status);
>> +
>> =A0static void __init gpmc_mem_init(void)
>> =A0{
>> =A0 =A0 =A0 int cs;
>> @@ -452,6 +514,5 @@ void __init gpmc_init(void)
>> =A0 =A0 =A0 l &=3D 0x03 << 3;
>> =A0 =A0 =A0 l |=3D (0x02 << 3) | (1 << 0);
>> =A0 =A0 =A0 gpmc_write_reg(GPMC_SYSCONFIG, l);
>> -
>> =A0 =A0 =A0 gpmc_mem_init();
>> =A0}
>> Index: mtd-2.6/arch/arm/plat-omap/include/mach/gpmc.h
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> --- mtd-2.6.orig/arch/arm/plat-omap/include/mach/gpmc.h
>> +++ mtd-2.6/arch/arm/plat-omap/include/mach/gpmc.h
>> @@ -103,6 +103,10 @@ extern int gpmc_cs_request(int cs, unsig
>> =A0extern void gpmc_cs_free(int cs);
>> =A0extern int gpmc_cs_set_reserved(int cs, int reserved);
>> =A0extern int gpmc_cs_reserved(int cs);
>> +extern int gpmc_prefetch_enable(int cs, int dma_mode,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 unsigned int u32_count, int is_write);
>> +extern void gpmc_prefetch_reset(void);
>> +extern int gpmc_prefetch_status(void);
>> =A0extern void __init gpmc_init(void);
>>
>> =A0#endif
>> Index: mtd-2.6/drivers/mtd/nand/Kconfig
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> --- mtd-2.6.orig/drivers/mtd/nand/Kconfig
>> +++ mtd-2.6/drivers/mtd/nand/Kconfig
>> @@ -80,6 +80,14 @@ config MTD_NAND_OMAP2
>> =A0 =A0 =A0 help
>> =A0 =A0 =A0 =A0 =A0 =A0Support for NAND flash on Texas Instruments OMAP2=
 and OMAP3 platforms.
>>
>> +config MTD_NAND_OMAP_PREFETCH
>> + =A0 =A0 bool "GPMC prefetch support for NAND Flash device"
>> + =A0 =A0 depends on MTD_NAND && MTD_NAND_OMAP2
>> + =A0 =A0 default y
>> + =A0 =A0 help
>> + =A0 =A0 =A0The NAND device can be accessed for Read/Write using GPMC P=
REFETCH engine
>> + =A0 =A0 =A0to improve the performance.
>> +
>> =A0config MTD_NAND_TS7250
>> =A0 =A0 =A0 tristate "NAND Flash device on TS-7250 board"
>> =A0 =A0 =A0 depends on MACH_TS72XX
>> Index: mtd-2.6/drivers/mtd/nand/omap2.c
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> --- mtd-2.6.orig/drivers/mtd/nand/omap2.c
>> +++ mtd-2.6/drivers/mtd/nand/omap2.c
>> @@ -112,6 +112,16 @@
>> =A0static const char *part_probes[] =3D { "cmdlinepart", NULL };
>> =A0#endif
>>
>> +#ifdef CONFIG_MTD_NAND_OMAP_PREFETCH
>> +static int use_prefetch =3D 1;
>> +
>> +/* "modprobe ... use_prefetch=3D0" etc */
>> +module_param(use_prefetch, bool, 0);
>> +MODULE_PARM_DESC(use_prefetch, "enable/disable use of PREFETCH");
>> +#else
>> +const int use_prefetch;
>> +#endif
>> +
>> =A0struct omap_nand_info {
>> =A0 =A0 =A0 struct nand_hw_control =A0 =A0 =A0 =A0 =A0controller;
>> =A0 =A0 =A0 struct omap_nand_platform_data =A0*pdata;
>> @@ -124,6 +134,7 @@ struct omap_nand_info {
>> =A0 =A0 =A0 unsigned long =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 phys_base;
>> =A0 =A0 =A0 void __iomem =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*gpmc_cs=
_baseaddr;
>> =A0 =A0 =A0 void __iomem =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*gpmc_ba=
seaddr;
>> + =A0 =A0 void __iomem =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*nand_pref=
_fifo_add;
>> =A0};
>>
>> =A0/**
>> @@ -189,6 +200,38 @@ static void omap_hwcontrol(struct mtd_in
>> =A0}
>>
>> =A0/**
>> + * omap_read_buf8 - read data from NAND controller into buffer
>> + * @mtd: MTD device structure
>> + * @buf: buffer to store date
>> + * @len: number of bytes to read
>> + */
>> +static void omap_read_buf8(struct mtd_info *mtd, u_char *buf, int len)
>> +{
>> + =A0 =A0 struct nand_chip *nand =3D mtd->priv;
>> +
>> + =A0 =A0 ioread8_rep(nand->IO_ADDR_R, buf, len);
>> +}
>> +
>> +/**
>> + * omap_write_buf8 - write buffer to NAND controller
>> + * @mtd: MTD device structure
>> + * @buf: data buffer
>> + * @len: number of bytes to write
>> + */
>> +static void omap_write_buf8(struct mtd_info *mtd, const u_char *buf, in=
t len)
>> +{
>> + =A0 =A0 struct omap_nand_info *info =3D container_of(mtd,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 struct omap_nand_info, mtd);
>> + =A0 =A0 u_char *p =3D (u_char *)buf;
>> +
>> + =A0 =A0 while (len--) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 iowrite8(*p++, info->nand.IO_ADDR_W);
>> + =A0 =A0 =A0 =A0 =A0 =A0 while (GPMC_BUF_EMPTY =3D=3D (readl(info->gpmc=
_baseaddr +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 GPMC_STATUS) & GPMC_BUF_FULL));
>> + =A0 =A0 }
>> +}
>> +
>> +/**
>> =A0 * omap_read_buf16 - read data from NAND controller into buffer
>> =A0 * @mtd: MTD device structure
>> =A0 * @buf: buffer to store date
>> @@ -198,7 +241,7 @@ static void omap_read_buf16(struct mtd_i
>> =A0{
>> =A0 =A0 =A0 struct nand_chip *nand =3D mtd->priv;
>>
>> - =A0 =A0 __raw_readsw(nand->IO_ADDR_R, buf, len / 2);
>> + =A0 =A0 ioread16_rep(nand->IO_ADDR_R, buf, len / 2);
>> =A0}
>>
>> =A0/**
>> @@ -217,13 +260,101 @@ static void omap_write_buf16(struct mtd_
>> =A0 =A0 =A0 len >>=3D 1;
>>
>> =A0 =A0 =A0 while (len--) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 writew(*p++, info->nand.IO_ADDR_W);
>> + =A0 =A0 =A0 =A0 =A0 =A0 iowrite16(*p++, info->nand.IO_ADDR_W);
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 while (GPMC_BUF_EMPTY =3D=3D (readl(info->gp=
mc_baseaddr +
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 GPMC_STATUS) & GPMC_BUF_FULL))
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ;
>> =A0 =A0 =A0 }
>> =A0}
>> +
>> +/**
>> + * omap_read_buf_pref - read data from NAND controller into buffer
>> + * @mtd: MTD device structure
>> + * @buf: buffer to store date
>> + * @len: number of bytes to read
>> + */
>> +static void omap_read_buf_pref(struct mtd_info *mtd, u_char *buf, int l=
en)
>> +{
>> + =A0 =A0 struct omap_nand_info *info =3D container_of(mtd,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 struct omap_nand_info, mtd);
>> + =A0 =A0 uint32_t pfpw_status =3D 0, r_count =3D 0;
>> + =A0 =A0 int ret =3D 0;
>> + =A0 =A0 u32 *p =3D (u32 *)buf;
>> +
>> + =A0 =A0 /* take care of subpage reads */
>> + =A0 =A0 for (; len % 4 !=3D 0; ) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 *buf++ =3D __raw_readb(info->nand.IO_ADDR_R);
>> + =A0 =A0 =A0 =A0 =A0 =A0 len--;
>> + =A0 =A0 }
>> + =A0 =A0 p =3D (u32 *) buf;
>> +
>> + =A0 =A0 /* configure and start prefetch transfer */
>> + =A0 =A0 ret =3D gpmc_prefetch_enable(info->gpmc_cs, 0x0, len, 0x0);
>> + =A0 =A0 if (ret) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* PFPW engine is busy, use cpu copy method */
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (info->nand.options & NAND_BUSWIDTH_16)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_read_buf16(mtd, buf, len);
>> + =A0 =A0 =A0 =A0 =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_read_buf8(mtd, buf, len);
>> + =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 do {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pfpw_status =3D gpmc_prefetch_=
status();
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 r_count =3D ((pfpw_status >> 2=
4) & 0x7F) >> 2;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ioread32_rep(info->nand_pref_f=
ifo_add, p, r_count);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 p +=3D r_count;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 len -=3D r_count << 2;
>> + =A0 =A0 =A0 =A0 =A0 =A0 } while (len);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* disable and stop the PFPW engine */
>> + =A0 =A0 =A0 =A0 =A0 =A0 gpmc_prefetch_reset();
>> + =A0 =A0 }
>> +}
>> +
>> +/**
>> + * omap_write_buf_pref - write buffer to NAND controller
>> + * @mtd: MTD device structure
>> + * @buf: data buffer
>> + * @len: number of bytes to write
>> + */
>> +static void omap_write_buf_pref(struct mtd_info *mtd,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 const u_char *buf, int len)
>> +{
>> + =A0 =A0 struct omap_nand_info *info =3D container_of(mtd,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 struct omap_nand_info, mtd);
>> + =A0 =A0 uint32_t pfpw_status =3D 0, w_count =3D 0;
>> + =A0 =A0 int i =3D 0, ret =3D 0;
>> + =A0 =A0 u16 *p =3D (u16 *) buf;
>> +
>> + =A0 =A0 /* take care of subpage writes */
>> + =A0 =A0 if (len % 2 !=3D 0) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 writeb(*buf, info->nand.IO_ADDR_R);
>> + =A0 =A0 =A0 =A0 =A0 =A0 p =3D (u16 *)(buf + 1);
>> + =A0 =A0 =A0 =A0 =A0 =A0 len--;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 /* =A0configure and start prefetch transfer */
>> + =A0 =A0 ret =3D gpmc_prefetch_enable(info->gpmc_cs, 0x0, len, 0x1);
>> + =A0 =A0 if (ret) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* PFPW engine is busy, use cpu copy method */
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (info->nand.options & NAND_BUSWIDTH_16)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_write_buf16(mtd, buf, len=
);
>> + =A0 =A0 =A0 =A0 =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_write_buf8(mtd, buf, len);
>> + =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 pfpw_status =3D gpmc_prefetch_status();
>> + =A0 =A0 =A0 =A0 =A0 =A0 while (pfpw_status & 0x3FFF) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 w_count =3D ((pfpw_status >> 2=
4) & 0x7F) >> 1;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (i =3D 0; (i < w_count) &&=
 len; i++, len -=3D 2)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 iowrite16(*p++=
, info->nand_pref_fifo_add);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pfpw_status =3D gpmc_prefetch_=
status();
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* disable and stop the PFPW engine */
>> + =A0 =A0 =A0 =A0 =A0 =A0 gpmc_prefetch_reset();
>> + =A0 =A0 }
>> +}
>> +
>> =A0/**
>> =A0 * omap_verify_buf - Verify chip data against buffer
>> =A0 * @mtd: MTD device structure
>> @@ -658,17 +789,12 @@ static int __devinit omap_nand_probe(str
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D -ENOMEM;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out_release_mem_region;
>> =A0 =A0 =A0 }
>> +
>> =A0 =A0 =A0 info->nand.controller =3D &info->controller;
>>
>> =A0 =A0 =A0 info->nand.IO_ADDR_W =3D info->nand.IO_ADDR_R;
>> =A0 =A0 =A0 info->nand.cmd_ctrl =A0=3D omap_hwcontrol;
>>
>> - =A0 =A0 /* REVISIT: =A0only supports 16-bit NAND flash */
>> -
>> - =A0 =A0 info->nand.read_buf =A0 =3D omap_read_buf16;
>> - =A0 =A0 info->nand.write_buf =A0=3D omap_write_buf16;
>> - =A0 =A0 info->nand.verify_buf =3D omap_verify_buf;
>> -
>> =A0 =A0 =A0 /*
>> =A0 =A0 =A0 =A0* If RDY/BSY line is connected to OMAP then use the omap =
ready
>> =A0 =A0 =A0 =A0* funcrtion and the generic nand_wait function which read=
s the status
>> @@ -689,6 +815,23 @@ static int __devinit omap_nand_probe(str
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D=3D 0x1000)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 info->nand.options =A0|=3D NAND_BUSWIDTH_16;
>>
>> + =A0 =A0 if (use_prefetch) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* copy the virtual address of nand base for f=
ifo access */
>> + =A0 =A0 =A0 =A0 =A0 =A0 info->nand_pref_fifo_add =3D info->nand.IO_ADD=
R_R;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 info->nand.read_buf =A0 =3D omap_read_buf_pref;
>> + =A0 =A0 =A0 =A0 =A0 =A0 info->nand.write_buf =A0=3D omap_write_buf_pre=
f;
>> + =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (info->nand.options & NAND_BUSWIDTH_16) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 info->nand.read_buf =A0 =3D om=
ap_read_buf16;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 info->nand.write_buf =A0=3D om=
ap_write_buf16;
>> + =A0 =A0 =A0 =A0 =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 info->nand.read_buf =A0 =3D om=
ap_read_buf8;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 info->nand.write_buf =A0=3D om=
ap_write_buf8;
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 }
>> + =A0 =A0 info->nand.verify_buf =3D omap_verify_buf;
>> +
>> =A0#ifdef CONFIG_MTD_NAND_OMAP_HWECC
>> =A0 =A0 =A0 info->nand.ecc.bytes =A0 =A0 =A0 =A0 =A0 =A0=3D 3;
>> =A0 =A0 =A0 info->nand.ecc.size =A0 =A0 =A0 =A0 =A0 =A0 =3D 512;
>> @@ -746,7 +889,7 @@ static int omap_nand_remove(struct platf
>> =A0 =A0 =A0 platform_set_drvdata(pdev, NULL);
>> =A0 =A0 =A0 /* Release NAND device, its internal structures and partitio=
ns */
>> =A0 =A0 =A0 nand_release(&info->mtd);
>> - =A0 =A0 iounmap(info->nand.IO_ADDR_R);
>> + =A0 =A0 iounmap(info->nand_pref_fifo_add);
>> =A0 =A0 =A0 kfree(&info->mtd);
>> =A0 =A0 =A0 return 0;
>> =A0}
>>
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>



-- =

---
Regards,
\/ | |\/| /-\ |_

____      __o
------   -\<,
-----  ( )/ ( )

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
