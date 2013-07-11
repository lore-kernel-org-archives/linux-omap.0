From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: Boot hang regression 3.10.0-rc4 -> 3.10.0
Date: Thu, 11 Jul 2013 14:41:11 +0530
Message-ID: <51DE76AF.8030402@ti.com>
References: <B5906170F1614E41A8A28DE3B8D121433EE94489@DBDE04.ent.ti.com> <B5906170F1614E41A8A28DE3B8D121433EE94520@DBDE04.ent.ti.com> <20130708112553.GU5523@atomide.com> <51DAB394.3050104@ti.com> <20130708131033.GA5523@atomide.com> <51DABC81.3080409@ti.com> <20130708133512.GD31221@arwen.pp.htv.fi> <87mwpuakod.fsf@linaro.org> <20130710142633.GV5523@atomide.com> <51DE4E3F.6030503@ti.com> <20130711062440.GY5523@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:42464 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932451Ab3GKJLl (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 11 Jul 2013 05:11:41 -0400
In-Reply-To: <20130711062440.GY5523@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Kevin Hilman <khilman@linaro.org>, balbi@ti.com, "Bedia, Vaibhav" <vaibhav.bedia@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Mark Jackson <mpfj-list@newflow.co.uk>, Sourav Poddar <sourav.poddar@ti.com>, Paul Walmsley <paul@pwsan.com>

On Thursday 11 July 2013 11:54 AM, Tony Lindgren wrote:
> * Rajendra Nayak <rnayak@ti.com> [130710 23:25]:
>> On Wednesday 10 July 2013 07:56 PM, Tony Lindgren wrote:
>>>
>>> Felipe is right, looks like all we need is to check if context is
>>> initialized or not. So no need for mach-omap2/serial.c or hwmod tinkering.
>>>
>>> After that having DEBUG_LL and cmdline with earlyprintk console=ttyO..
>>> works for me.
>>
>> On what platform? Like I said there are flags set statically in hmwod
>> data for OMAP4 and OMAP5, which make it work without any hwmod tinkering
>> in mach-omap2/serial.c. But it won't work for am33xx.
> 
> For me omap4 sdp hangs during ttyO2 probe if earlyprintk is enabled for
> that port and console is enabled for that port. That's because we attempt
> to restore uninitialized context.

Right, so thats the Issue 2: that you see on the omap4 sdp. You never hit
Issue 1: despite not doing any hwmod tinkering because of the static flags
set for uart3 in hwmod data.

> 
> It's possible that we have more than one bug here though.

Right, we have 2 issues like I said earlier. Issue 1: is when hwmod _setup()
does a console UART reset (Not seen if the flags are set either runtime or
statically)

Issue 2: Is when omap serial does a runtime resume before set_termios().

>  
>>> @@ -1523,6 +1524,8 @@ static int serial_omap_probe(struct platform_device *pdev)
>>>  
>>>  	pm_runtime_mark_last_busy(up->dev);
>>>  	pm_runtime_put_autosuspend(up->dev);
>>> +	up->initialized = true;
>>
>> This won't help as the context save for serial happens as part of set_termios() and not
>> when the device is probed.
> 
> The issue is that in serial probe we currently restore NULL context to
> the port which kills earlyprintk output until set_termios() is called.
> 
> But as discussed, there are better ways for fixing this issue.
> 
> Regards,
> 
> Tony
> 

