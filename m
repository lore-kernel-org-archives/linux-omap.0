From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: RE: [PATCH 3/4] arm: omap: prm: fix compile error
Date: Thu, 13 Jan 2011 17:21:19 +0530
Message-ID: <5792c70a7c9a58cb5bbf94c8224d1b7e@mail.gmail.com>
References: <1294918868-16263-1-git-send-email-balbi@ti.com> <1294918868-16263-4-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:59420 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756566Ab1AMLvV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 13 Jan 2011 06:51:21 -0500
Received: by mail-fx0-f46.google.com with SMTP id 20so1558226fxm.33
        for <linux-omap@vger.kernel.org>; Thu, 13 Jan 2011 03:51:21 -0800 (PST)
In-Reply-To: <1294918868-16263-4-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>, Tony Lindgren <tony@atomide.com>
Cc: Paul Walmsley <paul@pwsan.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Felipe Balbi
> Sent: Thursday, January 13, 2011 5:11 PM
> To: Tony Lindgren
> Cc: Paul Walmsley; Linux OMAP Mailing List; Felipe Balbi
> Subject: [PATCH 3/4] arm: omap: prm: fix compile error
>
> when building OMAP4-only kernel, the following
> comnpile errors appear:
>
> arch/arm/mach-omap2/built-in.o: In function `pm_dbg_regset_store':
> /home/balbi/workspace/linux-2.6/arch/arm/mach-omap2/pm-debug.c:335:
> undefined reference to `omap2_prm_read_mod_reg'
> arch/arm/mach-omap2/built-in.o: In function `omap2_pm_dump':
> /home/balbi/workspace/linux-2.6/arch/arm/mach-omap2/pm-debug.c:121:
> undefined reference to `omap2_prm_read_mod_reg'
> /home/balbi/workspace/linux-2.6/arch/arm/mach-omap2/pm-debug.c:123:
> undefined reference to `omap2_prm_read_mod_reg'
> /home/balbi/workspace/linux-2.6/arch/arm/mach-omap2/pm-debug.c:124:
> undefined reference to `omap2_prm_read_mod_reg'
> /home/balbi/workspace/linux-2.6/arch/arm/mach-omap2/pm-debug.c:125:
> undefined reference to `omap2_prm_read_mod_reg'
> arch/arm/mach-omap2/built-in.o:/home/balbi/workspace/linux-
> 2.6/arch/arm/mach-omap2/prcm.c:53:
> more undefined references to `omap2_prm_read_mod_reg' follow
> arch/arm/mach-omap2/built-in.o: In function `omap_prcm_arch_reset':
> /home/balbi/workspace/linux-2.6/arch/arm/mach-omap2/prcm.c:106:
> undefined reference to `omap2_prm_set_mod_reg_bits'
> /home/balbi/workspace/linux-2.6/arch/arm/mach-omap2/prcm.c:108:
> undefined reference to `omap2_prm_read_mod_reg'
> arch/arm/mach-omap2/built-in.o: In function `clkdm_add_wkdep':
> /home/balbi/workspace/linux-2.6/arch/arm/mach-
> omap2/clockdomain.c:440:
> undefined reference to `omap2_prm_set_mod_reg_bits'
> arch/arm/mach-omap2/built-in.o: In function `clkdm_del_wkdep':
> /home/balbi/workspace/linux-2.6/arch/arm/mach-
> omap2/clockdomain.c:475:
> undefined reference to `omap2_prm_clear_mod_reg_bits'
> arch/arm/mach-omap2/built-in.o: In function `clkdm_read_wkdep':
> /home/balbi/workspace/linux-2.6/arch/arm/mach-
> omap2/clockdomain.c:511:
> undefined reference to `omap2_prm_read_mod_bits_shift'
> arch/arm/mach-omap2/built-in.o: In function
> `clkdm_clear_all_wkdeps':
> /home/balbi/workspace/linux-2.6/arch/arm/mach-
> omap2/clockdomain.c:545:
> undefined reference to `omap2_prm_clear_mod_reg_bits'
> make: *** [.tmp_vmlinux1] Error 1
>
> fix them.
>
> Signed-off-by: Felipe Balbi <balbi@ti.com>

This one is also address in
http://www.mail-archive.com/linux-omap@vger.kernel.org/msg41712.html
