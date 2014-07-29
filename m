From: Paul Walmsley <paul@pwsan.com>
Subject: Re: OMAP baseline test results for v3.16-rc4
Date: Tue, 29 Jul 2014 12:32:08 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1407291225070.13035@utopia.booyaka.com>
References: <alpine.DEB.2.02.1407062339420.15016@utopia.booyaka.com> <20140707080238.GF28884@atomide.com> <alpine.DEB.2.02.1407251857480.5875@utopia.booyaka.com> <20140729064243.GF29045@atomide.com> <alpine.DEB.2.02.1407290810160.22957@utopia.booyaka.com>
 <20140729084930.GH29045@atomide.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:39250 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753369AbaG2McJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 29 Jul 2014 08:32:09 -0400
In-Reply-To: <20140729084930.GH29045@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kernel-build-reports@lists.linaro.org

On Tue, 29 Jul 2014, Tony Lindgren wrote:

> * Paul Walmsley <paul@pwsan.com> [140729 01:27]:
> > On Mon, 28 Jul 2014, Tony Lindgren wrote:
> > 
> > > Hmm I think the difference with the working v3.10 one is that you have
> > > root=/dev/mmcblk0p2 instead of root=/dev/nfs. As the Ethernet on beagle
> > > is on the USB EHCI, this is still blocking the deeper idle states AFAIK.
> > 
> > Hmm?  There's no Ethernet on the 3530 Beagle.
> > 
> > The hardware configuration on those two boards - the 37xxevm and 
> > the 3530es3beagle - hasn't changed between the two test runs, AFAIK.
> 
> Oh it's the original beagle, sorry. In that case the uart wake interrupts
> need to be enabled for the serial wake to work. I did not do that as
> I don't have one. I guess that might explain why it fails? Or are you
> using RTC wake for your test?

Serial wake works fine.  But the chip never enters dynamic retention idle 
as measured by the pm_debug/count differential for CORE powerdomain.
Works OK with static suspend.

> Wrong link here :) It should be:
> 
> http://www.pwsan.com/omap/testlogs/test_v3.16-rc7/20140727174803/pm/37xxevm/37xxevm_log.txt

Oops indeed :-)

> > I should probably read back those writes to autosuspend_delay_ms, just to 
> > make sure they are reaching the right destinations.  But you might want to 
> > confirm that you can see the CORE RET count increasing during dynamic idle 
> > on your 37xxevm.
> 
> Hmm seems to work on 37xxevm for me with my retention test script:
> 
> uarts=$(find /sys/class/tty/ttyO*/device/power/ -type d)
> for uart in $uarts; do
>         echo 3000 > $uart/autosuspend_delay_ms
> done
> 
> uarts=$(find /sys/class/tty/ttyO*/power/ -type d)
> for uart in $uarts; do
>         echo enabled > $uart/wakeup
>         echo auto > $uart/control
> done
> 
> echo 0 > /sys/kernel/debug/pm_debug/enable_off_mode
> 
> Which produces:
> 
> core_pwrdm (ON),OFF:0,RET:7,INA:0,ON:8,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0,RET-MEMBANK2-OFF:0
> 
> And then setting enable_off_mode:
> 
> core_pwrdm (ON),OFF:15,RET:100,INA:8,ON:124,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0,RET-MEMBANK2-OFF:0

OK thanks for the point of comparison.

> And I'm using UART3 like I mentioned earlier, but I doubt that
> makes a difference.
> 
> Are you maybe missing "echo auto > $uart/control"?

It should be doing both of those things, according to the logs:

--------
# # for u in `ls -1d /sys/class/tty/ttyO* | paste -s -d' '`; do echo 
enabled >  $u/power/wakeup; done

#
%% Start retention double suspend/resume UART wakeup test

 # for u in `ls -1d /sys/class/tty/ttyO* | paste -s -d' '`; do echo auto >  
$u/power/control; done
--------

I will add code to read back the values from the sysfs files, just to make 
sure they are being set.


- Paul
