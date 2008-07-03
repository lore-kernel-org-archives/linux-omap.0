From: Viktor Rosendahl <Viktor.Rosendahl@nokia.com>
Subject: Re: [PATCH 1/1] twl4030-madc: Fix arbitrarily initialized function
	pointer
Date: Thu, 03 Jul 2008 18:26:17 +0300
Message-ID: <1215098777.11098.46.camel@viktor.research.nokia.com>
References: <1215005796-10117-1-git-send-email-viktor.rosendahl@nokia.com>
	 <1215005796-10117-2-git-send-email-viktor.rosendahl@nokia.com>
	 <f30014d3264cbcef10a9f0342fce7ac2@felipebalbi.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:49320 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751253AbYGCPVV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Jul 2008 11:21:21 -0400
In-Reply-To: <f30014d3264cbcef10a9f0342fce7ac2@felipebalbi.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Felipe Balbi <me@felipebalbi.com>
Cc: linux-omap@vger.kernel.org


> 
> > +		req.func_cb	= NULL;
> 
> maybe below is a better patch:
> 
> diff --git a/drivers/i2c/chips/twl4030-madc.c
> b/drivers/i2c/chips/twl4030-madc.c
> index 72b126b..6d8915e 100644
> --- a/drivers/i2c/chips/twl4030-madc.c
> +++ b/drivers/i2c/chips/twl4030-madc.c
> @@ -360,7 +360,7 @@ static int twl4030_madc_ioctl(struct inode *inode,
> struct file *filp,
>  
>         switch (cmd) {
>         case TWL4030_MADC_IOCX_ADC_RAW_READ: {
> -               struct twl4030_madc_request req;
> +               static struct twl4030_madc_request req;
>                 if (par.channel >= TWL4030_MADC_MAX_CHANNELS)
>                         return -EINVAL;

I don't like this idea because:

- It's fragile. This struct, which is not a const, gets initialized only
once but we are still passing a pointer to it, expecting that a fairly
complex function will not modify it. This assertion is probably true
today but makes it easier for somebody to create a bug in the future.

- You introduce another shared datum and it is only protected by the BKL
in fs/ioctl.c:vfs_ioctl().

- I didn't see any argument why this variable should be static. Making
local variables static just to get cheap zero initialization is a weird
thing to do IMO.

best regards,

Viktor


