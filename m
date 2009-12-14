From: "Dasgupta, Romit" <romit@ti.com>
Subject: RE: [PATCH] OMAP3: PM:  Dynamic calculation of SDRC clock
 stabilization delay
Date: Mon, 14 Dec 2009 22:11:09 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301DD07FD36@dbde02.ent.ti.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB030ADD4B50@dbde02.ent.ti.com>
	<87skbhjwjo.fsf@deeprootsystems.com>	<87my1pggok.fsf@deeprootsystems.com>
 <4B25FF04.4040306@ti.com>,<873a3dfse2.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:59839 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756036AbZLNQlP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 14 Dec 2009 11:41:15 -0500
In-Reply-To: <873a3dfse2.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "Reddy, Teerth" <teerth@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


>>
>> I tried to find the code in LO but I think it is not yet present.

>Right, it is still being discussed.

>> So with that in mind may I propose that the pmc functions we
>> introduce in plat-omap will be present as __init code (so that we
>> ensure no one uses it after the system finishes booting up) as long
>> as the pmc infrastructure is not available for non-Oprofile uses?

>Personally, I don't like this idea.

>IMHO, the PMC is not OMAP specific and does not belong in plat-omap
>even as init code.  Either generalize and use existing PMC
>infrastructure, or use a different timer.

Ftrace/Oprofile/Perf are all initialized later during the boot process.
Actually if you see where we are using pmc it is in init_IRQ.
So until the pmc libraries I think it would be fair to use it. I do not see any problem.
Can you point out with any concrete code from the latest OMAP tree?

>You didn't answer my other question about whether or not a GPtimer
>could be used for this.  You could quickly request/program/free a
>GPtimer for this too using the omap_dm_timer* API.

May be possibe but IMHO it is ugly to setup and more complicated to use than the pmc approach. The other indirect way is like how bogomips is calculated. But that is a different story. We need accuracy in the delay and __may be__ interrupt latency would skew the results. If someone can implement it using Interrupt we would like to see how much access delay they get using irq technique.

>> As I mentioned in an earlier thread, the pmc is used and stopped
>> very early during the kernel boot and AFAICT there should not be any
>> problem (probably we need to check its behavior on EMU/HS devices).

>This isn't very convicing.

>Also, it's not just oprofile we have to be worried about.  The
>perf/trace infrastructure arm is also using the PMC.  It will not be
>uncommon to use perf on early boot/init and the use of the PMC in this
>patch will clearly interfere with that.
Wrong! See above.


>In summary, the PMC is a shared resource and should be treated as such
>using common code and common APIs. 

Where is it today?

Thanks,
-Romit