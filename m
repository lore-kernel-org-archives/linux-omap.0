From: "Kanigeri, Hari" <h-kanigeri2@ti.com>
Subject: RE: [PATCH 1/1] DSPBRIDGE: Convert ioctl() to unlocked_ioctl()
Date: Thu, 14 May 2009 07:59:48 -0500
Message-ID: <8F7AF80515AF0D4D93307E594F3CB40E2AFF361A@dlee03.ent.ti.com>
References: <1242281536-4757-1-git-send-email-Hiroshi.DOYU@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:36197 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752574AbZENNAG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 14 May 2009 09:00:06 -0400
In-Reply-To: <1242281536-4757-1-git-send-email-Hiroshi.DOYU@nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: "Menon, Nishanth" <nm@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Thanks, Doyu-san.

We will push this change once system level validation is completed with TI test suites.

Thank you,
Best regards,
Hari

> -----Original Message-----
> From: Hiroshi DOYU [mailto:Hiroshi.DOYU@nokia.com]
> Sent: Thursday, May 14, 2009 1:12 AM
> To: Kanigeri, Hari
> Cc: Menon, Nishanth; linux-omap@vger.kernel.org; Doyu Hiroshi (Nokia-
> D/Helsinki); Hiroshi DOYU
> Subject: [PATCH 1/1] DSPBRIDGE: Convert ioctl() to unlocked_ioctl()
> 
> From: Doyu Hiroshi (Nokia-D/Helsinki) <hiroshi.doyu@nokia.com>
> 
> dspbridge doesn't need BKL.
> 
> Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
> ---
>  drivers/dsp/bridge/rmgr/drv_interface.c |    4 ++--
>  drivers/dsp/bridge/rmgr/drv_interface.h |    2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/dsp/bridge/rmgr/drv_interface.c
> b/drivers/dsp/bridge/rmgr/drv_interface.c
> index 9466409..1659e2d 100755
> --- a/drivers/dsp/bridge/rmgr/drv_interface.c
> +++ b/drivers/dsp/bridge/rmgr/drv_interface.c
> @@ -197,7 +197,7 @@ static struct GT_Mask driverTrace;
>  static struct file_operations bridge_fops = {
>  	.open		= bridge_open,
>  	.release	= bridge_release,
> -	.ioctl		= bridge_ioctl,
> +	.unlocked_ioctl	= bridge_ioctl,
>  	.mmap		= bridge_mmap,
>  };
> 
> @@ -686,7 +686,7 @@ static int bridge_release(struct inode *ip, struct
> file *filp)
>  }
> 
>  /* This function provides IO interface to the bridge driver. */
> -static int bridge_ioctl(struct inode *ip, struct file *filp, unsigned int
> code,
> +static int bridge_ioctl(struct file *filp, unsigned int code,
>  		unsigned long args)
>  {
>  	int status;
> diff --git a/drivers/dsp/bridge/rmgr/drv_interface.h
> b/drivers/dsp/bridge/rmgr/drv_interface.h
> index f5b068e..3e77ed0 100644
> --- a/drivers/dsp/bridge/rmgr/drv_interface.h
> +++ b/drivers/dsp/bridge/rmgr/drv_interface.h
> @@ -34,7 +34,7 @@ static int __init bridge_init(void);	/* Initialize
> bridge */
>  static void __exit bridge_exit(void);	/* Opposite of initialize */
>  static int bridge_open(struct inode *, struct file *);	/* Open */
>  static int bridge_release(struct inode *, struct file *);	/* Release */
> -static int bridge_ioctl(struct inode *, struct file *, unsigned int,
> +static int bridge_ioctl(struct file *, unsigned int,
>  			unsigned long);
>  static int bridge_mmap(struct file *filp, struct vm_area_struct *vma);
>  #endif				/* ifndef _DRV_INTERFACE_H_ */
> --
> 1.6.0.4
> 

