From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH V2 0/7] ARM: OMAP2+: Add device-tree support for timers
Date: Sat, 29 Sep 2012 09:33:11 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A83EAEB9C6@DBDE01.ent.ti.com>
References: <1347579091-3794-1-git-send-email-jon-hunter@ti.com>
 <505A7E0B.30709@ti.com> <20120920235309.GO28835@atomide.com>
 <5063330E.3000203@ti.com> <5065F19E.5020708@ti.com> <50661B07.1040200@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:53470 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752112Ab2I2Jdl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 29 Sep 2012 05:33:41 -0400
In-Reply-To: <50661B07.1040200@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hunter, Jon" <jon-hunter@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, device-tree <devicetree-discuss@lists.ozlabs.org>, Rob Herring <rob.herring@calxeda.com>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>

On Sat, Sep 29, 2012 at 03:17:51, Hunter, Jon wrote:
> 
> On 09/28/2012 01:51 PM, Vaibhav Hiremath wrote:
> > 
> > 
> > On 9/26/2012 10:23 PM, Jon Hunter wrote:
> >>
> >> On 09/20/2012 06:53 PM, Tony Lindgren wrote:
> >>> * Benoit Cousson <b-cousson@ti.com> [120919 19:24]:
> >>>> Hi Tony,
> >>>>
> >>>> I was about to take the DTS patch, but was wondering if you will pull
> >>>> the driver changes for 3.7.
> >>>
> >>> I suggest that you do a separate branch on top of Paul's hwmod series
> >>> when he posts those if that works for you?
> >>
> >> Benoit, I see that you have pulled in the DTS patch.
> >>
> >> Do you guys want me to rebase the remaining patches with Rob's change on
> >> Tony's master branch and re-submit?
> >>
> > 
> > Jon,
> > 
> > Sorry for delayed response, But I tried using your omap_test application
> > to validate this patch series, but it is failing for me.
> > 
> > How did you test it? Are you running same test application at your end?
> 
> Sorry, I now see you are using the latest test code! I was too hasty
> when I saw the first error ;-)
> 

Jon, have patience ;-)
I understand, sometimes it happens un-intentionally.

> > I am debugging this issue, i just thought I should tell you this before
> > its too late.
> 
> Thanks.
> 
> > Below is the log -
> > 
> > [root@arago /]# echo 3 > /tmp/omap-test/timer/one
> > [   79.612223] omap_dm_timer_request_specific: Please use
> > omap_dm_timer_request_by_cap()
> > [   79.620636] Timer 3 not available!
> 
> This is expected because omap_dm_timer_request_specific() is no longer
> supported. I should remove in the omap-test/timer/one going forward.
> 
> > [root@arago /]#
> > [root@arago /]# echo 3 > /tmp/omap-test/timer/all
> > [  135.111949] Testing 48042000.timer with 24000000 Hz clock ...
> > [root@arago /]# [  137.457389] Timer read test PASSED! No errors, 100 loops
> > [  137.463267] Timer interrupt test PASSED!
> > [  137.467650] Testing 48042000.timer with 32768 Hz clock ...
> > [  139.816892] Timer read test PASSED! No errors, 100 loops
> > [  139.830776] Timer interrupt test PASSED!
> > [  139.835245] Testing 48044000.timer with 24000000 Hz clock ...
> > [  142.183912] Timer read test PASSED! No errors, 100 loops
> > [  142.189734] Timer interrupt test PASSED!
> > [  142.194076] Testing 48044000.timer with 32768 Hz clock ...
> > [  144.543451] Timer read test PASSED! No errors, 100 loops
> > [  144.557334] Timer interrupt test PASSED!
> > [  144.561806] Testing 48046000.timer with 24000000 Hz clock ...
> > [  146.910469] Timer read test PASSED! No errors, 100 loops
> > [  147.910493] Timer interrupt test FAILED! No interrupt occurred in 1 sec
> > [  147.917598] Testing 48046000.timer with 32768 Hz clock ...
> > [  150.262203] Timer read test PASSED! No errors, 100 loops
> > [  151.262049] Timer interrupt test FAILED! No interrupt occurred in 1 sec
> > [  151.269298] Testing 48048000.timer with 24000000 Hz clock ...
> > [  153.613596] Timer read test PASSED! No errors, 100 loops
> > [  154.613618] Timer interrupt test FAILED! No interrupt occurred in 1 sec
> > [  154.620725] Testing 48048000.timer with 32768 Hz clock ...
> > [  156.965324] Timer read test PASSED! No errors, 100 loops
> > [  157.965176] Timer interrupt test FAILED! No interrupt occurred in 1 sec
> > [  157.972419] Testing 4804a000.timer with 24000000 Hz clock ...
> > 
> > [root@arago /]# [  160.316753] Timer read test PASSED! No errors, 100 loops
> > 
> > [root@arago /]# [  161.316728] Timer interrupt test FAILED! No interrupt
> > occurred in 1 sec
> > [  161.323912] Testing 4804a000.timer with 32768 Hz clock ...
> > 
> > [root@arago /]# [  163.668490] Timer read test PASSED! No errors, 100 loops
> > [  164.668328] Timer interrupt test FAILED! No interrupt occurred in 1 sec
> > [  164.675545] Tested 5 timers, skipped 6 timers and detected 6 errors
> > [  164.682202] Test iteration 0 complete in 29 secs
> > [  164.687104] Test summary: Iterations 1, Errors 6
> 
> What is interesting is that it is the interrupt test that is failing for
> timers 5-7. Any chance there is a problem with the interrupt mapping? I
> checked the documentation for AM335x and I don't see anything obvious
> that is wrong with the binding unless the documentation itself is wrong.
> 
> Given that the interrupts work on timers 3 and 4 it appears to be a
> interrupt configuration problem somewhere. We could adapt the test to
> see if an interrupt is pending in the timer peripheral when it fails.
> This would tell us that the timer is working but the interrupt is not
> being enabled correctly in the interrupt controller.
> 

I am also surprised to see this, and as you mentioned, nothing I looks 
obviously wrong to me in  timer5-7. 
I have to debug this further and will keep you updated.

Thanks,
Vaibhav

> Cheers
> Jon
> 

