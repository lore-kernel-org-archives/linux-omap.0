From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH] Fix compile error in usb-musb.c
Date: Tue, 27 Jan 2009 01:26:15 +0200
Message-ID: <20090126232614.GI4185@frodo>
References: <5A47E75E594F054BAF48C5E4FC4B92AB02E6815B88@dbde02.ent.ti.com> <200901161431.00469.david-b@pacbell.net> <20090118113324.GC7976@atomide.com> <200901261523.42769.david-b@pacbell.net>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:58875 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754136AbZAZX0Y (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 26 Jan 2009 18:26:24 -0500
Content-Disposition: inline
In-Reply-To: <200901261523.42769.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: Tony Lindgren <tony@atomide.com>, me@felipebalbi.com, "Gadiyar, Anand" <gadiyar@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Mon, Jan 26, 2009 at 03:23:42PM -0800, David Brownell wrote:
> --- a/arch/arm/plat-omap/include/mach/pm.h
> +++ b/arch/arm/plat-omap/include/mach/pm.h
> @@ -108,7 +108,7 @@
>  	!defined(CONFIG_ARCH_OMAP15XX) && \
>  	!defined(CONFIG_ARCH_OMAP16XX) && \
>  	!defined(CONFIG_ARCH_OMAP24XX)
> -#error "Power management for this processor not implemented yet"
> +#warning "Power management for this processor not implemented yet"
>  #endif
>  
>  #ifndef __ASSEMBLER__

this is great as we can push usb-musb.c to mainline.

-- 
balbi
