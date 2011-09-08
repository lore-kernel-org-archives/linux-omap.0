From: Kevin Hilman <khilman@ti.com>
Subject: Re: [linux-pm] Issue: Runtime API usage in wake-up device irq_handler during wakeup from system-wide-suspend.
Date: Thu, 08 Sep 2011 06:51:01 -0700
Message-ID: <87d3fbm9bu.fsf@ti.com>
References: <Pine.LNX.4.44L0.1108271537300.21403-100000@netrider.rowland.org>
	<1315410513.2679.9.camel@sokoban> <87fwk8qllx.fsf@ti.com>
	<1315457911.2679.19.camel@sokoban>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:59323 "EHLO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932789Ab1IHNvI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Sep 2011 09:51:08 -0400
Received: by mail-gw0-f49.google.com with SMTP id 1so1044261gwb.22
        for <linux-omap@vger.kernel.org>; Thu, 08 Sep 2011 06:51:06 -0700 (PDT)
In-Reply-To: <1315457911.2679.19.camel@sokoban> (Tero Kristo's message of
	"Thu, 8 Sep 2011 07:58:31 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: t-kristo@ti.com
Cc: Alan Stern <stern@rowland.harvard.edu>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "R, Govindraj" <govindraj.raja@ti.com>, "Basak, Partha" <p-basak2@ti.com>, "Balbi, Felipe" <balbi@ti.com>, "Munegowda, Keshava" <keshava_mgowda@ti.com>, linux-pm@lists.linux-foundation.org, linux-omap@vger.kernel.org

Hi Tero,

Tero Kristo <t-kristo@ti.com> writes:

> On Wed, 2011-09-07 at 19:59 +0200, Hilman, Kevin wrote:
>> Tero Kristo <t-kristo@ti.com> writes:

[...]

>> > After thinking about this problem and looking at possible ways to fix
>> > it, I am planning to change the PRCM chain handler to be a driver, which
>> > gets suspended along with the rest of the system. This means the PRCM
>> > interrupt would get disabled also during this time, and it would be
>> > enabled in the driver->complete() call, which should happen after rest
>> > of the drivers have been able to enable their PM runtime in the
>> > driver->resume() call chain. Do you see any problems with this approach?
>> 
>> How will the system wakeup from retention or off-mode if the PRCM IRQ is
>> disabled?
>
> This is actually some sort of an issue with retention if we disable PRCM
> irq completely, off works purely with wakeup signals as we come out of
> reset. Anyway, I did some experimentation with this, and OMAP3 is able
> to wake up if we leave WKUP irq up, but disable IO chain irq. IO chain
> events seem to trigger a WKUP event also always, we just postpone the
> processing of IO chain until later. I had to also split the wakeup
> clearing for OMAP3 into 2 parts, one part handles wakeups and another IO
> chain. Currently both IO chain and WKUP are acked by the same handler.

Here's another option, which is kind of a hybrid of what's been
discussed so far.

The PRCM driver would leave the IRQs enabled during suspend, but would
just delay delivering them to the drivers.  IOW, handle/clear the PRCM
IRQ normally, but delay delivery of the *device* IRQ until the
->complete callback of the PRCM driver.

Doing this ensures all the drivers are resumed before any device IRQ is
delivered, and doesn't require any additional queuing of events in the
drivers.

Kevin
