From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [PATCH v2] McBSP: Fix the free variable update at remove.
Date: Tue, 2 Nov 2010 12:32:56 +0200
Message-ID: <20101102123256.b6bee4b7.jhnikula@gmail.com>
References: <1288693488-10200-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:49224 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750880Ab0KBKcv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Nov 2010 06:32:51 -0400
Received: by ewy7 with SMTP id 7so3842804ewy.19
        for <linux-omap@vger.kernel.org>; Tue, 02 Nov 2010 03:32:50 -0700 (PDT)
In-Reply-To: <1288693488-10200-1-git-send-email-shubhrajyoti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: shubhrajyoti@ti.com
Cc: linux-omap@vger.kernel.org

On Tue,  2 Nov 2010 15:54:48 +0530
shubhrajyoti@ti.com wrote:

> From: Shubhrajyoti D <shubhrajyoti@ti.com>
> 
> At remove the free variable is wrongly updated.Attempting to solve the same.
> 
> Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
> ---
> -[v2] Instead of using 0/1 use a macro
> 
>  arch/arm/plat-omap/include/plat/mcbsp.h |    3 +++
>  arch/arm/plat-omap/mcbsp.c              |   10 +++++-----
>  2 files changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm/plat-omap/include/plat/mcbsp.h b/arch/arm/plat-omap/include/plat/mcbsp.h
> index b87d83c..8988733 100644
> --- a/arch/arm/plat-omap/include/plat/mcbsp.h
> +++ b/arch/arm/plat-omap/include/plat/mcbsp.h
> @@ -37,6 +37,9 @@ static struct platform_device omap_mcbsp##port_nr = {	\
>  	.id	= OMAP_MCBSP##port_nr,			\
>  }
>  
> +#define TRUE			1
> +#define FALSE			0
> +
Use 'true' & 'false' in the code instead and then there is no need to
redefine these. They are defined in include/linux/stddef.h which is
probably included already by some another file.


-- 
Jarkko
