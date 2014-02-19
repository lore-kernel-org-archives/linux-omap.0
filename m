From: Vaibhav Bedia <vaibhav.bedia@gmail.com>
Subject: Re: [RFC PATCH] ARM: OMAP2+: clockdomain: Reintroduce SW_SLEEP
 Support (fwd)
Date: Wed, 19 Feb 2014 14:52:52 -0500
Message-ID: <CANacCWxZ8bfXvMed8Qk93n81uEb9YBtHK-Pe_EtJSAUYzrfL-g@mail.gmail.com>
References: <alpine.DEB.2.02.1402191824260.8777@utopia.booyaka.com>
	<CANacCWy10TTJenrZ6hdTN8bCpAQQjRa5MOBPde7bnn-LM+VFbw@mail.gmail.com>
	<alpine.DEB.2.02.1402191920040.8777@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qa0-f44.google.com ([209.85.216.44]:37389 "EHLO
	mail-qa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751865AbaBSTwx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 Feb 2014 14:52:53 -0500
Received: by mail-qa0-f44.google.com with SMTP id w5so1334913qac.3
        for <linux-omap@vger.kernel.org>; Wed, 19 Feb 2014 11:52:53 -0800 (PST)
In-Reply-To: <alpine.DEB.2.02.1402191920040.8777@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Dave Gerlach <d-gerlach@ti.com>

On Wed, Feb 19, 2014 at 2:22 PM, Paul Walmsley <paul@pwsan.com> wrote:
> On Wed, 19 Feb 2014, Vaibhav Bedia wrote:
>
>> On Wed, Feb 19, 2014 at 1:25 PM, Paul Walmsley <paul@pwsan.com> wrote:
>> >
>> > Just FYI.  Queued for v3.15 unless someone complains.
>> >
>>
>> No complains but i wanted to point out that with some additional
>> changes it's possible
>> to consolidate AM335x (and AM437x) very nicely with the rest of OMAP4+
>> PRM/CM code.
>>
>> I had posted a series (which had a similar patch) a while back [1] but
>> that got never
>> got any feedback :/
>
> Yeah, to be honest I don't like the consolidation approach.  The reason
> why is because the hardware seems to be quite different underneath, so the
> risk of breaking another chip is high.
>
>> If one looks hard enough AM335x/AM437x/TI81xx are not that different
>> from OMAP4+ :)
>
> Hmm, it's my understanding that the hardware implementations are quite
> different between the Wireless and the Catalog parts.  Certainly the
> Wireless engineers didn't have any knowledge at all of what Catalog folks
> were doing, and many implementation assumptions that held true across
> several Wireless parts did not hold up at all when extended to Catalog
> parts.
>

After spending a lot of time looking at the code and PRCM specs for the
different chips i had come to the conclusion that in reality the Catalog
parts had the same hardware minus intelligence ;)

The control bits are the same with just the AUTO modes in the PWRDM,
CLKDM, CLKCTRL never being supported.

The series touched less than 100 lines of OMAP4 code and from what
i can see it was just making it generic in a couple of places. Most of the
changes were just getting rid of AM335x specific pieces.

FWIW i had even suspend/resume also working on AM335x on top of that
series so a breakage, if any, should be simple to fix up. On the contrary
i found it easier to fix any breakage on AM335x due to common code.

But i'll leave the final decision to you :)

Regards,
Vaibhav
