From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [PATCH] [OMAP3_PM] Fix zoom2 defconfig build
Date: Mon, 2 Nov 2009 11:14:27 +0200
Message-ID: <20091102091427.GE9446@nokia.com>
References: <1257148563-18604-1-git-send-email-manjugk@ti.com>
 <1257150370.29885.986.camel@localhost>
 <E0D41E29EB0DAC4E9F3FF173962E9E940254037933@dbde02.ent.ti.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:23219 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753621AbZKBJPG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 2 Nov 2009 04:15:06 -0500
Content-Disposition: inline
In-Reply-To: <E0D41E29EB0DAC4E9F3FF173962E9E940254037933@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext G, Manjunath Kondaiah" <manjugk@ti.com>
Cc: "dedekind1@gmail.com" <dedekind1@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>

On Mon, Nov 02, 2009 at 10:00:23AM +0100, ext G, Manjunath Kondaiah wrote:
> 
> > > --- a/arch/arm/configs/omap_zoom2_defconfig
> > > +++ b/arch/arm/configs/omap_zoom2_defconfig
> > > @@ -1350,7 +1350,7 @@ CONFIG_ENABLE_MUST_CHECK=y
> > >  CONFIG_FRAME_WARN=1024
> > >  CONFIG_MAGIC_SYSRQ=y
> > >  # CONFIG_UNUSED_SYMBOLS is not set
> > > -# CONFIG_DEBUG_FS is not set
> > > +CONFIG_DEBUG_FS=y
> > >  # CONFIG_HEADERS_CHECK is not set
> > >  CONFIG_DEBUG_KERNEL=y
> > >  # CONFIG_DEBUG_SHIRQ is not set
> > 
> > It is nicer to provide the build failure log. But if this is a build
> > failure, this means there is a problem with Kconfig dependency, which
> > should be fixed properly, not hidden.
> 
> Here is build failure log:
>   MODPOST vmlinux.o
> WARNING: modpost: Found 1 section mismatch(es).
> To see full details build your kernel with:
> 'make CONFIG_DEBUG_SECTION_MISMATCH=y'
>   GEN     .version
>   CHK     include/linux/compile.h
>   UPD     include/linux/compile.h
>   CC      init/version.o
>   LD      init/built-in.o
>   LD      .tmp_vmlinux1
> arch/arm/mach-omap2/built-in.o: In function `omap_sram_idle':
> /home/manju/clones/git/linux-omap-pm/arch/arm/mach-omap2/pm34xx.c:441: undefined reference to `pm_dbg_regset_save'
> /home/manju/clones/git/linux-omap-pm/arch/arm/mach-omap2/pm34xx.c:452: undefined reference to `pm_dbg_regset_save'
> arch/arm/mach-omap2/built-in.o: In function `configure_vc':
> /home/manju/clones/git/linux-omap-pm/arch/arm/mach-omap2/pm34xx.c:1226: undefined reference to `pm_dbg_regset_init'
> /home/manju/clones/git/linux-omap-pm/arch/arm/mach-omap2/pm34xx.c:1227: undefined reference to `pm_dbg_regset_init'
> make: *** [.tmp_vmlinux1] Error 1
> 
> The above two API's are under CONFIG_DEBUG_FS flag in arch/arm/mach-omap2/pm-debug.c

so the right fix would be to change the ifdef to something saner.
Probably on the header file something like:

#if defined(CONFIG_PM_DEBUG) && defined(CONFIG_DEBUG_FS)

-- 
balbi
