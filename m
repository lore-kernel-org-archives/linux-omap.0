From: Nishanth Menon <nm@ti.com>
Subject: Re: L3 custom error on OMAP4460 (AES/DES)
Date: Mon, 14 Apr 2014 14:19:25 -0500
Message-ID: <534C34BD.6060109@ti.com>
References: <CAGhQ9Vy-hKBiW0_g3Ht4gqmg0w5WX8H+aqWAkeEhPnHh5AN68A@mail.gmail.com>	<534BE4D1.4080104@ti.com> <CAGhQ9Vxp6_OvFRnd1KL+oAX3xR72vWHgiWBmoqjfSXk1DwAusg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:58345 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750769AbaDNTT1 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 14 Apr 2014 15:19:27 -0400
In-Reply-To: <CAGhQ9Vxp6_OvFRnd1KL+oAX3xR72vWHgiWBmoqjfSXk1DwAusg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Joachim Eastwood <manabian@gmail.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, "Fernandes, Joel" <joelf@ti.com>

On 04/14/2014 02:15 PM, Joachim Eastwood wrote:
> On 14 April 2014 15:38, Santosh Shilimkar <santosh.shilimkar@ti.com> wrote:
>> On Saturday 12 April 2014 05:06 PM, Joachim Eastwood wrote:
>>> Hi,
>>>
>>> I getting the following error on Linus master right now.
>>>
>>> [ 2.166320] WARNING: CPU: 0 PID: 0 at drivers/bus/omap_l3_noc.c:113
>>> l3_interrupt_handler+0xf4/0x154()
>>> [ 2.166320] L3 custom error: MASTER:MPU TARGET:L4 PER2
>>> [ 2.166320] Modules linked in:

[...]
>>> The hardware is a VAR-STK-OM44 dev kit. I got one patch on top of
>>> Linus master which is the DT support patch which I posted a couple of
>>> hours ago.
>>>
>> Have you tried removing AES from the build ? Probably worth a
>> try.
> 
> Removing the aes driver makes the warning from omap_l3_noc disappear.
> 
> I also tried tried the omap_l3_noc patches from Nishanth Menon that
> was just posted but it had the same error when the aes driver was
> built-in.
Yeah - it better :).. Good to know that driver continues to report bad
accesses by drivers to targets that are not active yet. will be great
if you could provide a "Tested-by" tag on my series :).

Btw, I just finished testing on PandaBoard ES and SDP4430 and I dont
see the error that you see on var som. I wonder why?

pandaboard-es:  Boot PASS: http://slexy.org/raw/s21Hsq97mt
sdp4430:  Boot PASS: http://slexy.org/raw/s2ZQJUqjrP

> 
> Would it be possible for someone to add hwmod data for the aes driver
> to the kernel so that the aes could actually work?

Joel, are you planning on posting OMAP4 hwmod data for AES/DES?

-- 
Regards,
Nishanth Menon
