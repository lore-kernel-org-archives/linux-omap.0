From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC][RFT][PATCH 3/4 v5b] OMAP: McBSP: Introduce caching in
 register write operations
Date: Mon, 7 Dec 2009 13:06:31 -0800
Message-ID: <20091207210631.GG24013@atomide.com>
References: <200912010410.10129.jkrzyszt@tis.icnet.pl>
 <200912051447.41777.jkrzyszt@tis.icnet.pl>
 <20091207175534.GZ24013@atomide.com>
 <200912072039.34081.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:59132 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935559AbZLGVGb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Dec 2009 16:06:31 -0500
Content-Disposition: inline
In-Reply-To: <200912072039.34081.jkrzyszt@tis.icnet.pl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Cc: Jarkko Nikula <jhnikula@gmail.com>, linux-omap@vger.kernel.org, Peter Ujfalusi <peter.ujfalusi@nokia.com>

* Janusz Krzysztofik <jkrzyszt@tis.icnet.pl> [091207 11:38]:
> Monday 07 December 2009 18:55:35 Tony Lindgren napisa=C5=82(a):
> > Hi,
> >
> > This is pretty close :) Few more tweaks are still needed.
> >
> > * Janusz Krzysztofik <jkrzyszt@tis.icnet.pl> [091205 05:46]:
> > > Reserve static space for storing cached copies of McBSP register =
values.
> > > Split omap_mcbsp_read()/omap_mcbsp_write() into separate function=
s for
> > > OMAP1 and OMAP2/3/4, move them from plat-omap to mach-omap1 / mac=
h-omap2
> > > to be able to access the static cache.
> > > Modify omap_msbcp_write() to update the cache with every register=
 write
> > > operation.
> > > Modify omap_mcbsp_read() to support reading from cache or hardwar=
e.
> > > Update MCBSP_READ/MCBSP_WRITE macros for modified function APIs.
> > > Introduce a new macro that reads from the cache.
> > >
> > > Applies on top of patch 2 from this series:
> > > [PATCH v3 2/4] OMAP: McBSP: Prepare register read/write macros AP=
I for
> > > caching
> > >
> > > Tested on OMAP1510 based Amstrad Delta using linux-omap for-next,
> > > commit 82f1d8f22f2c65e70206e40a6f17688bf64a892c.
> > > Compile-tested with omap_generic_2420_defconfig, omap_3430sdp_def=
config.
> > >
> > > Signed-off-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
> > >
> > > ---
> > >
> > > Tony,
> > >
> > > Since I was not sure what your primary concern was, I've prepared=
 two
> > > alternative versions of patch 3/4.
> > > Please take this one as a base for further discussion if your pri=
mary
> > > concern was storage class for the cache.
> > > Otherwise, have a look at the other one (v5a), since this one has=
 even
> > > more ifdefs than before.
> > >
> > > Thanks,
> > > Janusz
> > >
> > > diff -upr git.orig/arch/arm/mach-omap1/mcbsp.c
> > > git/arch/arm/mach-omap1/mcbsp.c ---
> > > git.orig/arch/arm/mach-omap1/mcbsp.c	2009-12-02 15:48:37.00000000=
0 +0100
> > > +++ git/arch/arm/mach-omap1/mcbsp.c	2009-12-05 06:42:35.000000000=
 +0100
> > > @@ -200,3 +200,26 @@ int __init omap1_mcbsp_init(void)
> > >  }
> > >
> > >  arch_initcall(omap1_mcbsp_init);
> > > +
> > > +/* if adding more, put larger first */
> > > +#if defined(CONFIG_ARCH_OMAP16XX)
> > > +static u16 omap_mcbsp_cache[OMAP16XX_MCBSP_PDATA_SZ][OMAP_MCBSP_=
REG_COUNT];
> > > +#elif defined(CONFIG_ARCH_OMAP15XX)
> > > +static u16 omap_mcbsp_cache[OMAP15XX_MCBSP_PDATA_SZ][OMAP_MCBSP_=
REG_COUNT];
> > > +#elif defined(CONFIG_ARCH_OMAP7XX)
> > > +static u16 omap_mcbsp_cache[OMAP7XX_MCBSP_PDATA_SZ][OMAP_MCBSP_R=
EG_COUNT];
> > > +#else=20
> > > +#define omap_mcbsp_cache	NULL
> > > +#endif
> >
> > As 15xx and 16xx can be compiled into the same kernel binary, we ne=
ed to
> > get rid of the ifdef elif else (untested):
>=20
> > #ifdef(CONFIG_ARCH_OMAP7XX)
> > static u16 omap7xx_mcbsp_cache[OMAP7XX_MCBSP_PDATA_SZ][OMAP7XX_MCBS=
P_REG_COUNT];
> > #else=20
> > static 16 omap7xx_mcbsp_cache;
>=20
> ???
>=20
> static u16 omap7xx_mcbsp_cache; ?
>=20
> #define omap7xx_mcbsp_cache NULL ?

Yeah NULL is better here :)
=20
> > #endif
> >
> > #if defined(CONFIG_ARCH_OMAP15XX)
> > static u16 omap15xx_mcbsp_cache[OMAP15XX_MCBSP_PDATA_SZ][OMAP15XX_M=
CBSP_REG_COUNT];
> > #else
> > static 16 omap15xx_mcbsp_cache;
> > #endif
> >
> > #if defined(CONFIG_ARCH_OMAP16XX)
> > static u16 omap16xx_mcbsp_cache[OMAP16XX_MCBSP_PDATA_SZ][OMAP_16XXM=
CBSP_REG_COUNT];
> > #else
> > static 16 omap16xx_mcbsp_cache;
> > #endif
> > ...
> >
> > > +void omap_mcbsp_write(struct omap_mcbsp *mcbsp, u16 reg, u32 val=
)
> > > +{
> > > +	omap_mcbsp_cache[mcbsp->id][reg / sizeof(u16)] =3D (u16)val;
> > > +	__raw_writew((u16)val, mcbsp->io_base + reg);
> > > +}
> > > +
> > > +int omap_mcbsp_read(struct omap_mcbsp *mcbsp, u16 reg, bool from=
_cache)
> > > +{
> > > +	return !from_cache ? __raw_readw(mcbsp->io_base + reg) :
> > > +			omap_mcbsp_cache[mcbsp->id][reg / sizeof(u16)];
> > > +}
> >
> > Then these can become something like this:
> >
> > void omap_mcbsp_write(struct omap_mcbsp *mcbsp, u16 reg, u32 val)
> > {
> > 	if (cpu_is_omap7xx())
> > 		omap7xx_mcbsp_cache[mcbsp->id][reg / sizeof(u16)] =3D (u16)val;
> > 	else if (cpu_is_omap15xx())
> > 		omap15xx_mcbsp_cache[mcbsp->id][reg / sizeof(u16)] =3D (u16)val;
> > 	else if (cpu_is_omap16xx())
> > 		omap16xx_mcbsp_cache[mcbsp->id][reg / sizeof(u16)] =3D (u16)val;
> >
> > 	__raw_writew((u16)val, mcbsp->io_base + reg);
> > }
> > ...
> >
> > The code for processors that are not compiled in will get automatic=
ally
> > optimized out as the cpu_is_xxxx() becomes 0.
>=20
> Tony,
>=20
> For me, the fact that more than one processor type can be configured =
side by=20
> side it not enough reason here. With your code, if more then one proc=
essor=20
> type is configured, twice or tripple as much memory space will be dev=
oted to =20
> two or three cache tables instead of one that can be reused easily, a=
s it is=20
> with mine. Since you cannot run the same instance of the kernel on se=
veral=20
> machines simultaneously, only one of those two or three tables is req=
uired at=20
> runtime for storing data, so this looks like a waste of expensive mem=
ory=20
> unless some kind of runtime optimization that I am not familiar with =
can
> happen here. I was even affraid before that one of objections against=
 my idea=20
> of using the cache could be unnecessary waste of memory space.

Well if you want to optimize it out further, how about just kzalloc it
during init? Then you have just one copy that gets set the right size
depending on what you boot.
=20
> Nevertheless, I'll do it your way. Maybe there are still some other r=
easons
> not explicitly expressed yet.
>=20
> I guess that omap2 part should follow the same pattern, shouldn't it?

Yeas please.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
