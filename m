From: Paul Walmsley <paul@pwsan.com>
Subject: Re: DSS2/PM on 3.2 broken?
Date: Fri, 13 Jan 2012 04:31:37 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1201130423280.3659@utopia.booyaka.com>
References: <WC20120109124643.880164@terrafix.co.uk> <20120110080849.5a242adf@notabene.brown> <alpine.DEB.2.00.1201110632100.31702@utopia.booyaka.com> <20120112095940.0a54413e@notabene.brown> <alpine.DEB.2.00.1201130253070.3659@utopia.booyaka.com>
 <20120113222045.37f9b4ec@notabene.brown>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:41133 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752866Ab2AMLbi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 13 Jan 2012 06:31:38 -0500
In-Reply-To: <20120113222045.37f9b4ec@notabene.brown>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: NeilBrown <neilb@suse.de>
Cc: Joe Woodward <jw@terrafix.co.uk>, khilman@ti.com, t-kristo@ti.com, govindraj.raja@ti.com, linux-omap@vger.kernel.org

On Fri, 13 Jan 2012, NeilBrown wrote:

> Also, the HDQ access to the battery 'fuel gauge' is working fine, so
> presumably that gets disturbed by one of the lower power states (3,4,5).
> I guess it is 4,5,6 when CORE goes to RET or OFF.  So we need some way for
> HDQ to say "I'm busy" just like UART can.  omap_hdq_can_sleep() ???
> There must be a cleaner way...

The first thing to try is the HDQ runtime PM conversion series that was 
sent separately.  Maybe let us know if that fixes the problem.

> More experiments:
>  - I enabled off_mode and started seeing state3 happening.  UART and HDQ
>    still fine - as expected.
>  - I set the  /sys/devices/system/cpu/cpu0/cpuidle/state?/usage values
>    all to '10'.
>    Now things start to break;
>    Console is mostly OK, but the first char after 10 seconds of idle is bad.
>    I type 'enter' and get 'C'.  In general the first char typed is mapped to
>    something else in a consistent way:
>       0a -> c3
>       20 -> 90
>       55 -> d5
>       2a -> 95
>    It is a bit like we are missing a start bit, and a stop bit is shifting
>    down into the msb .. sometimes.

I'm not seeing garbling at all on the OMAP3 BeagleBoard here, running v3.2 
with omap2plus_defconfig.  The first character from the console gets lost, 
which again is expected when the CORE enters a low-power state and there's 
no flow control on the serial interface -- but no garbling.

>    HDQ also breaks.
>    That surprised me a bit as the HDQ access is immediately after typing so
>    it should be in the 10-second timeout when the UART keeps CORE powered on.
>    Maybe we need runtime_pm to run omap_hdq_break() again to reinitialise
>    the HDQ port if CORE might have been turned off.
> 
>    Also saw states all the way down to 6.  Cannot tell if this helps current
>    drain as I need HDQ working for that.

If CORE is going off, the HDQ device context will be lost, since the HDQ 
controller will be powered off.  You'll need to add code to either save 
and restore the HDQ register context into the HDQ driver, or to 
reinitialize the HDQ when it is re-enabled.  The latter is what we do for 
I2C, I think.

As far as the DSS goes, your best bet there is to try to work it out with 
Archit and Tomi.

> Thanks for the patch, it's been:
>    Tested-by: NeilBrown <neilb@suse.de>

Thanks.


- Paul
