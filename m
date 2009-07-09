From: "Guzman Lugo, Fernando" <x0095840@ti.com>
Subject: RE: [PATCHv2 3/4] DSPBRIDGE: PROCWRAP_Load function cleanup in a
 complete mess
Date: Thu, 9 Jul 2009 18:58:35 -0500
Message-ID: <496565EC904933469F292DDA3F1663E602A30E1412@dlee06.ent.ti.com>
References: <1246978928-7139-1-git-send-email-ameya.palande@nokia.com>
 <1246978928-7139-2-git-send-email-ameya.palande@nokia.com>
 <1246978928-7139-3-git-send-email-ameya.palande@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:52058 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750732AbZGIX6o convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Jul 2009 19:58:44 -0400
In-Reply-To: <1246978928-7139-3-git-send-email-ameya.palande@nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ameya Palande <ameya.palande@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Kanigeri, Hari" <h-kanigeri2@ti.com>, "ext-phil.2.carmody@nokia.com" <ext-phil.2.carmody@nokia.com>


Hi,

Could you please review this patch? I am getting corrupted patch when I try to apply.

Please see comments below.

Regards,
Fernando.

> -----Original Message-----
> From: Ameya Palande [mailto:ameya.palande@nokia.com]
> Sent: Tuesday, July 07, 2009 10:02 AM
> To: linux-omap@vger.kernel.org
> Cc: Guzman Lugo, Fernando; Kanigeri, Hari; ext-phil.2.carmody@nokia.com
> Subject: [PATCHv2 3/4] DSPBRIDGE: PROCWRAP_Load function cleanup in a
> complete mess
> 
> If you followed some failure paths, it was entirely possible that
> you'd attempt to MEM_Free a user-space pointer, because it wouldn't
> have been replaced with a kernel-space copy yet.
> 
> Signed-off-by: Phil Carmody <ext-phil.2.carmody@nokia.com>
> Signed-off-by: Ameya Palande <ameya.palande@nokia.com>
> ---
>  drivers/dsp/bridge/pmgr/wcd.c |  110 +++++++++++++++++++++++-------------
> ----
>  1 files changed, 63 insertions(+), 47 deletions(-)
> 
> diff --git a/drivers/dsp/bridge/pmgr/wcd.c b/drivers/dsp/bridge/pmgr/wcd.c
> index 563a1d8..811b2fc 100644
> --- a/drivers/dsp/bridge/pmgr/wcd.c
> +++ b/drivers/dsp/bridge/pmgr/wcd.c
> @@ -884,99 +884,115 @@ u32 PROCWRAP_Load(union Trapped_Args *args)
>  {
>  	s32 i, len;
>  	DSP_STATUS status = DSP_SOK;
> -       char *temp;
> -	s32 argc = args->ARGS_PROC_LOAD.iArgc;
> +	char *temp;
> +	s32 count = args->ARGS_PROC_LOAD.iArgc;
>  	u8 **argv, **envp = NULL;
> 
> -
>  	DBC_Require(argc > 0);
>  	DBC_Require(argc <= MAX_LOADARGS);

These two line will cause a compilation error since you removed argc and replace it by count. Please change argc in these two lines too.	
	
> 
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
> -		if (argv[i] != NULL) {
> -                        /* User space pointer to argument */
> -                       temp = (char *) argv[i];
> +	for (i = 0; DSP_SUCCEEDED(status) && (i < count); i++) {
> +		if (argv[i]) {
> +			/* User space pointer to argument */
> +			temp = (char *) argv[i];
>  			/* len is increased by 1 to accommodate NULL */
>  			len = strlen_user((char *)temp) + 1;
>  			/* Kernel space pointer to argument */
>  			argv[i] = MEM_Alloc(len, MEM_NONPAGED);
> -			if (argv[i] == NULL) {
> +			if (argv[i]) {
> +				cp_fm_usr(argv[i], temp, status, len);
> +				if (DSP_FAILED(status)) {
> +					MEM_Free(argv[i]);
> +					argv[i] = NULL;
> +					goto func_cont;
> +				}
> +			} else {
>  				status = DSP_EMEMORY;
> -				break;
> -			}
> -			cp_fm_usr(argv[i], temp, status, len);
> -			if (DSP_FAILED(status))
>  				goto func_cont;
> +			}
>  		}
>  	}
>  	/* TODO: validate this */
> -	if (args->ARGS_PROC_LOAD.aEnvp != NULL) {
> +	if (args->ARGS_PROC_LOAD.aEnvp) {
>  		/* number of elements in the envp array including NULL */
> -		len = 0;
> +		count = 0;
>  		do {
> -			len++;
> -                       get_user(temp, args->ARGS_PROC_LOAD.aEnvp);
> -               } while (temp);
> -		envp = MEM_Alloc(len * sizeof(u8 *), MEM_NONPAGED);
> -		if (envp == NULL) {
> +			get_user(temp, args->ARGS_PROC_LOAD.aEnvp + count);
> +			count++;
> +		} while (temp);
> +		envp = MEM_Alloc(count * sizeof(u8 *), MEM_NONPAGED);
> +		if (!envp) {
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
> -		for (i = 0; DSP_SUCCEEDED(status) && (envp[i] != NULL); i++) {
> -                        /* User space pointer to argument */
> -                       temp = (char *)envp[i];
> +		}
> +		for (i = 0; DSP_SUCCEEDED(status) && envp[i]; i++) {
> +			/* User space pointer to argument */
> +			temp = (char *)envp[i];
>  			/* len is increased by 1 to accommodate NULL */
>  			len = strlen_user((char *)temp) + 1;
>  			/* Kernel space pointer to argument */
>  			envp[i] = MEM_Alloc(len, MEM_NONPAGED);
> -			if (envp[i] == NULL) {
> +			if (envp[i]) {
> +				cp_fm_usr(envp[i], temp, status, len);
> +				if (DSP_FAILED(status)) {
> +					MEM_Free(envp[i]);
> +					envp[i] = NULL;
> +					goto func_cont;
> +				}
> +			} else {
>  				status = DSP_EMEMORY;
> -				break;
> -			}
> -			cp_fm_usr(envp[i], temp, status, len);
> -			if (DSP_FAILED(status))
>  				goto func_cont;
> +			}
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
>  func_cont:
> -	if (envp != NULL) {
> +	if (envp) {
>  		i = 0;
> -		while (envp[i] != NULL)
> +		while (envp[i])
>  			MEM_Free(envp[i++]);
> 
>  		MEM_Free(envp);
>  	}
> -	if (argv != NULL) {
> -		for (i = 0; i < argc; i++) {
> -			if (argv[i] != NULL)
> -				MEM_Free(argv[i]);
> 
> -		}
> +	if (argv) {
> +		count = args->ARGS_PROC_LOAD.iArgc;
> +		for (i = 0; (i < count) && argv[i]; i++)
> +			MEM_Free(argv[i]);
> +
>  		MEM_Free(argv);
>  	}
> +
>  	return status;
>  }
> 
> --
> 1.6.2.4
> 

