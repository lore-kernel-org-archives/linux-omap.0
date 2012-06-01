From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH] ARM: OMAP2+: OPP: Fix to ensure check of right oppdef after bad one
Date: Fri, 01 Jun 2012 06:54:48 -0700
Message-ID: <87fwafuogn.fsf@ti.com>
References: <1337361979-19052-1-git-send-email-nm@ti.com>
	<87d35kx7qd.fsf@ti.com> <4FC86926.5050404@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:53559 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758754Ab2FANyu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Jun 2012 09:54:50 -0400
Received: by dajt11 with SMTP id t11so2425833daj.10
        for <linux-omap@vger.kernel.org>; Fri, 01 Jun 2012 06:54:47 -0700 (PDT)
In-Reply-To: <4FC86926.5050404@compulab.co.il> (Igor Grinberg's message of
	"Fri, 01 Jun 2012 10:03:02 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Igor Grinberg <grinberg@compulab.co.il>
Cc: Nishanth Menon <nm@ti.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Steve Sakoman <steve@sakoman.com>

Igor Grinberg <grinberg@compulab.co.il> writes:

> Hi Kevin, Nishanth,
>
> On 06/01/12 02:15, Kevin Hilman wrote:
>> Nishanth Menon <nm@ti.com> writes:
>> 
>>> Commit 9fa2df6b90786301b175e264f5fa9846aba81a65
>>> (ARM: OMAP2+: OPP: allow OPP enumeration to continue if device is not present)
>>> makes the logic:
>>> for (i = 0; i < opp_def_size; i++) {
>>> 	<snip>
>>> 	if (!oh || !oh->od) {
>>> 		<snip>
>>> 		continue;
>>> 	}
>>> <snip>
>>> opp_def++;
>>> }
>>>
>>> In short, the moment we hit a "Bad OPP", we end up looping the list
>>> comparing against the bad opp definition pointer for the rest of the
>>> iteration count. Instead, increment opp_def in the for loop itself
>>> and allow continue to be used in code without much thought so that
>>> we check the next set of OPP definition pointers :)
>>>
>>> Cc: Kevin Hilman <khilman@ti.com>
>>> Cc: Steve Sakoman <steve@sakoman.com>
>>> Cc: Tony Lindgren <tony@atomide.com>
>>> Cc: linux-omap@vger.kernel.org
>>> Cc: linux-arm-kernel@lists.infradead.org
>>>
>>> Signed-off-by: Nishanth Menon <nm@ti.com>
>> 
>> Good catch.
>> 
>> Queuing for my next set of PM fixes for v3.5-rc (branch: for_3.5/fixes/pm-2)
>
> I think this should also apply for stable, right?
> If it should, can you please add a
> Cc: stable@vger.kernel.org

Yes, added.

Thanks,

Kevin
