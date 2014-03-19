From: Mark Jackson <mpfj-list@newflow.co.uk>
Subject: Re: rts-gpio DT binding
Date: Wed, 19 Mar 2014 09:15:03 +0000
Message-ID: <53296017.3090104@newflow.co.uk>
References: <20140318165536.GH14373@saruman.home> <53287CAF.9040708@newflow.co.uk> <20140318171110.GI14373@saruman.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 217-155-41-104.dsl.in-addr.zen.co.uk ([217.155.41.104]:43959
	"EHLO centos1.newflow.co.uk" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1758259AbaCSJPZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 19 Mar 2014 05:15:25 -0400
In-Reply-To: <20140318171110.GI14373@saruman.home>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>

On 18/03/14 17:11, Felipe Balbi wrote:
> On Tue, Mar 18, 2014 at 05:04:47PM +0000, Mark Jackson wrote:
>> On 18/03/14 16:55, Felipe Balbi wrote:
>>> Hi Mark,
>>>
>>> I'm looking at the omap-serial driver and saw that you added rts-gpio
>>> binding in commit 4a0ac0f55b18dc297a87a85417fcf068658bf103 (OMAP: add
>>> RS485 support) but, as it turns out, gpio0_13 and gpio2_15 are both
>>> actual RTS signals.
>>>
>>> Instead of adding that extra GPIO handling, why didn't you just mux
>>> those signals as RTS and enable auto-RTS/auto-CTS feature ?
>>>
>>> It looks to me like that's highly unnecessary binding.
>>
>> I agree !!
>>
>> I think it was to allow delays pre- and post- sending the comms data.
>>
>> Several RS485 drivers require a "warm up" time before they will
>> transmit data correctly, and also need a "cool down" time to prevent
>> clipping of the last few bits of data.
>>
>> IIRC the built-in RTS handling did not allow for this.
> 
> you might be right here. I can't find anywhere to write rts delays.
> Weird... digging TRM.
> 
>> It also allows the RTS signal to be "inverted", again required for
>> some RS485 driver chips.
>>
>> However, I'll dig into why I did this and report back.
> 
> cool, thanks

Okay ... it comes back to me now.

When using RS485 drivers, we're not actually using RTS as a "Ready
To Send", we're really using it as an "enable RS485 driver".

I just used the "RTS" mnemonic as "we're now wanting to send some
data so please now enable the RS485 driver", rather than the normal
"I'm ready for your to send me some data".

So it's the opposite function.

Maybe it was a poor choice of abbreviation ?

As I said before, RS485 drivers might have active or active low
enables, so we might need to invert the "RTS" polarity.  This is
not handled by the hardware RTS signal.

Is that a good enough explanation ?

Mark J.
