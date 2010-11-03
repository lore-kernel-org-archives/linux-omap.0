From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [PATCH v2 ] McBSP: Fix the free variable update at remove
Date: Wed, 3 Nov 2010 11:28:06 +0200
Message-ID: <20101103112806.c2cfe3d7.jhnikula@gmail.com>
References: <1288695814-8915-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:33784 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752847Ab0KCJ16 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 3 Nov 2010 05:27:58 -0400
Received: by eye27 with SMTP id 27so127891eye.19
        for <linux-omap@vger.kernel.org>; Wed, 03 Nov 2010 02:27:57 -0700 (PDT)
In-Reply-To: <1288695814-8915-1-git-send-email-shubhrajyoti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: shubhrajyoti@ti.com
Cc: linux-omap@vger.kernel.org

On Tue,  2 Nov 2010 16:33:34 +0530
shubhrajyoti@ti.com wrote:

> From: Shubhrajyoti D <shubhrajyoti@ti.com>
> 
> At remove the free variable is wrongly updated.Attempting to solve the same.
> 
> Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
> Reported-by: Vikram Pandita <vikram.pandita@ti.com>
> ---
> -[v2] Instead of using 0/1 use true/false
>  arch/arm/plat-omap/mcbsp.c |   10 +++++-----
>  1 files changed, 5 insertions(+), 5 deletions(-)
...
> @@ -1845,7 +1845,7 @@ static int __devexit omap_mcbsp_remove(struct
platform_device *pdev)
>  
>  		mcbsp->fclk = NULL;
>  		mcbsp->iclk = NULL;
> -		mcbsp->free = 0;
> +		mcbsp->free = true;
>  		mcbsp->dev = NULL;
>  	}
>  
While reviewing this I noticed that mcbsp->free is not problem at all
but the memory leak as there is no kfree(mcbsp) here and clk_disables
looked suspicious too.

I sent a patch fixing these and your patch changing to use true/false
flags with mcbsp->free looks worth to do as well. Care to send an
updated patch on top of mine (i.e no changes to omap_mcbsp_remove
reguired)?


-- 
Jarkko
