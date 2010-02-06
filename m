From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: Re: [PATCHv2] DSPBRIDGE: Fix memory leak in PROC_AutoStart()
Date: Fri, 5 Feb 2010 19:57:58 -0600
Message-ID: <4B6CCCA6.6080006@ti.com>
References: <1265045493.1997.26.camel@sanganak>  <ea29f699c0916873d206c498bbf41a610a53492d.1265045613.git.ameya.palande@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:46432 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933133Ab0BFB6F (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 5 Feb 2010 20:58:05 -0500
In-Reply-To: <ea29f699c0916873d206c498bbf41a610a53492d.1265045613.git.ameya.palande@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ameya Palande <ameya.palande@nokia.com>
Cc: "Menon, Nishanth" <nm@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Chitriki Rudramuni, Deepak" <deepak.chitriki@ti.com>

On 2/1/2010 11:36 AM, Ameya Palande wrote:
> Signed-off-by: Ameya Palande<ameya.palande@nokia.com>

Acked-by: Omar Ramirez Luna <omar.ramirez@ti.com>

> ---
>   drivers/dsp/bridge/rmgr/proc.c |    2 ++
>   1 files changed, 2 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/dsp/bridge/rmgr/proc.c b/drivers/dsp/bridge/rmgr/proc.c
> index 491661f..ff3329f 100644
> --- a/drivers/dsp/bridge/rmgr/proc.c
> +++ b/drivers/dsp/bridge/rmgr/proc.c
> @@ -411,6 +411,8 @@ DSP_STATUS PROC_AutoStart(struct CFG_DEVNODE *hDevNode,
>   			 "No Exec file found \n");
>   	}
>   func_cont:
> +	MEM_Free(hProcObject->g_pszLastCoff);
> +	hProcObject->g_pszLastCoff = NULL;
>   	MEM_FreeObject(hProcObject);
>   func_end:
>   	GT_1trace(PROC_DebugMask, GT_ENTER,

Pushed to dspbridge.

- omar
