From: Kalle Valo <kalle.valo@iki.fi>
Subject: Re: Problem trying to pull particular commit from PM tree
Date: Sat, 21 Nov 2009 13:29:03 +0200
Message-ID: <87lji0azgg.fsf@purkki.valot.fi>
References: <1258554311.750.33.camel@blitz>
	<20091118165738.GJ29266@atomide.com> <1258581497.750.57.camel@blitz>
	<87einvbgdm.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.25]:15365 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750745AbZKUL3B (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 21 Nov 2009 06:29:01 -0500
Received: by ey-out-2122.google.com with SMTP id 4so632155eyf.19
        for <linux-omap@vger.kernel.org>; Sat, 21 Nov 2009 03:29:06 -0800 (PST)
In-Reply-To: <87einvbgdm.fsf@deeprootsystems.com> (Kevin Hilman's message of "Wed\, 18 Nov 2009 14\:46\:45 -0800")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Peter Barada <peterb@logicpd.com>, Tony Lindgren <tony@atomide.com>, linux-omap <linux-omap@vger.kernel.org>

Hi Kevin,

Kevin Hilman <khilman@deeprootsystems.com> writes:

>> 2) When trees are rebased, are the previous commits in the tree lost -
>> i.e. if tree A has commits A', A'', etc, and is rebased on tree B(which
>> does not have the commits A', A'' in it), are the commits A', A'', etc
>> lost?
>
> When a branch is rebased, all the commit IDs in that branch change, so
> finding a change by commit ID in a rebased branch (like PM branch) is
> impossible.

What you could do is to tag the branch (with a date or something)
every time you rebase, that way git would store the old commits in the
repo. But I doubt it would be worth the effort, but that's one way to
store the history.

Just my 0.02 EUR :)

-- 
Kalle Valo
