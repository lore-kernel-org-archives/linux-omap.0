From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH RFC] arch/arm/plat-omap/devices.c
Date: Tue, 18 Sep 2007 15:11:44 -0700
Message-ID: <20070918221143.GG2521@atomide.com>
References: <ae36f8040709181333q2b8e3e6ena5d864b14178c582@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <ae36f8040709181333q2b8e3e6ena5d864b14178c582@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: =?iso-8859-1?Q?Lu=EDs?= Cargnini <lvcargnini@gmail.com>
Cc: OMAP <Linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Hi,

* Lu=EDs Cargnini <lvcargnini@gmail.com> [070918 13:34]:
> --- linux-omap-2.6/arch/arm/plat-omap/devices.c 2007-08-28 01:01:
> 50.502065325 -0300
> +++ linux-omap-2.6.23-instramed/arch/arm/plat-omap/devices.c    2007-09=
-18
> 15:05:44.748685528 -0300
> @@ -25,6 +25,26 @@
>  #include <asm/arch/gpio.h>
>  #include <asm/arch/menelaus.h>
>=20
> +/*--------------------------------------------------------------------=
-----*/
> +/**
> + * 18/09/2007 - 14:35 - 03:00GMT
> + * lvcargnini@ieee.org
> + * Luis Vitorio modifications for devices.c
> + * added this to fix some bugs founded for mmc and possible speed-up
> + * enhancements removing unecessary code, for some plataforms
> + * why test if cpu_is_2420 on the fly ????
> + */
> +
> +#if defined(CONFIG_ARCH_OMAP16XX)
> +#include <asm/arch/omap16xx.h>
> +#elif defined(CONFIG_ARCH_OMAP24XX)
> +#include <asm/arch/omap24xx.h>
> +#elif defined(CONFIG_ARCH_OMAP34XX)
> +#include <asm/arch/omap34xx.h>
> +#endif
> +
> +/*--------------------------------------------------------------------=
-----*/
> +
>  #if    defined(CONFIG_OMAP_DSP) || defined(CONFIG_OMAP_DSP_MODULE)
>=20
>  #include "../plat-omap/dsp/dsp_common.h"

We should just include all the headers we need, no need to ifdef them
out.

There are no real reasons why we could not compile in all the omap
kernels into one binary now that gcc supports mixing in later assembly
code. Adding ifdefs there will make compiling in support for various
omaps harder. (We can already compile in 15xx and 16xx).

Please also leave out changelog type comments, they will show up in
the git repository. Also leave out any formatting changes, they make
it harder to see what you're fixing. See the following under
Documentation in your Linux tree:

Documentation/SubmittingPatches
Documentation/SubmittingDrivers
Documentation/SubmitChecklist

Regards,

Tony
