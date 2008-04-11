From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: RE: [PATCH 00/23] General checkpatch.pl cleanup for twl and musb drivers
Date: Fri, 11 Apr 2008 14:36:05 +0530
Message-ID: <010C7BAE6783F34D9AC336EE5A01A08805D65026@dbde01.ent.ti.com>
References: <1207902516-6374-1-git-send-email-felipe.balbi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from soda.ext.ti.com ([198.47.26.145]:59637 "EHLO soda.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758104AbYDKJKS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 Apr 2008 05:10:18 -0400
Content-class: urn:content-classes:message
In-Reply-To: <1207902516-6374-1-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <felipe.balbi@nokia.com>, linux-omap@vger.kernel.org

Nice job! :)

By the way, how did you manage to get a list of checkpatch ERRORS and WARNINGS on a set of files?
Did you do a compare with /dev/null or is there a better way?

Regards,
Anand

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org 
> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Felipe Balbi
> Sent: Friday, April 11, 2008 1:58 PM
> To: linux-omap@vger.kernel.org
> Cc: Felipe Balbi
> Subject: [PATCH 00/23] General checkpatch.pl cleanup for twl 
> and musb drivers
> 
> The following series gets rid of checkpatch.pl ERRORS and WARNINGS
> for both twl4030 and musb drivers. I left some WARNINGS in musb_core.c
> because fixing them would decrease the code readability. Line 
> was only one
> character over the 80 max so it didn't make sense to fix that.
> 
> Felipe Balbi (23):
>   I2C: TWL4030: checkpatch.pl fixes for twl4030-core.c
>   I2C: TWL4030: checkpatch.pl fixes for twl4030-usb.c
>   I2C: TWL4030: checkpatch.pl fixes for twl4030-gpio.c
>   I2C: TWL4030: checkpatch.pl fixes to tlw4030.h
>   I2C: TLW4030: checkpatch.pl fixes to tlw4030-rtc.h
>   I2C: TWL4030: checkpatch.pl fixes to rtc-twl4030.c
>   USB: MUSB: checkpatch.pl fixes to cppi_dma.c
>   USB: MUSB: checkpatch.pl fixes to davinci.c
>   USB: MUSB: checkpatch.pl fixed to musb_core.c
>   USB: MUSB: checkpatch.pl fixes to musb_gadget.c
>   USB: MUSB: checkpatch.pl fixed to musb_gadget_ep0.c
>   USB: MUSB: checkpatch.pl fixed to musb_host.c
>   USB: MUSB: checkpatch.pl fixed to musb_procfs.c
>   USB: MUSB: checkpatch.pl fixes to musb_virthub.c
>   USB: MUSB: checkpatch.pl fixes to musbhsdma.c
>   USB: MUSB: checkpatch.pl fixes to omap2430.c
>   USB: MUSB: checkpatch.pl fixes to tusb6010.c
>   USB: MUSB: checkpatch.pl fixes to tusb6010_omap.c
>   USB: MUSB: checkpatch.pl fixes to davinci.h
>   USB: MUSB: checkpatch.pl fixes to musb_core.h
>   USB: MUSB: checkpatch.pl fixes to musb_io.h
>   USB: MUSB: checkpatch.pl fixed to musb_regs.h
>   USB: MUSB: checkpatch.pl fixes to musb_debug.h
> 
>  drivers/i2c/chips/twl4030-core.c   |   61 
> +++++++++++++---------------
>  drivers/i2c/chips/twl4030-gpio.c   |   37 ++++++++---------
>  drivers/i2c/chips/twl4030-usb.c    |    3 +-
>  drivers/rtc/rtc-twl4030.c          |   77 
> ++++++++++++++++++-----------------
>  drivers/usb/musb/cppi_dma.c        |    2 +-
>  drivers/usb/musb/davinci.c         |    8 ++--
>  drivers/usb/musb/davinci.h         |    4 +-
>  drivers/usb/musb/musb_core.c       |   35 +++++++---------
>  drivers/usb/musb/musb_core.h       |   10 ++--
>  drivers/usb/musb/musb_debug.h      |   14 +++---
>  drivers/usb/musb/musb_gadget.c     |   13 +++---
>  drivers/usb/musb/musb_gadget_ep0.c |    2 +-
>  drivers/usb/musb/musb_host.c       |   26 ++++++------
>  drivers/usb/musb/musb_io.h         |    2 +-
>  drivers/usb/musb/musb_procfs.c     |    8 ++--
>  drivers/usb/musb/musb_regs.h       |   22 +++++-----
>  drivers/usb/musb/musb_virthub.c    |    4 +-
>  drivers/usb/musb/musbhsdma.c       |   17 ++++----
>  drivers/usb/musb/omap2430.c        |    2 +-
>  drivers/usb/musb/tusb6010.c        |   12 +++---
>  drivers/usb/musb/tusb6010_omap.c   |   13 +++---
>  include/linux/i2c/twl4030-rtc.h    |    4 +-
>  include/linux/i2c/twl4030.h        |    6 +-
>  23 files changed, 186 insertions(+), 196 deletions(-)
> 
> --
> To unsubscribe from this list: send the line "unsubscribe 
> linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
