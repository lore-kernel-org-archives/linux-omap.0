From: Samuel Ortiz <sameo@linux.intel.com>
Subject: Re: [RFC PATCH 2/5] mfd: introduce retu-mfd driver
Date: Wed, 19 Sep 2012 17:30:31 +0200
Message-ID: <20120919153031.GI28670@sortiz-mobl>
References: <1346189667-32330-1-git-send-email-aaro.koskinen@iki.fi>
 <1346189667-32330-3-git-send-email-aaro.koskinen@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:39120 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756001Ab2ISPae (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 19 Sep 2012 11:30:34 -0400
Content-Disposition: inline
In-Reply-To: <1346189667-32330-3-git-send-email-aaro.koskinen@iki.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: linux-omap@vger.kernel.org

Hi Aaro,

On Wed, Aug 29, 2012 at 12:34:24AM +0300, Aaro Koskinen wrote:
> Retu is a multi-function device found on Nokia Internet Tablets
> implementing at least watchdog, RTC, headset detection and power button
> functionality.
> 
> This patch implements a minimum functionality providing only register
> access functions.
> 
> Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
> Cc: sameo@linux.intel.com
> ---
>  drivers/mfd/Kconfig      |    8 +++
>  drivers/mfd/Makefile     |    1 +
>  drivers/mfd/retu-mfd.c   |  114 ++++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/mfd/retu.h |   20 ++++++++
>  4 files changed, 143 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/mfd/retu-mfd.c
>  create mode 100644 include/linux/mfd/retu.h
Besides Felipe's comments, you probably want to use regmap I2C for this
driver.


> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index b1a1462..8ca1270 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -1003,6 +1003,14 @@ config MFD_PALMAS
>  	  If you say yes here you get support for the Palmas
>  	  series of PMIC chips from Texas Instruments.
>  
> +config MFD_RETU
> +	tristate "Support for Retu multi-function device"
> +	select MFD_CORE
> +	depends on I2C
> +	help
> +	  Retu is a multi-function device found on Nokia Internet Tables
> +	  (770, N800 and N810).
Which sub devices does it come with ?

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
