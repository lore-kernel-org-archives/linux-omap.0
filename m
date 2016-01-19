From: Vignesh R <vigneshr@ti.com>
Subject: Re: [PATCH RESEND] omap_hdq: fix usecount handling
Date: Tue, 19 Jan 2016 17:26:30 +0530
Message-ID: <569E246E.40506@ti.com>
References: <1452948530-10639-1-git-send-email-andreas@kemnade.info>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1452948530-10639-1-git-send-email-andreas@kemnade.info>
Sender: linux-kernel-owner@vger.kernel.org
To: Andreas Kemnade <andreas@kemnade.info>, Evgeniy Polyakov <zbr@ioremap.net>, "hns@goldelico.com" <hns@goldelico.com>, Fabian Frederick <fabf@skynet.be>
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org



On 01/16/2016 06:18 PM, Andreas Kemnade wrote:
> hdq_usecount was set to zero after a successful read, so
> omap_hdq_put could not properly free resources which leads
> e.g. to increasing usecounts in lsmod output
> 
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> ---

Reviewed-by: Vignesh R <vigneshr@ti.com>

Thanks,

>  drivers/w1/masters/omap_hdq.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/w1/masters/omap_hdq.c b/drivers/w1/masters/omap_hdq.c
> index 0e2f43b..a2eec97 100644
> --- a/drivers/w1/masters/omap_hdq.c
> +++ b/drivers/w1/masters/omap_hdq.c
> @@ -618,7 +618,6 @@ static u8 omap_w1_read_byte(void *_hdq)
>  
>  	hdq_disable_interrupt(hdq_data, OMAP_HDQ_CTRL_STATUS,
>  			      ~OMAP_HDQ_CTRL_STATUS_INTERRUPTMASK);
> -	hdq_data->hdq_usecount = 0;
>  
>  	/* Write followed by a read, release the module */
>  	if (hdq_data->init_trans) {
> 

-- 
Regards
Vignesh
