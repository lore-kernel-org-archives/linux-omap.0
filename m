From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH] drivers/gpio: using common order: let 'static const'
 instead of 'const static'
Date: Wed, 6 Feb 2013 15:06:27 +0530
Message-ID: <5112241B.8050207@ti.com>
References: <51122147.6080708@asianux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="GB2312"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:34975 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751276Ab3BFJfW (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 6 Feb 2013 04:35:22 -0500
In-Reply-To: <51122147.6080708@asianux.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Chen Gang <gang.chen@asianux.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, grant.likely@secretlab.ca, linus.walleij@linaro.org, linux-omap@vger.kernel.org

On Wednesday 06 February 2013 02:54 PM, Chen Gang wrote:
> 
>    'const static ' is not a common order, better to use 'const static' instead.
You mean  " use static const  instead ", right ?

> building:
>    make EXTRA_CFLAGS=-W ARCH=arm
> 
>    drivers/gpio/gpio-omap.c:1479:
>      warning: 'static' is not at beginning of declaration
>    drivers/gpio/gpio-omap.c:1485:
>      warning: 'static' is not at beginning of declaration
>    drivers/gpio/gpio-omap.c:1491:
>      warning: 'static' is not at beginning of declaration
> 
> 
> Signed-off-by: Chen Gang <gang.chen@asianux.com>
> ---
With change log fixed,

Acked-by: Santosh Shilimkar ,santosh.shilimkar@ti.com>

