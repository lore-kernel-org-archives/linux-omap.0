From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH linux-next] ARM: OMAP2: Fix compillation error in
 cm_common
Date: Mon, 12 Nov 2012 16:26:01 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1211121625150.6043@utopia.booyaka.com>
References: <1352733428-27889-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="843723315-2133751661-1352737561=:6043"
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <1352733428-27889-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-next-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-next@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--843723315-2133751661-1352737561=:6043
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi

On Mon, 12 Nov 2012, Peter Ujfalusi wrote:

> Fixes the following error:
>   CC      arch/arm/mach-omap2/cm_common.o
> arch/arm/mach-omap2/cm_common.c: In function =E2=80=98cm_register=E2=80=
=99:
> arch/arm/mach-omap2/cm_common.c:42:11: error: =E2=80=98EINVAL=E2=80=99 un=
declared (first use in this function)
> arch/arm/mach-omap2/cm_common.c:42:11: note: each undeclared identifier i=
s reported only once for each function it appears in
> arch/arm/mach-omap2/cm_common.c:45:11: error: =E2=80=98EEXIST=E2=80=99 un=
declared (first use in this function)
> arch/arm/mach-omap2/cm_common.c: In function =E2=80=98cm_unregister=E2=80=
=99:
> arch/arm/mach-omap2/cm_common.c:66:11: error: =E2=80=98EINVAL=E2=80=99 un=
declared (first use in this function)
> make[1]: *** [arch/arm/mach-omap2/cm_common.o] Error 1
> make: *** [arch/arm/mach-omap2] Error 2
>=20
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
>=20
> Hi,
>=20
> with today's linux-next the kernel build failed with the abive error for =
OMAP.
>=20
> Regards,
> Peter
>=20
>  arch/arm/mach-omap2/cm_common.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/arch/arm/mach-omap2/cm_common.c b/arch/arm/mach-omap2/cm_com=
mon.c
> index 3246cef..3fafc27 100644
> --- a/arch/arm/mach-omap2/cm_common.c
> +++ b/arch/arm/mach-omap2/cm_common.c
> @@ -13,6 +13,7 @@
> =20
>  #include <linux/kernel.h>
>  #include <linux/init.h>
> +#include <linux/errno.h>
> =20
>  #include "cm2xxx.h"
>  #include "cm3xxx.h"
> --=20
> 1.8.0

Acked-by: Paul Walmsley <paul@pwsan.com>

Thanks Peter.

Tony, how would you like to handle this one?


- Paul
--843723315-2133751661-1352737561=:6043--
