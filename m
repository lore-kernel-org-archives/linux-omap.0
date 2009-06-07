From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: Re: [PATCH 02/20] omapfb: Add support for
 MIPI-DCS compatible LCDs
Date: Mon, 8 Jun 2009 00:43:24 +0200
Message-ID: <20090608004324.6c5ecf17.krzysztof.h1@poczta.fm>
References: <1244137965-8937-1-git-send-email-imre.deak@nokia.com>
	<fab39c1a822c428466db6a19531be646d483664e.1244131952.git.imre.deak@nokia.com>
	<e7f92ea9f0a823f7be401e34243754141b7f72c1.1244131952.git.imre.deak@nokia.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3208150705202768922=="
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
In-Reply-To: <e7f92ea9f0a823f7be401e34243754141b7f72c1.1244131952.git.imre.deak@nokia.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Imre Deak <imre.deak@nokia.com>
Cc: Juha Yrjola <juha.yrjola@solidboot.com>, Imre Deak <imre.deak@solidboot.com>, linux-fbdev-devel@lists.sourceforge.net, Antonino Daplas <adaplas@gmail.com>, Tony Lindgren <tony@atomide.com>, Tomi Valkeinen <Tomi.Valkeinen@nokia.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

--===============3208150705202768922==
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  4 Jun 2009 20:52:27 +0300
Imre Deak <imre.deak@nokia.com> wrote:

> Fixed-by: Mike Wege <ext-mike.wege@nokia.com>
> Fixed-by: Arnaud Patard <arnaud.patard@rtp-net.org>
> Fixed-by: Timo Savola <tsavola@movial.fi>
> Fixed-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
> Fixed-by: Trilok Soni <soni.trilok@gmail.com>
> Signed-off-by: Imre Deak <imre.deak@solidboot.com>
> Signed-off-by: Juha Yrjola <juha.yrjola@solidboot.com>
> ---
>  arch/arm/plat-omap/include/mach/lcd_mipid.h |    5 +
>  drivers/video/omap/Kconfig                  |    8 +
>  drivers/video/omap/Makefile                 |    1 +
>  drivers/video/omap/lcd_mipid.c              |  631 +++++++++++++++++++++++++++
>  4 files changed, 645 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/video/omap/lcd_mipid.c
> 
> diff --git a/arch/arm/plat-omap/include/mach/lcd_mipid.h b/arch/arm/plat-omap/include/mach/lcd_mipid.h
> index f8fbc48..8e52c65 100644
> --- a/arch/arm/plat-omap/include/mach/lcd_mipid.h
> +++ b/arch/arm/plat-omap/include/mach/lcd_mipid.h
> @@ -16,7 +16,12 @@ enum mipid_test_result {
>  struct mipid_platform_data {
>  	int	nreset_gpio;
>  	int	data_lines;
> +
>  	void	(*shutdown)(struct mipid_platform_data *pdata);
> +	void	(*set_bklight_level)(struct mipid_platform_data *pdata,
> +				     int level);
> +	int	(*get_bklight_level)(struct mipid_platform_data *pdata);
> +	int	(*get_bklight_max)(struct mipid_platform_data *pdata);
>  };
>  
>  #endif
> diff --git a/drivers/video/omap/Kconfig b/drivers/video/omap/Kconfig
> index 4440885..574453f 100644
> --- a/drivers/video/omap/Kconfig
> +++ b/drivers/video/omap/Kconfig
> @@ -7,6 +7,14 @@ config FB_OMAP
>  	help
>            Frame buffer driver for OMAP based boards.
>  
> +config FB_OMAP_LCD_MIPID
> +	bool "MIPI DBI-C/DCS compatible LCD support"
> +	depends on FB_OMAP && SPI_MASTER
> +	help
> +	  Say Y here if you want to have support for LCDs compatible with
> +	  the Mobile Industry Processor Interface DBI-C/DCS
> +	  specification. (Supported LCDs: Philips LPH8923, Sharp LS041Y3)
> +
>  config FB_OMAP_BOOTLOADER_INIT
>  	bool "Check bootloader initialization"
>  	depends on FB_OMAP
> diff --git a/drivers/video/omap/Makefile b/drivers/video/omap/Makefile
> index d053498..d86d54a 100644
> --- a/drivers/video/omap/Makefile
> +++ b/drivers/video/omap/Makefile
> @@ -25,6 +25,7 @@ objs-$(CONFIG_ARCH_OMAP15XX)$(CONFIG_MACH_OMAP_INNOVATOR) += lcd_inn1510.o
>  objs-y$(CONFIG_MACH_OMAP_OSK) += lcd_osk.o
>  
>  objs-y$(CONFIG_MACH_OMAP_APOLLON) += lcd_apollon.o
> +objs-y$(CONFIG_FB_OMAP_LCD_MIPID) += lcd_mipid.o
>  
>  omapfb-objs := $(objs-yy)
>  
> diff --git a/drivers/video/omap/lcd_mipid.c b/drivers/video/omap/lcd_mipid.c
> new file mode 100644
> index 0000000..3165d3d
> --- /dev/null
> +++ b/drivers/video/omap/lcd_mipid.c
> @@ -0,0 +1,631 @@
> +/*
> + * LCD driver for MIPI DBI-C / DCS compatible LCDs
> + *
> + * Copyright (C) 2006 Nokia Corporation
> + * Author: Imre Deak <imre.deak@nokia.com>
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License as published by the
> + * Free Software Foundation; either version 2 of the License, or (at your
> + * option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful, but
> + * WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License along
> + * with this program; if not, write to the Free Software Foundation, Inc.,
> + * 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
> + */
> +#include <linux/device.h>
> +#include <linux/delay.h>
> +#include <linux/workqueue.h>
> +#include <linux/spi/spi.h>
> +
> +#include <mach/omapfb.h>
> +#include <mach/lcd_mipid.h>
> +
> +#define MIPID_MODULE_NAME		"lcd_mipid"
> +
> +#define MIPID_CMD_READ_DISP_ID		0x04
> +#define MIPID_CMD_READ_RED		0x06
> +#define MIPID_CMD_READ_GREEN		0x07
> +#define MIPID_CMD_READ_BLUE		0x08
> +#define MIPID_CMD_READ_DISP_STATUS	0x09
> +#define MIPID_CMD_RDDSDR		0x0F
> +#define MIPID_CMD_SLEEP_IN		0x10
> +#define MIPID_CMD_SLEEP_OUT		0x11
> +#define MIPID_CMD_DISP_OFF		0x28
> +#define MIPID_CMD_DISP_ON		0x29
> +
> +#define MIPID_VER_LPH8923		3
> +#define MIPID_VER_LS041Y3		4
> +
> +#define MIPID_ESD_CHECK_PERIOD		msecs_to_jiffies(5000)
> +
> +#define to_mipid_device(p)		container_of(p, struct mipid_device, \
> +						panel)
> +struct mipid_device {
> +	int		enabled;
> +	int		model;

This one is only set and never read. A name is probably enough.

> +	int		revision;
> +	u8		display_id[3];

This one should be a local variable.

> +	unsigned int	saved_bklight_level;
> +	unsigned long	hw_guard_end;		/* next value of jiffies
> +						   when we can issue the
> +						   next sleep in/out command */
> +	unsigned long	hw_guard_wait;		/* max guard time in jiffies */
> +
> +	struct omapfb_device	*fbdev;
> +	struct spi_device	*spi;
> +	struct mutex		mutex;
> +	struct lcd_panel	panel;

How does it differ from fbdev->panel? Is it duplicated field?

I am sorry but I had not enough time to review the rest.

Regards,
Krzysztof


----------------------------------------------------------------------
Zostan dziennikarzem obywatelskim!
Sprawd¼ sie >>> http://link.interia.pl/f21b9



--===============3208150705202768922==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
OpenSolaris 2009.06 is a cutting edge operating system for enterprises 
looking to deploy the next generation of Solaris that includes the latest 
innovations from Sun and the OpenSource community. Download a copy and 
enjoy capabilities such as Networking, Storage and Virtualization. 
Go to: http://p.sf.net/sfu/opensolaris-get
--===============3208150705202768922==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--===============3208150705202768922==--
