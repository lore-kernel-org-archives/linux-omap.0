From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: Re: [PATCH] DSPBRIDGE: Fix memory leak in PROC_AutoStart()
Date: Mon, 25 Jan 2010 13:21:33 -0600
Message-ID: <4B5DEF3D.4080701@ti.com>
References: <1264078990-4829-1-git-send-email-ameya.palande@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:46932 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752183Ab0AYTVi (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 25 Jan 2010 14:21:38 -0500
In-Reply-To: <1264078990-4829-1-git-send-email-ameya.palande@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ameya Palande <ameya.palande@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "omap.ramirez@ti.com" <omap.ramirez@ti.com>, "Menon, Nishanth" <nm@ti.com>, "Chitriki Rudramuni, Deepak" <deepak.chitriki@ti.com>

Hi,

On 1/21/2010 7:03 AM, Ameya Palande wrote:
> Signed-off-by: Ameya Palande<ameya.palande@nokia.com>
> ---
>   drivers/dsp/bridge/rmgr/proc.c |    4 ++++
>   1 files changed, 4 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/dsp/bridge/rmgr/proc.c b/drivers/dsp/bridge/rmgr/proc.c
> index a75b64a..91ab64f 100644
> --- a/drivers/dsp/bridge/rmgr/proc.c
> +++ b/drivers/dsp/bridge/rmgr/proc.c
> @@ -512,6 +512,10 @@ DSP_STATUS PROC_AutoStart(struct CFG_DEVNODE *hDevNode,
>   			 "No Exec file found \n");
>   	}
>   func_cont:
> +	if (hProcObject->g_pszLastCoff) {
> +		MEM_Free(hProcObject->g_pszLastCoff);
> +		hProcObject->g_pszLastCoff = NULL;
> +	}

Wouldn't be better to keep this inside PROC_Load in case of error?

Also MEM_Free checks for NULL.

>   	MEM_FreeObject(hProcObject);
>   func_end:
>   	GT_1trace(PROC_DebugMask, GT_ENTER,

Regards,

Omar
