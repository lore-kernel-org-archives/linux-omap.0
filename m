From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] ARM: remove duplicate 'const' annotations'
Date: Fri, 19 May 2017 10:14:29 +0200
Message-ID: <CAK8P3a2rxtL8oMt6TzX+KsZmKj03gZQQ7ptDGgJ3=LEEURoBjg@mail.gmail.com>
References: <20170511115059.2997141-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170511115059.2997141-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: arm-soc <arm@kernel.org>
Cc: Nicolas Pitre <nico@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Nicolas Ferre <nicolas.ferre@microchip.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Russell King <linux@armlinux.org.uk>, Florian Fainelli <f.fainelli@gmail.com>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>, Krzysztof Halasa <khalasa@piap.pl>, Rajendra Nayak <rnayak@codeaurora.org>, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, Viresh Kumar <vireshk@kernel.org>, Wenyou Yang <wenyou.yang@atmel.com>, Olof Johansson <olof@lixom.net>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-omap@vger.kernel.or
List-Id: linux-omap@vger.kernel.org

On Thu, May 11, 2017 at 1:50 PM, Arnd Bergmann <arnd@arndb.de> wrote:
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
>  arch/arm/mach-at91/pm.c          | 2 +-
>  arch/arm/mach-bcm/bcm_kona_smc.c | 2 +-
>  arch/arm/mach-cns3xxx/core.c     | 2 +-
>  arch/arm/mach-omap2/prm_common.c | 2 +-
>  arch/arm/mach-omap2/vc.c         | 2 +-
>  arch/arm/mach-spear/time.c       | 2 +-
>  6 files changed, 6 insertions(+), 6 deletions(-)

Applied to fixes now, thanks for the Acks!

      Arnd
