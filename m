From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCH v5 2/3] phy: Move ULPI phy header out of drivers to
 include path
Date: Thu, 11 May 2017 10:30:20 +0300
Message-ID: <20170511073020.GA7676@kuha.fi.intel.com>
References: <1494485262-18995-1-git-send-email-vivek.gautam@codeaurora.org>
 <1494485262-18995-2-git-send-email-vivek.gautam@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1494485262-18995-2-git-send-email-vivek.gautam@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Vivek Gautam <vivek.gautam@codeaurora.org>
Cc: kishon@ti.com, linux-kernel@vger.kernel.org, Stephen Boyd <stephen.boyd@linaro.org>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-usb@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Thu, May 11, 2017 at 12:17:41PM +0530, Vivek Gautam wrote:
> Although ULPI phy is currently being used by tusb1210,
> there can be other consumers too in future. So move this
> to the includes path for phy.
> 
> Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
> Cc: Stephen Boyd <stephen.boyd@linaro.org>
> Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Cc: Kishon Vijay Abraham I <kishon@ti.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-omap@vger.kernel.org
> Cc: linux-usb@vger.kernel.org
> ---

Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> Changes since v4:
>  - None.
> 
> Changes since v3:
>  - Removed qcom phy changes, since patch - 1/3 addressed that now.
> 
> Changes since v2:
>  - Updated the location for this header in drivers using it.
> 
>  drivers/phy/phy-tusb1210.c                | 3 +--
>  {drivers => include/linux}/phy/ulpi_phy.h | 0
>  2 files changed, 1 insertion(+), 2 deletions(-)
>  rename {drivers => include/linux}/phy/ulpi_phy.h (100%)
> 
> diff --git a/drivers/phy/phy-tusb1210.c b/drivers/phy/phy-tusb1210.c
> index 4f6d5e71507d..bb3fb031c478 100644
> --- a/drivers/phy/phy-tusb1210.c
> +++ b/drivers/phy/phy-tusb1210.c
> @@ -12,8 +12,7 @@
>  #include <linux/module.h>
>  #include <linux/ulpi/driver.h>
>  #include <linux/gpio/consumer.h>
> -
> -#include "ulpi_phy.h"
> +#include <linux/phy/ulpi_phy.h>
>  
>  #define TUSB1210_VENDOR_SPECIFIC2		0x80
>  #define TUSB1210_VENDOR_SPECIFIC2_IHSTX_SHIFT	0
> diff --git a/drivers/phy/ulpi_phy.h b/include/linux/phy/ulpi_phy.h
> similarity index 100%
> rename from drivers/phy/ulpi_phy.h
> rename to include/linux/phy/ulpi_phy.h
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project

-- 
heikki
