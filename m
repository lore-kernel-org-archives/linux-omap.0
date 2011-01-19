From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v2] OMAP: use fncpy to copy the PM code functions to SRAM
Date: Wed, 19 Jan 2011 13:38:24 -0800
Message-ID: <87mxmwr2un.fsf@ti.com>
References: <1295352126-29171-1-git-send-email-j-pihet@ti.com>
	<87vd1ksq2i.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:49375 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753264Ab1ASVia (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 19 Jan 2011 16:38:30 -0500
Received: by vws8 with SMTP id 8so623356vws.12
        for <linux-omap@vger.kernel.org>; Wed, 19 Jan 2011 13:38:28 -0800 (PST)
In-Reply-To: <87vd1ksq2i.fsf@ti.com> (Kevin Hilman's message of "Wed, 19 Jan
	2011 10:31:33 -0800")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: jean.pihet@newoldbits.com
Cc: Dave Martin <dave.martin@linaro.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Jean Pihet <j-pihet@ti.com>

Kevin Hilman <khilman@ti.com> writes:

> jean.pihet@newoldbits.com writes:
>
>> From: Jean Pihet <j-pihet@ti.com>
>>
>> The new fncpy API is better suited for copying some
>> code to SRAM at runtime. This patch changes the ad-hoc
>> code to the more generic fncpy API.
>>
>> Tested OK on OMAP3 in low power modes (RET/OFF)
>> using omap2plus_defconfig with !CONFIG_THUMB2_KERNEL.
>> Compile tested on OMAP1/2 using omap1_defconfig.
>>
>> Signed-off-by: Jean Pihet <j-pihet@ti.com>
>
> Acked-by: Kevin Hilman <khilman@ti.com>
>
> Boot tested on OMAP1 & OMAP2 as well.  Note that neither OMAP1 or OMAP2
> has had working suspend/resume for a long time now, so I did not test
> suspend/resume.

For OMAP2:

Tested-by: Kevin Hilman <khilman@ti.com>

to test a little more on OMAP2, I just removed the WFI from the
low-level code and tested suspend that way.  That's enough to be sure
the copied code is copied and executed.

Worked fine on OMAP2420/n810.

For OMAP1, this didn't work and would require more serious hacking on
the OMAP1 suspend path, which I currently have no plans to do.

Kevin
