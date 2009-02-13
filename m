From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: Re: [PATCH 1/1] Allow I2C_OMAP to compile as a module.
Date: Fri, 13 Feb 2009 08:58:27 +0200
Message-ID: <20090213085827.d516d6aa.jarkko.nikula@nokia.com>
References: <ba2e7dbd53e76bb21bbb95fc026df11787cbd798.1234447641.git.ext-atal.shargorodsky@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:61136 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751487AbZBMG60 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 13 Feb 2009 01:58:26 -0500
In-Reply-To: <ba2e7dbd53e76bb21bbb95fc026df11787cbd798.1234447641.git.ext-atal.shargorodsky@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shargorodsky Atal (EXT-Teleca/Helsinki)" <ext-atal.shargorodsky@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, tony@atomide.com

On Thu, 12 Feb 2009 15:10:29 +0100
"Shargorodsky Atal (EXT-Teleca/Helsinki)"
<ext-atal.shargorodsky@nokia.com> wrote:

> This patch allows I2C_OMAP to be compiled as a module.
> Only drivers/i2c/busses/i2c-omap.c can be compiled as a module,
> but not arch/arm/plat-omap/i2c.c , so let the contents of i2c.c
> to compile into the kernel if either I2C_OMAP was selected to compile
> in or as a module.
> 
> Signed-off-by: Atal Shargorodsky <ext-atal.shargorodsky@nokia.com>
> ---
>  arch/arm/plat-omap/Makefile |    3 +--
>  arch/arm/plat-omap/i2c.c    |    4 ++++
>  2 files changed, 5 insertions(+), 2 deletions(-)
> 
Tony,

You can add this to your 2.6.29-rc series since the same build error is
in mainline as well if CONFIG_I2C_OMAP=m.

  Building modules, stage 2.
  GZIP    arch/arm/boot/compressed/piggy.gz
  MODPOST 6 modules
ERROR: "i2c_register_board_info" [arch/arm/plat-omap/i2c.ko] undefined!
make[1]: *** [__modpost] Error 1
make: *** [modules] Error 2
make: *** Waiting for unfinished jobs....

Subject needs a "ARM: OMAP: " prefix, otherwise ok from me.

Acked-by: Jarkko Nikula <jarkko.nikula@nokia.com>
