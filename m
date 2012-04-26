From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH/RFT 1/3] ARM: OMAP2+: powerdomain: allow pre/post transtion to be per pwrdm
Date: Thu, 26 Apr 2012 06:35:26 -0700
Message-ID: <87mx5ybopt.fsf@ti.com>
References: <1335277420-29124-1-git-send-email-khilman@ti.com>
	<1335277420-29124-2-git-send-email-khilman@ti.com>
	<alpine.DEB.2.00.1204252130080.30642@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog119.obsmtp.com ([74.125.149.246]:57707 "EHLO
	na3sys009aog119.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751928Ab2DZNfa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 26 Apr 2012 09:35:30 -0400
Received: by pbcwz12 with SMTP id wz12so2933283pbc.2
        for <linux-omap@vger.kernel.org>; Thu, 26 Apr 2012 06:35:28 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1204252130080.30642@utopia.booyaka.com> (Paul
	Walmsley's message of "Wed, 25 Apr 2012 21:31:21 -0600 (MDT)")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, Jean Pihet <jean.pihet@newoldbits.com>, Tero Kristo <t-kristo@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>

Paul Walmsley <paul@pwsan.com> writes:

> On Tue, 24 Apr 2012, Kevin Hilman wrote:
>
>> Iteration over all power domains in the idle path is unnecessary since
>> only power domains that are transitioning need to be accounted for.
>> Also PRCM register accesses are known to be expensive, so the
>> additional latency added to the idle path is signficiant.
>> 
>> In order allow the pre/post transitions to be isolated and called
>> per-pwrdm, change the API so passing in a specific power domain will
>> trigger the pre/post transtion accounting for only that specific power
>> domain.  Passing NULL means iterating over all power domains as is
>> current behavior.
>> 
>> Signed-off-by: Kevin Hilman <khilman@ti.com>
>
> Based on a quick glance, it looks good to me:
>
> Acked-by: Paul Walmsley <paul@pwsan.com>
>
> Want to queue this one?

Yes, I'll queue this along with the others.

Thanks,

Kevin
