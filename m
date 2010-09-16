From: Jean Delvare <khali@linux-fr.org>
Subject: Re: [PATCH 0/2] twl4030-madc driver
Date: Thu, 16 Sep 2010 09:05:57 +0200
Message-ID: <20100916090557.6fb05bc6@hyperion.delvare>
References: <1284615264-31789-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from zone0.gcu-squad.org ([212.85.147.21]:34859 "EHLO
	services.gcu-squad.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754140Ab0IPHGK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 16 Sep 2010 03:06:10 -0400
In-Reply-To: <1284615264-31789-1-git-send-email-j-keerthy@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
Cc: linux-omap@vger.kernel.org, j-keerthy@ti.com, balajitk@ti.com

On Thu, 16 Sep 2010 11:04:24 +0530, Keerthy wrote:
> MADC(Monitoring ADC) driver enables monitoring analog signals using 
> analog-to-digital conversion (ADC) on the input source. The MADC driver
> is being added under the Hwmon class of drivers. 
> To get the context, the last set of comments can be found here:
> http://www.mail-archive.com/linux-omap@vger.kernel.org/msg19981.html
> 
> Several people have contributed to this driver on the linux-omap list.
> 
> Keerthy (2):
>   hwmon: twl4030: Driver for twl4030 madc module
>   Makefile and Kconfig changes for twl4030-madc driver
> 
>  arch/arm/mach-omap2/Kconfig      |    4 +
>  drivers/hwmon/Kconfig            |    4 +
>  drivers/hwmon/Makefile           |    1 +
>  drivers/hwmon/twl4030-madc.c     |  584 ++++++++++++++++++++++++++++++++++++++
>  include/linux/i2c/twl4030-madc.h |  118 ++++++++
>  5 files changed, 711 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/hwmon/twl4030-madc.c
>  create mode 100644 include/linux/i2c/twl4030-madc.h

Please send hwmon drivers to the lm-sensors list as instructed by
MAINTAINERS.

-- 
Jean Delvare
