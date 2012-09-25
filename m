From: Philippe De Swert <philippedeswert@gmail.com>
Subject: Re: [PATCH 1/1] usb: Include generic_interrupt for OMAP2_PLUS
Date: Tue, 25 Sep 2012 12:09:30 +0300
Message-ID: <CAPsFW+T_ezWAxO9StSf9cu9nJ6Gw8T9Dk1H3g6+bwJ-PKtn-cQ@mail.gmail.com>
References: <1348487604-7202-1-git-send-email-philippe.deswert@jollamobile.com>
	<20120924121538.GH2892@arwen.pp.htv.fi>
	<CAPsFW+RTLpgXFOOh9fD=K1wCPMpBe4MummhWoqEBEEYYzMay=Q@mail.gmail.com>
	<20120924130216.GA5603@arwen.pp.htv.fi>
	<20120924160914.GB28835@atomide.com>
	<20120925080420.GH9137@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:57109 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752009Ab2IYJJc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 25 Sep 2012 05:09:32 -0400
In-Reply-To: <20120925080420.GH9137@arwen.pp.htv.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: Tony Lindgren <tony@atomide.com>, Philippe De Swert <philippe.deswert@jollamobile.com>, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, Sergei Shtylyov <sshtylyov@ru.mvista.com>, heikki.krogerus@linux.intel.com, kishon@ti.com, marek.vasut@gmail.com, leoli@freescale.com, s.hauer@pengutronix.de, shubhrajyoti@ti.com, nsekhar@ti.com, notasas@gmail.com, vikram.pandita@ti.com, ravibabu@ti.com, mina86@mina86.com, praveen.nadahally@stericsson.com, mian.yousaf.kaukab@stericsson.com

Hi,
On 25/09/2012, Felipe Balbi <balbi@ti.com> wrote:
>> > > Not a mention of CONFIG_SOC_OMAP2430 and  CONFIG_SOC_OMAP3430 did not
>> > > get set (while it is not a 3430 but a 3630 I am using). Maybe
>> > > CONFIG_ARCH_OMAP3 would have been a better choice then?
>> >
>> > that's quite f**ked up. Tony, why doesn't SOC_OMAP3430 get set for all
>> > OMAP3 boards ? And another question: why don't we have a matching
>> > SOC_OMAP3530, SOC_OMAP3630 and so on ?
>>
>> ARCH_OMAP3 will probably eventually just disappear and
>> be replaced with ARCH_OMAP2PLUS + SOC_XXXX. But there's
>> no need to do it right now as most of that should be
>> internal to arch/arm/mach-omap2 anyways. I would just
>> set the driver to depend on ARCH_OMAP2PLUS, and rely on
>> the platform_data and DT to do something if specified.
>> That means that on 2420 musb should not probe unless
>> tusb6010 in specified.
>>
>> It seems that things like fifo_mode and generic_interrupt
>> can all be set during the probe based on the platform_data
>> or DT passed information?
>
> Then maybe it's best to just remove the ifdefs and always provide
> generic_interrupt() ?
>
> Anyone against it ?

Well it seems there are only two drivers that use it omap2430 and
ux500. Maybe we somehow link it to the drivers that need it? (I might
have missed other drivers but it looks like it is just those two)

Regards,

Philippe
