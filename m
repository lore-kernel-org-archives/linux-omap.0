From: Stephan Linz <linz@li-pro.net>
Subject: Re: [PATCH v4 0/4] LogicPD minimal board support for LV_SOM and Torpedo
Date: Sat, 9 Oct 2010 01:55:25 +0200
Message-ID: <201010090155.25932.linz@li-pro.net>
References: <1285603550-6382-1-git-send-email-tim.nordell@logicpd.com> <20100928171908.GE3117@atomide.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.161]:9525 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759496Ab0JHXza convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Oct 2010 19:55:30 -0400
In-Reply-To: <20100928171908.GE3117@atomide.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Tim Nordell <tim.nordell@logicpd.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Tony,
Hi Tim,

nice to see my patches here on the Linux mailinglists. I have not been =
working=20
on it for a long time. Tim, how we can work together? Are you working f=
or=20
LogicPD?


Bye,
Stephan

Am Dienstag, 28. September 2010, um 19:19:09 schrieb Tony Lindgren:
> * Tim Nordell <tim.nordell@logicpd.com> [100927 08:57]:
> > This was tested (and based) against 2.6.36-rc5
> >
> > Difference from patch v3 1/4:
> >  - Merged DEBUG_LL support patch (patch v3 5/5) into first patch
> >  - Added "select OMAP_PACKAGE_CBB" into Kconfig for both boards
> >
> > Tim Nordell (4):
> >   Adding LogicPD OMAP3 board support
> >   ARM: OMAP3LOGIC: Adding SDMMC support
> >   ARM: OMAP3: Add generic smsc911x support when connected to GPMC
> >   ARM: OMAP3LOGIC: Added SMSC Ethernet board support
> >
> >  arch/arm/mach-omap2/Kconfig                     |   20 ++
> >  arch/arm/mach-omap2/Makefile                    |    7 +
> >  arch/arm/mach-omap2/board-omap3logic.c          |  244
> > +++++++++++++++++++++++ arch/arm/mach-omap2/gpmc-smsc911x.c        =
     |
> >  113 +++++++++++ arch/arm/plat-omap/include/plat/gpmc-smsc911x.h | =
  35
> > ++++
> >  arch/arm/plat-omap/include/plat/uncompress.h    |    2 +
> >  6 files changed, 421 insertions(+), 0 deletions(-)
> >  create mode 100644 arch/arm/mach-omap2/board-omap3logic.c
> >  create mode 100644 arch/arm/mach-omap2/gpmc-smsc911x.c
> >  create mode 100644 arch/arm/plat-omap/include/plat/gpmc-smsc911x.h
>
> Thanks, queuing all of them for the upcoming merge window.
> I've updated the MMC related patch with the following to
> keep it compiling with the MMC related platform init changes.
>
> Regards,
>
> Tony
>
> --- a/arch/arm/mach-omap2/board-omap3logic.c
> +++ b/arch/arm/mach-omap2/board-omap3logic.c
> @@ -26,6 +26,7 @@
>  #include <linux/regulator/machine.h>
>
>  #include <linux/i2c/twl.h>
> +#include <linux/mmc/host.h>
>
>  #include <mach/hardware.h>
>  #include <asm/mach-types.h>
> @@ -112,7 +113,7 @@ static struct omap2_hsmmc_info __initdata
> board_mmc_info[] =3D { {
>  		.name		=3D "external",
>  		.mmc		=3D 1,
> -		.wires		=3D 4,
> +		.caps		=3D MMC_CAP_4_BIT_DATA,
>  		.gpio_cd	=3D -EINVAL,
>  		.gpio_wp	=3D -EINVAL,
>  	},
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


--=20
Viele Gr=FC=DFe,
Stephan Linz
_______________________________________________________________________=
_______
OpenDCC: http://www.li-pro.net/opendcc.phtml
PC/M: http://www.li-pro.net/pcm.phtml
CDK4AVR: http://cdk4avr.sourceforge.net/
CDK4NIOS: http://cdk4nios.sourceforge.net/
CDK4MSP: http://cdk4msp.sourceforge.net/
CPM4L: http://download.opensuse.org/repositories/home:/rexut:/CPM4L
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
