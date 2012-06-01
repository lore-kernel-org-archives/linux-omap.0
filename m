From: Igor Grinberg <grinberg@compulab.co.il>
Subject: Re: [PATCH] ARM: OMAP2+: OPP: Fix to ensure check of right oppdef
 after bad one
Date: Fri, 01 Jun 2012 10:03:02 +0300
Message-ID: <4FC86926.5050404@compulab.co.il>
References: <1337361979-19052-1-git-send-email-nm@ti.com> <87d35kx7qd.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 50.23.254.54-static.reverse.softlayer.com ([50.23.254.54]:40249
	"EHLO softlayer.compulab.co.il" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754614Ab2FAHDJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Jun 2012 03:03:09 -0400
In-Reply-To: <87d35kx7qd.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Nishanth Menon <nm@ti.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Steve Sakoman <steve@sakoman.com>

Hi Kevin, Nishanth,

On 06/01/12 02:15, Kevin Hilman wrote:
> Nishanth Menon <nm@ti.com> writes:
> 
>> Commit 9fa2df6b90786301b175e264f5fa9846aba81a65
>> (ARM: OMAP2+: OPP: allow OPP enumeration to continue if device is not present)
>> makes the logic:
>> for (i = 0; i < opp_def_size; i++) {
>> 	<snip>
>> 	if (!oh || !oh->od) {
>> 		<snip>
>> 		continue;
>> 	}
>> <snip>
>> opp_def++;
>> }
>>
>> In short, the moment we hit a "Bad OPP", we end up looping the list
>> comparing against the bad opp definition pointer for the rest of the
>> iteration count. Instead, increment opp_def in the for loop itself
>> and allow continue to be used in code without much thought so that
>> we check the next set of OPP definition pointers :)
>>
>> Cc: Kevin Hilman <khilman@ti.com>
>> Cc: Steve Sakoman <steve@sakoman.com>
>> Cc: Tony Lindgren <tony@atomide.com>
>> Cc: linux-omap@vger.kernel.org
>> Cc: linux-arm-kernel@lists.infradead.org
>>
>> Signed-off-by: Nishanth Menon <nm@ti.com>
> 
> Good catch.
> 
> Queuing for my next set of PM fixes for v3.5-rc (branch: for_3.5/fixes/pm-2)

I think this should also apply for stable, right?
If it should, can you please add a
Cc: stable@vger.kernel.org
?

Thanks


-- 
Regards,
Igor.
