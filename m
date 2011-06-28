From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCHv2] omap2+: pm: cpufreq: Fix loops_per_jiffy calculation
Date: Tue, 28 Jun 2011 16:07:58 -0700
Message-ID: <4E0A5ECE.5080508@ti.com>
References: <1308923618-5333-1-git-send-email-premi@ti.com> <CAMbhsRQUKBZbC3jJt8XpjTW2n7uA529D6G0g4eT5iLEHn2iNLg@mail.gmail.com> <4E0A5982.8040002@ti.com> <20110628230358.GB23312@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:57218 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751205Ab1F1XIB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 28 Jun 2011 19:08:01 -0400
Received: by mail-gy0-f179.google.com with SMTP id 15so411836gyc.10
        for <linux-omap@vger.kernel.org>; Tue, 28 Jun 2011 16:08:00 -0700 (PDT)
In-Reply-To: <20110628230358.GB23312@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Colin Cross <ccross@google.com>, Sanjeev Premi <premi@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 6/28/2011 4:03 PM, Russell King - ARM Linux wrote:
> On Tue, Jun 28, 2011 at 03:45:22PM -0700, Santosh Shilimkar wrote:
>> The udelay code doesn't use the per-cpu lpj variable. It uses the global
>> lpj. Secondly the calibration of no. of loops to be done is
>> precalculateed so overwrite shouldn't impact the scenario you mentioned.
>>
>> Though it has an issue where, pre-calculated loops can become short/long
>> based on new clock change which impacts both CPU's on OMAP, when the
>> other CPU is in in the middle of u-delay routine..
>
> And there's also the issue where you can start a udelay loop on one CPU,
> be pre-empted and end up running it on a different CPU running at a
> different speed.
>
Indeed.

> The thing to bear in mind is that udelays are approximate at best - I did
> some investigation into the accuracy of the loops_per_jiffy calculation,
> and it _will_ produce shorter delays than expected by the fact that
> what is being calibrated is the udelay() loop _plus_ the timer interrupt
> overhead.
 >
Sure but as Colin pointed out 4 times shorter delay will be too much.

Regards
Santosh



