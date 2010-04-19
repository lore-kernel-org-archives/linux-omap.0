From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: Re: [PATCH 00/10] dsp-bridge: deh: general cleanups
Date: Mon, 19 Apr 2010 15:37:28 -0500
Message-ID: <4BCCBF08.6030909@ti.com>
References: <1269379542-11892-1-git-send-email-felipe.contreras@gmail.com> <i2x94a0d4531004150512qf66c7c42u160707e3a89ec39a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:44180 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750939Ab0DSUhj (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 19 Apr 2010 16:37:39 -0400
In-Reply-To: <i2x94a0d4531004150512qf66c7c42u160707e3a89ec39a@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Ameya Palande <ameya.palande@nokia.com>

On 4/15/2010 7:12 AM, Felipe Contreras wrote:
> On Wed, Mar 24, 2010 at 12:25 AM, Felipe Contreras
> <felipe.contreras@gmail.com>  wrote:
>> While trying to fix the recovery feature I stumbled many areas of improvments
>> in 'deh' (whatever that means).
>>
>> I quickly tested tesed these changes in Nokia hw, there should be essentially
>> no functional changes.
>>
>> Cheers.
>>
>> Felipe Contreras (10):
>>   dsp-bridge: deh: remove obvious comments
>>   dsp-bridge: deh: trivial cleanups
>>   dsp-bridge: deh: remove unnecessary casts
>>   dsp-bridge: deh: improve logging stuff
>>   dsp-bridge: deh: report mmu faults as errors
>>   dsp-bridge: deh: decrease nesting levels
>>   dsp-bridge: deh: fix obvious return codes
>>   dsp-bridge: deh: reorganize create()
>>   dsp-bridge: deh: fix hdeh_mgr silliness
>>   dsp-bridge: deh: fix dummy_va_addr
>>
>>   arch/arm/plat-omap/include/dspbridge/wmddeh.h |   24 +-
>>   drivers/dsp/bridge/wmd/ue_deh.c               |  392 +++++++++++--------------
>>   2 files changed, 191 insertions(+), 225 deletions(-)
>
> I guess these patches don't apply any more. Shall I rebase them? If so... where?

As noted in a private mail, your patches were rebased and now pushed to 
dspbridge.

Only this patch was dropped "dsp-bridge: deh: trivial cleanups"[1]

I removed the trivial checkpatch warnings (80 char limit and space after 
comma) from 2 of them.

Omar

---
[1] http://marc.info/?l=linux-omap&m=126938906708916&w=2
