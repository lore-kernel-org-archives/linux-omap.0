From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCH v2 5/7] ARM: OMAP2+: Split omap2_hsmmc_init() to properly
 support I2C GPIO pins
Date: Fri, 24 Feb 2012 08:54:08 +0530
Message-ID: <4F4702D8.8020206@ti.com>
References: <1329997247-27342-1-git-send-email-rnayak@ti.com>
 <1329997247-27342-6-git-send-email-rnayak@ti.com>
 <4F464CFF.3080006@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <4F464CFF.3080006@compulab.co.il>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Igor Grinberg <grinberg@compulab.co.il>
Cc: tony@atomide.com, Steve Sakoman <sakoman@gmail.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Steve Sakoman <steve@sakoman.com>
List-Id: linux-omap@vger.kernel.org

On Thursday 23 February 2012 07:58 PM, Igor Grinberg wrote:
> Hi Tony, Rajendra,
>
> On 02/23/12 13:40, Rajendra Nayak wrote:
>> >  From: Tony Lindgren<tony@atomide.com>
>> >
>> >  Otherwise omap_device_build() and omap_mux related functions
>> >  can't be marked as __init when twl is build as a module.
>> >
>> >  If a board is using GPIO pins or regulators configured by an
>> >  external chip, such as TWL PMIC on I2C bus, the board must
>> >  mark those MMC controllers as deferred. Additionally both
>> >  omap_hsmmc_init() and omap_hsmmc_deferred_add() must be called
>> >  by the board.
>> >
>> >  For MMC controllers using internal GPIO pins for card
>> >  detect and regulators the slots don't need to be marked
>> >  deferred. In this case calling omap_hsmmc_init() is sufficient.
>> >
>> >  Note that this patch does not change the behaviour for
>> >  board-4430sdp.c board-omap4panda.c. These boards wrongly
>> >  rely on the omap_hsmmc.c init function callback to configure
>> >  the PMIC GPIO interrupt lines on external chip. If the PMIC
>> >  interrupt lines are not configured during init, they will
>> >  fail.
>> >
>> >  Reported-by: Russell King<rmk+kernel@arm.linux.org.uk>
>> >  Signed-off-by: Tony Lindgren<tony@atomide.com>
>> >  Signed-off-by: Rajendra Nayak<rnayak@ti.com>
>> >  ---
>> >    arch/arm/mach-omap2/board-2430sdp.c          |    2 +-
>> >    arch/arm/mach-omap2/board-3430sdp.c          |   12 ++--
>> >    arch/arm/mach-omap2/board-4430sdp.c          |    4 +-
>> >    arch/arm/mach-omap2/board-am3517evm.c        |    2 +-
>> >    arch/arm/mach-omap2/board-cm-t35.c           |   10 +-
>> >    arch/arm/mach-omap2/board-devkit8000.c       |    7 +-
>> >    arch/arm/mach-omap2/board-igep0020.c         |   11 ++-
>> >    arch/arm/mach-omap2/board-ldp.c              |    2 +-
>> >    arch/arm/mach-omap2/board-omap3beagle.c      |    7 +-
>> >    arch/arm/mach-omap2/board-omap3evm.c         |    9 +-
>> >    arch/arm/mach-omap2/board-omap3logic.c       |    2 +-
>> >    arch/arm/mach-omap2/board-omap3pandora.c     |   13 ++--
>> >    arch/arm/mach-omap2/board-omap3stalker.c     |   14 ++--
>> >    arch/arm/mach-omap2/board-omap3touchbook.c   |    7 +-
>> >    arch/arm/mach-omap2/board-omap4panda.c       |    4 +-
>> >    arch/arm/mach-omap2/board-overo.c            |    5 +-
>> >    arch/arm/mach-omap2/board-rm680.c            |    2 +-
>> >    arch/arm/mach-omap2/board-rx51-peripherals.c |    2 +-
>> >    arch/arm/mach-omap2/board-zoom-peripherals.c |    9 ++-
>> >    arch/arm/mach-omap2/hsmmc.c                  |  117 +++++++++++++++++++-------
>> >    arch/arm/mach-omap2/hsmmc.h                  |   13 ++-
>> >    21 files changed, 165 insertions(+), 89 deletions(-)
> [...]
>
>> >  diff --git a/arch/arm/mach-omap2/board-cm-t35.c b/arch/arm/mach-omap2/board-cm-t35.c
>> >  index d73316e..14df109 100644
>> >  --- a/arch/arm/mach-omap2/board-cm-t35.c
>> >  +++ b/arch/arm/mach-omap2/board-cm-t35.c
>> >  @@ -411,9 +411,9 @@ static struct omap2_hsmmc_info mmc[] = {
>> >    	{
>> >    		.mmc		= 1,
>> >    		.caps		= MMC_CAP_4_BIT_DATA,
>> >  -		.gpio_cd	= -EINVAL,
>> >  +		.gpio_cd	= OMAP_MAX_GPIO_LINES + 0,
>> >    		.gpio_wp	= -EINVAL,
>> >  -
>> >  +		.deferred	= true,
>> >    	},
>> >    	{
>> >    		.mmc		= 2,
>> >  @@ -422,6 +422,7 @@ static struct omap2_hsmmc_info mmc[] = {
>> >    		.gpio_cd	= -EINVAL,
>> >    		.gpio_wp	= -EINVAL,
>> >    		.ocr_mask	= 0x00100000,	/* 3.3V */
>> >  +		.deferred	= true,
> Why do you defer this one?
> It does not use external GPIO chip, in fact it does not use CD/WP at all.

I thought so too, but kept it that way since Tony's original patch
deferred it.
Tony, any reason you deferred the mmc devices which *do not* have card
detect via twl4030 gpio too?

>
>> >    	},
>> >    	{}	/* Terminator */
>> >    };
>> >  @@ -469,9 +470,7 @@ static int cm_t35_twl_gpio_setup(struct device *dev, unsigned gpio,
>> >    		pr_err("CM-T35: could not obtain gpio for WiFi reset\n");
>> >    	}
>> >
>> >  -	/* gpio + 0 is "mmc0_cd" (input/IRQ) */
>> >  -	mmc[0].gpio_cd = gpio + 0;
>> >  -	omap2_hsmmc_init(mmc);
>> >  +	omap_hsmmc_deferred_add(mmc);
>> >
>> >    	return 0;
>> >    }
>> >  @@ -639,6 +638,7 @@ static void __init cm_t3x_common_init(void)
>> >    	omap_serial_init();
>> >    	omap_sdrc_init(mt46h32m32lf6_sdrc_params,
>> >    			mt46h32m32lf6_sdrc_params);
>> >  +	omap_hsmmc_init(mmc);
>> >    	cm_t35_init_i2c();
>> >    	omap_ads7846_init(1, CM_T35_GPIO_PENDOWN, 0, NULL);
>> >    	cm_t35_init_ethernet();
> Other then the comment above, looks fine.
> I will probably be able to test this on Sunday.

Great, thanks.
