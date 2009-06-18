From: Tony Lindgren <tony@atomide.com>
Subject: Re: L-O master branch broken ?
Date: Thu, 18 Jun 2009 10:52:59 +0300
Message-ID: <20090618075257.GF8482@atomide.com>
References: <00eb01c9eff8$13dba760$LocalHost@wipultra793>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:49890 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754410AbZFRJxD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Jun 2009 05:53:03 -0400
Content-Disposition: inline
In-Reply-To: <00eb01c9eff8$13dba760$LocalHost@wipultra793>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hemanth V <hemanthv@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap@vger.kernel.org

* Hemanth V <hemanthv@ti.com> [090618 12:35]:
> I get the below error while compiling 3430SDP. I see below commit  as the 
> latest one.

Thanks, pushing a fix right now with the missing brace missing from Kevin's
sram.c patch. Also moved around the defines so sram.c build for omap1.

Regards,

Tony


> Hemanth
>
> commit 3dc15d62d3f8e85d74dcbabc234585cb8dbc2194
> Author: Tony Lindgren <tony@atomide.com>
> Date:   Thu Jun 18 08:59:09 2009 +0300
>
>    Fix iommu.c file permissions
>
>    Commit c8c8bfc4c3664317441b0037040c9bdea210fba1 changed the
>    permissions, so undo that. Also checked the other files with:
>
>    $ find arch/arm/*omap* -type f -perm 755
>
>    Signed-off-by: Tony Lindgren <tony@atomide.com>
>
>
> arch/arm/plat-omap/sram.c: In function 'omap_detect_sram':
> arch/arm/plat-omap/sram.c:139: error: expected expression before 'else'
> arch/arm/plat-omap/sram.c:190: warning: ISO C90 forbids mixed 
> declarations and code
> arch/arm/plat-omap/sram.c:347: error: invalid storage class for function  
> 'omap242x_sram_init'
> arch/arm/plat-omap/sram.c:368: error: invalid storage class for function  
> 'omap243x_sram_init'
> arch/arm/plat-omap/sram.c:433: error: expected declaration or statement 
> at end of input
> make[1]: *** [arch/arm/plat-omap/sram.o] Error 1
> make: *** [arch/arm/plat-omap] Error 2
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
