From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH 0/5] OMAP4: hwmod data fixes and update
Date: Fri, 10 Dec 2010 08:51:50 +0100
Message-ID: <4D01DC16.5010109@ti.com>
References: <1291937615-18571-1-git-send-email-b-cousson@ti.com> <87hbem4g76.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:45039 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751136Ab0LJHvy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 10 Dec 2010 02:51:54 -0500
In-Reply-To: <87hbem4g76.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "paul@pwsan.com" <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 12/10/2010 1:36 AM, Kevin Hilman wrote:
> Benoit Cousson<b-cousson@ti.com>  writes:
>
>> Hi Paul,
>>
>> Here is a small set of OMAP4 hwmod data updates.
>>
>> Re-order properly the data that were a little bit shuffled during
>> the previous merge window.
>> Add the new reset flags introduced in 2.6.37 and that were not
>> used in the hwmod data. The OMAP2 and OMAP3 fixes should come soon.
>> Fix some missing field in the GPIO OMAP4 hwmod data that I missed
>> during the review.
>> IVA and DSP are added just to allow the processors device creation
>> at boot time and avoid the warnings.
>>
>> Thanks to Charu for testing the GPIO / WD_TIMER changes.
>> Thanks to Govindraj for testing the UART changes.
>>
>> The series is based on lo/for-next (v2.6.37-rc5-66-ga2814df) and is
>> available here:
>> git://gitorious.org/omap-pm/linux.git for_2.6.38/hwmod_data
>>
>> Please note that there is a slight dependency with the following patch
>> due to the name change of the iva fclk:
>> OMAP4: clock data: Add missing DPLL x2 clock node
>> https://patchwork.kernel.org/patch/396612/
>>
>> Tested on sdp4430 + ES2.0/ES2.1.
>
> As with the other series, I tried to pull this into my pm-core for
> testing with all the other PM stuff we have baking for 2.6.38.
>
> Unfortunately, this series has conflicts with Paul's
> pwrdm_prcm_[ab]_2.6.38 branches.
> Could you rebase this on Paul's pwrdm_prcm_b_2.6.38 branch?

OK, I will rebase all my series on top of that one.

Regards,
Benoit
