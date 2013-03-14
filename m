From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH] ARM: smp: Allow real broadcast device selection instead
 of always dummy
Date: Thu, 14 Mar 2013 12:41:12 -0700
Message-ID: <514227D8.9010205@codeaurora.org>
References: <1363165608-13739-1-git-send-email-santosh.shilimkar@ti.com> <514046B6.9020005@ti.com> <20130313101641.GA13483@e106331-lin.cambridge.arm.com> <514061D1.20603@ti.com> <20130313122550.GD13483@e106331-lin.cambridge.arm.com> <51409EC3.5050905@ti.com> <20130313161811.GF13483@e106331-lin.cambridge.arm.com> <5141800A.2000307@ti.com> <20130314102807.GG13483@e106331-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wolverine01.qualcomm.com ([199.106.114.254]:20548 "EHLO
	wolverine01.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750844Ab3CNTlO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 14 Mar 2013 15:41:14 -0400
In-Reply-To: <20130314102807.GG13483@e106331-lin.cambridge.arm.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, Thomas Gleixner <tglx@linutronix.de>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Russell King <linux@arm.linux.org.uk>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 03/14/13 03:28, Mark Rutland wrote:
> On Thu, Mar 14, 2013 at 07:45:14AM +0000, Santosh Shilimkar wrote:
>> On Wednesday 13 March 2013 09:48 PM, Mark Rutland wrote:
>>> On Wed, Mar 13, 2013 at 03:44:03PM +0000, Santosh Shilimkar wrote:
>>>> On Wednesday 13 March 2013 05:55 PM, Mark Rutland wrote:
>>>>> I do agree it'd be worth lowering the dummy timer's rating to ensure it doesn't
>>>>> override a real timer elsewhere. 
>>>>>
>>>> Yep. Can I add you acked-by tag then for $subject patch ?
>>>> Would be good to get this one merged as well.
>>> Sure. Though could you reword the commit message? The patch solves the more
>>> general issue of a dummy being preferred over real hardware even outside of
>>> choosing the broadcast device.
>>>
>>> Acked-by: Mark Rutland <mark.rutland@arm.com>
>> Thanks. For record, patch is in end of the email which I plan
>> to put into patch system.
>>
>> Regards,
>> Santosh
> The below patch seems fine. Are you intending for this to go in as a fix for
> 3.9-rc*, or as a cleanup for 3.10?
>
> If you're aiming for the latter, it's going to clash with Stephen Boyd's local
> timer API removal [1], in which the generic dummy timer driver [2] (replacing
> the arm-specific dummy [3]) also has a rating of 100.

Thanks for the heads up. Looks like the conflict will be trivial, but I
wonder why need to put the patch at all? Per my understanding the
regression has been fixed by your patch in Thomas' tree and then in 3.10
we can merge the local timer removal patches and fix up the rating at
the same time.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation

