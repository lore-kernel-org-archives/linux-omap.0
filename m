From: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>
Subject: RE: Compilation broken for 3430SDP defconfig
Date: Mon, 6 Oct 2008 13:20:16 -0500
Message-ID: <A24693684029E5489D1D202277BE8944122B9B84@dlee02.ent.ti.com>
References: <200810060941.36725.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:51494 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751559AbYJFSUf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Oct 2008 14:20:35 -0400
In-Reply-To: <200810060941.36725.david-b@pacbell.net>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>, "me@felipebalbi.com" <me@felipebalbi.com>
Cc: "Gadiyar, Anand" <gadiyar@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>

Hi all,

Today I did a pull from the linux-omap tree, and I have this error in compilation with the sdp defconfig:

  CC      arch/arm/mach-omap2/board-3430sdp.o
arch/arm/mach-omap2/board-3430sdp.c:43:35: error: linux/i2c/twl4030-rtc.h: No such file or directory
arch/arm/mach-omap2/board-3430sdp.c: In function 'msecure_init':
arch/arm/mach-omap2/board-3430sdp.c:132: warning: initialization makes integer from pointer without a cast
make[1]: *** [arch/arm/mach-omap2/board-3430sdp.o] Error 1
make: *** [arch/arm/mach-omap2] Error 2

So, I just did a git pull, then a git gc. I'm not seeing that linux/i2c/twl4030-rtc.h file now. Has someone moved it? Or do you think it could be something related to my clone?

Regards,
Sergio

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of David Brownell
> Sent: Monday, October 06, 2008 11:42 AM
> To: me@felipebalbi.com
> Cc: Gadiyar, Anand; linux-omap@vger.kernel.org; tony@atomide.com
> Subject: Re: Compilation broken for 3430SDP defconfig
>
> On Monday 06 October 2008, Felipe Balbi wrote:
> > Yes, we need defconfig changes since Kconfig is not asking about the new
> > CONFIG_GPIO_TWL4030 symbol added.
>
> I seem to have tested with "make oldconfig" not "make ..._defconfig".
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

