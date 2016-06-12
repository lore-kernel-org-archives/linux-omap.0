From: Sakari Ailus <sakari.ailus-X3B1VOXEql0@public.gmane.org>
Subject: Re: [PATCH] userspace API definitions for auto-focus coil
Date: Sun, 12 Jun 2016 14:22:53 +0300
Message-ID: <20160612112253.GD26360@valkosipuli.retiisi.org.uk>
References: <20160531213437.GA28397@amd>
 <20160601152439.GQ26360@valkosipuli.retiisi.org.uk>
 <20160601220840.GA21946@amd>
 <20160602074544.GR26360@valkosipuli.retiisi.org.uk>
 <20160602193027.GB7984@amd>
 <20160602212746.GT26360@valkosipuli.retiisi.org.uk>
 <20160605190716.GA11321@amd>
 <575512E5.5030000@gmail.com>
 <20160611220654.GC26360@valkosipuli.retiisi.org.uk>
 <20160612084811.GA27446@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160612084811.GA27446@amd>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Cc: Ivaylo Dimitrov <ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, kernel list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, aaro.koskinen-X3B1VOXEql0@public.gmane.org, patrikbachan-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, serge-A9i7LUbDfNHQT0dZR+AlfA@public.gmane.org, linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, mchehab-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi Pavel,

On Sun, Jun 12, 2016 at 10:48:11AM +0200, Pavel Machek wrote:
> Hi!
> 
> > > >Add userspace API definitions.
> > > >
> > > >Signed-off-by: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
> > > >
> > > >diff --git a/include/uapi/linux/v4l2-controls.h b/include/uapi/linux/v4l2-controls.h
> > > >index b6a357a..23011cc 100644
> > > >--- a/include/uapi/linux/v4l2-controls.h
> > > >+++ b/include/uapi/linux/v4l2-controls.h
> > > >@@ -974,4 +975,9 @@ enum v4l2_detect_md_mode {
> > > >  #define V4L2_CID_DETECT_MD_THRESHOLD_GRID	(V4L2_CID_DETECT_CLASS_BASE + 3)
> > > >  #define V4L2_CID_DETECT_MD_REGION_GRID		(V4L2_CID_DETECT_CLASS_BASE + 4)
> > > >
> > > >+/* Control IDs specific to the AD5820 driver as defined by V4L2 */
> > > >+#define V4L2_CID_FOCUS_AD5820_BASE 	(V4L2_CTRL_CLASS_CAMERA | 0x10af)
> > 
> > Please check V4L2_CID_USER_*_BASE. That's how custom controls are handled
> > nowadays.
> 
> So something like this?
> 
> Thanks,
> 									Pavel
> 
> diff --git a/drivers/media/i2c/ad5820.c b/drivers/media/i2c/ad5820.c
> index 2efa5dc1..b04b471 100644
> --- a/drivers/media/i2c/ad5820.c
> +++ b/drivers/media/i2c/ad5820.c
> @@ -40,6 +40,11 @@
>  #define AD5820_RAMP_MODE_LINEAR		(0 << 3)
>  #define AD5820_RAMP_MODE_64_16		(1 << 3)
>  
> +/* Control IDs specific to the AD5820 driver as defined by V4L2 */
> +#define V4L2_CID_FOCUS_AD5820_RAMP_TIME		(V4L2_CID_USER_AD5820_BASE+0)
> +#define V4L2_CID_FOCUS_AD5820_RAMP_MODE		(V4L2_CID_FOCUS_AD5820_BASE+1)
> +
> +

We could still define these in a header file that can be included by the
user space. Please use V4L2_CID_AD5820 prefix.

A separate header file should be used, e.g. include/uapi/linux/ad5820.h.

>  #define CODE_TO_RAMP_US(s)	((s) == 0 ? 0 : (1 << ((s) - 1)) * 50)
>  #define RAMP_US_TO_CODE(c)	fls(((c) + ((c)>>1)) / 50)
>  
> diff --git a/include/uapi/linux/v4l2-controls.h b/include/uapi/linux/v4l2-controls.h
> index 23011cc..4b24546 100644
> --- a/include/uapi/linux/v4l2-controls.h
> +++ b/include/uapi/linux/v4l2-controls.h
> @@ -181,6 +181,10 @@ enum v4l2_colorfx {
>   * We reserve 16 controls for this driver. */
>  #define V4L2_CID_USER_TC358743_BASE		(V4L2_CID_USER_BASE + 0x1080)
>  
> +/* The base for the ad5820 driver controls.
> + * We reserve 16 controls for this driver. */
> +#define V4L2_CID_USER_AD5820_BASE		(V4L2_CID_USER_BASE + 0x1090)
> +
>  /* MPEG-class control IDs */
>  /* The MPEG controls are applicable to all codec controls
>   * and the 'MPEG' part of the define is historical */
> @@ -986,9 +990,4 @@ enum v4l2_detect_md_mode {
>  #define V4L2_CID_MODE_SENSITIVITY		(V4L2_CID_MODE_CLASS_BASE+6)
>  #define V4L2_CID_MODE_OPSYSCLOCK		(V4L2_CID_MODE_CLASS_BASE+7)
>  
> -/* Control IDs specific to the AD5820 driver as defined by V4L2 */
> -#define V4L2_CID_FOCUS_AD5820_BASE 		(V4L2_CTRL_CLASS_CAMERA | 0x10af)
> -#define V4L2_CID_FOCUS_AD5820_RAMP_TIME		(V4L2_CID_FOCUS_AD5820_BASE+0)
> -#define V4L2_CID_FOCUS_AD5820_RAMP_MODE		(V4L2_CID_FOCUS_AD5820_BASE+1)
> -
>  #endif
> 
> 

-- 
Kind regards,

Sakari Ailus
e-mail: sakari.ailus-X3B1VOXEql0@public.gmane.org	XMPP: sailus-PCDdDYkjdNMDXYZnReoRVg@public.gmane.org
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
