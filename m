From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP: Put LCD drivers back to Makefile.
Date: Fri, 10 Aug 2007 03:03:45 -0700
Message-ID: <20070810100345.GR8658@atomide.com>
References: <11864919772974-git-send-email-sakari.ailus@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <11864919772974-git-send-email-sakari.ailus@nokia.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Sakari Ailus <sakari.ailus@nokia.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Sakari Ailus <sakari.ailus@nokia.com> [070807 06:11]:
> Put back references to lcd_apollon.o, lcd_2430sdp.o and lcd_mipid.o that
> were lost in merge to drivers/video/omap/Makefile.
> 
> Signed-off-by: Sakari Ailus <sakari.ailus@nokia.com>
> ---
>  drivers/video/omap/Makefile |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/video/omap/Makefile b/drivers/video/omap/Makefile
> index de7c6bd..9211128 100644
> --- a/drivers/video/omap/Makefile
> +++ b/drivers/video/omap/Makefile
> @@ -27,5 +27,9 @@ objs-$(CONFIG_ARCH_OMAP15XX)$(CONFIG_MACH_OMAP_INNOVATOR) += lcd_inn1510.o
>  objs-y$(CONFIG_MACH_OMAP_OSK) += lcd_osk.o
>  objs-y$(CONFIG_MACH_SX1) += lcd_sx1.o
>  
> +objs-y$(CONFIG_MACH_OMAP_APOLLON) += lcd_apollon.o
> +objs-y$(CONFIG_MACH_OMAP_2430SDP) += lcd_2430sdp.o
> +objs-y$(CONFIG_FB_OMAP_LCD_MIPID) += lcd_mipid.o
> +
>  omapfb-objs := $(objs-yy)

Pushing today.

Tony
