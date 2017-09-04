From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v4] mfd: tps65217: Introduce dependency on CONFIG_OF
Date: Mon, 4 Sep 2017 16:14:19 +0100
Message-ID: <20170904151419.5bjqz2wp7kq2uqmy@dell>
References: <1504085350-20824-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1504085350-20824-1-git-send-email-j-keerthy@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Keerthy <j-keerthy@ti.com>
Cc: eballetbo@gmail.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, broonie@kernel.org, tony@atomide.com, b.zolnierkie@samsung.com, javier@dowhile0.org
List-Id: linux-omap@vger.kernel.org

On Wed, 30 Aug 2017, Keerthy wrote:

> Currently the driver boots only via device tree hence add a
> dependency on CONFIG_OF. This leaves with a bunch of unused code
> so clean that up. This patch also makes use of probe_new function
> in place of the probe function so as to avoid passing i2c_device_id.
> 
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
> ---
> 
> Changes in v4:
> 
>   * Added Javier's Reviewed-by.
>   * Added back I2C Device ID struct as it is needed for module autoprobe.
> 
> Changes in v3:
> 
>   * Added more details to commit log.
>   * No changes in code. Rebased to latest next branch.
> 
> Changes in v2:
> 
>   * Cleaned up chip_id and data attached to the match.
>   * Cleaned up i2c_dev_id
>   * dropped the rest of the patches in series for now
> 
> Boot tested and checked for regulator registrations on am335x-boneblack
> both as part of zImage and as module autoprobed.
> 
>  drivers/mfd/Kconfig                    |  2 +-
>  drivers/mfd/tps65217.c                 | 28 +++++-----------------------
>  drivers/regulator/tps65217-regulator.c |  5 -----
>  drivers/video/backlight/tps65217_bl.c  | 14 +++-----------
>  include/linux/mfd/tps65217.h           |  6 ------
>  5 files changed, 9 insertions(+), 46 deletions(-)

Applied for v4.15.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
