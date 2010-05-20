From: Wim Van Sebroeck <wim@iguana.be>
Subject: Re: [PATCH] twl4030_wdt: Disable watchdog while probing
Date: Thu, 20 May 2010 09:46:30 +0200
Message-ID: <20100520074630.GN4008@infomag.iguana.be>
References: <7fcfe2bbdbad2e7c330c219fa1e27497a5fd0f89.1274094577.git.ameya.palande@nokia.com> <1274333988.30871.17.camel@sarki.nmp.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mailrelay007.isp.belgacom.be ([195.238.6.173]:34559 "EHLO
	mailrelay007.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754407Ab0ETHqc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 20 May 2010 03:46:32 -0400
Content-Disposition: inline
In-Reply-To: <1274333988.30871.17.camel@sarki.nmp.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Timo Kokkonen <timo.t.kokkonen@nokia.com>
Cc: "Palande Ameya (Nokia-D/Helsinki)" <ameya.palande@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Timo,

> It seems that in this patch, you disable the watchdog regardless whether
> the registration fails or not. I wonder if this is a good thing to do.
> What if the bootloader have already enabled the watchdog and then user
> space booting fails for some reason before any process is able to open
> and re-enable the watchdog? We could end up with a hung system that does
> not have the watchdog enabled. Maybe we should disable the watchdog only
> in case the registration actually fails?
> 
> And even in that case, do we want to disable the watchdog? What are the
> situations where watchdog registration can fail? Is there a possibility
> that we would like to leave watchdog running in such case and cause a
> reboot (say, something bad happened before the watchdog module was
> loaded and the system ran out of memory, which causes watchdog
> registration to fail)?
> 
> Maybe there is something I've missed, but this kind of questions came in
> my mind..

The default behaviour should be to stop the watchdog. "Why?" you will
probably ask.
Let's first take a step back and go to the basis of the watchdog userspace API.
In essence userspace start the watchdog by opening /dev/watchdog, then pings
the watchdog by writing to /dev/watchdog and stops the watchdog when
/dev/watchdog is being closed. That's the basis of the API and it does mean
that the watchdog should not be running unless userspace starts the watchdog
by opening /dev/watchdog.
Later on ioctl calls have been added to extend functionality, we also added
extra feautures like the Magic Close feauture (so that a close is not always
stopping the watchdog - this to prevent userspace daemon crashes) and the
nowayout feature (to prevent a watchdog from being stopped once started).
So default is that the watchdog doesn't work unless userspace starts it.

That's the API like it is now. So let's take a second step back and look at
why we want/need watchdog's: we want them to make sure that our systems can
reboot when the systems becomes unstable and "crashes". The decision to reboot
a system actually is driven by userspace: if userspace pings the watchdog
then we now the system is stable enough, if not then we reboot.
And that's why we have a grey zone: userspace control is only there after the
system has booted. And the system is only booted and available for userspace
after the filesystem checks are done. So that's why in the past the people
that wrote the first watchdog's disabled all watchdog's before userspace
was able to control the watchdog: you didn't want (and in most cases still
don't want) your system to be rebooted during a filesystem check (because
after the reboot, the filesystem will have to be checked again which could
result in an endless loop). And this still is the default behaviour.

On the other hand: systems are faster, we have other types of filesystems,
we use flash-drives, ... . So for some embedded systems you might want
to secure booting in a different way then what we used to do on traditional
systems. The way I see it is to add a module_parameter that allows you
to have the driver keep the watchdog active on start and don't stop it.
The default behaviour would be to stop the watchdog, but it gives you the
possibility to override the default. This is how I was adding this to
the generic watchdog framework. (I'm doing some last veryfications before
releasing it for comments).

I hope the reasoning is clearer now and that your questions are answered.
(If not, just let me know which questions you still have).

=> bottom line: this patch adds the correct default behaviour and should
not be changed. Feel free to add the module-parameter to keep the watchog
running at start.

Kind regards,
Wim.

