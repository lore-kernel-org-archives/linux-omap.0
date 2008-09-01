From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH 1/1] SDP2430 Fix dependency in include file
Date: Mon, 1 Sep 2008 11:07:00 +0300
Message-ID: <20080901080700.GX9887@frodo>
References: <cb8016980808311857y693787daq8c641c785732058c@mail.gmail.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:40926 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751808AbYIAIJE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 1 Sep 2008 04:09:04 -0400
Content-Disposition: inline
In-Reply-To: <cb8016980808311857y693787daq8c641c785732058c@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Abraham Arce <abraham.arce.moreno@gmail.com>
Cc: omap <linux-omap@vger.kernel.org>

On Sun, Aug 31, 2008 at 08:57:44PM -0500, Abraham Arce wrote:
> TWL4030_MODIRQ_KEYPAD was undeclared, adding the required file.
> 
> Signed-off-by: Abraham Arce <abraham.arce.moreno@gmail.com>
> ---
>  arch/arm/mach-omap2/board-2430sdp.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/board-2430sdp.c
> b/arch/arm/mach-omap2/board-2430sdp.c
> index 64e76e8..195d53c 100644
> --- a/arch/arm/mach-omap2/board-2430sdp.c
> +++ b/arch/arm/mach-omap2/board-2430sdp.c
> @@ -24,6 +24,7 @@
>  #include <linux/clk.h>
>  #include <linux/spi/spi.h>
>  #include <linux/spi/ads7846.h>
> +#include <linux/i2c/twl4030.h>

and what's wrong with:

http://marc.info/?l=linux-omap&m=122011272912755&w=2

>  #include <linux/i2c/twl4030-rtc.h>
> 
>  #include <mach/hardware.h>

-- 
balbi
