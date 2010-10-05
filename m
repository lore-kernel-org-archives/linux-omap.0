From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCHv2 0/7] PWM core driver for pwm based led and backlight driver
Date: Tue, 05 Oct 2010 08:05:03 -0700
Message-ID: <87wrpwu1cw.fsf@deeprootsystems.com>
References: <1286280002-1636-1-git-send-email-arun.murthy@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1286280002-1636-1-git-send-email-arun.murthy@stericsson.com>
	(Arun Murthy's message of "Tue, 5 Oct 2010 17:29:55 +0530")
Sender: linux-kernel-owner@vger.kernel.org
To: Arun Murthy <arun.murthy@stericsson.com>
Cc: lars@metafoo.de, akpm@linux-foundation.org, kernel@pengutronix.de, philipp.zabel@gmail.com, robert.jarzmik@free.fr, marek.vasut@gmail.com, eric.y.miao@gmail.com, rpurdie@rpsys.net, sameo@linux.intel.com, kgene.kim@samsung.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mips@linux-mips.org, STEricsson_nomadik_linux@list.st.com, bgat@billgatliff.com
List-Id: linux-omap@vger.kernel.org

Arun Murthy <arun.murthy@stericsson.com> writes:

> PWM core driver for pwm based led and backlight driver.
> The intention of the pwm core driver is not to break the build if two or more
> pwm drivers are enabled.
> Align the existing pwm drivers to make use of the pwm core driver

Hi Arun,

Because you have Bill Gatliff on Cc, I'm guessing you've already looked
at his RFC for a generic PWM framework?

There's recently been a proposal on DaVinci that is similar to yours
that enables multiple PWM drivers, but it would be nice to have a common
framework for this, and what Bill has proposed seems to be a good
solution.

Kevin

> Arun Murthy (7):
>   pwm: Add pwm core driver
>   backlight:pwm: add an element 'name' to platform data
>   leds: pwm: add a new element 'name' to platform data
>   pwm: Align existing pwm drivers with pwm-core driver
>   platform: Update the pwm based led and backlight platform data
>   pwm: move existing pwm driver to drivers/pwm
>   pwm: Modify backlight and led Kconfig aligning to pwm core
>
>  arch/arm/mach-pxa/cm-x300.c               |    1 +
>  arch/arm/mach-pxa/colibri-pxa270-income.c |    1 +
>  arch/arm/mach-pxa/ezx.c                   |    1 +
>  arch/arm/mach-pxa/hx4700.c                |    1 +
>  arch/arm/mach-pxa/lpd270.c                |    1 +
>  arch/arm/mach-pxa/magician.c              |    1 +
>  arch/arm/mach-pxa/mainstone.c             |    1 +
>  arch/arm/mach-pxa/mioa701.c               |    1 +
>  arch/arm/mach-pxa/palm27x.c               |    1 +
>  arch/arm/mach-pxa/palmtc.c                |    1 +
>  arch/arm/mach-pxa/palmte2.c               |    1 +
>  arch/arm/mach-pxa/pcm990-baseboard.c      |    1 +
>  arch/arm/mach-pxa/raumfeld.c              |    1 +
>  arch/arm/mach-pxa/tavorevb.c              |    2 +
>  arch/arm/mach-pxa/viper.c                 |    1 +
>  arch/arm/mach-pxa/z2.c                    |    2 +
>  arch/arm/mach-pxa/zylonite.c              |    1 +
>  arch/arm/mach-s3c2410/mach-h1940.c        |    1 +
>  arch/arm/mach-s3c2440/mach-rx1950.c       |    1 +
>  arch/arm/mach-s3c64xx/mach-hmt.c          |    1 +
>  arch/arm/mach-s3c64xx/mach-smartq.c       |    1 +
>  arch/arm/plat-mxc/pwm.c                   |  166 +++++++++------------
>  arch/arm/plat-pxa/pwm.c                   |  210 ++++++++++++--------------
>  arch/arm/plat-samsung/pwm.c               |  235 +++++++++++++----------------
>  arch/mips/jz4740/pwm.c                    |    2 +-
>  drivers/Kconfig                           |    2 +
>  drivers/Makefile                          |    1 +
>  drivers/leds/Kconfig                      |    2 +-
>  drivers/leds/leds-pwm.c                   |    4 +-
>  drivers/mfd/Kconfig                       |    9 -
>  drivers/mfd/Makefile                      |    1 -
>  drivers/mfd/twl-core.c                    |   13 ++
>  drivers/mfd/twl6030-pwm.c                 |  163 --------------------
>  drivers/misc/Kconfig                      |    9 -
>  drivers/misc/Makefile                     |    1 -
>  drivers/misc/ab8500-pwm.c                 |  168 --------------------
>  drivers/pwm/Kconfig                       |   35 +++++
>  drivers/pwm/Makefile                      |    4 +
>  drivers/pwm/pwm-ab8500.c                  |  157 +++++++++++++++++++
>  drivers/pwm/pwm-core.c                    |  130 ++++++++++++++++
>  drivers/pwm/pwm-twl6040.c                 |  196 ++++++++++++++++++++++++
>  drivers/video/backlight/Kconfig           |    2 +-
>  drivers/video/backlight/pwm_bl.c          |    4 +-
>  include/linux/leds_pwm.h                  |    3 +-
>  include/linux/pwm.h                       |   31 ++++-
>  include/linux/pwm_backlight.h             |    1 +
>  46 files changed, 876 insertions(+), 696 deletions(-)
>  delete mode 100644 drivers/mfd/twl6030-pwm.c
>  delete mode 100644 drivers/misc/ab8500-pwm.c
>  create mode 100644 drivers/pwm/Kconfig
>  create mode 100644 drivers/pwm/Makefile
>  create mode 100644 drivers/pwm/pwm-ab8500.c
>  create mode 100644 drivers/pwm/pwm-core.c
>  create mode 100644 drivers/pwm/pwm-twl6040.c
