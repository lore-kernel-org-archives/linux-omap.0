From: Michael Trimarchi <michael@panicking.kicks-ass.org>
Subject: Re: USB lockup on OMAP3530
Date: Sun, 14 Feb 2010 12:44:01 +0100
Message-ID: <4B77E201.3010904@panicking.kicks-ass.org>
References: <f3642e6b1001261430n32d55can502931fc93271f67@mail.gmail.com>	 <4551feaf1001261513vf8ba655ua1c050a28f1d57eb@mail.gmail.com>	 <201001272046.42946.ahartmetz@gmail.com>	 <5A47E75E594F054BAF48C5E4FC4B92AB031E80D1A1@dbde02.ent.ti.com>	 <4B745311.4000708@panicking.kicks-ass.org> <f3642e6b1002131249y2af6704bk13875ab575c28e62@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ms01.sssup.it ([193.205.80.99]:58845 "EHLO sssup.it"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752793Ab0BNLoK (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 14 Feb 2010 06:44:10 -0500
In-Reply-To: <f3642e6b1002131249y2af6704bk13875ab575c28e62@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Andreas Hartmetz <ahartmetz@gmail.com>
Cc: "Gadiyar, Anand" <gadiyar@ti.com>, Robert Nelson <robertcnelson@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi

Andreas Hartmetz wrote:
> On Thu, Feb 11, 2010 at 7:57 PM, Michael Trimarchi
> <michael@panicking.kicks-ass.org> wrote:
>> Use an hub with external power and connect the hub to the OTG and the device
>> to the HUB.
>> Is it the same?
>>
> Uhm... what do you think how I attached a hard disk and a network
> device to the Beagle's USB OTG port (ONE port) that can only supply
> 100 mA?
> Of course I have everything connected to a powered hub that is
> connected to the OTG port.
> Note that my bug report is not about USB devices not working at all.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

Sorry for that :), I haven't read all the message. But I had the same problem
using a camera with isoc transfer. BTW, I have the two patches applied and that
one from openembeeded doens't work.

Michael
