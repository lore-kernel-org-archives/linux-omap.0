From: Francisco Alecrim <francisco.alecrim@indt.org.br>
Subject: Re: [RFC PATCH 1/1] OMAP: V4L: Update videobuf-dma-sg usage on omap
 camera drivers
Date: Tue, 29 Apr 2008 13:42:03 +0300
Message-ID: <4816FB7B.9040900@indt.org.br>
References: <"Francisco Alecrim <francisco.alecrim@indt.org.br>"> <1209459772-12659-1-git-send-email-francisco.alecrim@indt.org.br> <1209459772-12659-2-git-send-email-francisco.alecrim@indt.org.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:19707 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761542AbYD2KmT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 29 Apr 2008 06:42:19 -0400
Received: from esebh105.NOE.Nokia.com (esebh105.ntc.nokia.com [172.21.138.211])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m3TAg0AJ009650
	for <linux-omap@vger.kernel.org>; Tue, 29 Apr 2008 13:42:16 +0300
In-Reply-To: <1209459772-12659-2-git-send-email-francisco.alecrim@indt.org.br>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Francisco Alecrim <francisco.alecrim@indt.org.br>
Cc: linux-omap@vger.kernel.org

Hi folks,

    We found a similar patch sent by Tony on thread "Re: linux-omap vs 
N810" a few hours ago.

Sorry,
Alecrim.

Francisco Alecrim wrote:
> Update videobuf-dma-sg usage on omap camera drivers
>
> Signed-off-by: Francisco Alecrim <francisco.alecrim@indt.org.br>
> ---
>  drivers/media/video/omap/camera_core.c |    2 +-
>  drivers/media/video/omap24xxcam.c      |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/media/video/omap/camera_core.c b/drivers/media/video/omap/camera_core.c
> index dce47fc..eeedb36 100644
> --- a/drivers/media/video/omap/camera_core.c
> +++ b/drivers/media/video/omap/camera_core.c
> @@ -916,7 +916,7 @@ static int camera_core_open(struct inode *inode, struct file *file)
>  	vidioc_int_g_fmt_cap(cam->sdev, &format);
>  	spin_unlock(&cam->img_lock);
>  
> -	videobuf_queue_pci_init(&fh->vbq, &cam->vbq_ops, NULL, &cam->vbq_lock,
> +	videobuf_queue_sg_init(&fh->vbq, &cam->vbq_ops, NULL, &cam->vbq_lock,
>  			    fh->type, V4L2_FIELD_NONE,
>  			    sizeof(struct videobuf_buffer), fh);
>  
> diff --git a/drivers/media/video/omap24xxcam.c b/drivers/media/video/omap24xxcam.c
> index 4308fec..dfd3479 100644
> --- a/drivers/media/video/omap24xxcam.c
> +++ b/drivers/media/video/omap24xxcam.c
> @@ -1493,7 +1493,7 @@ static int omap24xxcam_open(struct inode *inode, struct file *file)
>  
>  	spin_lock_init(&fh->vbq_lock);
>  
> -	videobuf_queue_pci_init(&fh->vbq, &omap24xxcam_vbq_ops, NULL,
> +	videobuf_queue_sg_init(&fh->vbq, &omap24xxcam_vbq_ops, NULL,
>  				&fh->vbq_lock, V4L2_BUF_TYPE_VIDEO_CAPTURE,
>  				V4L2_FIELD_NONE,
>  				sizeof(struct videobuf_buffer), fh);
>   


-- 
Francisco Keppler Silva Alecrim - INdT
Phone: +55 92 2126-1017

