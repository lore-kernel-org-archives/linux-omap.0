From: Jingoo Han <jg1.han@samsung.com>
Subject: Re: [PATCH] fbdev: omap2: Fix format string mismatch in display-sysfs.c
Date: Mon, 28 Apr 2014 20:17:05 +0900
Message-ID: <002401cf62d3$634cc1f0$29e645d0$%han@samsung.com>
References: <1398682455-21043-1-git-send-email-standby24x7@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:11181 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754284AbaD1LRI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 28 Apr 2014 07:17:08 -0400
In-reply-to: <1398682455-21043-1-git-send-email-standby24x7@gmail.com>
Content-language: ko
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: 'Masanari Iida' <standby24x7@gmail.com>, 'Tomi Valkeinen' <tomi.valkeinen@ti.com>
Cc: 'Jean-Christophe Plagniol-Villard' <plagnioj@jcrosoft.com>, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, 'Jingoo Han' <jg1.han@samsung.com>

On Monday, April 28, 2014 7:54 PM, Masanari Iida wrote:
> 
> Fix two format string mismatch in display-sysfs.c
> 
> Signed-off-by: Masanari Iida <standby24x7@gmail.com>
> ---
>  drivers/video/fbdev/omap2/dss/display-sysfs.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/video/fbdev/omap2/dss/display-sysfs.c b/drivers/video/fbdev/omap2/dss/display-
> sysfs.c
> index 5a2095a..5928bc9 100644
> --- a/drivers/video/fbdev/omap2/dss/display-sysfs.c
> +++ b/drivers/video/fbdev/omap2/dss/display-sysfs.c
> @@ -184,7 +184,7 @@ static ssize_t display_rotate_show(struct device *dev,
>  	if (!dssdev->driver->get_rotate)
>  		return -ENOENT;
>  	rotate = dssdev->driver->get_rotate(dssdev);

According to 'struct omap_dss_driver', get_rotate() returns 'u8'.
Then, how about changing the type of 'rotate' variable from 'int'
to 'u8' as below?

--- a/drivers/video/fbdev/omap2/dss/display-sysfs.c
+++ b/drivers/video/fbdev/omap2/dss/display-sysfs.c
@@ -180,7 +180,7 @@ static ssize_t display_rotate_show(struct device *dev,
                struct device_attribute *attr, char *buf)
 {
        struct omap_dss_device *dssdev = to_dss_device_sysfs(dev);
-       int rotate;
+       u8 rotate;
        if (!dssdev->driver->get_rotate)
                return -ENOENT;
        rotate = dssdev->driver->get_rotate(dssdev);


Best regards,
Jingoo Han

> -	return snprintf(buf, PAGE_SIZE, "%u\n", rotate);
> +	return snprintf(buf, PAGE_SIZE, "%d\n", rotate);
>  }
> 
>  static ssize_t display_rotate_store(struct device *dev,
> @@ -215,7 +215,7 @@ static ssize_t display_mirror_show(struct device *dev,
>  	if (!dssdev->driver->get_mirror)
>  		return -ENOENT;
>  	mirror = dssdev->driver->get_mirror(dssdev);
> -	return snprintf(buf, PAGE_SIZE, "%u\n", mirror);
> +	return snprintf(buf, PAGE_SIZE, "%d\n", mirror);
>  }
> 
>  static ssize_t display_mirror_store(struct device *dev,
> --
> 2.0.0.rc1

