From: Artem Bityutskiy <dedekind1@gmail.com>
Subject: RE: [PATCH] [OMAP3_PM] Fix zoom2 defconfig build
Date: Mon, 02 Nov 2009 11:17:17 +0200
Message-ID: <1257153437.17890.0.camel@localhost>
References: <1257148563-18604-1-git-send-email-manjugk@ti.com>
	 <1257150370.29885.986.camel@localhost>
	 <E0D41E29EB0DAC4E9F3FF173962E9E940254037933@dbde02.ent.ti.com>
Reply-To: dedekind1@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:63562 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752371AbZKBJRr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 2 Nov 2009 04:17:47 -0500
In-Reply-To: <E0D41E29EB0DAC4E9F3FF173962E9E940254037933@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "G, Manjunath Kondaiah" <manjugk@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>

On Mon, 2009-11-02 at 14:30 +0530, G, Manjunath Kondaiah wrote:
> > > --- a/arch/arm/configs/omap_zoom2_defconfig
> > > +++ b/arch/arm/configs/omap_zoom2_defconfig
> > > @@ -1350,7 +1350,7 @@ CONFIG_ENABLE_MUST_CHECK=3Dy
> > >  CONFIG_FRAME_WARN=3D1024
> > >  CONFIG_MAGIC_SYSRQ=3Dy
> > >  # CONFIG_UNUSED_SYMBOLS is not set
> > > -# CONFIG_DEBUG_FS is not set
> > > +CONFIG_DEBUG_FS=3Dy
> > >  # CONFIG_HEADERS_CHECK is not set
> > >  CONFIG_DEBUG_KERNEL=3Dy
> > >  # CONFIG_DEBUG_SHIRQ is not set
> >=20
> > It is nicer to provide the build failure log. But if this is a buil=
d
> > failure, this means there is a problem with Kconfig dependency, whi=
ch
> > should be fixed properly, not hidden.
>=20
> Here is build failure log:
>   MODPOST vmlinux.o
> WARNING: modpost: Found 1 section mismatch(es).
> To see full details build your kernel with:
> 'make CONFIG_DEBUG_SECTION_MISMATCH=3Dy'
>   GEN     .version
>   CHK     include/linux/compile.h
>   UPD     include/linux/compile.h
>   CC      init/version.o
>   LD      init/built-in.o
>   LD      .tmp_vmlinux1
> arch/arm/mach-omap2/built-in.o: In function `omap_sram_idle':
> /home/manju/clones/git/linux-omap-pm/arch/arm/mach-omap2/pm34xx.c:441=
: undefined reference to `pm_dbg_regset_save'
> /home/manju/clones/git/linux-omap-pm/arch/arm/mach-omap2/pm34xx.c:452=
: undefined reference to `pm_dbg_regset_save'
> arch/arm/mach-omap2/built-in.o: In function `configure_vc':
> /home/manju/clones/git/linux-omap-pm/arch/arm/mach-omap2/pm34xx.c:122=
6: undefined reference to `pm_dbg_regset_init'
> /home/manju/clones/git/linux-omap-pm/arch/arm/mach-omap2/pm34xx.c:122=
7: undefined reference to `pm_dbg_regset_init'
> make: *** [.tmp_vmlinux1] Error 1
>=20
> The above two API's are under CONFIG_DEBUG_FS flag in arch/arm/mach-o=
map2/pm-debug.c

OK, but why do you send a band-aid to fix this, instead of a real fix?

--=20
Best Regards,
Artem Bityutskiy (=D0=90=D1=80=D1=82=D1=91=D0=BC =D0=91=D0=B8=D1=82=D1=8E=
=D1=86=D0=BA=D0=B8=D0=B9)

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
