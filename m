From: "Govindarajan, Sriramakrishnan" <srk@ti.com>
Subject: RE: [PATCH 02/12] AM3517: Add platform init code for EMAC driver
Date: Wed, 14 Apr 2010 18:31:20 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC3560870304B3E63F@dbde02.ent.ti.com>
References: <1271233822-27286-1-git-send-email-stanley.miao@windriver.com>
 <1271233822-27286-3-git-send-email-stanley.miao@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:41781 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755271Ab0DNNB1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 Apr 2010 09:01:27 -0400
In-Reply-To: <1271233822-27286-3-git-send-email-stanley.miao@windriver.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Stanley.Miao" <stanley.miao@windriver.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "tony@atomide.com" <tony@atomide.com>

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Stanley.Miao
> Sent: Wednesday, April 14, 2010 2:00 PM
> To: linux-omap@vger.kernel.org
> Cc: tony@atomide.com
> Subject: [PATCH 02/12] AM3517: Add platform init code for EMAC driver
> 
> Add platform init code for EMAC driver.
> 
> Signed-off-by: Stanley.Miao <stanley.miao@windriver.com>
> ---
>  arch/arm/mach-omap2/board-am3517evm.c     |  114
> +++++++++++++++++++++++++++++
>  arch/arm/mach-omap2/include/mach/am35xx.h |    9 ++
>  2 files changed, 123 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/board-am3517evm.c b/arch/arm/mach-
> omap2/board-am3517evm.c
> index 6ae8805..db542b2 100644
> --- a/arch/arm/mach-omap2/board-am3517evm.c
> +++ b/arch/arm/mach-omap2/board-am3517evm.c
> @@ -20,6 +20,7 @@
>  #include <linux/init.h>
>  #include <linux/platform_device.h>
>  #include <linux/gpio.h>
> +#include <linux/davinci_emac.h>
>  #include <linux/i2c/pca953x.h>
> 
>  #include <mach/hardware.h>
> @@ -30,6 +31,7 @@
> 
>  #include <plat/board.h>
>  #include <plat/common.h>
> +#include <plat/control.h>
>  #include <plat/usb.h>
>  #include <plat/display.h>

-- snip --

This patch has been posted earlier. Refer,
https://patchwork.kernel.org/patch/84921/
https://patchwork.kernel.org/patch/84919/

Tony,
Any updates on these

Regards
Sriram


