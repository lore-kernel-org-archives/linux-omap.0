From: "Bhandiwad, Hrishikesh" <hrishikesh.b@ti.com>
Subject: RE: [PATCH] OMAP3: NAND: Adding NAND support and specifying NAND
 partitions.
Date: Tue, 26 Jul 2011 16:36:54 +0530
Message-ID: <ADF30F4D7BDE934D9B632CE7D5C7ACA4047C4D08A08E@dbde03.ent.ti.com>
References: <1311601253-2933-1-git-send-email-hrishikesh.b@ti.com>,<CANOLnOODuPKAmRfiokC_4UgwrxCcw5xY1a9vhMsWN0T2LzNzAQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=Windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:59918 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752616Ab1GZLJH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 26 Jul 2011 07:09:07 -0400
In-Reply-To: <CANOLnOODuPKAmRfiokC_4UgwrxCcw5xY1a9vhMsWN0T2LzNzAQ@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, "Hiremath, Vaibhav" <hvaibhav@ti.com>, "Premi, Sanjeev" <premi@ti.com>

My Replies inline.

Thanks & Regards,
Hrishikesh
________________________________________
=46rom: Grazvydas Ignotas [notasas@gmail.com]
Sent: Tuesday, July 26, 2011 3:08 PM
To: Bhandiwad, Hrishikesh
Cc: linux-omap@vger.kernel.org; linux-arm-kernel@lists.infradead.org; l=
inux-kernel@vger.kernel.org; linux-mtd@lists.infradead.org; Hiremath, V=
aibhav; Premi, Sanjeev
Subject: Re: [PATCH] OMAP3: NAND: Adding NAND support and specifying NA=
ND partitions.

On Mon, Jul 25, 2011 at 4:40 PM, Hrishikesh Bhandiwad
<hrishikesh.b@ti.com> wrote:
> This patch adds the NAND support on OMAP3EVM board and also allocates
> five partitions  on NAND.
> Referred to file: arch/arm/mach-omap2/board-omap3beagle.c
>
> Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
> Signed-off-by: Sanjeev Premi <premi@ti.com>
> Signed-off-by: Hrishikesh Bhandiwad <hrishikesh.b@ti.com>
> ---
>  arch/arm/mach-omap2/board-omap3evm.c |   40 ++++++++++++++++++++++++=
++++++++++
>  1 files changed, 40 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-oma=
p2/board-omap3evm.c
> index b4d4346..be45b63 100644
> --- a/arch/arm/mach-omap2/board-omap3evm.c
> +++ b/arch/arm/mach-omap2/board-omap3evm.c
> @@ -30,6 +30,10 @@
>  #include <linux/usb/otg.h>
>  #include <linux/smsc911x.h>
>
> +#include <linux/mtd/mtd.h>

You don't need this include.

> +#include <linux/mtd/partitions.h>
> +#include <linux/mtd/nand.h>
> +
>  #include <linux/wl12xx.h>
>  #include <linux/regulator/fixed.h>
>  #include <linux/regulator/machine.h>
> @@ -46,6 +50,8 @@
>  #include <plat/mcspi.h>
>  #include <video/omapdss.h>
>  #include <video/omap-panel-generic-dpi.h>
> +#include <plat/gpmc.h>
> +#include <plat/nand.h>

These 2 too.

>
>  #include "mux.h"
>  #include "sdram-micron-mt46h32m32lf-6.h"
> @@ -101,6 +107,37 @@ static void __init omap3_evm_get_revision(void)
>        }
>  }
>
> +static struct mtd_partition omap3evm_nand_partitions[] =3D {
> +       /* All the partition sizes are listed in terms of NAND block =
size */
> +       {
> +               .name           =3D "X-Loader",
> +               .offset         =3D 0,
> +               .size           =3D 4 * NAND_BLOCK_SIZE,
> +               .mask_flags     =3D MTD_WRITEABLE,        /* force re=
ad-only */
> +       },
> +       {
> +               .name           =3D "U-Boot",
> +               .offset         =3D 0x80000

Missing comma. Have you at least tried compiling this?
[Hrishikesh] Apologies. I maintain different git repositories .Had comp=
iled and tested in other one , missed out the commas while making chang=
es in this one.
Will send out a patch with perfect changes in my next revision.

> +               .size           =3D 15 * NAND_BLOCK_SIZE,
> +               .mask_flags     =3D MTD_WRITEABLE,        /* force re=
ad-only */
> +       },
> +       {
> +               .name           =3D "U-Boot Env",
> +               .offset         =3D 0x260000
> +               .size           =3D 1 * NAND_BLOCK_SIZE,
> +       },
> +       {
> +               .name           =3D "Kernel",
> +               .offset         =3D 0x280000
> +               .size           =3D 32 * NAND_BLOCK_SIZE,
> +       },
> +       {
> +               .name           =3D "File System",
> +               .offset         =3D 0x680000
> +               .size           =3D MTDPART_SIZ_FULL,
> +       },
> +};
> +
>  #if defined(CONFIG_SMSC911X) || defined(CONFIG_SMSC911X_MODULE)
>  #include <plat/gpmc-smsc911x.h>
>
> @@ -696,6 +733,9 @@ static void __init omap3_evm_init(void)
>
>        omap_serial_init();
>
> +       omap_nand_flash_init(NAND_BUSWIDTH_16, omap3evm_nand_partitio=
ns,
> +                       ARRAY_SIZE(omap3evm_nand_partitions));
> +
>        /* OMAP3EVM uses ISP1504 phy and so register nop transceiver *=
/
>        usb_nop_xceiv_register();
>
> --
> 1.6.2.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

--
Gra=9Evydas
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
