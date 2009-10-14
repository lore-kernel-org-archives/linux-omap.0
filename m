From: vimal singh <vimal.newwork@gmail.com>
Subject: Re: [PATCH] OMAP3: Fix McBSP poll read and write for 32bit reg access
Date: Wed, 14 Oct 2009 15:22:30 +0530
Message-ID: <ce9ab5790910140252q14d2d8a6xd02bf12ae58bf260@mail.gmail.com>
References: <1255512629-14323-1-git-send-email-charu@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yx0-f188.google.com ([209.85.210.188]:48548 "EHLO
	mail-yx0-f188.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932262AbZJNJx0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 Oct 2009 05:53:26 -0400
Received: by yxe26 with SMTP id 26so5183766yxe.4
        for <linux-omap@vger.kernel.org>; Wed, 14 Oct 2009 02:52:50 -0700 (PDT)
In-Reply-To: <1255512629-14323-1-git-send-email-charu@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: charu@ti.com
Cc: linux-omap@vger.kernel.org, Syed Rafiuddin <rafiuddin.syed@ti.com>

On Wed, Oct 14, 2009 at 3:00 PM,  <charu@ti.com> wrote:
> omap_mcbsp_pollwrite and omap_mcbsp_pollread functions access
> McBSP registers as 16-bit registers.
>
> The McBSP registers (DRR_REG and DXR_REG) are limited to
> 32-bit data accesses (L4 Interconnect). 16-bit and 8-bit is
> not allowed and can corrupt register content.
>
> This patch modifies omap_mcbsp_pollwrite and
> omap_mcbsp_pollread functions to do 32 bit access for above
> mentioned McBSP registers. Data accepted by these
> functions is also modified to 32-bit.
>
> Signed-off-by: Charulatha V <charu@ti.com>
> Signed-off-by: Syed Rafiuddin <rafiuddin.syed@ti.com>
> ---
> =A0arch/arm/plat-omap/include/mach/mcbsp.h | =A0 =A04 +-
> =A0arch/arm/plat-omap/mcbsp.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 46 +++=
+++++++++++-----------------
> =A02 files changed, 23 insertions(+), 27 deletions(-)
>
> diff --git a/arch/arm/plat-omap/include/mach/mcbsp.h b/arch/arm/plat-=
omap/include/mach/mcbsp.h
> index 7e9cae3..05b0d8d 100644
> --- a/arch/arm/plat-omap/include/mach/mcbsp.h
> +++ b/arch/arm/plat-omap/include/mach/mcbsp.h
> @@ -455,8 +455,8 @@ int omap_mcbsp_spi_master_recv_word_poll(unsigned=
 int id, u32 * word);
> =A0void omap_mcbsp_set_spi_mode(unsigned int id, const struct omap_mc=
bsp_spi_cfg * spi_cfg);
>
> =A0/* Polled read/write functions */
> -int omap_mcbsp_pollread(unsigned int id, u16 * buf);
> -int omap_mcbsp_pollwrite(unsigned int id, u16 buf);
> +int omap_mcbsp_pollread(unsigned int id, u32 *buf);
> +int omap_mcbsp_pollwrite(unsigned int id, u32 buf);
> =A0int omap_mcbsp_set_io_type(unsigned int id, omap_mcbsp_io_type_t i=
o_type);
>
> =A0#endif
> diff --git a/arch/arm/plat-omap/mcbsp.c b/arch/arm/plat-omap/mcbsp.c
> index 88ac976..1f278a2 100644
> --- a/arch/arm/plat-omap/mcbsp.c
> +++ b/arch/arm/plat-omap/mcbsp.c
> @@ -613,7 +613,7 @@ void omap_mcbsp_stop(unsigned int id, int tx, int=
 rx)
> =A0EXPORT_SYMBOL(omap_mcbsp_stop);
>
> =A0/* polled mcbsp i/o operations */
> -int omap_mcbsp_pollwrite(unsigned int id, u16 buf)
> +int omap_mcbsp_pollwrite(unsigned int id, u32 buf)
> =A0{
> =A0 =A0 =A0 =A0struct omap_mcbsp *mcbsp;
> =A0 =A0 =A0 =A0void __iomem *base;
> @@ -626,26 +626,24 @@ int omap_mcbsp_pollwrite(unsigned int id, u16 b=
uf)
> =A0 =A0 =A0 =A0mcbsp =3D id_to_mcbsp_ptr(id);
> =A0 =A0 =A0 =A0base =3D mcbsp->io_base;
>
> - =A0 =A0 =A0 writew(buf, base + OMAP_MCBSP_REG_DXR1);
> + =A0 =A0 =A0 OMAP_MCBSP_WRITE(base, DXR, buf);
> =A0 =A0 =A0 =A0/* if frame sync error - clear the error */
> - =A0 =A0 =A0 if (readw(base + OMAP_MCBSP_REG_SPCR2) & XSYNC_ERR) {
> + =A0 =A0 =A0 if (OMAP_MCBSP_READ(base, SPCR2) & XSYNC_ERR) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* clear error */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 writew(readw(base + OMAP_MCBSP_REG_SPCR=
2) & (~XSYNC_ERR),
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0base + OMAP_MCBSP_REG_SP=
CR2);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP_MCBSP_WRITE(base, SPCR2, OMAP_MCBS=
P_READ(base , SPCR2)

remove extra space: 'base ,'
checkpatch.pl should catch these kind of issues.

-vimal

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 & (~XSYNC_ERR));
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* resend */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -1;
> =A0 =A0 =A0 =A0} else {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* wait for transmit confirmation */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0int attemps =3D 0;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 while (!(readw(base + OMAP_MCBSP_REG_SP=
CR2) & XRDY)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 while (!(OMAP_MCBSP_READ(base, SPCR2) &=
 XRDY)) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (attemps++ > 1000) =
{
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 writew(=
readw(base + OMAP_MCBSP_REG_SPCR2) &
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0(~XRST),
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0base + OMAP_MCBSP_REG_SPCR2);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP_MC=
BSP_WRITE(base, SPCR2,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 OMAP_MCBSP_READ(base, SPCR2) & (~XRST));
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0udelay=
(10);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 writew(=
readw(base + OMAP_MCBSP_REG_SPCR2) |
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0(XRST),
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0base + OMAP_MCBSP_REG_SPCR2);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP_MC=
BSP_WRITE(base, SPCR2,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 OMAP_MCBSP_READ(base, SPCR2) | (XRST));
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0udelay=
(10);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_er=
r(mcbsp->dev, "Could not write to"
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0" McBSP%d Register\n", mcbsp->id);
> @@ -658,7 +656,7 @@ int omap_mcbsp_pollwrite(unsigned int id, u16 buf=
)
> =A0}
> =A0EXPORT_SYMBOL(omap_mcbsp_pollwrite);
>
> -int omap_mcbsp_pollread(unsigned int id, u16 *buf)
> +int omap_mcbsp_pollread(unsigned int id, u32 *buf)
> =A0{
> =A0 =A0 =A0 =A0struct omap_mcbsp *mcbsp;
> =A0 =A0 =A0 =A0void __iomem *base;
> @@ -671,24 +669,22 @@ int omap_mcbsp_pollread(unsigned int id, u16 *b=
uf)
>
> =A0 =A0 =A0 =A0base =3D mcbsp->io_base;
> =A0 =A0 =A0 =A0/* if frame sync error - clear the error */
> - =A0 =A0 =A0 if (readw(base + OMAP_MCBSP_REG_SPCR1) & RSYNC_ERR) {
> + =A0 =A0 =A0 if (OMAP_MCBSP_READ(base, SPCR1) & RSYNC_ERR) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* clear error */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 writew(readw(base + OMAP_MCBSP_REG_SPCR=
1) & (~RSYNC_ERR),
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0base + OMAP_MCBSP_REG_SP=
CR1);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP_MCBSP_WRITE(base, SPCR1, OMAP_MCBS=
P_READ(base, SPCR1)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 & (~RSYNC_ERR));
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* resend */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -1;
> =A0 =A0 =A0 =A0} else {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* wait for recieve confirmation */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0int attemps =3D 0;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 while (!(readw(base + OMAP_MCBSP_REG_SP=
CR1) & RRDY)) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (attemps++ > 1000) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 writew(=
readw(base + OMAP_MCBSP_REG_SPCR1) &
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0(~RRST),
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0base + OMAP_MCBSP_REG_SPCR1);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 while (!(OMAP_MCBSP_READ(base, SPCR1) &=
 RRDY)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (attemps++ > 10000) =
{
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP_MC=
BSP_WRITE(base, SPCR1,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 OMAP_MCBSP_READ(base, SPCR1) & (~RRST));
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0udelay=
(10);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 writew(=
readw(base + OMAP_MCBSP_REG_SPCR1) |
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0(RRST),
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0base + OMAP_MCBSP_REG_SPCR1);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP_MC=
BSP_WRITE(base, SPCR1,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 OMAP_MCBSP_READ(base, SPCR1) | (RRST));
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0udelay=
(10);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_er=
r(mcbsp->dev, "Could not read from"
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0" McBSP%d Register\n", mcbsp->id);
> @@ -696,7 +692,7 @@ int omap_mcbsp_pollread(unsigned int id, u16 *buf=
)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0}
> - =A0 =A0 =A0 *buf =3D readw(base + OMAP_MCBSP_REG_DRR1);
> + =A0 =A0 =A0 *buf =3D OMAP_MCBSP_READ(base, DRR);
>
> =A0 =A0 =A0 =A0return 0;
> =A0}
> --
> 1.6.0.4
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
