From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCHv4 1/6] ARM: OMAP3 PM: correct enable/disable of daisy
 io chain
Date: Tue, 06 Mar 2012 09:23:38 +0530
Message-ID: <4F558A42.1020503@ti.com>
References: <1330701475-22576-1-git-send-email-t-kristo@ti.com> <1330701475-22576-2-git-send-email-t-kristo@ti.com> <alpine.DEB.2.00.1203051953580.6649@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog120.obsmtp.com ([74.125.149.140]:58478 "EHLO
	na3sys009aog120.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757178Ab2CFDxq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 5 Mar 2012 22:53:46 -0500
Received: by yenl12 with SMTP id l12so2455517yen.5
        for <linux-omap@vger.kernel.org>; Mon, 05 Mar 2012 19:53:45 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1203051953580.6649@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Mohan V <mohanv@ti.com>, Vishwanath BS <vishwanath.bs@ti.com>, Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org, khilman@ti.com, linux-arm-kernel@lists.infradead.org

Hi Paul,

On Tuesday 06 March 2012 08:29 AM, Paul Walmsley wrote:
>
> cc'ing Nilesh, Rajendra
>
> Hi
>
> On Fri, 2 Mar 2012, Tero Kristo wrote:
>
>> From: Mohan V<mohanv@ti.com>
>>
>> Currently the enabling and disabling of IO Daisy chain is not
>> according to the TRM. The below steps are followed to enable/
>> disable the IO chain according to the "Sec 3.5.7.2.2
>> I/O Wake-Up Mechanism" in OMAP3630 Public TRM[1].
>>
>> Steps to enable IO chain:
>> [a] Set PM_WKEN_WKUP.EN_IO bit
>> [b] Set the PM_WKEN_WKUP.EN_IO_CHAIN bit
>> [c] Poll for PM_WKST_WKUP.ST_IO_CHAIN.
>> [d] When ST_IO_CHAIN bit set to 1, clear PM_WKEN_WKUP.EN_IO_CHAIN
>
> Looking at the above TRM section, it doesn't mention clearing
> PM_WKEN_WKUP.EN_IO_CHAIN at all.  This only seems to be mentioned (in a
> rather unclear way) in the OMAP4430 TRM.
>
> Since Tero and Rajendra are reporting that this series works, I assume
> that the conclusion is that this patch description just needs to be fixed.
> Could someone confirm that this is indeed the case -- that I/O wakeups are
> expected to work when EN_IO_CHAIN/WUCLK_CTRL is 0?

Yes, thats my understanding too, again based on taking to people like
Nilesh, because the documentation just doesn't mention this clearly.
The 4430 TRM is a tad bit better like you said.

I guess your confusion of IO wakeups working with EN_IO_CHAIN set to '0'
is also probably coming from the fact that the bit itself is called
*EN_IO_CHAIN* which is a completely *wrong* name for the bit, as
compared to what it does.
That bit is actually used to send a WUCLK pulse through the chain, so
you set it to '1' and wait for it to propagate through the chain, then
you set it to '0' and again wait for it to propagate through.

The control to enable/disable is at 2 levels, a global switch which is
'EN_IO' in case of OMAP3 and the one at the individual pad level.

You can also read this thread which has some more explanation based on
my understanding of how this works
http://www.spinics.net/lists/linux-serial/msg04480.html

regards,
Rajendra

>
> Is the I/O wakeup path from the pad to the PRCM wakeup line completely
> asynchronous?
>
>
> - Paul

