From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH V2]omap: mux.c warning removal
Date: Mon, 10 May 2010 09:11:55 -0700
Message-ID: <874oiflos4.fsf@deeprootsystems.com>
References: <0680EC522D0CC943BC586913CF3768C003B31655C3@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:49380 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752532Ab0EJQMA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 10 May 2010 12:12:00 -0400
Received: by pxi5 with SMTP id 5so1730662pxi.19
        for <linux-omap@vger.kernel.org>; Mon, 10 May 2010 09:12:00 -0700 (PDT)
In-Reply-To: <0680EC522D0CC943BC586913CF3768C003B31655C3@dbde02.ent.ti.com> (Keshava Munegowda's message of "Fri\, 7 May 2010 12\:17\:48 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Munegowda, Keshava" <keshava_mgowda@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>

"Munegowda, Keshava" <keshava_mgowda@ti.com> writes:

> From: Keshava Munegowda <a0393220@ti.com>
>
> This patch removes the below warning 
> arch/arm/mach-omap2/mux.c:52: warning: 'mux_phys' defined but not used
> The definition of variable mux_phys should be enclosed in the macro CONFIG_ARCH_OMAP3 
>
> Signed-off-by: Keshava Munegowda <a0393220@ti.com>

Thanks, this version looks better.

Acked-by: Kevin Hilman <khilman@deeprootsystems.com>


One silly question though... is your a0....@ti.com address the one you
want as your From: and Signed-off-by?  Since the mail actually comes
from a more human readable address, I'm guessing that would be
preferred?  If so, create a ~/.gitconfig file and add this:

[user]
	name = Keshava Munegowda
	email = keshava_mgowda@ti.com

This way, all your local git commands will use this name/email in your
git commits, sign-offs etc.

Kevin







> Index: linux-2.6/arch/arm/mach-omap2/mux.c
> ===================================================================
> --- linux-2.6.orig/arch/arm/mach-omap2/mux.c	2010-05-05 23:59:19.000000000 +0530
> +++ linux-2.6/arch/arm/mach-omap2/mux.c	2010-05-06 00:00:07.000000000 +0530
> @@ -49,7 +49,7 @@
>  	struct list_head	node;
>  };
>  
> -static unsigned long mux_phys;
> +
>  static void __iomem *mux_base;
>  
>  u16 omap_mux_read(u16 reg)
> @@ -373,6 +373,7 @@
>  #ifdef CONFIG_ARCH_OMAP3
>  static LIST_HEAD(muxmodes);
>  static DEFINE_MUTEX(muxmode_mutex);
> +static unsigned long mux_phys;
>  
>  #ifdef CONFIG_OMAP_MUX
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
