From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: RE: [PATCH 2/5] omap2plus: prm: Trvial build break fix for undefined
 reference to 'omap2_prm_read_mod_reg'
Date: Wed, 5 Jan 2011 00:13:58 +0530
Message-ID: <cc76ecb39b950683cd12d254968e851c@mail.gmail.com>
References: <1294165576-15628-1-git-send-email-santosh.shilimkar@ti.com>
 <1294165576-15628-2-git-send-email-santosh.shilimkar@ti.com>
 <1294165576-15628-3-git-send-email-santosh.shilimkar@ti.com> <alpine.DEB.2.00.1101041139110.19319@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:34733 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751037Ab1ADSn7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 4 Jan 2011 13:43:59 -0500
Received: by mail-gx0-f171.google.com with SMTP id 8so7052866gxk.2
        for <linux-omap@vger.kernel.org>; Tue, 04 Jan 2011 10:43:59 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1101041139110.19319@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, Kevin Hilman <khilman@ti.com>, tony@atomide.com, linux-arm-kernel@lists.infradead.org

> -----Original Message-----
> From: Paul Walmsley [mailto:paul@pwsan.com]
> Sent: Wednesday, January 05, 2011 12:11 AM
> To: Santosh Shilimkar
> Cc: linux-omap@vger.kernel.org; khilman@ti.com; tony@atomide.com;
> linux-arm-kernel@lists.infradead.org
> Subject: Re: [PATCH 2/5] omap2plus: prm: Trvial build break fix for
> undefined reference to 'omap2_prm_read_mod_reg'
>
> Hi Santosh,
>
> On Tue, 4 Jan 2011, Santosh Shilimkar wrote:
>
> > omap2plus_defocnfig build breaks when customised with only
> ARCH_OMAP4
> > selected. This is because common files make references to the
> functions
> > which are defined only for omap2xxx and omap3xxx.
> >
> >  LD      .tmp_vmlinux1
> > arch/arm/mach-omap2/built-in.o: In function `pm_dbg_regset_store':
> > arch/arm/mach-omap2/pm-debug.c:335: undefined reference to
> `omap2_prm_read_mod_reg'
> > arch/arm/mach-omap2/built-in.o: In function `omap2_pm_dump':
> > arch/arm/mach-omap2/pm-debug.c:121: undefined reference to
> `omap2_prm_read_mod_reg'
> > arch/arm/mach-omap2/pm-debug.c:123: undefined reference to
> `omap2_prm_read_mod_reg'
> > arch/arm/mach-omap2/pm-debug.c:124: undefined reference to
> `omap2_prm_read_mod_reg'
> > arch/arm/mach-omap2/pm-debug.c:125: undefined reference to
> `omap2_prm_read_mod_reg'
> > arch/arm/mach-omap2/built-in.o: In function
> `omap_prcm_arch_reset':
> > arch/arm/mach-omap2/prcm.c:106: undefined reference to
> `omap2_prm_set_mod_reg_bits'
> > arch/arm/mach-omap2/prcm.c:108: undefined reference to
> `omap2_prm_read_mod_reg'
> > arch/arm/mach-omap2/built-in.o: In function
> `omap_prcm_get_reset_sources':
> > arch/arm/mach-omap2/prcm.c:53: undefined reference to
> `omap2_prm_read_mod_reg'
> > arch/arm/mach-omap2/built-in.o: In function
> `clkdm_clear_all_wkdeps':
> > arch/arm/mach-omap2/clockdomain.c:545: undefined reference to
> `omap2_prm_clear_mod_reg_bits'
> > arch/arm/mach-omap2/built-in.o: In function `clkdm_del_wkdep':
> > arch/arm/mach-omap2/clockdomain.c:475: undefined reference to
> `omap2_prm_clear_mod_reg_bits'
> > arch/arm/mach-omap2/built-in.o: In function `clkdm_read_wkdep':
> > arch/arm/mach-omap2/clockdomain.c:511: undefined reference to
> `omap2_prm_read_mod_bits_shift'
> > arch/arm/mach-omap2/built-in.o: In function `clkdm_add_wkdep':
> > arch/arm/mach-omap2/clockdomain.c:440: undefined reference to
> `omap2_prm_set_mod_reg_bits'
> > make: *** [.tmp_vmlinux1] Error 1
> >
> > This patch adds stubs for these functions so that build continues
> to work.
> >
> > Probably alternately  the build can be fixed as below but that not
> seems to
> > be the right way.
>
> Since these functions now return 0, maybe it would be better to call
> WARN() or BUG() in these functions for OMAP4.  Otherwise, they are
> going
> to silently do the wrong thing, and someone needs to fix any usage
> of
> these functions where they shouldn't be used.  e.g., in mach-
> omap2/prcm.c
> or mach-omap2/pm-debug.c ...
>
Good point. Will update the patch accordingly and repost.

Regards,
Santosh
