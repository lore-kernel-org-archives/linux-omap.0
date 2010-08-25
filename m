From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCHv2 6/8] OMAP3: PM: Adding smartreflex class3 driver
Date: Wed, 25 Aug 2010 15:31:27 -0700
Message-ID: <87vd6yb9z4.fsf@deeprootsystems.com>
References: <1281707231-3026-1-git-send-email-thara@ti.com>
	<1281707231-3026-7-git-send-email-thara@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:36769 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751748Ab0HYWb3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 25 Aug 2010 18:31:29 -0400
Received: by pwi7 with SMTP id 7so474928pwi.19
        for <linux-omap@vger.kernel.org>; Wed, 25 Aug 2010 15:31:29 -0700 (PDT)
In-Reply-To: <1281707231-3026-7-git-send-email-thara@ti.com> (Thara Gopinath's
	message of "Fri, 13 Aug 2010 19:17:09 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thara Gopinath <thara@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, b-cousson@ti.com, vishwanath.bs@ti.com, sawant@ti.com, dderrick@ti.com

Thara Gopinath <thara@ti.com> writes:

> Smartreflex Class3 implementation continuously monitors
> silicon performance  and instructs the Voltage Processors
> to increase or decrease the voltage.
> This patch adds smartreflex class 3 driver. This driver hooks
> up with the generic smartreflex driver smartreflex.c to abstract
> out class specific implementations out of the generic driver.
>
> Signed-off-by: Thara Gopinath <thara@ti.com>
> ---
>  arch/arm/mach-omap2/Makefile             |    1 +
>  arch/arm/mach-omap2/board-3430sdp.c      |    2 +
>  arch/arm/mach-omap2/board-3630sdp.c      |    2 +
>  arch/arm/mach-omap2/board-zoom3.c        |    2 +

I think this should be board-zoom-peripherals.c so it is enabled for
Zoom2 also.

>  arch/arm/mach-omap2/smartreflex-class3.c |   61 ++++++++++++++++++++++++++++++
>  arch/arm/mach-omap2/smartreflex-class3.h |   23 +++++++++++
>  arch/arm/plat-omap/Kconfig               |    9 ++++

Please separate this into the 2 patches.  One for the class driver, and
a second to modify the board files.

Kevin
