From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 03/17] ARM: mark const init data with __initconst instead
 of __initdata
Date: Fri, 30 Mar 2012 11:50:24 +0200
Message-ID: <20120330095024.GS15647@pengutronix.de>
References: <20120329211131.GA31250@pengutronix.de>
 <1333055554-31300-3-git-send-email-u.kleine-koenig@pengutronix.de>
 <20120330061134.GD3254@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20120330061134.GD3254@S2101-09.ap.freescale.net>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, kernel@pengutronix.de, Andrew Victor <linux@maxim.org.za>, Nicolas Ferre <nicolas.ferre@atmel.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Russell King <linux@arm.linux.org.uk>, Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@ti.com>, Kukjin Kim <kgene.kim@samsung.com>, Lennert Buytenhek <kernel@wantstofly.org>, Nicolas Pitre <nico@fluxnic.net>, Eric Miao <eric.y.miao@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, David Brown <davidb@codeaurora.org>, Daniel Walker <dwalker@fifo99.com>, Bryan Huntsman <bryanh@codeaurora.org>, Tony Lindgren <tony@atomide.com>, Barry Song <baohua.song@csr.com>, Andrew Lunn <andrew@lunn.ch>, Lucas De Marchi <lucas.demarchi@profusion.mobi>, linux-arm-kernel@lists.infradead.org, davinci-linux-open-source@linux.davincidsp.com, linux-sa
List-Id: linux-omap@vger.kernel.org

Hello Shawn,

On Fri, Mar 30, 2012 at 02:11:36PM +0800, Shawn Guo wrote:
> On Thu, Mar 29, 2012 at 11:12:20PM +0200, Uwe Kleine-K=F6nig wrote:
> ...
> > diff --git a/arch/arm/mach-imx/imx51-dt.c b/arch/arm/mach-imx/imx51=
-dt.c
> > index 5cca573..7e00748 100644
> > --- a/arch/arm/mach-imx/imx51-dt.c
> > +++ b/arch/arm/mach-imx/imx51-dt.c
> > @@ -102,7 +102,7 @@ static struct sys_timer imx51_timer =3D {
> >  	.init =3D imx51_timer_init,
> >  };
> > =20
> > -static const char *imx51_dt_board_compat[] __initdata =3D {
> > +static const char *imx51_dt_board_compat[] __initconst =3D {
> >  	"fsl,imx51-babbage",
> >  	"fsl,imx51",
> >  	NULL
>=20
>   CC      arch/arm/mach-imx/imx51-dt.o
> arch/arm/mach-imx/imx51-dt.c:105:20: error: imx51_dt_board_compat cau=
ses a section type conflict
> make[2]: *** [arch/arm/mach-imx/imx51-dt.o] Error 1
>=20
> I do not understand why though.
that's because the strings are constant, but the array is not. The fix
is:

-static const char *imx51_dt_board_compat[] __initconst =3D {
+static const char *const imx51_dt_board_compat[] __initconst =3D {

or keeping __initdata.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
