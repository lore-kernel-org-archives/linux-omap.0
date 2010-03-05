From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: usb_nop_xceiv_register() missing when OTG built as modules
Date: Fri, 05 Mar 2010 14:02:32 -0800
Message-ID: <87y6i6zatj.fsf@deeprootsystems.com>
References: <87635d54nn.fsf@deeprootsystems.com>
	<19F8576C6E063C45BE387C64729E7394044DB7B6BD@dbde02.ent.ti.com>
	<87eik03scn.fsf@deeprootsystems.com>
	<20100305090426.GG12757@nokia.com>
	<871vfy3azr.fsf@deeprootsystems.com>
	<558f5bffd42210a777154737d6730232@secure211.sgcpanel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f212.google.com ([209.85.219.212]:61652 "EHLO
	mail-ew0-f212.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755614Ab0CEWCi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Mar 2010 17:02:38 -0500
Received: by ewy4 with SMTP id 4so2736436ewy.28
        for <linux-omap@vger.kernel.org>; Fri, 05 Mar 2010 14:02:37 -0800 (PST)
In-Reply-To: <558f5bffd42210a777154737d6730232@secure211.sgcpanel.com> (me@felipebalbi.com's message of "Fri\, 05 Mar 2010 13\:54\:04 -0600")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: me@felipebalbi.com
Cc: felipe.balbi@nokia.com, "Gupta, Ajay Kumar" <ajay.gupta@ti.com>, linux-omap@vger.kernel.org

<me@felipebalbi.com> writes:

> On Fri, 05 Mar 2010 09:59:52 -0800, Kevin Hilman
>> It would be my fault if I wrote those board files.  ;)
>
> sure, sorry. Maybe I didn't express myself really well.
>
>>> I suggest you keep usb as a module, but keep nop xceiv built-in.
>> 
>> Yes, that's the workaround I'm already using, but it is not a fix.
>> 
>> This dependency breaks the ability to build a minimal kernel with
>> everything as modules (allmodconfig)
>
> now this is a really good point. Haven't thought that way...
>
>> The nop xceiv needs a way for built-in code to register itself for
>> the cases when no xceiv is built as a module.
>
> when way to do that is not to use usb_nop_xceiv_register() and
> add the platform_device to the board-files. I never really liked
> the whole usb_nop_xceiv_register() hackery. Almost all board-files
> have a list of platform_devices which get added by platform_add_devices()
> anyways, so why not using that ??
>
> to me the usb_nop_xceiv_register() thing is just a lazy way of
> defining platform_devices. Specially one that takes some 3
> lines of code only.

Completely agree.  I didn't take the time to look into the USB code to
see if a simple plaform device creation would fix this.

If so, any chance of a patch for OMAP3EVM and 4430SDP?

I'll be happy to test on OMAP3EVM, but don't have a 4430.

Kevin

