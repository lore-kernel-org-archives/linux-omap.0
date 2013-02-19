From: Kevin Hilman <khilman@linaro.org>
Subject: Re: [RFC/NOT FOR MERGING 2/3] serial: omap: remove hwmod dependency
Date: Tue, 19 Feb 2013 11:16:38 -0800
Message-ID: <87ppzww1ux.fsf@linaro.org>
References: <1360840554-26901-1-git-send-email-balbi@ti.com>
	<1360840554-26901-2-git-send-email-balbi@ti.com>
	<20130214171253.GC7144@atomide.com>
	<20130214175650.GA25891@arwen.pp.htv.fi>
	<20130214181217.GA11806@atomide.com>
	<20130214192719.GB26679@arwen.pp.htv.fi>
	<20130214193911.GD11806@atomide.com>
	<alpine.DEB.2.00.1302141946110.11016@utopia.booyaka.com>
	<20130214222247.GE11362@atomide.com>
	<alpine.DEB.2.00.1302191516150.32069@utopia.booyaka.com>
	<20130219163820.GF5724@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:51362 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933885Ab3BSTQm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 Feb 2013 14:16:42 -0500
Received: by mail-pa0-f54.google.com with SMTP id fa10so3566857pad.27
        for <linux-omap@vger.kernel.org>; Tue, 19 Feb 2013 11:16:41 -0800 (PST)
In-Reply-To: <20130219163820.GF5724@atomide.com> (Tony Lindgren's message of
	"Tue, 19 Feb 2013 08:38:20 -0800")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Paul Walmsley <paul@pwsan.com>, Felipe Balbi <balbi@ti.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>

[...]

>> > Just to recap what we've discussed earlier, the reasons why we want
>> > reset and idle functions should be in the driver specific header are:
>> > 
>> > 1. There's often driver specific logic needed in addition to the
>> >    syconfig tinkering in the reset/idle functions.
>> 
>> It's been a while since I last tabulated this.  But my recollection was 
>> that some kind of IP block-specific reset code is needed for about 7% to 
>> 10% of the OMAP IP blocks.
>
> Yes it's not too many, but the issue there is the driver specific code
> that's duplicated in both places. And sounds like the solution to that
> is to make driver specific reset code a static inline function in the
> driver header as discussed earlier so bus code can call it when there's
> no driver loaded.

This thread is going in many directions and I've lost track.  

I think we need to separate out the specific reset cases and look at
examples, since there are not very many (in theory).  Specifically, IMO,
we need to separate out the init-time reset needs from the runtime reset
needs.

It seems to me that init-time reset issues can (and should) be handled
by omap_device/omap_hwmod.  For devices with drivers, this can be done
easily before driver probe (using bus notifiers).  Any remaining devices
that specifically need reset can be reset later (which devices are
these?)

The other problem is the where reset is need during runtime.  Again,
what are the specific examples here?  The one I can think of off the top
of my head is I2C, where it's needed in certain error recovery
scenarios.

Here, we need a way for the driver itself to initiate a full reset.
Maybe a new runtime PM hook like ->runtime_reset() as Felipe has
suggested (though I'm not yet sure runtime PM is the right place for
this, since it's not strictly related to runtime PM).  Or, if these are
mostly corner-case, error recovery scenarios, maybe a a way force the
driver to remove itself and re-probe (which would trigger the
bus-notifier based reset) as Tony has suggested is the better approach.

Either way, it would be good to summarize the devices that need this to
be sure what the actual needs are.

The OMAP I2C driver is doing a reset and fully re-initializing itself,
so it seems the forced remove/probe is the right approach there.  Any
one have the other use cases handy?

Kevin
