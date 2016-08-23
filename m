From: Keerthy <a0393675-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v7 0/3] mfd: lp873x: Add lp873x PMIC support
Date: Tue, 23 Aug 2016 10:12:04 +0530
Message-ID: <5c7c9cba-36db-6912-2520-cc64140f9175@ti.com>
References: <1470824291-14902-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1470824291-14902-1-git-send-email-j-keerthy-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Lee Jones,

On Wednesday 10 August 2016 03:48 PM, Keerthy wrote:
> The LP873X chip is a power management IC for Portable Navigation Systems
>     and Tablet Computing devices. It contains the following components:
>
>      - Regulators.
>      - Configurable General Purpose Output Signals(GPO).
>
> PMIC interacts with the main processor through i2c. PMIC has
> couple of LDOs(Linear Regulators), couple of BUCKs (Step-Down DC-DC
> Converter Cores) and GPOs(General Purpose Output Signals).
>

Kindly pull this set if there are no further comments.

> The regulator patch is already queued:
> http://marc.info/?l=linux-kernel&m=146298767110771&w=2
>
> DT patch also queued:
>
> Hence posting the remaining patches of the series with
> the comments fixed on mfd driver.
>
> Chages in v7:
>
> Reverted the dependency on http://www.gossamer-threads.com/lists/linux/kernel/2457552.
>
> Changes in v6:
>
> Series depends on: http://www.gossamer-threads.com/lists/linux/kernel/2457552
> probe_new used.
>
> Chnages in v4:
>
> Added GPO driver support.
>
> Keerthy (3):
>   mfd: lp873x: Add lp873x PMIC support
>   gpio: lp873x: Add support for General Purpose Outputs
>   regulator: lp873x: Change the MFD config option as per latest naming
>
>  drivers/gpio/Kconfig       |  10 ++
>  drivers/gpio/Makefile      |   1 +
>  drivers/gpio/gpio-lp873x.c | 185 +++++++++++++++++++++++++++++++
>  drivers/mfd/Kconfig        |  14 +++
>  drivers/mfd/Makefile       |   2 +
>  drivers/mfd/lp873x.c       |  96 +++++++++++++++++
>  drivers/regulator/Kconfig  |   2 +-
>  include/linux/mfd/lp873x.h | 264 +++++++++++++++++++++++++++++++++++++++++++++
>  8 files changed, 573 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/gpio/gpio-lp873x.c
>  create mode 100644 drivers/mfd/lp873x.c
>  create mode 100644 include/linux/mfd/lp873x.h
>
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
