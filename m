From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: Padconf not working on pm_defconfig?
Date: Mon, 14 Dec 2009 08:54:19 -0800
Message-ID: <87fx7dcx8k.fsf@deeprootsystems.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB030ADD4EFC@dbde02.ent.ti.com>
	<19F8576C6E063C45BE387C64729E739404372AAB54@dbde02.ent.ti.com>
	<5A47E75E594F054BAF48C5E4FC4B92AB030ADD4F0F@dbde02.ent.ti.com>
	<5A47E75E594F054BAF48C5E4FC4B92AB030ADD4F23@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f42.google.com ([209.85.160.42]:61265 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756711AbZLNQyX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 14 Dec 2009 11:54:23 -0500
Received: by pwj9 with SMTP id 9so2030330pwj.21
        for <linux-omap@vger.kernel.org>; Mon, 14 Dec 2009 08:54:22 -0800 (PST)
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB030ADD4F23@dbde02.ent.ti.com> (Anand Gadiyar's message of "Mon\, 14 Dec 2009 15\:53\:44 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gadiyar, Anand" <gadiyar@ti.com>
Cc: "Gupta, Ajay Kumar" <ajay.gupta@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Peter De Schrijver <peter.de-schrijver@nokia.com>

"Gadiyar, Anand" <gadiyar@ti.com> writes:

> Gadiyar, Anand wrote:
>> Gupta, Ajay Kumar wrote:
>> > > 
>> > > I'm seeing some strange behavior with linux-omap-pm branch
>> > > and possibly with linux-omap master as well. I booted up
>> > > a 3430 SDP with an image built using omap3_pm_defconfig.
>> > > (I enabled EHCI in the menuconfig).
>> > 
>> > Check if CONFIG_OMAP_MUX=y set.
>> > 
>> 
>> It's set.
>> 
>> Also, dumping the registers just after the usb-echi.c makes
>> these mux calls shows they are okay.
>> 
>> Something seems to be changing these later - debugging now.
>> 
>
>
> Found it - I remember that these lines are muxed with ETK signals
> and with the hwdebug signals.
>
> So I looked at the debobs driver - and that's the culprit!
> (Cc-ing the author of that driver)
>
> How should this be handled? IMO, this driver has should use the
> MUX framework for changing the mux modes.
>
> What say?

Yes, the debobs driver needs to be updated to use the MUX API.

But even with that, AFAICT, the new mux API will still allow
the last caller to "win" as there is no request/free API
to get pins.

Kevin

