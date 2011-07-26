From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: [PATCH] OMAP3: NAND: Adding NAND support and specifying NAND partitions.
Date: Tue, 26 Jul 2011 12:38:46 +0300
Message-ID: <CANOLnOODuPKAmRfiokC_4UgwrxCcw5xY1a9vhMsWN0T2LzNzAQ@mail.gmail.com>
References: <1311601253-2933-1-git-send-email-hrishikesh.b@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:54701 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751211Ab1GZJir convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 26 Jul 2011 05:38:47 -0400
In-Reply-To: <1311601253-2933-1-git-send-email-hrishikesh.b@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hrishikesh Bhandiwad <hrishikesh.b@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org, Vaibhav Hiremath <hvaibhav@ti.com>, Sanjeev Premi <premi@ti.com>

On Mon, Jul 25, 2011 at 4:40 PM, Hrishikesh Bhandiwad
<hrishikesh.b@ti.com> wrote:
> This patch adds the NAND support on OMAP3EVM board and also allocates
> five partitions =C2=A0on NAND.
> Referred to file: arch/arm/mach-omap2/board-omap3beagle.c
>
> Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
> Signed-off-by: Sanjeev Premi <premi@ti.com>
> Signed-off-by: Hrishikesh Bhandiwad <hrishikesh.b@ti.com>
> ---
> =C2=A0arch/arm/mach-omap2/board-omap3evm.c | =C2=A0 40 ++++++++++++++=
++++++++++++++++++++
> =C2=A01 files changed, 40 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-oma=
p2/board-omap3evm.c
> index b4d4346..be45b63 100644
> --- a/arch/arm/mach-omap2/board-omap3evm.c
> +++ b/arch/arm/mach-omap2/board-omap3evm.c
> @@ -30,6 +30,10 @@
> =C2=A0#include <linux/usb/otg.h>
> =C2=A0#include <linux/smsc911x.h>
>
> +#include <linux/mtd/mtd.h>

You don't need this include.

> +#include <linux/mtd/partitions.h>
> +#include <linux/mtd/nand.h>
> +
> =C2=A0#include <linux/wl12xx.h>
> =C2=A0#include <linux/regulator/fixed.h>
> =C2=A0#include <linux/regulator/machine.h>
> @@ -46,6 +50,8 @@
> =C2=A0#include <plat/mcspi.h>
> =C2=A0#include <video/omapdss.h>
> =C2=A0#include <video/omap-panel-generic-dpi.h>
> +#include <plat/gpmc.h>
> +#include <plat/nand.h>

These 2 too.

>
> =C2=A0#include "mux.h"
> =C2=A0#include "sdram-micron-mt46h32m32lf-6.h"
> @@ -101,6 +107,37 @@ static void __init omap3_evm_get_revision(void)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> =C2=A0}
>
> +static struct mtd_partition omap3evm_nand_partitions[] =3D {
> + =C2=A0 =C2=A0 =C2=A0 /* All the partition sizes are listed in terms=
 of NAND block size */
> + =C2=A0 =C2=A0 =C2=A0 {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .name =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =3D "X-Loader",
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .offset =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =3D 0,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .size =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =3D 4 * NAND_BLOCK_SIZE,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .mask_flags =C2=A0=
 =C2=A0 =3D MTD_WRITEABLE, =C2=A0 =C2=A0 =C2=A0 =C2=A0/* force read-onl=
y */
> + =C2=A0 =C2=A0 =C2=A0 },
> + =C2=A0 =C2=A0 =C2=A0 {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .name =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =3D "U-Boot",
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .offset =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =3D 0x80000

Missing comma. Have you at least tried compiling this?

> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .size =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =3D 15 * NAND_BLOCK_SIZE,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .mask_flags =C2=A0=
 =C2=A0 =3D MTD_WRITEABLE, =C2=A0 =C2=A0 =C2=A0 =C2=A0/* force read-onl=
y */
> + =C2=A0 =C2=A0 =C2=A0 },
> + =C2=A0 =C2=A0 =C2=A0 {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .name =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =3D "U-Boot Env",
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .offset =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =3D 0x260000
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .size =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =3D 1 * NAND_BLOCK_SIZE,
> + =C2=A0 =C2=A0 =C2=A0 },
> + =C2=A0 =C2=A0 =C2=A0 {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .name =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =3D "Kernel",
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .offset =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =3D 0x280000
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .size =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =3D 32 * NAND_BLOCK_SIZE,
> + =C2=A0 =C2=A0 =C2=A0 },
> + =C2=A0 =C2=A0 =C2=A0 {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .name =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =3D "File System",
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .offset =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =3D 0x680000
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .size =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =3D MTDPART_SIZ_FULL,
> + =C2=A0 =C2=A0 =C2=A0 },
> +};
> +
> =C2=A0#if defined(CONFIG_SMSC911X) || defined(CONFIG_SMSC911X_MODULE)
> =C2=A0#include <plat/gpmc-smsc911x.h>
>
> @@ -696,6 +733,9 @@ static void __init omap3_evm_init(void)
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0omap_serial_init();
>
> + =C2=A0 =C2=A0 =C2=A0 omap_nand_flash_init(NAND_BUSWIDTH_16, omap3ev=
m_nand_partitions,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 ARRAY_SIZE(omap3evm_nand_partitions));
> +
> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* OMAP3EVM uses ISP1504 phy and so regist=
er nop transceiver */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0usb_nop_xceiv_register();
>
> --
> 1.6.2.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
>

--=20
Gra=C5=BEvydas
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
