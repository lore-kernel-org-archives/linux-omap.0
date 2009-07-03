From: "Guzman Lugo, Fernando" <x0095840@ti.com>
Subject: RE: [PATCH 1/4] DSPBRIDGE: always malloc strlen+1 for the trailing
 \0
Date: Fri, 3 Jul 2009 13:42:19 -0500
Message-ID: <496565EC904933469F292DDA3F1663E602A2C9D6FD@dlee06.ent.ti.com>
References: <1246544468-14546-1-git-send-email-ameya.palande@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:48000 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756075AbZGCSm0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 Jul 2009 14:42:26 -0400
In-Reply-To: <1246544468-14546-1-git-send-email-ameya.palande@nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ameya Palande <ameya.palande@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Kanigeri, Hari" <h-kanigeri2@ti.com>, "ext-phil.2.carmody@nokia.com" <ext-phil.2.carmody@nokia.com>


It looks good. Thanks

> -----Original Message-----
> From: Ameya Palande [mailto:ameya.palande@nokia.com]
> Sent: Thursday, July 02, 2009 9:21 AM
> To: linux-omap@vger.kernel.org
> Cc: Guzman Lugo, Fernando; Kanigeri, Hari; ext-phil.2.carmody@nokia.com
> Subject: [PATCH 1/4] DSPBRIDGE: always malloc strlen+1 for the trailing \0
> 
> From: Phil Carmody <ext-phil.2.carmody@nokia.com>
> 
> Array member [pathSize] is set to \0, so the array must be
> pathSize+1 bytes in size.
> 
> Signed-off-by: Phil Carmody <ext-phil.2.carmody@nokia.com>
> ---
>  drivers/dsp/bridge/pmgr/wcd.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/dsp/bridge/pmgr/wcd.c b/drivers/dsp/bridge/pmgr/wcd.c
> index 86812c6..7732492 100644
> --- a/drivers/dsp/bridge/pmgr/wcd.c
> +++ b/drivers/dsp/bridge/pmgr/wcd.c
> @@ -530,7 +530,7 @@ u32 MGRWRAP_RegisterObject(union Trapped_Args *args)
>  		goto func_end;
>  	pathSize = strlen_user((char *)
>  				args->ARGS_MGR_REGISTEROBJECT.pszPathName);
> -	pszPathName = MEM_Alloc(pathSize, MEM_NONPAGED);
> +	pszPathName = MEM_Alloc(pathSize + 1, MEM_NONPAGED);
>  	if (!pszPathName)
>  		goto func_end;
>  	retVal = strncpy_from_user(pszPathName,
> --
> 1.6.2.4
> 

Acked-by Fernando Guzman Lugo <x0095840@ti.com>

