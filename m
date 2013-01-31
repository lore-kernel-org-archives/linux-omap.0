From: Paul Walmsley <paul@pwsan.com>
Subject: Re: OMAP4 PM bootloader dependency problems
Date: Thu, 31 Jan 2013 15:21:27 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1301311416360.23099@utopia.booyaka.com>
References: <alpine.DEB.2.00.1301220229140.25789@utopia.booyaka.com>  <alpine.DEB.2.00.1301301706580.17105@utopia.booyaka.com> <1359622829.10415.40.camel@sokoban>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:52275 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751458Ab3AaPV2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 31 Jan 2013 10:21:28 -0500
In-Reply-To: <1359622829.10415.40.camel@sokoban>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: rnayak@ti.com, santosh.shilimkar@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, khilman@deeprootsystems.com

Hi,

On Thu, 31 Jan 2013, Tero Kristo wrote:

> Personally I don't like too much to have just extra spam during boot,
> which in many cases is even unnecessary (e.g. people who actually have
> good u-boot in use.)

The impact of two or three informative lines sent to the kernel console on 
boot is lower than the cost of people spending hours trying to figure out 
why chip retention idle doesn't work.

Linux distributions that control the bootloader version can easily 
comment out the warning.

I'm hoping the console messages will inspire someone out there to fix the 
root cause of the problem -- that the kernel is missing device 
reset and initialization code for several OMAP4 devices.

> Personally I would like to have some sort of test during boot which 
> detects broken PM and maybe prevents core idle completely if this is the 
> case.

As far as I know, a simple, clean test for this that can be merged 
right now doesn't exist, and has never been posted to the lists.

Personally, it's unclear how such a test can be implemented reliably.  
You've proposed checking IP block idle/standby states during PM init in 
previous E-mails.  But the problem with this is that those IP blocks might 
already be in use by their drivers by the time the OMAP4 PM code 
initializes.

It's also important to keep in mind that adding any significant amount of 
new code this late in the 3.8-rc cycle is not acceptable for my upstreams.

That said, if you have a clean, reliable, and short solution for this, 
please post it by the end of the week.

> Alternatively we can add extra info to the failed suspend dump and 
> mention a good u-boot to try out (v2012-07 or newer.)

Folks might be using dynamic idle, so just adding a message on resume from 
suspend isn't enough.

> If we could detect boot loader version from kernel side, that would work
> also.

I haven't seen any proposals for how to do this.  Even if one were 
available, it would require maintaining kernel blacklists.  Considering 
that the fault is in the kernel OMAP4 integration code and data, adding 
such a blacklist seems like the wrong approach.

...

In any case, all of the options that you've mentioned are workarounds, not 
real solutions.  Fixing the root cause would involve adding reset and 
initialization code for the remaining devices.  No one is working on this 
as far as I'm aware.  And even if they were, it would be too much code to 
add during the v3.8-rc fixes cycle.

I understand that you don't want to add an unconditional message on boot.  
But right now, it's the best approach.  Please post a patch for this by 
the end of this week that I or Kevin can send upstream ASAP.


regards,

- Paul
