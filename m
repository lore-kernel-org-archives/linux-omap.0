From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: Re: [REVIEW  PATCH 9/9] DSS: support for OMAP3 SDP board
Date: Wed, 5 Nov 2008 12:54:56 +0200
Message-ID: <20081105125456.721aabf0.jarkko.nikula@nokia.com>
References: <20081104160946.19071.44903.stgit@tubuntu>
	<20081104161045.19071.33189.stgit@tubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:40581 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755006AbYKEKzn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Nov 2008 05:55:43 -0500
In-Reply-To: <20081104161045.19071.33189.stgit@tubuntu>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-omap@vger.kernel.org

On Tue, 04 Nov 2008 18:10:45 +0200
"ext Tomi Valkeinen" <tomi.valkeinen@nokia.com> wrote:

> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@nokia.com>
> ---
> 
>  arch/arm/mach-omap2/board-3430sdp.c |  234 +++++++++++++++++++++++++++++++++--
>  drivers/video/omap2/Kconfig         |    7 +
>  drivers/video/omap2/Makefile        |    1 
>  drivers/video/omap2/panel-sdp3430.c |  110 ++++++++++++++++
>  4 files changed, 340 insertions(+), 12 deletions(-)
>  create mode 100644 drivers/video/omap2/panel-sdp3430.c
> 

> +static void __init display_init(void)
>
I would use unique 3430sdp_display_init even the function is static.
Cleaner symbol names and cleaner oops dumps.

> +{
> +	int r;
> +
> +	enable_gpio    = SDP3430_LCD_PANEL_ENABLE_GPIO;
> +	backlight_gpio = SDP3430_LCD_PANEL_BACKLIGHT_GPIO;
> +
> +	r = gpio_request(enable_gpio, "OMAP SDP LCD Reset GPIO");
> +	if (r) {
> +		printk(KERN_ERR "failed to get LCD reset GPIO\n");
> +		goto err0;
> +	}
> +
> +	r = gpio_request(backlight_gpio, "OMAP SDP LCD Backlight GPIO");
> +	if (r) {

How about labels "LCD reset" and "LCD backlight" (actually bit too
long).

> +static int panel_enable_lcd(struct omap_display *display)
> +static void panel_disable_lcd(struct omap_display *display)
> +static int panel_enable_dvi(struct omap_display *display)

Would it better to rename these as sdp3430_enable_lcd etc since
otherwise looks somewhat confusing to see them in board-3430sdp.c where
there is also panel-sdp3430.c?


Jarkko
