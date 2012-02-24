From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 4/7] ARM: OMAP2+: Fix zoom LCD backlight if TWL_CORE is
 not selected
Date: Fri, 24 Feb 2012 15:53:58 +0400
Message-ID: <4F477A56.9000005@ru.mvista.com>
References: <20120224005324.16794.73852.stgit@kaulin.local> <20120224005411.16794.720.stgit@kaulin.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.dev.rtsoft.ru ([213.79.90.226]:36067 "HELO
	mail.dev.rtsoft.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754817Ab2BXLzT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 24 Feb 2012 06:55:19 -0500
In-Reply-To: <20120224005411.16794.720.stgit@kaulin.local>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

Hello.

On 24-02-2012 4:54, Tony Lindgren wrote:

> Otherwise we get:

> arch/arm/mach-omap2/board-zoom-display.c:64: undefined reference to `twl_i2c_read_u8'
> arch/arm/mach-omap2/board-zoom-display.c:65: undefined reference to `twl_i2c_read_u8'
> arch/arm/mach-omap2/board-zoom-display.c:84: undefined reference to `twl_i2c_write_u8'
> arch/arm/mach-omap2/board-zoom-display.c:86: undefined reference to `twl_i2c_write_u8'
> arch/arm/mach-omap2/board-zoom-display.c:91: undefined reference to `twl_i2c_write_u8'
> arch/arm/mach-omap2/board-zoom-display.c:92: undefined reference to `twl_i2c_write_u8'
> arch/arm/mach-omap2/board-zoom-display.c:72: undefined reference to `twl_i2c_write_u8'

> Signed-off-by: Tony Lindgren<tony@atomide.com>
[...]

> diff --git a/arch/arm/mach-omap2/board-zoom-display.c b/arch/arm/mach-omap2/board-zoom-display.c
> index d4683ba..7f75fcd 100644
> --- a/arch/arm/mach-omap2/board-zoom-display.c
> +++ b/arch/arm/mach-omap2/board-zoom-display.c
> @@ -53,8 +53,11 @@ static void zoom_panel_disable_lcd(struct omap_dss_device *dssdev)
>   #define TWL_LED_PWMON	0x0
>   #define TWL_LED_PWMOFF	0x1
>
> +
>   static int zoom_set_bl_intensity(struct omap_dss_device *dssdev, int level)
>   {
> +

    Empty lines not needed.

> +#ifdef CONFIG_TWL4030_CORE
>   	unsigned char c;
>   	u8 mux_pwm, enb_pwm;
>

WBR, Sergei
