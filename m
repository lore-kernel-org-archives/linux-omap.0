From: Samuel Ortiz <sameo@linux.intel.com>
Subject: Re: [PATCH v4 2/4] mfd: introduce retu-mfd driver
Date: Wed, 21 Nov 2012 15:27:53 +0100
Message-ID: <20121121142753.GX18738@sortiz-mobl>
References: <1353256582-12166-1-git-send-email-aaro.koskinen@iki.fi>
 <1353256582-12166-3-git-send-email-aaro.koskinen@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1353256582-12166-3-git-send-email-aaro.koskinen@iki.fi>
Sender: linux-kernel-owner@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Aaro,

On Sun, Nov 18, 2012 at 06:36:20PM +0200, Aaro Koskinen wrote:
> Retu is a multi-function device found on Nokia Internet Tablets
> implementing at least watchdog, RTC, headset detection and power button
> functionality.
> 
> This patch implements minimum functionality providing register access,
> IRQ handling and power off functions.
> 
> Cc: Samuel Ortiz <sameo@linux.intel.com>
> Acked-by: Felipe Balbi <balbi@ti.com>
> Acked-by: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
> ---
>  drivers/mfd/Kconfig      |    9 ++
>  drivers/mfd/Makefile     |    1 +
>  drivers/mfd/retu-mfd.c   |  264 ++++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/mfd/retu.h |   22 ++++
>  4 files changed, 296 insertions(+)
>  create mode 100644 drivers/mfd/retu-mfd.c
>  create mode 100644 include/linux/mfd/retu.h
Thanks, I applied this one to my for-next branch.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
