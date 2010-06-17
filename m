From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: RE: [PATCH] Enable lm75 and hwmon in OMAP4
Date: Thu, 17 Jun 2010 17:41:53 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB03234B30E1@dbde02.ent.ti.com>
References: <0680EC522D0CC943BC586913CF3768C003B34A6712@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:43997 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759888Ab0FQML7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 17 Jun 2010 08:11:59 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id o5HCBuSa011872
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 17 Jun 2010 07:11:58 -0500
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id o5HCBtUC021280
	for <linux-omap@vger.kernel.org>; Thu, 17 Jun 2010 17:41:56 +0530 (IST)
In-Reply-To: <0680EC522D0CC943BC586913CF3768C003B34A6712@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Datta, Shubhrajyoti" <shubhrajyoti@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Datta, Shubhrajyoti wrote:
> Enabling hwmon and lm75 in the omap4 defconfig
> 

I believe we're not going to be taking defconfig changes now.

> Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
> ---
>  arch/arm/configs/omap_4430sdp_defconfig |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
>  mode change 100644 => 100755 arch/arm/configs/omap_4430sdp_defconfig
> 
> diff --git a/arch/arm/configs/omap_4430sdp_defconfig b/arch/arm/configs/omap_4430sdp_defconfig
> old mode 100644
> new mode 100755


And this mode change was unnecessary?

> index 1fb0456..86d69ae
> --- a/arch/arm/configs/omap_4430sdp_defconfig
> +++ b/arch/arm/configs/omap_4430sdp_defconfig
> @@ -724,7 +724,8 @@ CONFIG_GPIOLIB=y
>  #
>  # CONFIG_W1 is not set
>  # CONFIG_POWER_SUPPLY is not set
> -# CONFIG_HWMON is not set
> +CONFIG_HWMON=y
> +CONFIG_SENSORS_LM75=y
>  # CONFIG_THERMAL is not set
>  CONFIG_WATCHDOG=y
>  # CONFIG_WATCHDOG_NOWAYOUT is not set
