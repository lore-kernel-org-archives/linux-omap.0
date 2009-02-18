From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [PATCH] ARM: OMAP: Allow I2C bus driver to be compiled as a
 module
Date: Wed, 18 Feb 2009 11:45:25 +0200
Message-ID: <20090218114525.cb95391f.jhnikula@gmail.com>
References: <20090217235018.GF11928@atomide.com>
	<1234948938-6979-1-git-send-email-Aaro.Koskinen@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f21.google.com ([209.85.219.21]:40900 "EHLO
	mail-ew0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751381AbZBRJmr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 Feb 2009 04:42:47 -0500
Received: by ewy14 with SMTP id 14so2618538ewy.13
        for <linux-omap@vger.kernel.org>; Wed, 18 Feb 2009 01:42:46 -0800 (PST)
In-Reply-To: <1234948938-6979-1-git-send-email-Aaro.Koskinen@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Aaro Koskinen <Aaro.Koskinen@nokia.com>
Cc: tony@atomide.com, linux-omap@vger.kernel.org, jarkko.nikula@nokia.com, ext-atal.shargorodsky@nokia.com

On Wed, 18 Feb 2009 11:22:18 +0200
Aaro Koskinen <Aaro.Koskinen@nokia.com> wrote:

> Fixes a linker error when OMAP I2C bus driver is compiled as a module:
> 
>    ERROR: "i2c_register_board_info" [arch/arm/plat-omap/i2c.ko]
> undefined!
> 
> The I2C utility functions used for board initialization should be
> always built-in.
> 
> Signed-off-by: Aaro Koskinen <Aaro.Koskinen@nokia.com>
> ---
>  arch/arm/plat-omap/Makefile              |    3 ++-
>  arch/arm/plat-omap/include/mach/common.h |    2 +-
>  2 files changed, 3 insertions(+), 2 deletions(-)
> 
Acked-by: Jarkko Nikula  <jarkko.nikula@nokia.com>
