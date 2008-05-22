From: "arun c" <arunedarath@mistralsolutions.com>
Subject: Re: omap osk and mistral touchscreen-ads7846
Date: Thu, 22 May 2008 11:46:36 +0530
Message-ID: <c656a4d20805212316jdf9eb72ma62059f8cfc49e82@mail.gmail.com>
References: <a1d91fa0805211540n11fc237dhed8deb988f8cbde4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ti-out-0910.google.com ([209.85.142.189]:41702 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760638AbYEVGQk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 22 May 2008 02:16:40 -0400
Received: by ti-out-0910.google.com with SMTP id b6so1722519tic.23
        for <linux-omap@vger.kernel.org>; Wed, 21 May 2008 23:16:36 -0700 (PDT)
In-Reply-To: <a1d91fa0805211540n11fc237dhed8deb988f8cbde4@mail.gmail.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: mohammed shareef <mdshareef@gmail.com>
Cc: linux-omap@vger.kernel.org

On Thu, May 22, 2008 at 4:10 AM, mohammed shareef <mdshareef@gmail.com> wrote:
> Hello,
>
> i have enabled the SPI and ADS7846 drivers during kernel (2.6.18)
> compilation. i could see in the kernel boot log that they are also
> initialized.
>
> ////////////////////////////////////////////////////////////////////////
> ads7846 spi2.0: touchscreen + hwmon, irq 164
> input: ADS784x Touchscreen as /class/input/input1
> /////////////////////////////////////////////////////////////////////////
> but could someone tell me what should i do next to calibrate my touchscreen?
>
> i even tried compiling tslib and added the executables to the file
> system. But when i run the executable
> /usr/X11/bin/ts_calibrate
>
> i see no response on the LCD. the system just hangs.'
>
> thanx and regards,
> Shareef
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
>

Hi Shareef,

Touch the screen several times and do a cat /proc/interrupts
to check whether the interrupts are coming.

Or you can enable event device debugging in menuconfig
and see the debug messages.

Regards,
Arun C
