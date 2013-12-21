From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: OMAP display subsystem - does it work?
Date: Sat, 21 Dec 2013 00:59:41 +0000
Message-ID: <20131221005941.GI32243@n2100.arm.linux.org.uk>
References: <20131218120023.GG4360@n2100.arm.linux.org.uk>
 <52B1A922.6020901@ti.com> <20131218180240.GG27438@atomide.com>
 <20131219175644.GE32243@n2100.arm.linux.org.uk>
 <20131219182252.GP27438@atomide.com>
 <20131220112700.GF32243@n2100.arm.linux.org.uk>
 <20131220114837.GH32243@n2100.arm.linux.org.uk> <52B44982.4020501@ti.com>
 <20131220160432.GZ27438@atomide.com> <20131220165456.GD27438@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20131220165456.GD27438@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Fri, Dec 20, 2013 at 08:55:03AM -0800, Tony Lindgren wrote:
> Yeah this seems to do the trick for me for the built-in DSS on LDP.
> 
> Tony
> 
> 8< -----------------------------------
> From: Tony Lindgren <tony@atomide.com>
> Date: Fri, 20 Dec 2013 08:53:27 -0800
> Subject: [PATCH] ARM: OMAP2+: Fix LCD panel backlight regression for LDP legacy booting
> 
> Looks like the LCD panel on LDP has been broken quite a while, and
> recently got fixed. However, there's still an issue where the panel
> backlight does not come on if the LCD drivers are built into the
> kernel.
> 
> Fix the issue by registering the DPI LCD panel only after the twl4030
> GPIO has probed.
> 
> Reported-by: Russell King <rmk+kernel@arm.linux.org.uk>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> 
> --- a/arch/arm/mach-omap2/board-ldp.c
> +++ b/arch/arm/mach-omap2/board-ldp.c
> @@ -248,7 +248,7 @@ static int ldp_twl_gpio_setup(struct device *dev, unsigned gpio, unsigned ngpio)
>  	/* Backlight enable GPIO */
>  	ldp_lcd_pdata.backlight_gpio = gpio + 15;
>  
> -	return 0;
> +	return platform_device_register(&ldp_lcd_device);
>  }
>  
>  static struct twl4030_gpio_platform_data ldp_gpio_data = {
> @@ -346,7 +346,6 @@ static struct omap2_hsmmc_info mmc[] __initdata = {
>  
>  static struct platform_device *ldp_devices[] __initdata = {
>  	&ldp_gpio_keys_device,
> -	&ldp_lcd_device,
>  };
>  
>  #ifdef CONFIG_OMAP_MUX

I've added it to the test build for tonight (only as an uncommitted
modification) so we'll see what happens tomorrow morning.
