From: jouni.hogander@nokia.com (=?utf-8?Q?H=C3=B6gander?= Jouni)
Subject: Re: PM related problem with dispc controller
Date: Tue, 23 Sep 2008 11:05:49 +0300
Message-ID: <87ej3b5lsy.fsf@trdhcp146196.ntc.nokia.com>
References: <87skrr5pck.fsf@trdhcp146196.ntc.nokia.com>
	<c656a4d20809230003g49e646bck5967fbdfb403ea7e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:48583 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752926AbYIWIEG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 23 Sep 2008 04:04:06 -0400
In-Reply-To: <c656a4d20809230003g49e646bck5967fbdfb403ea7e@mail.gmail.com>
	(ext arun c.'s message of "Tue, 23 Sep 2008 03:03:03 -0400")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext arun c <arun.edarath@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

"ext arun c" <arun.edarath@gmail.com> writes:

> On Tue, Sep 23, 2008 at 2:49 AM, H=C3=B6gander Jouni
> <jouni.hogander@nokia.com> wrote:
>> Hi,
>>
>> I'm debugging pm-0 branch with SDP board and seeing lots of dispc
>> related error printouts:
>>
>> / # <4>__ratelimit: 453 callbacks suppressed
>> __ratelimit: 453 callbacks suppressed
>> <3>omapfb omapfb: irq error status 00e2
>> omapfb omapfb: irq error status 00e2
>> <3>omapfb omapfb: irq error status 00e2
>> omapfb omapfb: irq error status 00e2
>> <3>omapfb omapfb: irq error status 00c0
>> omapfb omapfb: irq error status 00c0
>> <3>omapfb omapfb: irq error status 0062
>> omapfb omapfb: irq error status 0062
>> <3>omapfb omapfb: irq error status 00c2
>> omapfb omapfb: irq error status 00c2
>>
>> The error bit in all these statuses is "GFXFIFOUNDERFLOW". Is this
>> something that could happen e.g. in a case that mpu wake-up from wfi
>> takes too long? I mean is there some interrupt that should be served
>> faster? Or is this taken care by sdma/hw triggering and now sdma is
>> not capable to fill the fifo for reason or another?
>>
>> I have cpuidle enabled and it is "forced" to select only C1 or
>> C0. This means tha MPU, NEON, CORE and PER are always
>> ON/INACTIVE. Display is also on and there is penguin logo on it. Whe=
n
>> I see these error messages there is also flickering on the display.
>>
>> This far I had found that on mpu wfi something is switched off
>> sometimes. I can see that from consumption of SDP board. Sometimes
>> consumption is much lower on wfi even if the states of domains are
>> same. When this happens, also these omapfb irq errors begin to happe=
n.
>>
>> I can workaround this problem by disabling DSS_ICK AUTOIDLE. Another
>> workaround is to disable hw supervised mode for core_l3_clkdm or
>> core_l4_clkdm.
>
> Try disabling the smart standby feature of DISPC

Yes, this actually helps. I see this also as a workaround. Is the case
here that L3 domain is entering some sleep state and waking it up
takes too long for dispc?

--=20
Jouni H=C3=B6gander

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
