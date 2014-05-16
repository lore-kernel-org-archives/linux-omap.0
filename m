From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: RCU stall on panda
Date: Fri, 16 May 2014 09:37:51 -0400
Message-ID: <537614AF.50100@ti.com>
References: <53675C5F.10509@linaro.org> <20140505180617.GM8754@linux.vnet.ibm.com> <20140512212102.GF5668@atomide.com> <5371BD69.8010600@linaro.org> <20140513153220.GC16837@atomide.com> <53747E6D.60500@linaro.org> <53748371.5030704@linaro.org> <5374C07C.1070400@linaro.org> <20140515183247.GF23659@atomide.com> <5375091D.3010607@ti.com> <5375C145.6070904@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:48465 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932737AbaEPNi0 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 16 May 2014 09:38:26 -0400
In-Reply-To: <5375C145.6070904@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Alex Shi <alex.shi@linaro.org>, Tony Lindgren <tony@atomide.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, "naresh.kamboju@linaro.org Kamboju" <naresh.kamboju@linaro.org>, Linaro Kernel <linaro-kernel@lists.linaro.org>, LAK <linux-arm-kernel@lists.infradead.org>, Mark Brown <broonie@linaro.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Friday 16 May 2014 03:41 AM, Alex Shi wrote:
> On 05/16/2014 02:36 AM, Santosh Shilimkar wrote:
>>>>>> yes.
>>>>>> My board is panda ES. without this revert, it works.
>>>>
>>>> Care to specify what linux version you are testing against?
>>>>
>>>> Does it hang in idle always immediately on booting?
>>>>
>>>> Or does the serial console first hang with sysrq still
>>>> working (ctrl-a h in minicom for help) with device
>>>> eventually locking up hard?
>>>>
>> I just posted an updated patch Alex on other thread.
>> Attaching here again for your reference. Please try
>> it out and see if the you still get a hang.
> 
> it does not hang this time.
>
This is good news and exactly what I expected.
 
> but I am not sure it can solve my problem, since RCU stall is not easy
> to reproduce in short time.
> 
You may want to run the system longer if you can. I suspect the RCU stall
was also side effect of missing interrupts.

Regards,
Santosh
