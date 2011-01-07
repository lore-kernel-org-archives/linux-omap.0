From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: RE: 4430SDP boot failure
Date: Fri, 7 Jan 2011 15:22:56 +0530
Message-ID: <86f60bc5418ca1d3e87db960e5e2c48f@mail.gmail.com>
References: <20110106170805.GE1198@n2100.arm.linux.org.uk> <20110106180030.GA8249@n2100.arm.linux.org.uk>
 <20110106182023.GV7771@atomide.com> <20110106195225.GX7771@atomide.com>
 <20110106203431.GZ7771@atomide.com> <20110106205107.GI1198@n2100.arm.linux.org.uk>
 <20110106235203.GA14425@n2100.arm.linux.org.uk> <d540408e2df154cf13932e79d3a11ceb@mail.gmail.com>
 <20110107092800.GJ1198@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:54494 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754444Ab1AGJw7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Jan 2011 04:52:59 -0500
Received: by fxm2 with SMTP id 2so16597472fxm.35
        for <linux-omap@vger.kernel.org>; Fri, 07 Jan 2011 01:52:58 -0800 (PST)
In-Reply-To: <20110107092800.GJ1198@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>

> -----Original Message-----
> From: Russell King - ARM Linux [mailto:linux@arm.linux.org.uk]
> Sent: Friday, January 07, 2011 2:58 PM
> To: Santosh Shilimkar
> Cc: linux-omap@vger.kernel.org; Tony Lindgren
> Subject: Re: 4430SDP boot failure
>
> On Fri, Jan 07, 2011 at 02:09:17PM +0530, Santosh Shilimkar wrote:
> > > Can we _please_ have a version of uboot for the SDP4430 platform
> > > which
> > > can be configured at runtime _and_ which is capable of DHCP/TFTP
> ?
> > > I really don't want to mess about anymore with buggy boot
> loaders.
> > Just read this thread. Looks like you are not able to boot the
> kernel
> > at all. 2.6.37 + Tony's queue booted for me without any issues.
>
> I can only boot older kernels.  I can't debug later kernels because
> as soon as I access the UART, I get this very bland 'X-loader hangs'
> message which is no help what so ever (for the amount of use it is,
> it
> might as well not even print that.)
>
> I don't know whether that's because I'm doing something wrong or
> what as
> there's no way to get any diagnostics out of the system.
>
Ok. Will try 2.6.37 major version.

> The u-boot SD card issues are just another layer of timewasting
> frustration
> which really doesn't help.  I don't want to spend many hours
> debugging
> the boot loader because it also doesn't work properly.  I want
> something
> which works every time without fail.
>
> BTW, if it makes any difference to the boot loader, please note that
> I'm
> still waiting for the upgrade for the SDP board.
That means your board is with ES1.0. I shall try 2.6.37 on
ES1.0
