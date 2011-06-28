From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCHv2] omap2+: pm: cpufreq: Fix loops_per_jiffy calculation
Date: Tue, 28 Jun 2011 16:00:55 -0700
Message-ID: <4E0A5D27.5090709@ti.com>
References: <1308923618-5333-1-git-send-email-premi@ti.com>	<CAMbhsRQUKBZbC3jJt8XpjTW2n7uA529D6G0g4eT5iLEHn2iNLg@mail.gmail.com>	<4E0A5982.8040002@ti.com> <CAMbhsRRctHC2wSi7cWjO2Fn_rM7=dMtTrt6PbsVehrgx9SKwzw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:51131 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752772Ab1F1XA7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 28 Jun 2011 19:00:59 -0400
Received: by mail-yi0-f47.google.com with SMTP id 18so325203yib.20
        for <linux-omap@vger.kernel.org>; Tue, 28 Jun 2011 16:00:57 -0700 (PDT)
In-Reply-To: <CAMbhsRRctHC2wSi7cWjO2Fn_rM7=dMtTrt6PbsVehrgx9SKwzw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Colin Cross <ccross@google.com>
Cc: Sanjeev Premi <premi@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Russell King - ARM Linux <linux@arm.linux.org.uk>

On 6/28/2011 3:53 PM, Colin Cross wrote:
> On Tue, Jun 28, 2011 at 3:45 PM, Santosh Shilimkar
> <santosh.shilimkar@ti.com <mailto:santosh.shilimkar@ti.com>> wrote:

[....]

>         Can't this rewrite the loops_per_jiffy for the other CPU while it is
>         in a udelay?  If it has already calculated the number of loops
>         necessary, and the CPU frequency increases, it could end up
>         returning
>         too early from udelay.
>
>         There were previous discussions about polling a fixed-frequency
>         timer
>         for udelay on SMP systems.
>
>     The udelay code doesn't use the per-cpu lpj variable. It uses the global
>     lpj. Secondly the calibration of no. of loops to be done is
>     precalculateed so overwrite shouldn't impact the scenario you mentioned.
>
>     Though it has an issue where, pre-calculated loops can become short/long
>     based on new clock change which impacts both CPU's on OMAP, when the
>     other CPU is in in the middle of u-delay routine..
>
>
> The precalculated loops is exactly the problem I described.  udelay(100)
> can return in 50 microseconds if the cpu speed is doubled.  On OMAP4,
> frequencies can range from 350Mhz to 1.5GHz, so udelay can be more than
> 4 times too short.  That breaks the guarantees of udelay.
>
You have a point and I agree with you on above.
And to fix that scenrio, the only option is to use hardware
timer based u-delay() which can remain constant across the
CPU freq change.

Regards,
Santosh
