From: <aaro.koskinen@nokia.com>
Subject: RE: Code for v2.6.39 merge window frozen, patches archived
Date: Tue, 15 Mar 2011 20:32:09 +0000
Message-ID: <CA1B555B4D79E3448D96A7C9847C7D9803604516@008-AM1MPN1-033.mgdnok.nokia.com>
References: <20110314192538.GH7258@atomide.com>
 <alpine.DEB.1.10.1103151856180.880@esdhcp041196.research.nokia.com>,<4D7FC70D.7050508@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.1.47]:48120 "EHLO mgw-sa01.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757950Ab1COUc0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 15 Mar 2011 16:32:26 -0400
In-Reply-To: <4D7FC70D.7050508@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: b-cousson@ti.com
Cc: tony@atomide.com, linux-omap@vger.kernel.org, tarun.kanti@ti.com

Hi,

From: Cousson, Benoit [b-cousson@ti.com]:
>On 3/15/2011 6:54 PM, Aaro Koskinen wrote:
>> On Mon, 14 Mar 2011, Tony Lindgren wrote:
>>> I've applied few random fix like patches today into omap-for-linus
>>> but that's it for this merge window.
>>>
>>> So let's do some testing with with Stephen's for-next and
>>> omap-for-linus and start queueing up fixes for the -rc cycle.
>>
>> I did some quick testing:
>>
>> linux-omap/master, omap2plus_defconfig:
>>
>>       - RM-680 hangs after uncompressing kernel. earlyprintk shows:
>>
>>       [    0.293395] omap_hwmod: _populate_mpu_rt_base found no _mpu_rt_va for l4_core
>>       [    0.300903] omap_hwmod: _populate_mpu_rt_base found no _mpu_rt_va for l4_per
>>       [    0.308288] omap_hwmod: _populate_mpu_rt_base found no _mpu_rt_va for l4_wkup
>>       [    0.316101] omap_hwmod: gpt12_fck: missing clockdomain for gpt12_fck.
>>
>>       (then some garbage)
>>
>>       - With RX-51 I get the same messages, but no hang.
>
> Mmm, that looks like an access to a secure timer from hwmod code on a HS
> device. Could you comment out the timer12 entry
> (&omap3xxx_timer12_hwmod) in the omap3 hwmod list at the end of
> omap_hwmod_3xxx_data.c to check that?

Yes, it's a HS device. I actually tried that already, with a debug print in _enable
and it was timer 12. When commented out, it got a bit further, but there was another
hang again in hwmod code, this time I think it was i2c3. I have to check that again
properly when I get back to the lab.

A.
