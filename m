From: Vaibhav Hiremath <hvaibhav@ti.com>
Subject: Re: [PATCH V2 0/7] ARM: OMAP2+: Add device-tree support for timers
Date: Sat, 29 Sep 2012 00:21:10 +0530
Message-ID: <5065F19E.5020708@ti.com>
References: <1347579091-3794-1-git-send-email-jon-hunter@ti.com> <505A7E0B.30709@ti.com> <20120920235309.GO28835@atomide.com> <5063330E.3000203@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:58624 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756050Ab2I1Sva (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 28 Sep 2012 14:51:30 -0400
In-Reply-To: <5063330E.3000203@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, device-tree <devicetree-discuss@lists.ozlabs.org>, Rob Herring <rob.herring@calxeda.com>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>



On 9/26/2012 10:23 PM, Jon Hunter wrote:
> 
> On 09/20/2012 06:53 PM, Tony Lindgren wrote:
>> * Benoit Cousson <b-cousson@ti.com> [120919 19:24]:
>>> Hi Tony,
>>>
>>> I was about to take the DTS patch, but was wondering if you will pull
>>> the driver changes for 3.7.
>>
>> I suggest that you do a separate branch on top of Paul's hwmod series
>> when he posts those if that works for you?
> 
> Benoit, I see that you have pulled in the DTS patch.
> 
> Do you guys want me to rebase the remaining patches with Rob's change on
> Tony's master branch and re-submit?
> 

Jon,

Sorry for delayed response, But I tried using your omap_test application
to validate this patch series, but it is failing for me.

How did you test it? Are you running same test application at your end?

I am debugging this issue, i just thought I should tell you this before
its too late.


Below is the log -

[root@arago /]# echo 3 > /tmp/omap-test/timer/one
[   79.612223] omap_dm_timer_request_specific: Please use
omap_dm_timer_request_by_cap()
[   79.620636] Timer 3 not available!

[root@arago /]#
[root@arago /]# echo 3 > /tmp/omap-test/timer/all
[  135.111949] Testing 48042000.timer with 24000000 Hz clock ...
[root@arago /]# [  137.457389] Timer read test PASSED! No errors, 100 loops
[  137.463267] Timer interrupt test PASSED!
[  137.467650] Testing 48042000.timer with 32768 Hz clock ...
[  139.816892] Timer read test PASSED! No errors, 100 loops
[  139.830776] Timer interrupt test PASSED!
[  139.835245] Testing 48044000.timer with 24000000 Hz clock ...
[  142.183912] Timer read test PASSED! No errors, 100 loops
[  142.189734] Timer interrupt test PASSED!
[  142.194076] Testing 48044000.timer with 32768 Hz clock ...
[  144.543451] Timer read test PASSED! No errors, 100 loops
[  144.557334] Timer interrupt test PASSED!
[  144.561806] Testing 48046000.timer with 24000000 Hz clock ...
[  146.910469] Timer read test PASSED! No errors, 100 loops
[  147.910493] Timer interrupt test FAILED! No interrupt occurred in 1 sec
[  147.917598] Testing 48046000.timer with 32768 Hz clock ...
[  150.262203] Timer read test PASSED! No errors, 100 loops
[  151.262049] Timer interrupt test FAILED! No interrupt occurred in 1 sec
[  151.269298] Testing 48048000.timer with 24000000 Hz clock ...
[  153.613596] Timer read test PASSED! No errors, 100 loops
[  154.613618] Timer interrupt test FAILED! No interrupt occurred in 1 sec
[  154.620725] Testing 48048000.timer with 32768 Hz clock ...
[  156.965324] Timer read test PASSED! No errors, 100 loops
[  157.965176] Timer interrupt test FAILED! No interrupt occurred in 1 sec
[  157.972419] Testing 4804a000.timer with 24000000 Hz clock ...

[root@arago /]# [  160.316753] Timer read test PASSED! No errors, 100 loops

[root@arago /]# [  161.316728] Timer interrupt test FAILED! No interrupt
occurred in 1 sec
[  161.323912] Testing 4804a000.timer with 32768 Hz clock ...

[root@arago /]# [  163.668490] Timer read test PASSED! No errors, 100 loops
[  164.668328] Timer interrupt test FAILED! No interrupt occurred in 1 sec
[  164.675545] Tested 5 timers, skipped 6 timers and detected 6 errors
[  164.682202] Test iteration 0 complete in 29 secs
[  164.687104] Test summary: Iterations 1, Errors 6



> Cheers
> Jon
> 
> 
> _______________________________________________
> devicetree-discuss mailing list
> devicetree-discuss@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/devicetree-discuss
> 
