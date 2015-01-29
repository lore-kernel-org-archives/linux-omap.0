From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 1/7] extcon: usb-gpio: Introduce gpio usb extcon driver
Date: Thu, 29 Jan 2015 08:56:26 -0800
Message-ID: <20150129165625.GB16250@atomide.com>
References: <1422274532-9488-1-git-send-email-rogerq@ti.com>
 <1422274532-9488-2-git-send-email-rogerq@ti.com>
 <CAGTfZH3nmpUGgFJ6RU+xH8tuDkGBFA-NbXWa0CSXZXR+DXrbkQ@mail.gmail.com>
 <54C66B0D.9040109@ti.com>
 <54C6EFC8.1090601@samsung.com>
 <54C7B0E5.20101@ti.com>
 <54C8472B.6070302@samsung.com>
 <54C8D238.4080001@ti.com>
 <20150128170954.GQ28663@atomide.com>
 <54CA1A12.5080507@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp4.ore.mailhop.org ([54.149.240.58]:48754 "EHLO
	smtp4.ore.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753623AbbA2Q70 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 29 Jan 2015 11:59:26 -0500
Content-Disposition: inline
In-Reply-To: <54CA1A12.5080507@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: Chanwoo Choi <cw00.choi@samsung.com>, Felipe Balbi <balbi@ti.com>, "myungjoo.ham@samsung.com" <myungjoo.ham@samsung.com>, george.cherian@ti.com, nsekhar@ti.com, devicetree <devicetree@vger.kernel.org>, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>

* Roger Quadros <rogerq@ti.com> [150129 03:34]:
> On 28/01/15 19:09, Tony Lindgren wrote:
> > * Roger Quadros <rogerq@ti.com> [150128 04:15]:
> >> On 28/01/15 04:19, Chanwoo Choi wrote:
> >>>>
> >>>> I still fail to understand that we need to call disable_irq() in .suspend() and
> >>>> enable_irq() in .resume()
> >>>>
> >>>> can you point me to any other drivers doing so?
> >>>
> >>> You can refer the suspend function in drivers/mfd/max14577.c or drivers/mfd/max77693.c.
> >>> The max14577_suspend() includes the detailed comment for why using disable_irq() in suspend function.
> >>>
> >>> In max14577 case, max14577_suspend() use disable_irq() function because of i2c dependency.
> >>> If max14577 device is wake-up from suspend state before completing the resume sequence
> >>> of i2c, max14577 may fail to read/write i2c communication.
> >>
> >> Thanks for this information. I will add disable/enable_irq() in suspend/resume().
> > 
> > Are the .dts changes safe for me to apply already?
> > 
> 
> Yes Tony, you can pick them. Thanks.

OK will apply the dts changes into omap-for-v3.20/dt thanks.
I have also the defconfig changes tagged, will apply those
a bit later probably as a fix after the driver is merged.

Regards,

Tony
