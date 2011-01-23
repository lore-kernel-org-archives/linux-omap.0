From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH v9 18/18] OMAP2,3: DSS2: Get DSS IRQ from platform device
Date: Sun, 23 Jan 2011 15:39:23 +0300
Message-ID: <4D3C217B.9020301@ru.mvista.com>
References: <1295690758-5845-1-git-send-email-sumit.semwal@ti.com> <1295690758-5845-19-git-send-email-sumit.semwal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:63484 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751096Ab1AWMkg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 23 Jan 2011 07:40:36 -0500
Received: by ewy5 with SMTP id 5so1532010ewy.19
        for <linux-omap@vger.kernel.org>; Sun, 23 Jan 2011 04:40:34 -0800 (PST)
In-Reply-To: <1295690758-5845-19-git-send-email-sumit.semwal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sumit Semwal <sumit.semwal@ti.com>
Cc: tomi.valkeinen@nokia.com, paul@pwsan.com, khilman@ti.com, hvaibhav@ti.com, linux-omap@vger.kernel.org, Senthilvadivu Guruswamy <svadivu@ti.com>, linux-arm-kernel@lists.infradead.org

Hello.

On 22-01-2011 13:05, Sumit Semwal wrote:

> From: Senthilvadivu Guruswamy<svadivu@ti.com>

> DSS IRQ number can be obtained from platform_get_irq().  This API in turn
> picks the right IRQ number belonging to HW IP from the hwmod database.
> So hardcoding of IRQ number could be removed.
>
> Reviewed-by: Paul Walmsley<paul@pwsan.com>
> Reviewed-by: Kevin Hilman<khilman@ti.com>
> Tested-by: Kevin Hilman<khilman@ti.com>
> Signed-off-by: Senthilvadivu Guruswamy<svadivu@ti.com>
> Signed-off-by: Sumit Semwal<sumit.semwal@ti.com>
[...]

> diff --git a/drivers/video/omap2/dss/dss.c b/drivers/video/omap2/dss/dss.c
> index 4d7a816..22690e9 100644
> --- a/drivers/video/omap2/dss/dss.c
> +++ b/drivers/video/omap2/dss/dss.c
[...]
> @@ -609,15 +609,18 @@ static int dss_init(bool skip_init)
>   	REG_FLD_MOD(DSS_CONTROL, 0, 2, 2);	/* venc clock mode = normal */
>   #endif
>
> -	r = request_irq(INT_24XX_DSS_IRQ,
> +	dss_irq = platform_get_irq(dss.pdev, 0);
> +	if (dss_irq != -ENXIO) {

    Better just 'dss_irq > 0', IMHO.

WBR, Sergei
