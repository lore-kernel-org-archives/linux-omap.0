From: Joel Fernandes <joelf@ti.com>
Subject: Re: L3 custom error on OMAP4460 (AES/DES)
Date: Tue, 15 Apr 2014 12:15:29 -0500
Message-ID: <534D6931.70006@ti.com>
References: <CAGhQ9Vy-hKBiW0_g3Ht4gqmg0w5WX8H+aqWAkeEhPnHh5AN68A@mail.gmail.com>	<534BE4D1.4080104@ti.com> <CAGhQ9Vxp6_OvFRnd1KL+oAX3xR72vWHgiWBmoqjfSXk1DwAusg@mail.gmail.com> <534C34BD.6060109@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:49650 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751012AbaDORPb (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 15 Apr 2014 13:15:31 -0400
In-Reply-To: <534C34BD.6060109@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>, Joachim Eastwood <manabian@gmail.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org

Nishanth,

On 04/14/2014 02:19 PM, Nishanth Menon wrote:
> On 04/14/2014 02:15 PM, Joachim Eastwood wrote:
>> On 14 April 2014 15:38, Santosh Shilimkar <santosh.shilimkar@ti.com> wrote:
>>> On Saturday 12 April 2014 05:06 PM, Joachim Eastwood wrote:
>>>> Hi,
>>>>
>>>> I getting the following error on Linus master right now.
>>>>
>>>> [ 2.166320] WARNING: CPU: 0 PID: 0 at drivers/bus/omap_l3_noc.c:113
>>>> l3_interrupt_handler+0xf4/0x154()
>>>> [ 2.166320] L3 custom error: MASTER:MPU TARGET:L4 PER2
>>>> [ 2.166320] Modules linked in:
> 
> [...]
>>>> The hardware is a VAR-STK-OM44 dev kit. I got one patch on top of
>>>> Linus master which is the DT support patch which I posted a couple of
>>>> hours ago.
>>>>
>>> Have you tried removing AES from the build ? Probably worth a
>>> try.
>>
>> Removing the aes driver makes the warning from omap_l3_noc disappear.
>>
>> I also tried tried the omap_l3_noc patches from Nishanth Menon that
>> was just posted but it had the same error when the aes driver was
>> built-in.
> Yeah - it better :).. Good to know that driver continues to report bad
> accesses by drivers to targets that are not active yet. will be great
> if you could provide a "Tested-by" tag on my series :).
> 
> Btw, I just finished testing on PandaBoard ES and SDP4430 and I dont
> see the error that you see on var som. I wonder why?
> 
> pandaboard-es:  Boot PASS: http://slexy.org/raw/s21Hsq97mt
> sdp4430:  Boot PASS: http://slexy.org/raw/s2ZQJUqjrP
> 
>>
>> Would it be possible for someone to add hwmod data for the aes driver
>> to the kernel so that the aes could actually work?
> 
> Joel, are you planning on posting OMAP4 hwmod data for AES/DES?
> 

I was out sick yesterday, sorry for the late reply.

Yes, sure. I believe it wasn't posted due to another kernel problem
which I don't remember. I'll post it this week after some more testing
and rebasing.

Thanks for patching the pm_runtime return to handle this.

Regards,
-Joel
