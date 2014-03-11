From: Hans Verkuil <hverkuil@xs4all.nl>
Subject: Re: [PATCH v3 10/14] v4l: ti-vpe: Use correct bus_info name for the
 device in querycap
Date: Tue, 11 Mar 2014 13:23:18 +0100
Message-ID: <531F0036.6070802@xs4all.nl>
References: <1393922965-15967-1-git-send-email-archit@ti.com> <1394526833-24805-1-git-send-email-archit@ti.com> <1394526833-24805-11-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp-vbr9.xs4all.nl ([194.109.24.29]:3203 "EHLO
	smtp-vbr9.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753550AbaCKMYJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 11 Mar 2014 08:24:09 -0400
In-Reply-To: <1394526833-24805-11-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>
Cc: k.debski@samsung.com, linux-media@vger.kernel.org, linux-omap@vger.kernel.org

On 03/11/14 09:33, Archit Taneja wrote:
> The bus_info parameter in v4l2_capabilities expects a 'platform_' prefix. This
> wasn't done in the driver and hence was breaking compliance. Update the bus_info
> parameter accordingly.
> 
> Signed-off-by: Archit Taneja <archit@ti.com>

Reviewed-by: Hans Verkuil <hans.verkuil@cisco.com>

> ---
>  drivers/media/platform/ti-vpe/vpe.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/media/platform/ti-vpe/vpe.c b/drivers/media/platform/ti-vpe/vpe.c
> index 46b9d44..5591d04 100644
> --- a/drivers/media/platform/ti-vpe/vpe.c
> +++ b/drivers/media/platform/ti-vpe/vpe.c
> @@ -1346,7 +1346,8 @@ static int vpe_querycap(struct file *file, void *priv,
>  {
>  	strncpy(cap->driver, VPE_MODULE_NAME, sizeof(cap->driver) - 1);
>  	strncpy(cap->card, VPE_MODULE_NAME, sizeof(cap->card) - 1);
> -	strlcpy(cap->bus_info, VPE_MODULE_NAME, sizeof(cap->bus_info));
> +	snprintf(cap->bus_info, sizeof(cap->bus_info), "platform:%s",
> +		VPE_MODULE_NAME);
>  	cap->device_caps  = V4L2_CAP_VIDEO_M2M_MPLANE | V4L2_CAP_STREAMING;
>  	cap->capabilities = cap->device_caps | V4L2_CAP_DEVICE_CAPS;
>  	return 0;
> 

