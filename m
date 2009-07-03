From: "Guzman Lugo, Fernando" <x0095840@ti.com>
Subject: RE: [PATCH 3/4] DSPBRIDGE: PROCWRAP_Load function cleanup in a
 complete mess
Date: Fri, 3 Jul 2009 13:39:12 -0500
Message-ID: <496565EC904933469F292DDA3F1663E602A2C9D6FC@dlee06.ent.ti.com>
References: <1246544468-14546-1-git-send-email-ameya.palande@nokia.com>
 <1246544468-14546-2-git-send-email-ameya.palande@nokia.com>
 <1246544468-14546-3-git-send-email-ameya.palande@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:35566 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756116AbZGCSjU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 Jul 2009 14:39:20 -0400
In-Reply-To: <1246544468-14546-3-git-send-email-ameya.palande@nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ameya Palande <ameya.palande@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Kanigeri, Hari" <h-kanigeri2@ti.com>, "ext-phil.2.carmody@nokia.com" <ext-phil.2.carmody@nokia.com>


Please see my comments below.

> -----Original Message-----
> From: Ameya Palande [mailto:ameya.palande@nokia.com]
> Sent: Thursday, July 02, 2009 9:21 AM
> To: linux-omap@vger.kernel.org
> Cc: Guzman Lugo, Fernando; Kanigeri, Hari; ext-phil.2.carmody@nokia.com
> Subject: [PATCH 3/4] DSPBRIDGE: PROCWRAP_Load function cleanup in a
> complete mess
> 
> From: Phil Carmody <ext-phil.2.carmody@nokia.com>
> 
> If you followed some failure paths, it was entirely possible that
> you'd attempt to MEM_Free a user-space pointer, because it wouldn't
> have been replaced with a kernel-space copy yet. Now replace all
> untouched pointers with NULL, so the cleanup does nothing for those
> ones.
> 
> Signed-off-by: Phil Carmody <ext-phil.2.carmody@nokia.com>
> Signed-off-by: Ameya Palande <ameya.palande@nokia.com>
> ---
>  drivers/dsp/bridge/pmgr/wcd.c |   95 +++++++++++++++++++++++-------------
> ----
>  1 files changed, 55 insertions(+), 40 deletions(-)
> 
> diff --git a/drivers/dsp/bridge/pmgr/wcd.c b/drivers/dsp/bridge/pmgr/wcd.c
> index 00b2770..2fd9f8c 100644
> --- a/drivers/dsp/bridge/pmgr/wcd.c
> +++ b/drivers/dsp/bridge/pmgr/wcd.c
> @@ -880,83 +880,99 @@ u32 PROCWRAP_Load(union Trapped_Args *args)
>  {
>  	s32 i, len;
>  	DSP_STATUS status = DSP_SOK;
> -       char *temp;
> -	s32 argc = args->ARGS_PROC_LOAD.iArgc;
> +	char *temp;
> +	s32 count = args->ARGS_PROC_LOAD.iArgc;
>  	u8 **argv, **envp = NULL;
> 
> +	DBC_Require(count > 0);
> +	DBC_Require(count <= MAX_LOADARGS);
> 
> -	DBC_Require(argc > 0);
> -	DBC_Require(argc <= MAX_LOADARGS);
> -
> -	argv = MEM_Alloc(argc * sizeof(u8 *), MEM_NONPAGED);
> -	if (argv == NULL)
> +	argv = MEM_Alloc(count * sizeof(u8 *), MEM_NONPAGED);
> +	if (!argv) {
>  		status = DSP_EMEMORY;
> +		goto func_cont;
> +	}
> 
> -	cp_fm_usr(argv, args->ARGS_PROC_LOAD.aArgv, status, argc);
> -	if (DSP_FAILED(status))
> +	cp_fm_usr(argv, args->ARGS_PROC_LOAD.aArgv, status, count);
> +	if (DSP_FAILED(status)) {
> +		MEM_Free(argv);
> +		argv = NULL;
>  		goto func_cont;
> +	}
> 
> -	for (i = 0; DSP_SUCCEEDED(status) && (i < argc); i++) {
> +	for (i = 0; DSP_SUCCEEDED(status) && (i < count); i++) {
>  		if (argv[i] != NULL) {
>                          /* User space pointer to argument */
> -                       temp = (char *) argv[i];
> -                       len = strlen_user((char *)temp);
> +			temp = (char *) argv[i];
> +			len = strlen_user((char *)temp);
>  			/* Kernel space pointer to argument */
>  			argv[i] = MEM_Alloc(len + 1, MEM_NONPAGED);
> -			if (argv[i] == NULL) {
> +			if (argv[i] != NULL) {
> +				cp_fm_usr(argv[i], temp, status, len);
> +			} else {
>  				status = DSP_EMEMORY;
> -				break;
>  			}

Brackets should be removed from if and else sentences if only one statement follow them.

> -			cp_fm_usr(argv[i], temp, status, len);
> -			if (DSP_FAILED(status))
> +
> +			if (DSP_FAILED(status)) {
> +				while (i < count)
> +					argv[i++] = NULL;

In this point memory has been allocated to argv[i] and you are assigned argv[i] to null losing that reference and provoking a memory leak. Other think due to the check for freeing " for (i = 0; (i < count) && argv[i]; i++)" it only frees memory until it finds the first null (or until count), assigning argv[i+1] to null is enough and the "while" is not needed.

>  				goto func_cont;
> +			}
>  			argv[i][len] = '\0';
>  		}
>  	}
>  	/* TODO: validate this */
>  	if (args->ARGS_PROC_LOAD.aEnvp != NULL) {
>  		/* number of elements in the envp array including NULL */
> -		len = 0;
> +		count = 0;
>  		do {
> -			len++;
> -                       get_user(temp, args->ARGS_PROC_LOAD.aEnvp);
> -               } while (temp);
> -		envp = MEM_Alloc(len * sizeof(u8 *), MEM_NONPAGED);
> +			count++;
> +			get_user(temp, args->ARGS_PROC_LOAD.aEnvp);
> +		} while (temp);
> +		envp = MEM_Alloc(count * sizeof(u8 *), MEM_NONPAGED);
>  		if (envp == NULL) {
>  			status = DSP_EMEMORY;
>  			goto func_cont;
>  		}
> 
> -		cp_fm_usr(envp, args->ARGS_PROC_LOAD.aEnvp, status, len);
> -		if (DSP_FAILED(status))
> +		cp_fm_usr(envp, args->ARGS_PROC_LOAD.aEnvp, status, count);
> +		if (DSP_FAILED(status)) {
> +			MEM_Free(envp);
> +			envp = NULL;
>  			goto func_cont;
> +		}
>  		for (i = 0; DSP_SUCCEEDED(status) && (envp[i] != NULL); i++) {
>                          /* User space pointer to argument */
> -                       temp = (char *)envp[i];
> -                       len = strlen_user((char *)temp);
> +			temp = (char *)envp[i];
> +			len = strlen_user((char *)temp);
>  			/* Kernel space pointer to argument */
>  			envp[i] = MEM_Alloc(len + 1, MEM_NONPAGED);
> -			if (envp[i] == NULL) {
> +			if (envp[i] != NULL) {
> +				cp_fm_usr(envp[i], temp, status, len);
> +			} else {
>  				status = DSP_EMEMORY;
> -				break;
>  			}

Brackets should be removed from if and else sentences if only one statement follow them.

> -			cp_fm_usr(envp[i], temp, status, len);
> -			if (DSP_FAILED(status))
> +
> +			if (DSP_FAILED(status)) {
> +				while (i < count)
> +					envp[i++] = NULL;

In this point memory has been allocated to envp[i] and you are assigned envp[i] to null losing that reference and provoking a memory leak. Other think due to the check for freeing "while (envp[i] != NULL)" it only frees memory until it finds the first null so assigning envp[i+1] to null is enough and the "while" is not needed.

>  				goto func_cont;
> +			}
>  			envp[i][len] = '\0';
>  		}
>  	}
>  	GT_5trace(WCD_debugMask, GT_ENTER,
> -		 "PROCWRAP_Load, hProcessor: 0x%x\n\tiArgc:"
> -		 "0x%x\n\taArgv: 0x%x\n\taArgv[0]: %s\n\taEnvp: 0x%0x\n",
> -		 args->ARGS_PROC_LOAD.hProcessor,
> -		 args->ARGS_PROC_LOAD.iArgc, args->ARGS_PROC_LOAD.aArgv,
> -		 argv[0], args->ARGS_PROC_LOAD.aEnvp);
> +		"PROCWRAP_Load, hProcessor: 0x%x\n\tiArgc:"
> +		"0x%x\n\taArgv: 0x%x\n\taArgv[0]: %s\n\taEnvp: 0x%0x\n",
> +		args->ARGS_PROC_LOAD.hProcessor,
> +		args->ARGS_PROC_LOAD.iArgc, args->ARGS_PROC_LOAD.aArgv,
> +		argv[0], args->ARGS_PROC_LOAD.aEnvp);
>  	if (DSP_SUCCEEDED(status)) {
>  		status = PROC_Load(args->ARGS_PROC_LOAD.hProcessor,
> -				  args->ARGS_PROC_LOAD.iArgc,
> -				  (CONST char **)argv, (CONST char **)envp);
> +				args->ARGS_PROC_LOAD.iArgc,
> +				(CONST char **)argv, (CONST char **)envp);
>  	}
> +
>  func_cont:
>  	if (envp != NULL) {
>  		i = 0;
> @@ -966,11 +982,10 @@ func_cont:
>  		MEM_Free(envp);
>  	}
>  	if (argv != NULL) {
> -		for (i = 0; i < argc; i++) {
> -			if (argv[i] != NULL)
> -				MEM_Free(argv[i]);
> +		count = args->ARGS_PROC_LOAD.iArgc;
> +		for (i = 0; (i < count) && argv[i]; i++)
> +				MEM_Free(argv[i++]);
> 
> -		}
>  		MEM_Free(argv);
>  	}
>  	return status;
> --
> 1.6.2.4
> 

Please correct it and send it again.

Regards,
Fernando
Guzman
Lugo.

