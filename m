From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [PATCH 3/3] Disable linux-omap version of menelaus
Date: Thu, 22 Jan 2009 15:15:09 +0200
Message-ID: <20090122131509.GH9233@scadufax.research.nokia.com>
References: <20090122131602.18315.84862.stgit@tikku> <20090122131920.18315.68032.stgit@tikku>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:20506 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751428AbZAVN1V (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 22 Jan 2009 08:27:21 -0500
Received: from vaebh106.NOE.Nokia.com (vaebh106.europe.nokia.com [10.160.244.32])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id n0MDRBVJ001837
	for <linux-omap@vger.kernel.org>; Thu, 22 Jan 2009 07:27:18 -0600
Content-Disposition: inline
In-Reply-To: <20090122131920.18315.68032.stgit@tikku>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Kalle Valo <kalle.valo@nokia.com>
Cc: linux-omap@vger.kernel.org

On Thu, Jan 22, 2009 at 03:19:20PM +0200, Kalle Valo wrote:
> Fixes linker errors like this:
> 
> drivers/i2c/built-in.o: In function `menelaus_set_vdcdc':
> lp5521.c:(.text+0x3910): multiple definition of `menelaus_set_vdcdc'
> drivers/mfd/built-in.o:menelaus.c:(.text+0x95c): first defined here
> drivers/i2c/built-in.o: In function `menelaus_set_vio':
> lp5521.c:(.text+0x3990): multiple definition of `menelaus_set_vio'
> 
> Signed-off-by: Kalle Valo <kalle.valo@nokia.com>
> ---
> 
>  drivers/i2c/chips/Makefile |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/i2c/chips/Makefile b/drivers/i2c/chips/Makefile
> index b451369..d8bef8c 100644
> --- a/drivers/i2c/chips/Makefile
> +++ b/drivers/i2c/chips/Makefile
> @@ -18,7 +18,6 @@ obj-$(CONFIG_SENSORS_PCA9539)	+= pca9539.o
>  obj-$(CONFIG_SENSORS_PCF8574)	+= pcf8574.o
>  obj-$(CONFIG_PCF8575)		+= pcf8575.o
>  obj-$(CONFIG_SENSORS_PCF8591)	+= pcf8591.o
> -obj-$(CONFIG_MENELAUS)		+= menelaus.o

and mmc is broken again

-- 
balbi
