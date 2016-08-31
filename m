From: Keerthy <a0393675-l0cyMroinI0@public.gmane.org>
Subject: Re: [GIT PULL] Immutable branch between MFD, GPIO and Regulator due
 for the v4.9 merge window
Date: Wed, 31 Aug 2016 18:20:32 +0530
Message-ID: <8e1378ce-b757-39f9-7c36-707f2d9db21e@ti.com>
References: <1472633892-8261-1-git-send-email-j-keerthy@ti.com>
 <20160831122435.GD9415@dell>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160831122435.GD9415@dell>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>
Cc: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Wednesday 31 August 2016 05:54 PM, Lee Jones wrote:
> Enjoy!

Thanks! Just curious to know where to pull the below patch from:

https://patchwork.kernel.org/patch/9266665/

I checked in couple of other branches in your tree could not find the 
above patch.

Regards,
Keerthy

>
> The following changes since commit 694d0d0bb2030d2e36df73e2d23d5770511dbc8d:
>
>   Linux 4.8-rc2 (2016-08-14 19:11:36 -0700)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git ib-mfd-gpio-regulator-v4.9
>
> for you to fetch changes up to f618ed218dc01207882a8f02b1310c7daaf5156a:
>
>   regulator: lp873x: Change the MFD config option as per latest naming (2016-08-31 13:20:44 +0100)
>
> ----------------------------------------------------------------
> Immutable branch between MFD, GPIO and Regulator due for the v4.9 merge window
>
> ----------------------------------------------------------------
> Keerthy (3):
>       mfd: lp873x: Add lp873x PMIC support
>       gpio: lp873x: Add support for General Purpose Outputs
>       regulator: lp873x: Change the MFD config option as per latest naming
>
>  drivers/gpio/Kconfig       |  10 ++
>  drivers/gpio/Makefile      |   1 +
>  drivers/gpio/gpio-lp873x.c | 193 ++++++++++++++++++++++++++++++++
>  drivers/mfd/Kconfig        |  14 +++
>  drivers/mfd/Makefile       |   2 +
>  drivers/mfd/lp873x.c       |  99 +++++++++++++++++
>  drivers/regulator/Kconfig  |   2 +-
>  include/linux/mfd/lp873x.h | 269 +++++++++++++++++++++++++++++++++++++++++++++
>  8 files changed, 589 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/gpio/gpio-lp873x.c
>  create mode 100644 drivers/mfd/lp873x.c
>  create mode 100644 include/linux/mfd/lp873x.h
>
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
