From: Mark Jackson <mpfj-list@newflow.co.uk>
Subject: Re: rts-gpio DT binding
Date: Wed, 19 Mar 2014 17:02:56 +0000
Message-ID: <5329CDC0.6010705@newflow.co.uk>
References: <20140318165536.GH14373@saruman.home> <53287CAF.9040708@newflow.co.uk> <20140318171110.GI14373@saruman.home> <53296017.3090104@newflow.co.uk> <20140319145957.GB27752@saruman.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 217-155-41-104.dsl.in-addr.zen.co.uk ([217.155.41.104]:46975
	"EHLO centos1.newflow.co.uk" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S933574AbaCSRDS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 19 Mar 2014 13:03:18 -0400
In-Reply-To: <20140319145957.GB27752@saruman.home>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>

On 19/03/14 14:59, Felipe Balbi wrote:
> Hi,
> 
> On Wed, Mar 19, 2014 at 09:15:03AM +0000, Mark Jackson wrote:

[snip]

>>
>> Okay ... it comes back to me now.
>>
>> When using RS485 drivers, we're not actually using RTS as a "Ready
>> To Send", we're really using it as an "enable RS485 driver".
>>
>> I just used the "RTS" mnemonic as "we're now wanting to send some
>> data so please now enable the RS485 driver", rather than the normal
>> "I'm ready for your to send me some data".
>>
>> So it's the opposite function.
>>
>> Maybe it was a poor choice of abbreviation ?
>>
>> As I said before, RS485 drivers might have active or active low
>> enables, so we might need to invert the "RTS" polarity.  This is
>> not handled by the hardware RTS signal.
>>
>> Is that a good enough explanation ?
> 
> fair, but considering you can toggle RTS by hand with writes to MCR
> register, I still don't see the need for remuxing the lines as GPIOs.
> 
> Just don't use auto-RTS and toggle the line by hand with MCR, no ?

TBH I hadn't realised you could do that, so I guess you could.

But my solution seems more flexible as it would allow you to add an RTS
signal to UART0 and UART5 which don't have any hardware handshaking lines.

Mark J.
