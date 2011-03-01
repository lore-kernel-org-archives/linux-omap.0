From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH 0/3] OMAP2+ hwmod fixes
Date: Tue, 1 Mar 2011 17:57:45 +0100
Message-ID: <4D6D2589.3090505@ti.com>
References: <1297858285-7056-1-git-send-email-rnayak@ti.com> <4D5BCC10.2060301@ti.com> <6cc4b2788ff1e15c22987d5db91f0395@mail.gmail.com> <4D5E85EA.70605@ti.com> <alpine.DEB.2.00.1102210901140.22636@utopia.booyaka.com> <e6550ef1ea27499e3bc093e264c54d0f@mail.gmail.com> <alpine.DEB.2.00.1102221200260.22636@utopia.booyaka.com> <19850e063c924a8a30c69ac02621a659@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:43317 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752551Ab1CAQ5v (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 1 Mar 2011 11:57:51 -0500
In-Reply-To: <19850e063c924a8a30c69ac02621a659@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Nayak, Rajendra" <rnayak@ti.com>, Paul Walmsley <paul@pwsan.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi Paul,

On 2/23/2011 11:05 AM, Nayak, Rajendra wrote:
> Hi Paul,
>
>> From: Paul Walmsley [mailto:paul@pwsan.com]
>> Sent: Wednesday, February 23, 2011 12:40 AM
>>
>> Hi Rajendra
>>
>> On Tue, 22 Feb 2011, Rajendra Nayak wrote:
>>
>>> The original behavior of the iterators, to terminate upon
>>> encountering an error, seems fine to me. The only problem
>>> I faced was that they fail silently and go undetected, unless
>>> their user catches the return value and WARN's, which I found
>>> was not the case with most users, mainly those of
>>> omap_hwmod_for_each_by_class.
>>> I was thinking of keeping the behaviour of these iterators
>>> same for now and add WARN's in these iterators itself upon
>>> an error, so its seen even if the user fails to catch it.
>>
>> What's your opinion on adding the pr_err() or WARN() into the code that
>> the iterator calls for each hwmod?  That code should know why something
>> fails, so it should be able to provide a more detailed error message.
> Of
>> course, it is not as general a solution...
>
> I agree, if the callback functions are written with proper errors
> or WARN's, they are the right place where most of the details'
> exist. So maybe we don't need these in the iterator's after all.

So to conclude, I will drop the #3 and just push #1 and #2.

#1 is fine with addition of the WARN.
#2 does return an error but does not print anything, but since each call 
(_init_main_clk, _init_interface_clks, _init_opt_clks) does report
some pr_warn in case of error, this is fine.


Regards,
Benoit

