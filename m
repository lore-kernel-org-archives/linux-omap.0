From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] Fix warning in omapfb_main.c
Date: Fri, 20 Jan 2006 11:03:03 -0800
Message-ID: <20060120190303.GF4431@atomide.com>
References: <43CD3B20.1060007@de.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <43CD3B20.1060007@de.bosch.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Dirk Behme <dirk.behme@de.bosch.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Dirk Behme <dirk.behme@de.bosch.com> [060117 10:52]:
> 
> ARM: OMAP: Fix warning because of changed ioctl() parameters
> 
> drivers/video/omap/omapfb_main.c:877: warning: initialization from
> incompatible pointer type
> 
> Signed-off-by: Dirk Behme <dirk.behme_at_de.bosch.com>
> 

> --- ./drivers/video/omap/omapfb_main.c_orig	2006-01-17 18:58:58.037572648 +0100
> +++ ./drivers/video/omap/omapfb_main.c	2006-01-17 19:04:15.332336512 +0100
> @@ -743,9 +743,8 @@ EXPORT_SYMBOL(omapfb_write_first_pixel);
>   * graphics transformations, frame flipping support is provided through this
>   * interface.
>   */
> -static int omapfb_ioctl(struct inode *inode, struct file *file,
> -			unsigned int cmd, unsigned long arg,
> -			struct fb_info *fbi)
> +static int omapfb_ioctl(struct fb_info *fbi, unsigned int cmd,
> +                        unsigned long arg)
>  {
>  	struct omapfb_device	*fbdev = (struct omapfb_device *)fbi->par;
>  	struct fb_ops		*ops = fbi->fbops;
> 

Pushing this one too.

Tony
