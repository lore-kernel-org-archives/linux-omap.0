From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH 2/2] ARM: OMAP2: Fix GPMC memory initialisation
Date: Tue, 5 Feb 2013 18:22:41 -0600
Message-ID: <5111A251.9020400@ti.com>
References: <1359736726-10193-1-git-send-email-jon-hunter@ti.com> <1359736726-10193-3-git-send-email-jon-hunter@ti.com> <20130201215154.GV22517@atomide.com> <51103247.2030906@ti.com> <51103A25.9010401@ti.com> <20130205233407.GR25185@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:36087 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754562Ab3BFAWq (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 5 Feb 2013 19:22:46 -0500
In-Reply-To: <20130205233407.GR25185@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Afzal Mohammed <afzal@ti.com>


On 02/05/2013 05:34 PM, Tony Lindgren wrote:
> * Jon Hunter <jon-hunter@ti.com> [130204 14:49]:
>>
>> On 02/04/2013 04:12 PM, Jon Hunter wrote:
>>>
>>> On 02/01/2013 03:51 PM, Tony Lindgren wrote:
>>>
>>>> How about let's fix this properly to start with so we don't add
>>>> more blockers moving this code to drivers/bus?
>>>>
>>>> Looks like gpmc_mem_init() gets called from gpmc_probe() so
>>>> we can pass that information in pdev.
>>>
>>> I have re-worked this a bit to use platform data. I have also update
>>> the logic for testing internal/external boot on omap2430 which is
>>> different from omap2420 (according to the TRM). However, I have only
>>> boot tested on omap2420. 
>>>
>>> Do you know why this was changed in the first place? See below ...
>>>
>>> http://permalink.gmane.org/gmane.linux.kernel.commits.head/95931
>>>
>>> Heres what I have now ...
>>
>> Updated patch (I was missing a kfree()). By the way, this is based
>> upon the apollon removal patch. I understand probably needs to be
>> rebased on your latest gpmc series too.
> 
> Yeah makes sense to me thanks. I'll figure out where to apply this
> so we don't get too many dependencies.

Actually, let me look into this a bit more. It appears that for all
omap2+ devices NOR should be mapped to CS0 at 0x08000000. So I am
wondering if the boot-loader is re-mapping the CS0 space. If it is then
may be we can avoid having such hacks in the kernel by fixing the
bootloader. To date only the apollon board has really had this problem
and I need to check what I have on my H4 (which has been hacked by me ;-)

Cheers
Jon
