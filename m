From: "Guzman Lugo, Fernando" <x0095840@ti.com>
Subject: RE: [PATCHv2 2/4] DSPBRIDGE: Heuristic fixes of strlen/malloc out
 by one
Date: Thu, 9 Jul 2009 18:52:23 -0500
Message-ID: <496565EC904933469F292DDA3F1663E602A30E140E@dlee06.ent.ti.com>
References: <1246978928-7139-1-git-send-email-ameya.palande@nokia.com>
 <1246978928-7139-2-git-send-email-ameya.palande@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:53443 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750799AbZGIXwf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Jul 2009 19:52:35 -0400
In-Reply-To: <1246978928-7139-2-git-send-email-ameya.palande@nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ameya Palande <ameya.palande@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Kanigeri, Hari" <h-kanigeri2@ti.com>, "ext-phil.2.carmody@nokia.com" <ext-phil.2.carmody@nokia.com>


Thanks good patch.

> -----Original Message-----
> From: Ameya Palande [mailto:ameya.palande@nokia.com]
> Sent: Tuesday, July 07, 2009 10:02 AM
> To: linux-omap@vger.kernel.org
> Cc: Guzman Lugo, Fernando; Kanigeri, Hari; ext-phil.2.carmody@nokia.com
> Subject: [PATCHv2 2/4] DSPBRIDGE: Heuristic fixes of strlen/malloc out by
> one
> 
> From: Phil Carmody <ext-phil.2.carmody@nokia.com>
> 
> I say 'heuristic', as I can't prove they're wrong, they just look
> wrong, and for that reason should be given extra close scrutiny.
> These are basically just the old malloc-one-more-than-strlen.
> 
> Signed-off-by: Phil Carmody <ext-phil.2.carmody@nokia.com>
> ---
>  drivers/dsp/bridge/pmgr/wcd.c |   11 ++++++-----
>  1 files changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/dsp/bridge/pmgr/wcd.c b/drivers/dsp/bridge/pmgr/wcd.c
> index aaf3019..563a1d8 100644
> --- a/drivers/dsp/bridge/pmgr/wcd.c
> +++ b/drivers/dsp/bridge/pmgr/wcd.c
> @@ -532,8 +532,9 @@ u32 MGRWRAP_RegisterObject(union Trapped_Args *args)
>  	cp_fm_usr(&pUuid, args->ARGS_MGR_REGISTEROBJECT.pUuid, status, 1);
>  	if (DSP_FAILED(status))
>  		goto func_end;
> +	/* pathSize is increased by 1 to accommodate NULL */
>  	pathSize = strlen_user((char *)
> -				args->ARGS_MGR_REGISTEROBJECT.pszPathName);
> +			args->ARGS_MGR_REGISTEROBJECT.pszPathName) + 1;
>  	pszPathName = MEM_Alloc(pathSize, MEM_NONPAGED);
>  	if (!pszPathName)
>  		goto func_end;
> @@ -544,7 +545,6 @@ u32 MGRWRAP_RegisterObject(union Trapped_Args *args)
>  		status = DSP_EPOINTER;
>  		goto func_end;
>  	}
> -	pszPathName[pathSize] = '\0';
> 
>  	GT_1trace(WCD_debugMask, GT_ENTER,
>  		 "MGRWRAP_RegisterObject: entered pg2hMsg "
> @@ -904,7 +904,8 @@ u32 PROCWRAP_Load(union Trapped_Args *args)
>  		if (argv[i] != NULL) {
>                          /* User space pointer to argument */
>                         temp = (char *) argv[i];
> -                       len = strlen_user((char *)temp);
> +			/* len is increased by 1 to accommodate NULL */
> +			len = strlen_user((char *)temp) + 1;
>  			/* Kernel space pointer to argument */
>  			argv[i] = MEM_Alloc(len, MEM_NONPAGED);
>  			if (argv[i] == NULL) {
> @@ -914,7 +915,6 @@ u32 PROCWRAP_Load(union Trapped_Args *args)
>  			cp_fm_usr(argv[i], temp, status, len);
>  			if (DSP_FAILED(status))
>  				goto func_cont;
> -
>  		}
>  	}
>  	/* TODO: validate this */
> @@ -937,7 +937,8 @@ u32 PROCWRAP_Load(union Trapped_Args *args)
>  		for (i = 0; DSP_SUCCEEDED(status) && (envp[i] != NULL); i++) {
>                          /* User space pointer to argument */
>                         temp = (char *)envp[i];
> -                       len = strlen_user((char *)temp);
> +			/* len is increased by 1 to accommodate NULL */
> +			len = strlen_user((char *)temp) + 1;
>  			/* Kernel space pointer to argument */
>  			envp[i] = MEM_Alloc(len, MEM_NONPAGED);
>  			if (envp[i] == NULL) {
> --
> 1.6.2.4
> 

Acked-by Fernando Guzman Lugo <x0095840@ti.com>

