From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] ARM: remove duplicate 'const' annotations'
Date: Fri, 12 May 2017 09:54:21 +0530
Message-ID: <20170512042421.GP17481@vireshk-i7>
References: <20170511115059.2997141-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170511115059.2997141-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: arm@kernel.org, Nicolas Pitre <nico@linaro.org>, Nicolas Ferre <nicolas.ferre@microchip.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Russell King <linux@armlinux.org.uk>, Florian Fainelli <f.fainelli@gmail.com>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, bcm-kernel-feedback-list@broadcom.com, Krzysztof Halasa <khalasa@piap.pl>, Rajendra Nayak <rnayak@codeaurora.org>, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, Viresh Kumar <vireshk@kernel.org>, Wenyou Yang <wenyou.yang@atmel.com>, Olof Johansson <olof@lixom.net>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 11-05-17, 13:50, Arnd Bergmann wrote:
> gcc-7 warns about some declarations that are more 'const' than necessary:
> 
> arch/arm/mach-at91/pm.c:338:34: error: duplicate 'const' declaration specifier [-Werror=duplicate-decl-specifier]
>  static const struct of_device_id const ramc_ids[] __initconst = {
> arch/arm/mach-bcm/bcm_kona_smc.c:36:34: error: duplicate 'const' declaration specifier [-Werror=duplicate-decl-specifier]
>  static const struct of_device_id const bcm_kona_smc_ids[] __initconst = {
> arch/arm/mach-spear/time.c:207:34: error: duplicate 'const' declaration specifier [-Werror=duplicate-decl-specifier]
>  static const struct of_device_id const timer_of_match[] __initconst = {
> arch/arm/mach-omap2/prm_common.c:714:34: error: duplicate 'const' declaration specifier [-Werror=duplicate-decl-specifier]
>  static const struct of_device_id const omap_prcm_dt_match_table[] __initconst = {
> arch/arm/mach-omap2/vc.c:562:35: error: duplicate 'const' declaration specifier [-Werror=duplicate-decl-specifier]
>  static const struct i2c_init_data const omap4_i2c_timing_data[] __initconst = {
> 
> The ones in arch/arm were apparently all introduced accidentally by one
> commit that correctly marked a lot of variables as __initconst.
> 
> Cc: Nicolas Pitre <nico@linaro.org>
> Fixes: 19c233b79d1a ("ARM: appropriate __init annotation for const data")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/arm/mach-spear/time.c       | 2 +-

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
