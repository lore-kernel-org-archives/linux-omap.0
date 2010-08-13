From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 2/2 v3] OMAP-McSPI :Adds support for FIFO and auto chip
 select mode
Date: Fri, 13 Aug 2010 16:38:45 -0600
Message-ID: <AANLkTi=1O_EFxEOSx+9ndDXTOGvrw0xjZR+xvzKbz+r7@mail.gmail.com>
References: <32933.192.168.10.88.1281707945.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:60912 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754536Ab0HMWjH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 13 Aug 2010 18:39:07 -0400
Received: by gxk23 with SMTP id 23so1144107gxk.19
        for <linux-omap@vger.kernel.org>; Fri, 13 Aug 2010 15:39:05 -0700 (PDT)
In-Reply-To: <32933.192.168.10.88.1281707945.squirrel@dbdmail.itg.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Govindraj.R" <govindraj.raja@ti.com>
Cc: spi-devel-general@lists.sourceforge.net, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, dbrownell@users.sourceforge.net, Hemanth V <hemanthv@ti.com>

On Fri, Aug 13, 2010 at 7:59 AM, Govindraj.R <govindraj.raja@ti.com> wr=
ote:
>
> From: Hemanth V <hemanthv@ti.com>
>
> DMA and FIFO could be enabled together for better throughput.
> Platform config parameters have been added to enable these
> features on any particular McSPI controller.
>
> FIFO can be enabled by defining fifo_depth parameter. fifo_depth need=
s
> to be a multiple of buffer size that is used for read/write.
>
> Auto chip select mode can be enabled by setting force_cs_mode
> to zero

Hi Hemanth, comments below.

>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Signed-off-by: Hemanth V <hemanthv@ti.com>
> Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
> ---
> =A0drivers/spi/omap2_mcspi.c | =A0336 +++++++++++++++++++++++++++++++=
+++++++++-----
> =A01 files changed, 300 insertions(+), 36 deletions(-)
>
> diff --git a/drivers/spi/omap2_mcspi.c b/drivers/spi/omap2_mcspi.c
> index b3a94ca..dc0420f 100644
> --- a/drivers/spi/omap2_mcspi.c
> +++ b/drivers/spi/omap2_mcspi.c
> @@ -41,6 +41,7 @@
> =A0#include <plat/mcspi.h>
>
> =A0#define OMAP2_MCSPI_MAX_FREQ =A0 =A0 =A0 =A0 =A0 48000000
> +#define OMAP2_MCSPI_MAX_FIFODEPTH =A0 =A0 =A0 64
>
> =A0/* OMAP2 has 3 SPI controllers, while OMAP3 has 4 */
> =A0#define OMAP2_MCSPI_MAX_CTRL =A0 =A0 =A0 =A0 =A0 4
> @@ -53,6 +54,7 @@
> =A0#define OMAP2_MCSPI_WAKEUPENABLE =A0 =A0 =A0 0x20
> =A0#define OMAP2_MCSPI_SYST =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x24
> =A0#define OMAP2_MCSPI_MODULCTRL =A0 =A0 =A0 =A0 =A00x28
> +#define OMAP2_MCSPI_XFERLEVEL =A0 =A0 =A0 =A0 =A00x7c
>
> =A0/* per-channel banks, 0x14 bytes each, first is: */
> =A0#define OMAP2_MCSPI_CHCONF0 =A0 =A0 =A0 =A0 =A0 =A00x2c
> @@ -89,11 +91,15 @@
> =A0#define OMAP2_MCSPI_CHCONF_IS =A0 =A0 =A0 =A0 =A0BIT(18)
> =A0#define OMAP2_MCSPI_CHCONF_TURBO =A0 =A0 =A0 BIT(19)
> =A0#define OMAP2_MCSPI_CHCONF_FORCE =A0 =A0 =A0 BIT(20)
> +#define OMAP2_MCSPI_CHCONF_FFET =A0 =A0 =A0 =A0BIT(27)
> +#define OMAP2_MCSPI_CHCONF_FFER =A0 =A0 =A0 =A0BIT(28)
>
> =A0#define OMAP2_MCSPI_CHSTAT_RXS =A0 =A0 =A0 =A0 BIT(0)
> =A0#define OMAP2_MCSPI_CHSTAT_TXS =A0 =A0 =A0 =A0 BIT(1)
> =A0#define OMAP2_MCSPI_CHSTAT_EOT =A0 =A0 =A0 =A0 BIT(2)
>
> +#define OMAP2_MCSPI_IRQ_EOW =A0 =A0 =A0 =A0 =A0 =A0BIT(17)
> +
> =A0#define OMAP2_MCSPI_CHCTRL_EN =A0 =A0 =A0 =A0 =A0BIT(0)
>
> =A0#define OMAP2_MCSPI_WAKEUPENABLE_WKEN =A0BIT(0)
> @@ -115,7 +121,6 @@ struct omap2_mcspi_dma {
> =A0*/
> =A0#define DMA_MIN_BYTES =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0160
>
> -

Unrelated whitespace change

> =A0struct omap2_mcspi {
> =A0 =A0 =A0 =A0struct work_struct =A0 =A0 =A0work;
> =A0 =A0 =A0 =A0/* lock protects queue and registers */
> @@ -129,6 +134,10 @@ struct omap2_mcspi {
> =A0 =A0 =A0 =A0unsigned long =A0 =A0 =A0 =A0 =A0 phys;
> =A0 =A0 =A0 =A0/* SPI1 has 4 channels, while SPI2 has 2 */
> =A0 =A0 =A0 =A0struct omap2_mcspi_dma =A0*dma_channels;
> + =A0 =A0 =A0 u8 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mcspi_mod=
e;
> + =A0 =A0 =A0 u8 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dma_mode;
> + =A0 =A0 =A0 u8 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0force_cs_=
mode;
> + =A0 =A0 =A0 u16 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 fifo_depth;
> =A0};
>
> =A0struct omap2_mcspi_cs {
> @@ -152,6 +161,37 @@ struct omap2_mcspi_regs {
>
> =A0static struct omap2_mcspi_regs omap2_mcspi_ctx[OMAP2_MCSPI_MAX_CTR=
L];
>
> +#ifdef CONFIG_SPI_DEBUG
> +struct reg_type {
> + =A0 =A0 =A0 char name[40];
> + =A0 =A0 =A0 int offset;
> +};
> +
> +static struct reg_type reg_map[] =3D {
> + =A0 =A0 =A0 {"MCSPI_REV", 0x0},
> + =A0 =A0 =A0 {"MCSPI_SYSCONFIG", 0x10},
> + =A0 =A0 =A0 {"MCSPI_SYSSTATUS", 0x14},
> + =A0 =A0 =A0 {"MCSPI_IRQSTATUS", 0x18},
> + =A0 =A0 =A0 {"MCSPI_IRQENABLE", 0x1C},
> + =A0 =A0 =A0 {"MCSPI_WAKEUPENABLE", 0x20},
> + =A0 =A0 =A0 {"MCSPI_SYST", 0x24},
> + =A0 =A0 =A0 {"MCSPI_MODULCTRL", 0x28},
> + =A0 =A0 =A0 {"MCSPI_XFERLEVEL", 0x7c},
> + =A0 =A0 =A0 {"CH0", 0x2C},
> + =A0 =A0 =A0 {"CH1", 0x40},
> + =A0 =A0 =A0 {"CH2", 0x54},
> + =A0 =A0 =A0 {"CH3", 0x68}
> +};
> +
> +static struct reg_type ch_reg_type[] =3D {
> + =A0 =A0 =A0 {"CONF", 0x00},
> + =A0 =A0 =A0 {"STAT", 0x04},
> + =A0 =A0 =A0 {"CTRL", 0x08},
> + =A0 =A0 =A0 {"TX", 0x0C},
> + =A0 =A0 =A0 {"RX", 0x10},
> +};
> +#endif
> +
> =A0static struct workqueue_struct *omap2_mcspi_wq;
>
> =A0#define MOD_REG_BIT(val, mask, set) do { \
> @@ -223,6 +263,39 @@ static void omap2_mcspi_set_dma_req(const struct=
 spi_device *spi,
> =A0 =A0 =A0 =A0mcspi_write_chconf0(spi, l);
> =A0}
>
> +#ifdef CONFIG_SPI_DEBUG
> +static int
> +omap2_mcspi_dump_regs(struct spi_master *master)
> +{
> + =A0 =A0 =A0 u32 spi_base;
> + =A0 =A0 =A0 u32 reg;
> + =A0 =A0 =A0 u32 channel;
> + =A0 =A0 =A0 struct omap2_mcspi *mcspi =3D spi_master_get_devdata(ma=
ster);
> +
> + =A0 =A0 =A0 spi_base =3D (u32)mcspi->base;
> +
> + =A0 =A0 =A0 for (reg =3D 0; (reg < ARRAY_SIZE(reg_map)); reg++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct reg_type *reg_d =3D &reg_map[reg=
];
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 u32 base1 =3D spi_base + reg_d->offset;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (reg_d->name[0] =3D=3D 'C') {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (channel =3D 0; (ch=
annel < (ARRAY_SIZE(ch_reg_type)));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 channel++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct =
reg_type *reg_c =3D &ch_reg_type[channel];
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 u32 bas=
e2 =3D base1 + reg_c->offset;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_debu=
g("MCSPI_%s%s [0x%08X] =3D 0x%08X\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0reg_d->name, reg_c->name, base2,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0__raw_readl(base2));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_debug("%s : [0x%08X]=
 =3D 0x%08X\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg_d->=
name, base1, __raw_readl(base1));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 return 0;
> +}
> +#endif
> +

Large chunk of debug code not mentioned in the patch description.
Please move to a separate patch.

> =A0static void omap2_mcspi_set_enable(const struct spi_device *spi, i=
nt enable)
> =A0{
> =A0 =A0 =A0 =A0u32 l;
> @@ -242,22 +315,135 @@ static void omap2_mcspi_force_cs(struct spi_de=
vice *spi, int cs_active)
> =A0 =A0 =A0 =A0mcspi_write_chconf0(spi, l);
> =A0}
>
> +static int omap2_mcspi_set_txfifo(const struct spi_device *spi, int =
buf_size,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 int enable)
> +{
> + =A0 =A0 =A0 u32 l, rw, s;
> + =A0 =A0 =A0 unsigned short revert =3D 0;
> + =A0 =A0 =A0 struct spi_master *master =3D spi->master;
> + =A0 =A0 =A0 struct omap2_mcspi *mcspi =3D spi_master_get_devdata(ma=
ster);
> +
> + =A0 =A0 =A0 l =3D mcspi_read_cs_reg(spi, OMAP2_MCSPI_CHCONF0);
> + =A0 =A0 =A0 s =3D mcspi_read_cs_reg(spi, OMAP2_MCSPI_CHCTRL0);
> +
> + =A0 =A0 =A0 if (enable =3D=3D 1) {
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* FIFO cannot be enabled for both TX a=
nd RX
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* simultaneously
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (l & OMAP2_MCSPI_CHCONF_FFER)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EPERM;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Channel needs to be disabled and ena=
bled
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* for FIFO setting to take affect
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (s & OMAP2_MCSPI_CHCTRL_EN) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap2_mcspi_set_enable(=
spi, 0);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 revert =3D 1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (buf_size < mcspi->fifo_depth)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mcspi_write_reg(master,=
 OMAP2_MCSPI_XFERLEVEL,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 ((buf_size << 16) |
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 (buf_size - 1) << 0));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mcspi_write_reg(master,=
 OMAP2_MCSPI_XFERLEVEL,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 ((buf_size << 16) |
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 (mcspi->fifo_depth - 1) << 0));

The following would be more concise and more readable as to what the
difference is between the two conditions:

		s =3D buf_size < mcspi->fifo_depth ? buf_size : mcspi->fifo_depth;
		mcspi_write_reg(master, OMAP2_MCSPI_XFERLEVEL,
				(buf_size << 16) | (s - 1));

> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 rw =3D OMAP2_MCSPI_CHCONF_FFET;
> + =A0 =A0 =A0 MOD_REG_BIT(l, rw, enable);
> + =A0 =A0 =A0 mcspi_write_cs_reg(spi, OMAP2_MCSPI_CHCONF0, l);
> +
> + =A0 =A0 =A0 if (revert)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap2_mcspi_set_enable(spi, 1);
> +
> + =A0 =A0 =A0 return 0;
> +
> +}
> +
> +static int omap2_mcspi_set_rxfifo(const struct spi_device *spi, int =
buf_size,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 int enable)
> +{
> + =A0 =A0 =A0 u32 l, rw, s;
> + =A0 =A0 =A0 unsigned short revert =3D 0;
> + =A0 =A0 =A0 struct spi_master *master =3D spi->master;
> + =A0 =A0 =A0 struct omap2_mcspi *mcspi =3D spi_master_get_devdata(ma=
ster);
> +
> + =A0 =A0 =A0 l =3D mcspi_read_cs_reg(spi, OMAP2_MCSPI_CHCONF0);
> + =A0 =A0 =A0 s =3D mcspi_read_cs_reg(spi, OMAP2_MCSPI_CHCTRL0);
> +
> + =A0 =A0 =A0 if (enable =3D=3D 1) {
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* FIFO cannot be enabled for both TX a=
nd RX
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* simultaneously
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (l & OMAP2_MCSPI_CHCONF_FFET)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EPERM;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Channel needs to be disabled and ena=
bled
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* for FIFO setting to take affect
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (s & OMAP2_MCSPI_CHCTRL_EN) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap2_mcspi_set_enable(=
spi, 0);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 revert =3D 1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (buf_size < mcspi->fifo_depth)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mcspi_write_reg(master,=
 OMAP2_MCSPI_XFERLEVEL,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 ((buf_size << 16) |
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 (buf_size - 1) << 8));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mcspi_write_reg(master,=
 OMAP2_MCSPI_XFERLEVEL,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 ((buf_size << 16) |
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 (mcspi->fifo_depth - 1) << 8));

Ditto here.

> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 rw =3D OMAP2_MCSPI_CHCONF_FFER;
> + =A0 =A0 =A0 MOD_REG_BIT(l, rw, enable);
> + =A0 =A0 =A0 mcspi_write_cs_reg(spi, OMAP2_MCSPI_CHCONF0, l);
> +
> + =A0 =A0 =A0 if (revert)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap2_mcspi_set_enable(spi, 1);
> +
> + =A0 =A0 =A0 return 0;
> +
> +}
> +
> =A0static void omap2_mcspi_set_master_mode(struct spi_master *master)
> =A0{
> =A0 =A0 =A0 =A0u32 l;
> + =A0 =A0 =A0 struct omap2_mcspi *mcspi =3D spi_master_get_devdata(ma=
ster);
>
> =A0 =A0 =A0 =A0/* setup when switching from (reset default) slave mod=
e
> - =A0 =A0 =A0 =A0* to single-channel master mode
> + =A0 =A0 =A0 =A0* to single-channel master mode based on config valu=
e
> =A0 =A0 =A0 =A0 */
> =A0 =A0 =A0 =A0l =3D mcspi_read_reg(master, OMAP2_MCSPI_MODULCTRL);
> =A0 =A0 =A0 =A0MOD_REG_BIT(l, OMAP2_MCSPI_MODULCTRL_STEST, 0);
> =A0 =A0 =A0 =A0MOD_REG_BIT(l, OMAP2_MCSPI_MODULCTRL_MS, 0);
> - =A0 =A0 =A0 MOD_REG_BIT(l, OMAP2_MCSPI_MODULCTRL_SINGLE, 1);
> +
> + =A0 =A0 =A0 if (mcspi->force_cs_mode)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 MOD_REG_BIT(l, OMAP2_MCSPI_MODULCTRL_SI=
NGLE, 1);
> +

No mention of adding slave mode support in the patch description.  Nor
do I see any description of how slave mode is intended to work.

> =A0 =A0 =A0 =A0mcspi_write_reg(master, OMAP2_MCSPI_MODULCTRL, l);
>
> =A0 =A0 =A0 =A0omap2_mcspi_ctx[master->bus_num - 1].modulctrl =3D l;
> =A0}
>
> +static int mcspi_wait_for_reg_bit(void __iomem *reg, unsigned long b=
it)
> +{
> + =A0 =A0 =A0 unsigned long timeout;
> +
> + =A0 =A0 =A0 timeout =3D jiffies + msecs_to_jiffies(1000);
> + =A0 =A0 =A0 while (!(__raw_readl(reg) & bit)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (time_after(jiffies, timeout))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cpu_relax();
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 return 0;
> +}
> +
> =A0static void omap2_mcspi_restore_ctx(struct omap2_mcspi *mcspi)
> =A0{
> =A0 =A0 =A0 =A0struct spi_master *spi_cntrl;
> @@ -302,16 +488,18 @@ omap2_mcspi_txrx_dma(struct spi_device *spi, st=
ruct spi_transfer *xfer)
> =A0 =A0 =A0 =A0struct omap2_mcspi =A0 =A0 =A0*mcspi;
> =A0 =A0 =A0 =A0struct omap2_mcspi_cs =A0 *cs =3D spi->controller_stat=
e;
> =A0 =A0 =A0 =A0struct omap2_mcspi_dma =A0*mcspi_dma;
> - =A0 =A0 =A0 unsigned int =A0 =A0 =A0 =A0 =A0 =A0count, c;
> + =A0 =A0 =A0 unsigned int =A0 =A0 =A0 =A0 =A0 =A0count, c, bytes_per=
_transfer;
> =A0 =A0 =A0 =A0unsigned long =A0 =A0 =A0 =A0 =A0 base, tx_reg, rx_reg=
;
> =A0 =A0 =A0 =A0int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 word_len, =
data_type, element_count;
> - =A0 =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 elements;
> + =A0 =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 elements, f=
rame_count, sync_type;
> =A0 =A0 =A0 =A0u32 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 l;
> =A0 =A0 =A0 =A0u8 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* rx;
> =A0 =A0 =A0 =A0const u8 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* tx;
> + =A0 =A0 =A0 void __iomem =A0 =A0 =A0 =A0 =A0 =A0*irqstat_reg;
>
> =A0 =A0 =A0 =A0mcspi =3D spi_master_get_devdata(spi->master);
> =A0 =A0 =A0 =A0mcspi_dma =3D &mcspi->dma_channels[spi->chip_select];
> + =A0 =A0 =A0 irqstat_reg =3D mcspi->base + OMAP2_MCSPI_IRQSTATUS;
> =A0 =A0 =A0 =A0l =3D mcspi_cached_chconf0(spi);
>
> =A0 =A0 =A0 =A0count =3D xfer->len;
> @@ -327,19 +515,34 @@ omap2_mcspi_txrx_dma(struct spi_device *spi, st=
ruct spi_transfer *xfer)
> =A0 =A0 =A0 =A0if (word_len <=3D 8) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0data_type =3D OMAP_DMA_DATA_TYPE_S8;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0element_count =3D count;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 bytes_per_transfer =3D 1;
> =A0 =A0 =A0 =A0} else if (word_len <=3D 16) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0data_type =3D OMAP_DMA_DATA_TYPE_S16;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0element_count =3D count >> 1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 bytes_per_transfer =3D 2;
> =A0 =A0 =A0 =A0} else /* word_len <=3D 32 */ {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0data_type =3D OMAP_DMA_DATA_TYPE_S32;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0element_count =3D count >> 2;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 bytes_per_transfer =3D 4;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 if ((mcspi->fifo_depth !=3D 0) && (count > mcspi->fifo_=
depth)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 sync_type =3D OMAP_DMA_SYNC_FRAME;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 element_count =3D mcspi->fifo_depth/byt=
es_per_transfer;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 frame_count =3D count/mcspi->fifo_depth=
;
> + =A0 =A0 =A0 } else if ((mcspi->fifo_depth !=3D 0) && (count <=3D =A0=
mcspi->fifo_depth)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 sync_type =3D OMAP_DMA_SYNC_FRAME;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 frame_count =3D 1;
> + =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 sync_type =3D OMAP_DMA_SYNC_ELEMENT;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 frame_count =3D 1;
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0if (tx !=3D NULL) {
> +
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap_set_dma_transfer_params(mcspi_dma=
->dma_tx_channel,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 data_ty=
pe, element_count, 1,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP_DM=
A_SYNC_ELEMENT,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mcspi_d=
ma->dma_tx_sync_dev, 0);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 data_ty=
pe, element_count, frame_count,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sync_ty=
pe, mcspi_dma->dma_tx_sync_dev, 0);
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap_set_dma_dest_params(mcspi_dma->dm=
a_tx_channel, 0,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0OMAP_D=
MA_AMODE_CONSTANT,
> @@ -348,6 +551,9 @@ omap2_mcspi_txrx_dma(struct spi_device *spi, stru=
ct spi_transfer *xfer)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap_set_dma_src_params(mcspi_dma->dma=
_tx_channel, 0,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0OMAP_D=
MA_AMODE_POST_INC,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0xfer->=
tx_dma, 0, 0);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (mcspi->fifo_depth !=3D 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap2_mcspi_set_txfifo(=
spi, count, 1);
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0if (rx !=3D NULL) {
> @@ -367,6 +573,14 @@ omap2_mcspi_txrx_dma(struct spi_device *spi, str=
uct spi_transfer *xfer)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap_set_dma_dest_params(mcspi_dma->dm=
a_rx_channel, 0,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0OMAP_D=
MA_AMODE_POST_INC,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0xfer->=
rx_dma, 0, 0);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (mcspi->fifo_depth !=3D 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap2_mcspi_set_rxfifo(=
spi, count, 1);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Dummy write required=
 for RX only mode */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (tx =3D=3D NULL)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mcspi_w=
rite_cs_reg(spi, OMAP2_MCSPI_TX0, 0);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0if (tx !=3D NULL) {
> @@ -381,11 +595,32 @@ omap2_mcspi_txrx_dma(struct spi_device *spi, st=
ruct spi_transfer *xfer)
>
> =A0 =A0 =A0 =A0if (tx !=3D NULL) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0wait_for_completion(&mcspi_dma->dma_tx=
_completion);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (mcspi->fifo_depth !=3D 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (mcspi_wait_for_reg_=
bit(irqstat_reg,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP2_M=
CSPI_IRQ_EOW) < 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 dev_err(&spi->dev, "TXS timed out\n");
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mcspi_write_reg(mcspi->master, OMAP2_MC=
SPI_IRQSTATUS,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP2_M=
CSPI_IRQ_EOW);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap2_mcspi_set_txfifo(spi, count, 0);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dma_unmap_single(NULL, xfer->tx_dma, c=
ount, DMA_TO_DEVICE);
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0if (rx !=3D NULL) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0wait_for_completion(&mcspi_dma->dma_rx=
_completion);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (mcspi->fifo_depth !=3D 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap2_mcspi_set_rxfifo(=
spi, count, 0);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mcspi_write_reg(mcspi->master, OMAP2_MC=
SPI_IRQSTATUS,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP2_M=
CSPI_IRQ_EOW);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dma_unmap_single(NULL, xfer->rx_dma, c=
ount, DMA_FROM_DEVICE);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap2_mcspi_set_enable(spi, 0);
>
> @@ -435,19 +670,6 @@ omap2_mcspi_txrx_dma(struct spi_device *spi, str=
uct spi_transfer *xfer)
> =A0 =A0 =A0 =A0return count;
> =A0}
>
> -static int mcspi_wait_for_reg_bit(void __iomem *reg, unsigned long b=
it)
> -{
> - =A0 =A0 =A0 unsigned long timeout;
> -
> - =A0 =A0 =A0 timeout =3D jiffies + msecs_to_jiffies(1000);
> - =A0 =A0 =A0 while (!(__raw_readl(reg) & bit)) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (time_after(jiffies, timeout))
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -1;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 cpu_relax();
> - =A0 =A0 =A0 }
> - =A0 =A0 =A0 return 0;
> -}
> -
> =A0static unsigned
> =A0omap2_mcspi_txrx_pio(struct spi_device *spi, struct spi_transfer *=
xfer)
> =A0{
> @@ -684,8 +906,13 @@ static int omap2_mcspi_setup_transfer(struct spi=
_device *spi,
> =A0 =A0 =A0 =A0/* standard 4-wire master mode: =A0SCK, MOSI/out, MISO=
/in, nCS
> =A0 =A0 =A0 =A0 * REVISIT: this controller could support SPI_3WIRE mo=
de.
> =A0 =A0 =A0 =A0 */
> - =A0 =A0 =A0 l &=3D ~(OMAP2_MCSPI_CHCONF_IS|OMAP2_MCSPI_CHCONF_DPE1)=
;
> - =A0 =A0 =A0 l |=3D OMAP2_MCSPI_CHCONF_DPE0;
> + =A0 =A0 =A0 if (mcspi->mcspi_mode =3D=3D OMAP2_MCSPI_MASTER) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 l &=3D ~(OMAP2_MCSPI_CHCONF_IS|OMAP2_MC=
SPI_CHCONF_DPE1);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 l |=3D OMAP2_MCSPI_CHCONF_DPE0;
> + =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> + =A0 =A0 =A0 }
> +

Continuing my thought from above; please split all the slave mode
support code out of this patch and put it into another.  How the spi
api will behave in slave mode is a critical question to answer, so it
is best kept separate so it doesn't hold up the DMA support code.

>
> =A0 =A0 =A0 =A0/* wordlength */
> =A0 =A0 =A0 =A0l &=3D ~OMAP2_MCSPI_CHCONF_WL_MASK;
> @@ -697,9 +924,11 @@ static int omap2_mcspi_setup_transfer(struct spi=
_device *spi,
> =A0 =A0 =A0 =A0else
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0l &=3D ~OMAP2_MCSPI_CHCONF_EPOL;
>
> - =A0 =A0 =A0 /* set clock divisor */
> - =A0 =A0 =A0 l &=3D ~OMAP2_MCSPI_CHCONF_CLKD_MASK;
> - =A0 =A0 =A0 l |=3D div << 2;
> + =A0 =A0 =A0 if (mcspi->mcspi_mode =3D=3D OMAP2_MCSPI_MASTER) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* set clock divisor */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 l &=3D ~OMAP2_MCSPI_CHCONF_CLKD_MASK;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 l |=3D div << 2;
> + =A0 =A0 =A0 }
>
> =A0 =A0 =A0 =A0/* set SPI mode 0..3 */
> =A0 =A0 =A0 =A0if (spi->mode & SPI_CPOL)
> @@ -909,7 +1138,10 @@ static void omap2_mcspi_work(struct work_struct=
 *work)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0par_override =3D 0;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!cs_active) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((!cs_active) && (mc=
spi->force_cs_mode) &&
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (mcspi-=
>mcspi_mode =3D=3D
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP2_M=
CSPI_MASTER)) {
> +
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap2_=
mcspi_force_cs(spi, 1);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cs_act=
ive =3D 1;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> @@ -939,10 +1171,14 @@ static void omap2_mcspi_work(struct work_struc=
t *work)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0__raw_writel(0, cs->base
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0+ OMAP2_MCSPI_TX0);
>
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (m->=
is_dma_mapped || t->len >=3D DMA_MIN_BYTES)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (m->=
is_dma_mapped ||
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 t->len >=3D DMA_MIN_BYTES ||
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 mcspi->dma_mode)
> +

Hmmm.  I'm not sure what is intended here.  Perhaps I started with the
wrong impression, but it appears that the driver *already* supports
DMA transfers.  What is the intention of the dma_mode flag?

> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0count =3D omap2_mcspi_txrx_dma(spi, t);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0else
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0count =3D omap2_mcspi_txrx_pio(spi, t);
> +

unrelated whitespace change.

> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0m->act=
ual_length +=3D count;
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (co=
unt !=3D t->len) {
> @@ -955,7 +1191,10 @@ static void omap2_mcspi_work(struct work_struct=
 *work)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0udelay=
(t->delay_usecs);
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* ignore the "leave i=
t on after last xfer" hint */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (t->cs_change) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((t->cs_change) && (=
mcspi->force_cs_mode) &&
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (mcspi-=
>mcspi_mode =3D=3D
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP2_M=
CSPI_MASTER)) {
> +
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap2_=
mcspi_force_cs(spi, 0);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cs_act=
ive =3D 0;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> @@ -967,8 +1206,9 @@ static void omap2_mcspi_work(struct work_struct =
*work)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0status =3D omap2_mcspi=
_setup_transfer(spi, NULL);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (cs_active)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap2_mcspi_force_cs(sp=
i, 0);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((cs_active) && (mcspi->force_cs_mod=
e) &&
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (mcspi->mcspi_mode =3D=3D=
 OMAP2_MCSPI_MASTER))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap2_m=
cspi_force_cs(spi, 0);
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap2_mcspi_set_enable(spi, 0);
>
> @@ -993,6 +1233,8 @@ static int omap2_mcspi_transfer(struct spi_devic=
e *spi, struct spi_message *m)
> =A0 =A0 =A0 =A0m->actual_length =3D 0;
> =A0 =A0 =A0 =A0m->status =3D 0;
>
> + =A0 =A0 =A0 mcspi =3D spi_master_get_devdata(spi->master);
> +
> =A0 =A0 =A0 =A0/* reject invalid messages and transfers */
> =A0 =A0 =A0 =A0if (list_empty(&m->transfers) || !m->complete)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EINVAL;
> @@ -1021,7 +1263,14 @@ static int omap2_mcspi_transfer(struct spi_dev=
ice *spi, struct spi_message *m)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EINVAL;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (m->is_dma_mapped || len < DMA_MIN_B=
YTES)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (mcspi->fifo_depth !=3D 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((len % mcspi->fifo_=
depth) !=3D 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return =
-EINVAL;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }

This looks wrong. There cannot be a guarantee that the buffer length
will be a multiple of the fifo depth.

> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Ignore DMA_MIN_BYTES check if dma on=
ly mode is set */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (m->is_dma_mapped || ((len < DMA_MIN=
_BYTES) &&
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 (!mcspi->dma_mode)))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0continue;
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Do DMA mapping "early" for better e=
rror reporting and
> @@ -1052,8 +1301,6 @@ static int omap2_mcspi_transfer(struct spi_devi=
ce *spi, struct spi_message *m)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 mcspi =3D spi_master_get_devdata(spi->master);
> -
> =A0 =A0 =A0 =A0spin_lock_irqsave(&mcspi->lock, flags);
> =A0 =A0 =A0 =A0list_add_tail(&m->queue, &mcspi->msg_queue);
> =A0 =A0 =A0 =A0queue_work(omap2_mcspi_wq, &mcspi->work);
> @@ -1066,6 +1313,7 @@ static int __init omap2_mcspi_reset(struct omap=
2_mcspi *mcspi)
> =A0{
> =A0 =A0 =A0 =A0struct spi_master =A0 =A0 =A0 *master =3D mcspi->maste=
r;
> =A0 =A0 =A0 =A0u32 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tmp;
> + =A0 =A0 =A0 u32 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 error =3D 0=
;
>
> =A0 =A0 =A0 =A0if (omap2_mcspi_enable_clocks(mcspi))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -1;
> @@ -1086,9 +1334,13 @@ static int __init omap2_mcspi_reset(struct oma=
p2_mcspi *mcspi)
> =A0 =A0 =A0 =A0mcspi_write_reg(master, OMAP2_MCSPI_WAKEUPENABLE, tmp)=
;
> =A0 =A0 =A0 =A0omap2_mcspi_ctx[master->bus_num - 1].wakeupenable =3D =
tmp;
>
> - =A0 =A0 =A0 omap2_mcspi_set_master_mode(master);
> + =A0 =A0 =A0 if (mcspi->mcspi_mode =3D=3D OMAP2_MCSPI_MASTER)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap2_mcspi_set_master_mode(master);
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 error =3D -EINVAL;
> +
> =A0 =A0 =A0 =A0omap2_mcspi_disable_clocks(mcspi);
> - =A0 =A0 =A0 return 0;
> + =A0 =A0 =A0 return error;
> =A0}
>
> =A0static u8 __initdata spi1_rxdma_id [] =3D {
> @@ -1141,6 +1393,8 @@ static u8 __initdata spi4_txdma_id[] =3D {
> =A0static int __init omap2_mcspi_probe(struct platform_device *pdev)
> =A0{
> =A0 =A0 =A0 =A0struct spi_master =A0 =A0 =A0 *master;
> + =A0 =A0 =A0 struct omap2_mcspi_platform_config *pdata =3D
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 (struct omap2_mcspi_platform_config *)p=
dev->dev.platform_data;
> =A0 =A0 =A0 =A0struct omap2_mcspi =A0 =A0 =A0*mcspi;
> =A0 =A0 =A0 =A0struct resource =A0 =A0 =A0 =A0 *r;
> =A0 =A0 =A0 =A0int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 status =3D=
 0, i;
> @@ -1198,6 +1452,16 @@ static int __init omap2_mcspi_probe(struct pla=
tform_device *pdev)
>
> =A0 =A0 =A0 =A0mcspi =3D spi_master_get_devdata(master);
> =A0 =A0 =A0 =A0mcspi->master =3D master;
> + =A0 =A0 =A0 mcspi->mcspi_mode =3D OMAP2_MCSPI_MASTER;
> + =A0 =A0 =A0 mcspi->dma_mode =3D pdata->dma_mode;
> + =A0 =A0 =A0 mcspi->force_cs_mode =3D pdata->force_cs_mode;
> +
> + =A0 =A0 =A0 if (pdata->fifo_depth <=3D OMAP2_MCSPI_MAX_FIFODEPTH)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mcspi->fifo_depth =3D pdata->fifo_depth=
;
> + =A0 =A0 =A0 else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mcspi->fifo_depth =3D 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(&pdev->dev, "Invalid fifo depth=
 specified\n");
> + =A0 =A0 =A0 }
>
> =A0 =A0 =A0 =A0r =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> =A0 =A0 =A0 =A0if (r =3D=3D NULL) {
> --
> 1.6.3.3


Sorry, I have to Nack this patch.  It makes several unrelated changes
that should be in separate patches, and I suspect that the changes are
incorrect (please correct me if I'm misunderstanding).

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
