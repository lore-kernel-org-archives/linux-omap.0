From: John Rigby <jcrigby@gmail.com>
Subject: Re: MMC_CAP_SDIO_IRQ for omap 3430
Date: Fri, 16 Oct 2009 07:43:13 -0600
Message-ID: <4b73d43f0910160643y59d39373y1dd1c1995f521778@mail.gmail.com>
References: <4b73d43f0910151330q6c5cae7sa2a5948b586cc215@mail.gmail.com>
	 <4AD81DC2.4080607@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f188.google.com ([209.85.222.188]:59267 "EHLO
	mail-pz0-f188.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753247AbZJPNnu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Oct 2009 09:43:50 -0400
Received: by pzk26 with SMTP id 26so1618340pzk.4
        for <linux-omap@vger.kernel.org>; Fri, 16 Oct 2009 06:43:13 -0700 (PDT)
In-Reply-To: <4AD81DC2.4080607@googlemail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dirk Behme <dirk.behme@googlemail.com>
Cc: linux-omap@vger.kernel.org, Madhusudhan <madhu.cr@ti.com>, Steve Sakoman <sakoman@gmail.com>

Dirk,

Many thanks, after sending the request yesterday I made my own attempt
which failed miserably.  My patch looks like a subset of yours so that
is to be expected.  I'll try yours out today and report back my
experience.

John

On Fri, Oct 16, 2009 at 1:16 AM, Dirk Behme <dirk.behme@googlemail.com>=
 wrote:
> John Rigby wrote:
>>
>> I have seen several discussions about lack of sdio irq support in th=
e
>> hsmmc driver but no patches. =A0Has anyone on this list implemented =
this
>> and/or can anyone point me to patches?
>
> What a coincidence ;)
>
> I'm currently working on this. See attachment what I currently have. =
It is
> compile tested only against recent omap linux head. I don't have a bo=
ard
> using SDIO at the moment, so no real testing possible :(
>
> Some background, maybe it helps people to step in:
>
> Gumstix OMAP3 based Overo air board connects Marvell 88W8686 wifi by =
MMC
> port 2 in 4 bit configuration [1]. The wifi performance is quite bad
> (~100kB/s). There is some rumor that this might be SDIO irq related [=
2].
> There was an attempt to fix this [3] already, but this doesn't work [=
4].
> Having this, I started to look into it.
>
> I used [3], the TI Davinci driver [5] (supporting SDIO irq), the SDIO
> Simplified Specification [6] and the OMAP35x TRM [7] as starting poin=
ts.
>
> Unfortunately, the Davinci MMC registers and irqs are different (Davi=
nci has
> a dedicated SDIO irq). But combining [3] and [5] helps to get an idea=
 what
> has to be done.
>
> I think the main issues of [3] were that it doesn't enable IBG for 4 =
bit
> mode ([6] chapter 8.1.2) and that mmc_omap_irq() doesn't reset the ir=
q bits.
>
> Topics I still open:
>
> - Is it always necessary to deal with IE _and_ ISE register? I'm not =
totally
> clear what the difference between these two registers are ;) And in w=
hich
> order they have to be set.
>
> - Davinci driver [5] in line 1115 checks for data line to call
> mmc_signal_sdio_irq() for irq enable.
>
> - Davinci driver deals with SDIO in xfer_done() (line 873)
>
> - Davinci driver sets block size to 64 if SDIO in line 701
>
> It would be quite nice if anybody likes to comment on attachment and =
help
> testing.
>
> Many thanks and best regards
>
> Dirk
>
> [1] http://gumstix.net/wiki/index.php?title=3DOvero_Wifi
>
> [2] http://groups.google.com/group/beagleboard/msg/14e822778c5eeb56
>
> [3] http://groups.google.com/group/beagleboard/msg/d0eb69f4c20673be
>
> [4] http://groups.google.com/group/beagleboard/msg/5cdfe2a319531937
>
> [5]
> http://arago-project.org/git/projects/?p=3Dlinux-davinci.git;a=3Dblob=
;f=3Ddrivers/mmc/host/davinci_mmc.c;h=3D1bf0587250614c6d8abfe02028b96e0=
e47148ac8;hb=3DHEAD
>
> [6] http://www.sdcard.org/developers/tech/sdio/sd_bluetooth_spec/
>
> [7] http://focus.ti.com/lit/ug/spruf98c/spruf98c.pdf
>
>
> Subject: [PATCH][RFC] OMAP HSMMC: Add SDIO interrupt support
> Form: Dirk Behme <dirk.behme@googlemail.com>
>
> At the moment, OMAP HSMMC driver supports only SDIO polling, resultin=
g in
> poor
> performance. Add support for SDIO interrupt handling.
>
> Signed-off-by: Dirk Behme <dirk.behme@googlemail.com>
> ---
>
> Patch against recent omap-linux head "Linux omap got rebuilt from scr=
atch"
> 274c94b29ee7c53609a756acca974e4742c59559
>
> Compile tested only. Please comment and help testing.
>
> =A0drivers/mmc/host/omap_hsmmc.c | =A0 48
> +++++++++++++++++++++++++++++++++++++-----
> =A01 file changed, 43 insertions(+), 5 deletions(-)
>
> Index: linux-beagle/drivers/mmc/host/omap_hsmmc.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-beagle.orig/drivers/mmc/host/omap_hsmmc.c
> +++ linux-beagle/drivers/mmc/host/omap_hsmmc.c
> @@ -27,6 +27,7 @@
> =A0#include <linux/timer.h>
> =A0#include <linux/clk.h>
> =A0#include <linux/mmc/host.h>
> +#include <linux/mmc/card.h>
> =A0#include <linux/mmc/core.h>
> =A0#include <linux/io.h>
> =A0#include <linux/semaphore.h>
> @@ -65,6 +66,7 @@
> =A0#define SDVSDET =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x0=
0000400
> =A0#define AUTOIDLE =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x1
> =A0#define SDBP =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (1 << 8)
> +#define IBG =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(1 << 19)
> =A0#define DTO =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00xe
> =A0#define ICE =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x1
> =A0#define ICS =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x2
> @@ -76,6 +78,7 @@
> =A0#define INT_EN_MASK =A0 =A0 =A0 =A0 =A0 =A00x307F0033
> =A0#define BWR_ENABLE =A0 =A0 =A0 =A0 =A0 =A0 (1 << 4)
> =A0#define BRR_ENABLE =A0 =A0 =A0 =A0 =A0 =A0 (1 << 5)
> +#define CIRQ_ENABLE =A0 =A0 =A0 =A0 =A0 =A0(1 << 8)
> =A0#define INIT_STREAM =A0 =A0 =A0 =A0 =A0 =A0(1 << 1)
> =A0#define DP_SELECT =A0 =A0 =A0 =A0 =A0 =A0 =A0(1 << 21)
> =A0#define DDIR =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (1 << 4)
> @@ -87,6 +90,7 @@
> =A0#define CC =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x1
> =A0#define TC =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x02
> =A0#define OD =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x1
> +#define CIRQ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (1 << =A08)
> =A0#define ERR =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(1 << 15)
> =A0#define CMD_TIMEOUT =A0 =A0 =A0 =A0 =A0 =A0(1 << 16)
> =A0#define DATA_TIMEOUT =A0 =A0 =A0 =A0 =A0 (1 << 20)
> @@ -653,6 +657,15 @@ static irqreturn_t omap_hsmmc_irq(int ir
> =A0 =A0 =A0 =A0status =3D OMAP_HSMMC_READ(host->base, STAT);
> =A0 =A0 =A0 =A0dev_dbg(mmc_dev(host->mmc), "IRQ Status is %x\n", stat=
us);
>
> + =A0 =A0 =A0 if (status & CIRQ) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(mmc_dev(host->mmc), "SDIO inter=
rupt");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP_HSMMC_WRITE(host->base, IE, OMAP_H=
SMMC_READ(host->base,
> IE)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0& ~(=
CIRQ_ENABLE));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_signal_sdio_irq(host->mmc);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock(&host->irq_lock);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return IRQ_HANDLED;
> + =A0 =A0 =A0 }
> +
> =A0 =A0 =A0 =A0if (status & ERR) {
> =A0#ifdef CONFIG_MMC_DEBUG
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap_hsmmc_report_irq(host, status);
> @@ -1165,8 +1178,15 @@ static void omap_hsmmc_set_ios(struct mm
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> =A0 =A0 =A0 =A0case MMC_BUS_WIDTH_4:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0OMAP_HSMMC_WRITE(host->base, CON, con =
& ~DW8);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP_HSMMC_WRITE(host->base, HCTL,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP_HSMMC_READ(host->b=
ase, HCTL) | FOUR_BIT);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (mmc_card_sdio(host->mmc->card)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP_HSMMC_WRITE(host->=
base, HCTL,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0OMAP_HSMMC_READ(host->base, HCTL)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0| IBG | FOUR_BIT);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP_HSMMC_WRITE(host->=
base, HCTL,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0OMAP_HSMMC_READ(host->base, HCTL)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0| FOUR_BIT);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> =A0 =A0 =A0 =A0case MMC_BUS_WIDTH_1:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0OMAP_HSMMC_WRITE(host->base, CON, con =
& ~DW8);
> @@ -1512,6 +1532,24 @@ static int omap_hsmmc_disable_fclk(struc
> =A0 =A0 =A0 =A0return 0;
> =A0}
>
> +static void omap_hsmmc_enable_sdio_irq(struct mmc_host *mmc, int ena=
ble)
> +{
> + =A0 =A0 =A0 struct omap_hsmmc_host *host =3D mmc_priv(mmc);
> + =A0 =A0 =A0 u32 ie, ise;
> +
> + =A0 =A0 =A0 ise =3D OMAP_HSMMC_READ(host->base, ISE);
> + =A0 =A0 =A0 ie =A0=3D OMAP_HSMMC_READ(host->base, IE);
> +
> + =A0 =A0 =A0 if (enable) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP_HSMMC_WRITE(host->base, ISE, ise |=
 CIRQ_ENABLE);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP_HSMMC_WRITE(host->base, IE, =A0ie =
=A0| CIRQ_ENABLE);
> + =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP_HSMMC_WRITE(host->base, ISE, ise &=
 ~CIRQ_ENABLE);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP_HSMMC_WRITE(host->base, IE, =A0ie =
=A0& ~CIRQ_ENABLE);
> + =A0 =A0 =A0 }
> +
> +}
> +
> =A0static const struct mmc_host_ops omap_hsmmc_ops =3D {
> =A0 =A0 =A0 =A0.enable =3D omap_hsmmc_enable_fclk,
> =A0 =A0 =A0 =A0.disable =3D omap_hsmmc_disable_fclk,
> @@ -1519,7 +1557,7 @@ static const struct mmc_host_ops omap_hs
> =A0 =A0 =A0 =A0.set_ios =3D omap_hsmmc_set_ios,
> =A0 =A0 =A0 =A0.get_cd =3D omap_hsmmc_get_cd,
> =A0 =A0 =A0 =A0.get_ro =3D omap_hsmmc_get_ro,
> - =A0 =A0 =A0 /* NYET -- enable_sdio_irq */
> + =A0 =A0 =A0 .enable_sdio_irq =3D omap_hsmmc_enable_sdio_irq,
> =A0};
>
> =A0static const struct mmc_host_ops omap_hsmmc_ps_ops =3D {
> @@ -1529,7 +1567,7 @@ static const struct mmc_host_ops omap_hs
> =A0 =A0 =A0 =A0.set_ios =3D omap_hsmmc_set_ios,
> =A0 =A0 =A0 =A0.get_cd =3D omap_hsmmc_get_cd,
> =A0 =A0 =A0 =A0.get_ro =3D omap_hsmmc_get_ro,
> - =A0 =A0 =A0 /* NYET -- enable_sdio_irq */
> + =A0 =A0 =A0 .enable_sdio_irq =3D omap_hsmmc_enable_sdio_irq,
> =A0};
>
> =A0#ifdef CONFIG_DEBUG_FS
> @@ -1734,7 +1772,7 @@ static int __init omap_hsmmc_probe(struc
> =A0 =A0 =A0 =A0mmc->max_seg_size =3D mmc->max_req_size;
>
> =A0 =A0 =A0 =A0mmc->caps |=3D MMC_CAP_MMC_HIGHSPEED | MMC_CAP_SD_HIGH=
SPEED |
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0MMC_CAP_WAIT_WHILE_BUSY;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0MMC_CAP_WAIT_WHILE_BUSY | MM=
C_CAP_SDIO_IRQ;
>
> =A0 =A0 =A0 =A0if (mmc_slot(host).wires >=3D 8)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc->caps |=3D MMC_CAP_8_BIT_DATA;
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
