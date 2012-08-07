From: Igor Grinberg <grinberg@compulab.co.il>
Subject: Re: [PATCH] Revert "ARM: OMAP3530evm: set pendown_state and debounce
 time for ads7846"
Date: Tue, 07 Aug 2012 08:58:09 +0300
Message-ID: <5020AE71.1060405@compulab.co.il>
References: <876298iv9s.fsf@ti.com> <1344284535-16717-1-git-send-email-grinberg@compulab.co.il> <871ujj7ngd.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from softlayer.compulab.co.il ([50.23.254.55]:58664 "EHLO
	compulab.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752555Ab2HGF6Q (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 7 Aug 2012 01:58:16 -0400
In-Reply-To: <871ujj7ngd.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Zumeng Chen <zumeng.chen@windriver.com>, Arnd Bergmann <arnd@arndb.de>

On 08/06/12 23:52, Kevin Hilman wrote:
> Igor Grinberg <grinberg@compulab.co.il> writes:
> 
>> 1) The above commit introduced a common ->get_pendown_state() function
>> into the generic code, but that function was board-specific for the
>> OMAP3EVM and thus broke most other boards using this code.
>>
>> 2) The above commit was mis-merged introducing another bug which
>> prevents the ads7846 driver probe function to succeed.
>> The omap_ads7846_init() function frees the pendown GPIO in case there is
>> no ->get_pendown_state() function set by the caller (board specific
>> code), so it can be requested later by the ads7846 driver.
>> The above commit add a common ->get_pendown_state() function without
>> removing the gpio_free() call and thus once the ads7846 driver tries
>> to use the pendown GPIO, it crashes as the pendown GPIO has not been
>> requested.
>>
>> 3) The above commit introduces NO new functionality as
>> get_pendown_state() function is already implemented in a suitable way by
>> the ads7846 driver and the debounce time handling has already been
>> fixed by commit 97ee9f01 (ARM: OMAP: fix the ads7846 init code).
>>
>> This reverts commit 16aced80f6739beb2a6ff7b6f96c83ba80d331e8.
>>
>> Conflicts:
>> 	arch/arm/mach-omap2/common-board-devices.c
>>
>> Solved by taking the working version prior to the above commit.
>>
>> Cc: Zumeng Chen <zumeng.chen@windriver.com>
>> Cc: Arnd Bergmann <arnd@arndb.de>
>> Signed-off-by: Igor Grinberg <grinberg@compulab.co.il>
>> ---
>> Kevin, sorry for the late reply.
>> How about the above commit message and the below patch?
>>
>> The patch applies cleanly to Tony's master branch (6 Aug 2012)
>> or Kevin's kevin-omap-pm/for_3.6/fixes/ads7846
>> after resetting two top most commits.
> 
> Now that v3.6-rc1 is out, it should probalby be applied on top of -rc1.
> I've taken care of that and tested as well.
> 
>> This patch has been tested on both above branches on cm-t3730.
>> Any other board tested will be greately appreciated.
>>
>> Also, if after all said in the commit message, you still don't
>> want to revert the original patch, feel free to post your thoughts.
> 
> After all the digging I did, I agree that the revert is the best
> solution.  
> 
> While it's a slightly different problem/bug, I think the gpio_free() in
> common-board-devices.c should still be unconditonal since the
> gpio_request() is now unconditional.  That can be a separate patch though.

Well, the logic behind the conditional gpio_free() is:
if a board specific code provides a board specific get_pendown_state()
function (which is different from the one in the ads7846 driver),
that board will not need to re-request the pendown GPIO (duplicate code).
If we free the pendown GPIO unconditionally, then the board specific code
will have to re-request it.
So, I think, no - it should be conditional.

> 
> Acked-by: Kevin Hilman <khilman@ti.com>
> Tested-by: Kevin Hilman <khilman@ti.com>
> 
> Tested on 3430/n900, 3530/Overo, 3730/Overo STORM, 3730/BB-xM.

Thanks!

[...]


-- 
Regards,
Igor.
