From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH 0/6] OMAP3+ Clock Fixes
Date: Fri, 15 Jul 2011 09:37:00 -0500
Message-ID: <4E20508C.7060402@ti.com>
References: <1310685857-3211-1-git-send-email-jon-hunter@ti.com> <alpine.DEB.2.00.1107150215360.16606@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:35207 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752160Ab1GOOhC (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 15 Jul 2011 10:37:02 -0400
In-Reply-To: <alpine.DEB.2.00.1107150215360.16606@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap <linux-omap@vger.kernel.org>

Hi Paul,

On 7/15/2011 3:16, Paul Walmsley wrote:
> Hi Jon
>
> On Thu, 14 Jul 2011, Jon Hunter wrote:
>
>> From: Jon Hunter<jon-hunter@ti.com>
>>
>> Various clock fixes for OMAP3 and OMAP4 devices.
>> Plus one debug patch (if anyone is interested).
>>
>> Jon Hunter (4):
>>    OMAP4: Add missing clock divider for OCP_ABE_ICLK
>>    OMAP3+: use DPLLs recalc function instead of omap2_get_dpll_rate
>>    OMAP3+: Update DPLL Fint range for OMAP36xx and OMAP4xxx devices
>>    OMAP: Add debugfs node to show the summary of all clocks
>>
>> Mike Turquette (2):
>>    OMAP4: Clock: round_rate and recalc functions for DPLL_ABE
>>    OMAP3+: use DPLL's round_rate when setting rate
>
> Could you please repost these patches, cc'ing
> linux-arm-kernel@lists.infradead.org ?

No problem. Will re-send. I will drop patch #6 (I see this in your 
queue) and I may add one for the slimbus fck bug too. However, I will 
wait for Benoit's feedback on #1.

Cheers
Jon
