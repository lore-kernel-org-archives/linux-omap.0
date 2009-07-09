From: "Guzman Lugo, Fernando" <x0095840@ti.com>
Subject: RE: [PATCH 4/4] DSPBRIDGE: Remove unnecessary conditions from some
 for loops
Date: Thu, 9 Jul 2009 18:53:30 -0500
Message-ID: <496565EC904933469F292DDA3F1663E602A30E1411@dlee06.ent.ti.com>
References: <1246978928-7139-1-git-send-email-ameya.palande@nokia.com>
 <1246978928-7139-2-git-send-email-ameya.palande@nokia.com>
 <1246978928-7139-3-git-send-email-ameya.palande@nokia.com>
 <1246978928-7139-4-git-send-email-ameya.palande@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:47057 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750842AbZGIXxk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Jul 2009 19:53:40 -0400
In-Reply-To: <1246978928-7139-4-git-send-email-ameya.palande@nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ameya Palande <ameya.palande@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Kanigeri, Hari" <h-kanigeri2@ti.com>, "ext-phil.2.carmody@nokia.com" <ext-phil.2.carmody@nokia.com>


Good.

Regards,
Fernando.

> -----Original Message-----
> From: Ameya Palande [mailto:ameya.palande@nokia.com]
> Sent: Tuesday, July 07, 2009 10:02 AM
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
> index 811b2fc..6b2136a 100644
> --- a/drivers/dsp/bridge/pmgr/wcd.c
> +++ b/drivers/dsp/bridge/pmgr/wcd.c
> @@ -904,7 +904,7 @@ u32 PROCWRAP_Load(union Trapped_Args *args)
>  		goto func_cont;
>  	}
> 
> -	for (i = 0; DSP_SUCCEEDED(status) && (i < count); i++) {
> +	for (i = 0; i < count; i++) {
>  		if (argv[i]) {
>  			/* User space pointer to argument */
>  			temp = (char *) argv[i];
> @@ -945,7 +945,7 @@ u32 PROCWRAP_Load(union Trapped_Args *args)
>  			envp = NULL;
>  			goto func_cont;
>  		}
> -		for (i = 0; DSP_SUCCEEDED(status) && envp[i]; i++) {
> +		for (i = 0; envp[i]; i++) {
>  			/* User space pointer to argument */
>  			temp = (char *)envp[i];
>  			/* len is increased by 1 to accommodate NULL */
> --
> 1.6.2.4
> 

Acked-by Fernando Guzman Lugo <x0095840@ti.com>

