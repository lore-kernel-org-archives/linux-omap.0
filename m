From: Ben Dooks <ben-i2c@fluff.org>
Subject: Re: [PATCH] MAINTAINERS: List i2c-omap and i2c-davinci drivers
Date: Tue, 17 Jan 2012 23:10:18 +0000
Message-ID: <20120117231018.GA7774@freya.fluff.org>
References: <20120110153640.0d30a643@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cpc7-stkp7-2-0-cust918.10-2.cable.virginmedia.com ([86.22.251.151]:56232
	"EHLO freya" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750849Ab2AQXxM (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 17 Jan 2012 18:53:12 -0500
Content-Disposition: inline
In-Reply-To: <20120110153640.0d30a643@endymion.delvare>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Delvare <khali@linux-fr.org>
Cc: Linux I2C <linux-i2c@vger.kernel.org>, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@ti.com>

On Tue, Jan 10, 2012 at 03:36:40PM +0100, Jean Delvare wrote:
> This will ensure that the right people and lists are notified when
> these drivers are modified.

sounds like a good idea.
 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Sekhar Nori <nsekhar@ti.com>
> Cc: Kevin Hilman <khilman@ti.com>
> ---
> If there are no objections, I'll send this to Linus quickly.
> 
>  MAINTAINERS |    3 +++
>  1 file changed, 3 insertions(+)
> 
> --- linux-3.3-rc0.orig/MAINTAINERS	2012-01-10 15:24:37.000000000 +0100
> +++ linux-3.3-rc0/MAINTAINERS	2012-01-10 15:27:28.000000000 +0100
> @@ -4673,6 +4673,8 @@ Q:	http://patchwork.kernel.org/project/l
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap.git
>  S:	Maintained
>  F:	arch/arm/*omap*/
> +F:	drivers/i2c/busses/i2c-omap.c
> +F:	include/linux/i2c-omap.h
>  
>  OMAP CLOCK FRAMEWORK SUPPORT
>  M:	Paul Walmsley <paul@pwsan.com>
> @@ -5945,6 +5947,7 @@ L:	davinci-linux-open-source@linux.davin
>  Q:	http://patchwork.kernel.org/project/linux-davinci/list/
>  S:	Supported
>  F:	arch/arm/mach-davinci
> +F:	drivers/i2c/busses/i2c-davinci.c
>  
>  SIS 190 ETHERNET DRIVER
>  M:	Francois Romieu <romieu@fr.zoreil.com>
> 
> 
> -- 
> Jean Delvare
> --
> To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
