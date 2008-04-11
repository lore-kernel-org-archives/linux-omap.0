From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/2] sparse warnings
Date: Fri, 11 Apr 2008 12:05:14 -0700
Message-ID: <20080411190513.GE7717@atomide.com>
References: <1207911557-9392-1-git-send-email-felipe.balbi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-bos.mailhop.org ([63.208.196.179]:62198 "EHLO
	mho-02-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760229AbYDKTFQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 Apr 2008 15:05:16 -0400
Content-Disposition: inline
In-Reply-To: <1207911557-9392-1-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <felipe.balbi@nokia.com>
Cc: linux-omap@vger.kernel.org

* Felipe Balbi <felipe.balbi@nokia.com> [080411 04:00]:
> The following two patches get rids of most sparse warnings
> in musb and twl4030 drivers.
> 
> Some of them still there because it didn't make sense fixing.
> The most notable case is the preprocessor macros in the pr_info()
> at musb_init() and lack of use of twl4030*gpio*() at twl4030-gpio.c.

Pushing these too.

Tony

> Felipe Balbi (2):
>   USB: MUSB: sparse fixes to musb_hdrc driver
>   I2C: TWL4030: sparse fixes for twl4030 driver
> 
>  drivers/i2c/chips/twl4030-core.c     |    2 +-
>  drivers/i2c/chips/twl4030-gpio.c     |   53 ++++++++++++++++------------------
>  drivers/i2c/chips/twl4030-poweroff.c |    2 +-
>  drivers/usb/musb/musb_host.c         |    6 ++--
>  drivers/usb/musb/musbhsdma.c         |    6 ++--
>  5 files changed, 33 insertions(+), 36 deletions(-)
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
