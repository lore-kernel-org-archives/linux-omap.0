From: "Remith Ravi" <remith@mistralsolutions.com>
Subject: Re: OMAP3530 EVM Sources are on linux.omap.com
Date: Thu, 15 May 2008 21:02:59 +0530
Message-ID: <814dfab70805150832x4f1ffb04ue24a591497ec8cb4@mail.gmail.com>
References: <0680EC522D0CC943BC586913CF3768C001578E8398@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ti-out-0910.google.com ([209.85.142.188]:29733 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932580AbYEOPdC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 15 May 2008 11:33:02 -0400
Received: by ti-out-0910.google.com with SMTP id b6so233003tic.23
        for <linux-omap@vger.kernel.org>; Thu, 15 May 2008 08:32:59 -0700 (PDT)
In-Reply-To: <0680EC522D0CC943BC586913CF3768C001578E8398@dbde02.ent.ti.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Syed Mohammed, Khasim" <khasim@ti.com>, remith@mistralsolutions.com
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Khasim,

After running the power management command ' echo "mem" >
/sys/power/state '  the OMAP3430EVM entered into suspend state.

Now what I have to do to make the system resume the normal state? I
tried pressing some keys but it didn't help.

Regards,
Remith
Mistral Solutions.


On Mon, May 12, 2008 at 4:29 PM, Syed Mohammed, Khasim <khasim@ti.com> wrote:
> Hello all:
>
> We have uploaded OMAP3530 EVM sources on linux.omap.com
>
> x-loader               : http://linux.omap.com/pub/xloader/3530evm/
> u-boot-1.1.4           : http://linux.omap.com/pub/bootloader/3530evm/
> Linux Kernel 2.6.22-18 : http://linux.omap.com/pub/kernel/3530evm/
> Tool Chain used        : Code Sourcery arm-2007q3
>
> Few important features supported in kernel are listed below:
>
> *       ALSA Audio Driver.
> *       Power Management
> *       Supports for NFS file system.
> *       Ethernet.
> *       Frame buffer (FBDEV).
> *       Debug UART port.
> *       DMA framework.
> *       TWL4030 (T2) RTC.
> *       Watchdog driver.
> *       Support T2 Core GPIO.
> *       GPIO.
> *       V4L2 Based Video driver.
> *       Keypad.
> *       HS-I2C.
> *       McBSP.
> *       McSPI.
> *       TouchScreen.
> *       UART library.
> *       High-speed MMC
> *       NAND
> *       USB OTG
> *       TV out.
> *       Clock framework with device driver adaptation
>
> Platform description can be found here,
> http://focus.ti.com/general/docs/wtbu/wtbusplashcontent.tsp?templateId=6123&contentId=4750#omap3530
>
> Regards,
> Khasim
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
