From: a0131647 <sourav.poddar@ti.com>
Subject: Re: [RFC/RFT PATCH 0/2] SERIAL: OMAP: Remove idle handling from driver
Date: Fri, 15 Feb 2013 18:33:58 +0530
Message-ID: <511E323E.3050104@ti.com>
References: <1360929970-31934-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:32929 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161337Ab3BONEJ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 15 Feb 2013 08:04:09 -0500
In-Reply-To: <1360929970-31934-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, balbi@ti.com, khilman@deeprootsystems.com, paul@pwsan.com, tony@atomide.com, vaibhav.bedia@ti.com, linux@arm.linux.org.uk, linux-arm-kernel@lists.infradead.org

Hi,
On Friday 15 February 2013 05:36 PM, Santosh Shilimkar wrote:
> OMAP UART IP needs manual idle modes based on state of the
> IP. Currently this is handled by the driver with function pointers
> implemented in platform code.
>
> This however breaks in case of device tree because of missing
> idle handling.
>
> The series tries to address the issue
>
> Patches has been tested on OMAP4 and OMAP5 devices where the console
> slugishness was observed without idle mode handling. CPUIDLE and
> suspend tested ok on these devices.
>
> Need help in testing on OMAP2, OMAP3 and AM3XXX devices.
>
Tested this series on omap3630 beagle board for:
1. Retention in idle and suspend.
2. Off mode in idle and suspend.

Tested-by: Sourav Poddar <sourav.poddar@ti.com>

> Santosh Shilimkar (2):
>    ARM: OMAP2+: hwmod-data: UART IP needs software control of sidle
>      modes
>    SERIAL: OMAP: Remove the idle handling from the driver
>
>   arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c |    3 ++
>   arch/arm/mach-omap2/omap_hwmod_33xx_data.c         |    6 ++++
>   arch/arm/mach-omap2/omap_hwmod_3xxx_data.c         |    4 +++
>   arch/arm/mach-omap2/omap_hwmod_44xx_data.c         |    6 +++-
>   arch/arm/mach-omap2/serial.c                       |   31 --------------------
>   drivers/tty/serial/omap-serial.c                   |   23 ---------------
>   6 files changed, 18 insertions(+), 55 deletions(-)
>

