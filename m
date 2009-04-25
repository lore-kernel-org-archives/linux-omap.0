From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] regulator core: fix double-free in regulator_register() error path
Date: Sat, 25 Apr 2009 15:11:56 -0700
Message-ID: <200904251511.57390.david-b@pacbell.net>
References: <alpine.DEB.2.00.0904250526210.28378@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from n15b.bullet.mail.mud.yahoo.com ([68.142.207.236]:21449 "HELO
	n15b.bullet.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752713AbZDYWMD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Sat, 25 Apr 2009 18:12:03 -0400
In-Reply-To: <alpine.DEB.2.00.0904250526210.28378@utopia.booyaka.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: lrg@slimlogic.co.uk, broonie@opensource.wolfsonmicro.com
Cc: Paul Walmsley <paul@pwsan.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org

On Saturday 25 April 2009, Paul Walmsley wrote:
> 
> During regulator registration, any error after device_register() will 
> cause a double-free on the struct regulator_dev 'rdev'.  The bug is in 
> drivers/regulator/core.c:regulator_register():
> 
> ...
> scrub:
> 	device_unregister(&rdev->dev);
> clean:
> 	kfree(rdev);                           <---
> 	rdev = ERR_PTR(ret);
> 	goto out;
> ...
> 
> device_unregister() calls regulator_dev_release() which frees rdev.  The 
> subsequent kfree corrupts memory and causes some OMAP3 systems to oops on 
> boot in regulator_get().
> 
> Applies against 2.6.30-rc3.
> 
> Signed-off-by: Paul Walmsley <paul@pwsan.com>

This looks like it would address the oopsing I mentioned a
while back, since affects cleanup paths after errors during
driver probe().


> ---
>  drivers/regulator/core.c |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
> index 01f7702..fabd2e0 100644
> --- a/drivers/regulator/core.c
> +++ b/drivers/regulator/core.c
> @@ -2080,6 +2080,10 @@ out:
>  
>  scrub:
>  	device_unregister(&rdev->dev);
> +	/* device core frees rdev */
> +	rdev = ERR_PTR(ret);
> +	goto out;
> +
>  clean:
>  	kfree(rdev);
>  	rdev = ERR_PTR(ret);
> -- 
> 1.6.3.rc1.51.gea0b7
> 
> 



