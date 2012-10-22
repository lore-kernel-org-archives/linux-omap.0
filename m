From: Sumit Semwal <sumit.semwal@linaro.org>
Subject: Re: [PATCH] OMAPDSS: HDMI: fix missing unlock on error in hdmi_dump_regs()
Date: Mon, 22 Oct 2012 11:32:36 +0530
Message-ID: <5084E17C.1070403@linaro.org>
References: <CAPgLHd--5Y4cq3ieoRSueg-i0boqRa4JqRPL7+cJ0UfesunjoQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:59166 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755033Ab2JVGCm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 22 Oct 2012 02:02:42 -0400
Received: by mail-ob0-f174.google.com with SMTP id uo13so2100266obb.19
        for <linux-omap@vger.kernel.org>; Sun, 21 Oct 2012 23:02:41 -0700 (PDT)
In-Reply-To: <CAPgLHd--5Y4cq3ieoRSueg-i0boqRa4JqRPL7+cJ0UfesunjoQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Wei Yongjun <weiyj.lk@gmail.com>
Cc: tomi.valkeinen@ti.com, FlorianSchandinat@gmx.de, yongjun_wei@trendmicro.com.cn, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

On Sunday 21 October 2012 06:24 PM, Wei Yongjun wrote:
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
>
> Add the missing unlock on the error handling path in function
> hdmi_dump_regs().
>
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
Looks good to me; feel free to add:
Reviewed-by: Sumit Semwal <sumit.semwal@ti.com>
> ---
> no test
> ---
>   drivers/video/omap2/dss/hdmi.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/dss/hdmi.c
> index a48a7dd..8c9b8b3 100644
> --- a/drivers/video/omap2/dss/hdmi.c
> +++ b/drivers/video/omap2/dss/hdmi.c
> @@ -644,8 +644,10 @@ static void hdmi_dump_regs(struct seq_file *s)
>   {
>   	mutex_lock(&hdmi.lock);
>
> -	if (hdmi_runtime_get())
> +	if (hdmi_runtime_get()) {
> +		mutex_unlock(&hdmi.lock);
>   		return;
> +	}
>
>   	hdmi.ip_data.ops->dump_wrapper(&hdmi.ip_data, s);
>   	hdmi.ip_data.ops->dump_pll(&hdmi.ip_data, s);
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

