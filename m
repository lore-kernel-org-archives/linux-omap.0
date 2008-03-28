From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/7] twl4030 changes
Date: Fri, 28 Mar 2008 09:49:00 +0200
Message-ID: <20080328074900.GD24896@atomide.com>
References: <1206638167-23951-1-git-send-email-felipe.balbi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:55987 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751857AbYC1HtE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 28 Mar 2008 03:49:04 -0400
Content-Disposition: inline
In-Reply-To: <1206638167-23951-1-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <felipe.balbi@nokia.com>
Cc: linux-omap@vger.kernel.org

* Felipe Balbi <felipe.balbi@nokia.com> [080327 19:20]:
> Hi Tony,
> 
> I'm resending this series cuz I changed a bit patch #5 to set
> session bit on musb_platform_set_mode so musb core will really
> go to a_host mode when we echo sysfs.
> 
> Without this small change the sysfs interface will work only with
> a few devices, most likely usb sticks.
> 
> Below is a shortlog and diffstat of the changes.

Pushing this series today.

Tony



> Best regards,
> 
> 	- Balbi
> 
> Felipe Balbi (7):
>   I2C: TWL4030: Move twl4030's headers under include/linux/i2c/
>   I2C: TWL4030: Move all *_*.c to *-*.c
>   I2C: TWL4030: General cleanup in twl4030-core.c
>   I2C: TWL4030: Cleanup twl4030-usb.c
>   I2C: TWL4030: Make twl4030-usb.c initialize otg_transceiver
>   I2C: TWL4030: Reorganize code in twl4030-usb.c
>   USB: MUSB: Let board specific code handle clock initialization
> 
>  arch/arm/mach-omap2/board-2430sdp-usb.c            |   27 ++
>  arch/arm/mach-omap2/board-3430sdp-usb.c            |   29 ++-
>  arch/arm/mach-omap2/board-3430sdp.c                |    2 +-
>  arch/arm/mach-omap2/board-sdp-hsmmc.c              |    2 +-
>  drivers/i2c/chips/Makefile                         |    8 +-
>  .../i2c/chips/{twl4030_core.c => twl4030-core.c}   |   80 ++++---
>  .../i2c/chips/{twl4030_gpio.c => twl4030-gpio.c}   |    2 +-
>  .../{twl4030_poweroff.c => twl4030-poweroff.c}     |    2 +-
>  drivers/i2c/chips/{twl4030_usb.c => twl4030-usb.c} |  255 +++++++++++++-------
>  drivers/input/keyboard/omap-twl4030keypad.c        |    2 +-
>  drivers/rtc/rtc-twl4030.c                          |    4 +-
>  drivers/usb/musb/musb_core.h                       |    4 +-
>  drivers/usb/musb/omap2430.c                        |   39 ++--
>  drivers/usb/musb/omap2430.h                        |    8 -
>  .../{asm-arm/arch-omap => linux/i2c}/twl4030-rtc.h |    0 
>  include/{asm-arm/arch-omap => linux/i2c}/twl4030.h |    0 
>  16 files changed, 303 insertions(+), 161 deletions(-)
>  rename drivers/i2c/chips/{twl4030_core.c => twl4030-core.c} (93%)
>  rename drivers/i2c/chips/{twl4030_gpio.c => twl4030-gpio.c} (99%)
>  rename drivers/i2c/chips/{twl4030_poweroff.c => twl4030-poweroff.c} (98%)
>  rename drivers/i2c/chips/{twl4030_usb.c => twl4030-usb.c} (87%)
>  rename include/{asm-arm/arch-omap => linux/i2c}/twl4030-rtc.h (100%)
>  rename include/{asm-arm/arch-omap => linux/i2c}/twl4030.h (100%)
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
