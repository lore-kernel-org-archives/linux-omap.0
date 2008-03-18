From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] DSP: Fix up dspgateway when building n800 kernel images
Date: Tue, 18 Mar 2008 13:42:53 +0200
Message-ID: <20080318114252.GA7843@atomide.com>
References: <1205843836-19121-1-git-send-email-felipe.balbi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:64594 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752383AbYCRMmf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 Mar 2008 08:42:35 -0400
Content-Disposition: inline
In-Reply-To: <1205843836-19121-1-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <felipe.balbi@nokia.com>
Cc: linux-omap@vger.kernel.org

* Felipe Balbi <felipe.balbi@nokia.com> [080318 14:39]:
> A missing include file. Thanks to Tony Lindgren for
> pointing that out.
> 
> Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
> ---
>  drivers/dsp/dspgateway/dsp_ctl_core.c |    1 +
>  drivers/dsp/dspgateway/taskwatch.c    |    1 +
>  2 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/dsp/dspgateway/dsp_ctl_core.c b/drivers/dsp/dspgateway/dsp_ctl_core.c
> index 956ef26..3c13572 100644
> --- a/drivers/dsp/dspgateway/dsp_ctl_core.c
> +++ b/drivers/dsp/dspgateway/dsp_ctl_core.c
> @@ -25,6 +25,7 @@
>  #include <linux/fs.h>
>  #include <linux/device.h>
>  #include <linux/init.h>
> +#include <asm/io.h>
>  #include "dsp.h"
>  
>  #define CTL_MINOR	0
> diff --git a/drivers/dsp/dspgateway/taskwatch.c b/drivers/dsp/dspgateway/taskwatch.c
> index 4297b51..0fab20e 100644
> --- a/drivers/dsp/dspgateway/taskwatch.c
> +++ b/drivers/dsp/dspgateway/taskwatch.c
> @@ -27,6 +27,7 @@
>  #include <linux/sched.h>
>  #include <asm/uaccess.h>
>  #include <asm/arch/dsp.h>
> +#include <asm/io.h>
>  #include "dsp_mbcmd.h"
>  #include "dsp.h"

Thanks, looks like more breakage from my header changes.. Pushing today.

Tony
