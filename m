From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH] OMAP1: PM: fix omap1 build
Date: Fri, 11 Feb 2011 16:13:14 -0800
Message-ID: <87oc6i5cv9.fsf@ti.com>
References: <1297081358-8294-1-git-send-email-manjugk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:46629 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752298Ab1BLANS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 11 Feb 2011 19:13:18 -0500
Received: by gwaa20 with SMTP id a20so1713025gwa.23
        for <linux-omap@vger.kernel.org>; Fri, 11 Feb 2011 16:13:17 -0800 (PST)
In-Reply-To: <1297081358-8294-1-git-send-email-manjugk@ti.com> (Manjunath
	Kondaiah G.'s message of "Mon, 7 Feb 2011 17:52:38 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "G, Manjunath Kondaiah" <manjugk@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Manju,

"G, Manjunath Kondaiah" <manjugk@ti.com> writes:

> The omap1_defconfig build on pm branch throughs below build error:
>
>   CC      drivers/i2c/busses/i2c-omap.o
> drivers/i2c/busses/i2c-omap.c:1173: error: lvalue required as unary '&' operand
> make[3]: *** [drivers/i2c/busses/i2c-omap.o] Error 1
> make[2]: *** [drivers/i2c/busses] Error 2
> make[1]: *** [drivers/i2c] Error 2
> make: *** [drivers] Error 2
>
> Fix above build error. Boot tested on omap1710(h3) board.
>
> Signed-off-by: G, Manjunath Kondaiah <manjugk@ti.com>
> ---
>  drivers/i2c/busses/i2c-omap.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> index 0541df9..8db456f 100644
> --- a/drivers/i2c/busses/i2c-omap.c
> +++ b/drivers/i2c/busses/i2c-omap.c
> @@ -1170,7 +1170,7 @@ static struct platform_driver omap_i2c_driver = {
>  	.driver		= {
>  		.name	= "omap_i2c",
>  		.owner	= THIS_MODULE,
> -		.pm     = &omap_i2c_pm_ops,
> +		.pm     = omap_i2c_pm_ops,
>  	},
>  };

This might fix the compile on OMAP1, but it then breaks the build for
OMAP2+ when CONFIG_PM is enabled.

This isn't really an OMAP1 issue, rather it's a !CONFIG_PM issue.

The right fix will be to make the #else clause of the #ifdef CONFIG_PM
correct for all OMAPs.

Also, please Cc Ben Dooks and the linux-i2c list on I2C driver patches
(MAINTAINERS entry below.)

Thanks,

Kevin




I2C SUBSYSTEM
M:	"Jean Delvare (PC drivers, core)" <khali@linux-fr.org>
M:	"Ben Dooks (embedded platforms)" <ben-linux@fluff.org>
L:	linux-i2c@vger.kernel.org
W:	http://i2c.wiki.kernel.org/
T:	quilt kernel.org/pub/linux/kernel/people/jdelvare/linux-2.6/jdelvare-i2c/
T:	git git://git.fluff.org/bjdooks/linux.git
S:	Maintained
F:	Documentation/i2c/
F:	drivers/i2c/
F:	include/linux/i2c.h
F:	include/linux/i2c-*.h

