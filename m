From: "Guzman Lugo, Fernando" <x0095840@ti.com>
Subject: RE: [PATCH 4/4] DSPBRIDGE: Remove unnecessary conditions from some
 for loops
Date: Fri, 3 Jul 2009 13:56:29 -0500
Message-ID: <496565EC904933469F292DDA3F1663E602A2C9D700@dlee06.ent.ti.com>
References: <1246544468-14546-1-git-send-email-ameya.palande@nokia.com>
 <1246544468-14546-2-git-send-email-ameya.palande@nokia.com>
 <1246544468-14546-3-git-send-email-ameya.palande@nokia.com>
 <1246544468-14546-4-git-send-email-ameya.palande@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:47336 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757315AbZGCS4g convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 Jul 2009 14:56:36 -0400
In-Reply-To: <1246544468-14546-4-git-send-email-ameya.palande@nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ameya Palande <ameya.palande@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Kanigeri, Hari" <h-kanigeri2@ti.com>, "ext-phil.2.carmody@nokia.com" <ext-phil.2.carmody@nokia.com>



Yes you are right thanks for the patch.

> -----Original Message-----
> From: Ameya Palande [mailto:ameya.palande@nokia.com]
> Sent: Thursday, July 02, 2009 9:21 AM
> To: linux-omap@vger.kernel.org
> Cc: Guzman Lugo, Fernando; Kanigeri, Hari; ext-phil.2.carmody@nokia.com
> Subject: [PATCH 4/4] DSPBRIDGE: Remove unnecessary conditions from some
> for loops
> 
> The status cannot be a failure value at the start of the loops,
> and the only changes to a failure state are accompanied by a
> break or goto, so these conditions are always true.
> 
> Signed-off-by: Phil Carmody <ext-phil.2.carmody@nokia.com>
> ---
>  drivers/dsp/bridge/pmgr/wcd.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/dsp/bridge/pmgr/wcd.c b/drivers/dsp/bridge/pmgr/wcd.c
> index 2fd9f8c..a1bd2c7 100644
> --- a/drivers/dsp/bridge/pmgr/wcd.c
> +++ b/drivers/dsp/bridge/pmgr/wcd.c
> @@ -900,7 +900,7 @@ u32 PROCWRAP_Load(union Trapped_Args *args)
>  		goto func_cont;
>  	}
> 
> -	for (i = 0; DSP_SUCCEEDED(status) && (i < count); i++) {
> +	for (i = 0; i < count; i++) {
>  		if (argv[i] != NULL) {
>                          /* User space pointer to argument */
>  			temp = (char *) argv[i];
> @@ -941,7 +941,7 @@ u32 PROCWRAP_Load(union Trapped_Args *args)
>  			envp = NULL;
>  			goto func_cont;
>  		}
> -		for (i = 0; DSP_SUCCEEDED(status) && (envp[i] != NULL); i++) {
> +		for (i = 0; envp[i] != NULL; i++) {
>                          /* User space pointer to argument */
>  			temp = (char *)envp[i];
>  			len = strlen_user((char *)temp);
> --
> 1.6.2.4
> 

Acked-by Fernando Guzman Lugo <x0095840@ti.com>
