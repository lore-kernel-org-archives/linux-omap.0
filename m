From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] V4L: Int if: Set slave's master before attach, remove
	master argument
Date: Wed, 31 Oct 2007 05:50:01 -0700
Message-ID: <20071031124959.GC32547@atomide.com>
References: <11925473082391-git-send-email-sakari.ailus@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <11925473082391-git-send-email-sakari.ailus@nokia.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Sakari Ailus <sakari.ailus@nokia.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Sakari Ailus <sakari.ailus@nokia.com> [071016 08:17]:
> Set slave's master before master's attach call.
> 
> The master also now gets its own pointer from slave's structure.
> 
> Signed-off-by: Sakari Ailus <sakari.ailus@nokia.com>
> ---
>  drivers/media/video/v4l2-int-device.c |    6 +++---
>  include/media/v4l2-int-device.h       |    5 ++---
>  2 files changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/media/video/v4l2-int-device.c b/drivers/media/video/v4l2-int-device.c
> index f497c94..286b7f0 100644
> --- a/drivers/media/video/v4l2-int-device.c
> +++ b/drivers/media/video/v4l2-int-device.c
> @@ -65,12 +65,12 @@ static void v4l2_int_device_try_attach_all(void)
>  			if (!try_module_get(m->module))
>  				continue;
>  
> -			if (m->u.master->attach(m, s)) {
> +			s->u.slave->master = m;
> +			if (m->u.master->attach(s)) {
> +				s->u.slave->master = NULL;
>  				module_put(m->module);
>  				continue;
>  			}
> -
> -			s->u.slave->master = m;
>  		}
>  	}
>  }
> diff --git a/include/media/v4l2-int-device.h b/include/media/v4l2-int-device.h
> index 066ebfc..c8b80e0 100644
> --- a/include/media/v4l2-int-device.h
> +++ b/include/media/v4l2-int-device.h
> @@ -44,9 +44,8 @@ enum v4l2_int_type {
>  struct v4l2_int_device;
>  
>  struct v4l2_int_master {
> -	int (*attach)(struct v4l2_int_device *master,
> -		      struct v4l2_int_device *slave);
> -	void (*detach)(struct v4l2_int_device *master);
> +	int (*attach)(struct v4l2_int_device *slave);
> +	void (*detach)(struct v4l2_int_device *slave);
>  };
>  
>  typedef int (v4l2_int_ioctl_func)(struct v4l2_int_device *);
> -- 
> 1.5.0.6
> 

Pushing today.

Tony
