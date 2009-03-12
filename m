From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: ioremap bug?
Date: Thu, 12 Mar 2009 14:27:55 -0700
Message-ID: <87fxhi5t44.fsf@deeprootsystems.com>
References: <496565EC904933469F292DDA3F1663E60287CA6EC4@dlee06.ent.ti.com>
	<7A436F7769CA33409C6B44B358BFFF0CFF51DF41@dlee02.ent.ti.com>
	<87zlfq6497.fsf@deeprootsystems.com>
	<7A436F7769CA33409C6B44B358BFFF0CFF51E139@dlee02.ent.ti.com>
	<13B9B4C6EF24D648824FF11BE8967162037B7D2E7E@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ag-out-0708.google.com ([72.14.246.248]:4990 "EHLO
	ag-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752383AbZCLV2C (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Mar 2009 17:28:02 -0400
Received: by ag-out-0708.google.com with SMTP id 26so1222290agb.10
        for <linux-omap@vger.kernel.org>; Thu, 12 Mar 2009 14:27:59 -0700 (PDT)
In-Reply-To: <13B9B4C6EF24D648824FF11BE8967162037B7D2E7E@dlee02.ent.ti.com> (Richard Woodruff's message of "Thu\, 12 Mar 2009 14\:32\:53 -0500")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Woodruff, Richard" <r-woodruff2@ti.com>
Cc: "Menon, Nishanth" <nm@ti.com>, "Guzman Lugo, Fernando" <x0095840@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Kanigeri, Hari" <h-kanigeri2@ti.com>, "Lakhani, Amish" <amish@ti.com>, "Gupta, Ramesh" <grgupta@ti.com>, Ameya Palande <ameya.palande@nokia.com>

"Woodruff, Richard" <r-woodruff2@ti.com> writes:

>> Kevin,
>> Some more isolation:
>> The l-o master branch does not have an issue, only the pm branch seems to have
>> the problem - probably some commit(s?) missing in pm branch. Since bridge is
>> based off the pm branch, wont make sense to regress on it :(.
>
> This rings a bell from a couple months back.  I've not followed the thread but recall a recent fix to ioremap.
>
> http://www.mail-archive.com/linux-omap@vger.kernel.org/msg08836.html
>

Yes, I was trying to remember why this sounded familiar, thanks
Richard.

The reason it works on l-o and not PM branch is because PM branch is
still 2.6.8 based, and l-o is on 2.6.29-rc which has a fix for this.

Nishant, can you try to cherry-pick commit
24f11ec001920f1cfaeeed8e8b55725d900bbb56 from Linus' tree into your PM
branch and see if that helps.

Kevin
