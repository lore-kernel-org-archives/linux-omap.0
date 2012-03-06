From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCHv4 1/6] ARM: OMAP3 PM: correct enable/disable of daisy
 io chain
Date: Tue, 06 Mar 2012 10:02:56 +0530
Message-ID: <4F559378.3010204@ti.com>
References: <1330701475-22576-1-git-send-email-t-kristo@ti.com> <1330701475-22576-2-git-send-email-t-kristo@ti.com> <alpine.DEB.2.00.1203051953580.6649@utopia.booyaka.com> <4F558A42.1020503@ti.com> <alpine.DEB.2.00.1203052103440.6649@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:51887 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758255Ab2CFEdG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 5 Mar 2012 23:33:06 -0500
Received: by ghrr18 with SMTP id r18so2435037ghr.0
        for <linux-omap@vger.kernel.org>; Mon, 05 Mar 2012 20:33:03 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1203052103440.6649@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: dnilesh@ti.com, Mohan V <mohanv@ti.com>, Vishwanath BS <vishwanath.bs@ti.com>, Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org, khilman@ti.com, linux-arm-kernel@lists.infradead.org

On Tuesday 06 March 2012 09:43 AM, Paul Walmsley wrote:
> Hi Rajendra
>
> (thanks for adding in Nilesh, added him again here)
>
> On Tue, 6 Mar 2012, Rajendra Nayak wrote:
>
>> Yes, thats my understanding too, again based on taking to people like
>> Nilesh, because the documentation just doesn't mention this clearly.
>> The 4430 TRM is a tad bit better like you said.
>>
>> I guess your confusion of IO wakeups working with EN_IO_CHAIN set to '0'
>> is also probably coming from the fact that the bit itself is called
>> *EN_IO_CHAIN* which is a completely *wrong* name for the bit, as
>> compared to what it does.
>> That bit is actually used to send a WUCLK pulse through the chain, so
>> you set it to '1' and wait for it to propagate through the chain, then
>> you set it to '0' and again wait for it to propagate through.
>
> Okay.  So to confirm: EN_IO_CHAIN doesn't enable a continuous clock, it
> just controls the WUCLKIN line directly?

Right.

>
>> The control to enable/disable is at 2 levels, a global switch which is
>> 'EN_IO' in case of OMAP3 and the one at the individual pad level.
>
> Do you happen to know what EN_IO/GLOBAL_WUEN does?  For example, if it's
> 0, will the I/O chain not latch in wakeup events occuring on the pads?

Yes, it wouldn't. Figure 3-74 in OMAP4430_ES2.x Public TRM vO
explains this better.

The WUEN signal to each pad (which can be used to enable IO-daisy
for the given pad) is a AND of a signal from PRCM and
one from SCM.
The signal from PRCM can be enabled by writing into
EN_IO/GLOBAL_WUEN bit.
The signal from SCM can be enabled by writing to the individual
pad registers in SCM
CONTROL.CONTROL_PADCONF_<IOpad>[14] WAKEUPENABLE0
CONTROL.CONTROL_PADCONF_<IOpad>[30] WAKEUPENABLE1.

If either one of them is not enabled the IO wakeups on the pads won't
be latched. So if EN_IO/GLOBAL_WUEN is disabled, none of the pads will
be able to generate IO wakeups.

> Or does it just cause the PRCM to ignore any PRCM wakeups coming from the
> I/O chain?  (Or something else, heh)
>
>> You can also read this thread which has some more explanation based on
>> my understanding of how this works
>> http://www.spinics.net/lists/linux-serial/msg04480.html
>
> I've been reading that post; it's been quite helpful.
>
>
> - Paul

