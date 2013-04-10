From: Kevin Hilman <khilman@linaro.org>
Subject: Re: [PATCHv3] driver: serial: prevent UART console idle on suspend while using "no_console_suspend"
Date: Wed, 10 Apr 2013 14:26:17 -0700
Message-ID: <87bo9myt52.fsf@linaro.org>
References: <1365167733-28083-1-git-send-email-sourav.poddar@ti.com>
	<87mwtclvua.fsf@linaro.org> <516463D2.2070008@ti.com>
	<87obdnh6au.fsf@linaro.org> <516501A0.4000004@ti.com>
	<B5906170F1614E41A8A28DE3B8D121433ED96446@DBDE01.ent.ti.com>
	<51653450.2010200@ti.com>
	<B5906170F1614E41A8A28DE3B8D121433ED96C45@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pd0-f173.google.com ([209.85.192.173]:49606 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936609Ab3DJV0V (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Apr 2013 17:26:21 -0400
Received: by mail-pd0-f173.google.com with SMTP id v14so486347pde.4
        for <linux-omap@vger.kernel.org>; Wed, 10 Apr 2013 14:26:21 -0700 (PDT)
In-Reply-To: <B5906170F1614E41A8A28DE3B8D121433ED96C45@DBDE01.ent.ti.com>
	(Vaibhav Bedia's message of "Wed, 10 Apr 2013 11:26:56 +0000")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Bedia, Vaibhav" <vaibhav.bedia@ti.com>
Cc: "Poddar, Sourav" <sourav.poddar@ti.com>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "tony@atomide.com" <tony@atomide.com>, "rmk+kernel@arm.linux.org.uk" <rmk+kernel@arm.linux.org.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "Balbi, Felipe" <balbi@ti.com>, "Nayak, Rajendra" <rnayak@ti.com>

"Bedia, Vaibhav" <vaibhav.bedia@ti.com> writes:

> Hi Sourav,
>
> On Wed, Apr 10, 2013 at 15:13:44, Poddar, Sourav wrote:
> [...]
>> Yes, had a look at that and found your situation similar to UART.
>> 
>> But how exactly this gets used, I mean I don't  see any drivers/ in mainline
>> making use of this compatible string  "ti,am3352-ocmcram".  ?
>
> OCMC clock is enabled during bootup (not sure whether that's the h/w
> default or ROM does it) since the initial bootloader runs from there.
> By marking the corresponding hwmod with HWMOD_INIT_NO_IDLE we leave the
> clock running. Right now the sram code under arch/arm/plat-omap/ is what
> manages the OCMC. I guess this needs to move somewhere under drivers/
> and start managing the clocks. Even then we'll need a mechanism
> to leave the clocks running as part of the kernel suspend process
> since the assembly code which runs at the fag end of the suspend
> process runs out of OCMC and hence we can't cut its clock.
>
> On AM335x, the OCMC clock is cut to have PER power domain transition
> but that's done in the WKUP-M3 firmware when going down. During the
> wakeup sequence, WKUP-M3 re-enables the OCMC clock so that when the
> kernel resumes the h/w state is same.

OK, but *today*, in *mainline*, where in the linux kernel (not the M3
firmware) is the OCMRAM clock cut during suspend?

>From what I can see, there is no driver for this device, so there are no
system PM calls being done for that device, and thus no omap_device
calls being done for that device, so the no_idle_on_suspend has no
effect.

Kevin
