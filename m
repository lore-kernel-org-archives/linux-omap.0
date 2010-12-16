From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH] dspbridge: Fix atoi to support hexadecimal numbers correctly
Date: Fri, 17 Dec 2010 00:10:32 +0100
Message-ID: <201012170010.33236.laurent.pinchart@ideasonboard.com>
References: <1292161177-5266-1-git-send-email-laurent.pinchart@ideasonboard.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from perceval.ideasonboard.com ([95.142.166.194]:42771 "EHLO
	perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751379Ab0LPXKf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 16 Dec 2010 18:10:35 -0500
In-Reply-To: <1292161177-5266-1-git-send-email-laurent.pinchart@ideasonboard.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: omar.ramirez@ti.com, rene.sapiens@ti.com, ernesto@ti.com, felipe.contreras@gmail.com, ionut.nicu@gmail.com

Hi everybody,

Ping ?

On Sunday 12 December 2010 14:39:37 Laurent Pinchart wrote:
> For some strange reason, the DSP base image node/object properties
> description string stores hexadecimal numbers with a 'h' or 'H' suffix
> instead of a '0x' prefix. This causes parsing issue because the
> dspbridge atoi() implementation relies on strict_strtoul(), which will
> return an error because of the trailing 'h' character.
> 
> As the atoi() return value is never checked for an error anyway, replace
> strict_strtoul() with simple_strtoul() to ignore the suffix.
> 
> This fix gets rid of the following assertion failed messages that were
> printed when running the dsp-dummy test application.
> 
> drivers/staging/tidspbridge/rmgr/nldr.c, line 1691:
> Assertion (segid == MEMINTERNALID || segid == MEMEXTERNALID) failed.
> 
> Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> ---
>  drivers/staging/tidspbridge/rmgr/dbdcd.c |    6 +-----
>  1 files changed, 1 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/staging/tidspbridge/rmgr/dbdcd.c
> b/drivers/staging/tidspbridge/rmgr/dbdcd.c index 3581a55..b76f26c 100644
> --- a/drivers/staging/tidspbridge/rmgr/dbdcd.c
> +++ b/drivers/staging/tidspbridge/rmgr/dbdcd.c
> @@ -1020,8 +1020,6 @@ static s32 atoi(char *psz_buf)
>  {
>  	char *pch = psz_buf;
>  	s32 base = 0;
> -	unsigned long res;
> -	int ret_val;
> 
>  	while (isspace(*pch))
>  		pch++;
> @@ -1033,9 +1031,7 @@ static s32 atoi(char *psz_buf)
>  		base = 16;
>  	}
> 
> -	ret_val = strict_strtoul(pch, base, &res);
> -
> -	return ret_val ? : res;
> +	return simple_strtoul(pch, NULL, base);
>  }
> 
>  /*

-- 
Regards,

Laurent Pinchart
