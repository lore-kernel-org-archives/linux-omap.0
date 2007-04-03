From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP: FB: Properly initialise struct in
	full-screen update
Date: Tue, 3 Apr 2007 14:24:14 -0400
Message-ID: <20070403182409.GC32591@atomide.com>
References: <20070402162902.EEAF5CEF47@intune.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <20070402162902.EEAF5CEF47@intune.research.nokia.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Daniel Stone <daniel.stone@nokia.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Daniel Stone <daniel.stone@nokia.com> [070402 16:43]:
> Make sure out_x, out_y, out_width and out_height are initialised when we
> perform a full-screen update.
> 
> This hunk appears to have been dropped from the N800 omapfb merge.
> 
> Signed-off-by: Daniel Stone <daniel.stone@nokia.com>
> ---
>  drivers/video/omap/omapfb_main.c |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/video/omap/omapfb_main.c b/drivers/video/omap/omapfb_main.c
> index 52de408..7915b1e 100644
> --- a/drivers/video/omap/omapfb_main.c
> +++ b/drivers/video/omap/omapfb_main.c
> @@ -756,6 +756,10 @@ static int omapfb_update_full_screen(str
>  	win.y = 0;
>  	win.width = fbi->var.xres;
>  	win.height = fbi->var.yres;
> +	win.out_x = 0;
> +	win.out_y = 0;
> +	win.out_width = fbi->var.xres;
> +	win.out_height = fbi->var.yres;
>  	win.format = 0;
>  
>  	omapfb_rqueue_lock(fbdev);

Thanks, will merge this into Imre's "Add support for OMAP framebuffer"
patch in omap-drivers branch. (Assuming Imre is OK with it :)

Regards,

Tony
