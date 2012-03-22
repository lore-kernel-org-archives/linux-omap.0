From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH RFC] usb: musb: omap: fix the error check for pm_runtime_get_sync
Date: Thu, 22 Mar 2012 16:42:21 +0400
Message-ID: <4F6B1E2D.8020802@mvista.com>
References: <1332400686-27674-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:41062 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752745Ab2CVMnr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 22 Mar 2012 08:43:47 -0400
Received: by bkcik5 with SMTP id ik5so1702873bkc.19
        for <linux-omap@vger.kernel.org>; Thu, 22 Mar 2012 05:43:46 -0700 (PDT)
In-Reply-To: <1332400686-27674-1-git-send-email-shubhrajyoti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Shubhrajyoti D <shubhrajyoti@ti.com>
Cc: linux-omap@vger.kernel.org, linux-usb@vger.kernel.org, balbi@ti.com, Kishon Vijay Abraham I <kishon@ti.com>

Hello.

On 22-03-2012 11:18, Shubhrajyoti D wrote:

> pm_runtime_get_sync returns a signed integer.In case of errors
> it returns a negative value.This patch fixes the error check
> by making it signed instead of unsigned thus preventing register
> access if get_sync_fails. Also passes the error cause to the
> debug message.

> Cc:  Kishon Vijay Abraham I<kishon@ti.com>
> Signed-off-by: Shubhrajyoti D<shubhrajyoti@ti.com>
> ---
> Compile tested only

    You haven't run it thru scripts/checkpatch.pl either, I guess?

>   drivers/usb/musb/omap2430.c |    5 +++--
>   1 files changed, 3 insertions(+), 2 deletions(-)

> diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
> index 2ae0bb3..e5dd18f 100644
> --- a/drivers/usb/musb/omap2430.c
> +++ b/drivers/usb/musb/omap2430.c
[...]
> @@ -301,7 +302,7 @@ static int omap2430_musb_init(struct musb *musb)
>
>   	status = pm_runtime_get_sync(dev);
>   	if (status<  0) {
> -		dev_err(dev, "pm_runtime_get_sync FAILED");
> +		dev_err(dev, "pm_runtime_get_sync FAILED %d \n",status);

    If I don't mistake, scripts/checkpatch.pl should warn about unneeded 
spaces before '\n'. And also about missing spaces after commas.

WBR, Sergei
