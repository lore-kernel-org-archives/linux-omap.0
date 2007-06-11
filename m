From: "Trilok Soni" <soni.trilok@gmail.com>
Subject: Re: [PATCH 9/12] Add support for HTC Typhoon and Hurricane/Tornado
	LCD panels.
Date: Mon, 11 Jun 2007 13:04:48 +0530
Message-ID: <5d5443650706110034kf1d701fwc4396fae20f42a5f@mail.gmail.com>
References: <466AE442.6090703@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <466AE442.6090703@free.fr>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Vivien Chappelier <vivien.chappelier@free.fr>
Cc: Linux OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

On 6/9/07, Vivien Chappelier <vivien.chappelier@free.fr> wrote:
> This patch add support for the various LCD panels used on the HTC
> Typhoon, Hurricane and Tornado smartphones. Backlight support is also
> implemented.
>
> Signed-off-by: Vivien Chappelier <vivien.chappelier@free.fr>
>
> ---
>  drivers/video/omap/Makefile      |    1 +
>  drivers/video/omap/lcd_typhoon.c |  294
> ++++++++++++++++++++++++++++++++++++++
>  2 files changed, 295 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/video/omap/lcd_typhoon.c
>
> diff --git a/drivers/video/omap/Makefile b/drivers/video/omap/Makefile
> index 0166e03..f7572d8 100644
> --- a/drivers/video/omap/Makefile
> +++ b/drivers/video/omap/Makefile
> @@ -29,6 +29,7 @@ objs-y$(CONFIG_MACH_OMAP_OSK) += lcd_osk.o
>  objs-y$(CONFIG_MACH_OMAP_PERSEUS2) += lcd_p2.o
>  objs-y$(CONFIG_MACH_OMAP_APOLLON) += lcd_apollon.o
>  objs-y$(CONFIG_MACH_OMAP_2430SDP) += lcd_2430sdp.o
> +objs-y$(CONFIG_MACH_TYPHOON) += lcd_typhoon.o
>
>  objs-y$(CONFIG_FB_OMAP_LCD_MIPID) += lcd_mipid.o
>
> diff --git a/drivers/video/omap/lcd_typhoon.c
> b/drivers/video/omap/lcd_typhoon.c
> new file mode 100644
> index 0000000..08adb15
> --- /dev/null
> +++ b/drivers/video/omap/lcd_typhoon.c
> @@ -0,0 +1,294 @@
> +/*
> + * File: drivers/video/omap_new/lcd-typhoon.c
> + *

Wrong path. It should be drivers/video/omap/lcd-typhoon.c.

-- 
--Trilok Soni
