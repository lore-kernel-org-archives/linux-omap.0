From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH v2] drivers/gpio: using common order: let 'static const'
 instead of 'const static'
Date: Wed, 6 Feb 2013 16:17:24 +0530
Message-ID: <511234BC.2000305@ti.com>
References: <51122147.6080708@asianux.com> <5112241B.8050207@ti.com> <511232B1.7090206@asianux.com> <5112334F.1020508@ti.com> <51123410.40602@asianux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:48001 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751891Ab3BFKqY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 6 Feb 2013 05:46:24 -0500
In-Reply-To: <51123410.40602@asianux.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Chen Gang <gang.chen@asianux.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, grant.likely@secretlab.ca, linus.walleij@linaro.org, linux-omap@vger.kernel.org

On Wednesday 06 February 2013 04:14 PM, Chen Gang wrote:
>
>    'const static ' is not a common order, better to use 'static const' instead.
>
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
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> ---
Thanks for update.
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

