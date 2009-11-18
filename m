From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: Problem trying to pull particular commit from PM tree
Date: Wed, 18 Nov 2009 14:46:45 -0800
Message-ID: <87einvbgdm.fsf@deeprootsystems.com>
References: <1258554311.750.33.camel@blitz>
	<20091118165738.GJ29266@atomide.com> <1258581497.750.57.camel@blitz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f180.google.com ([209.85.216.180]:57654 "EHLO
	mail-px0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756215AbZKRWql (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 Nov 2009 17:46:41 -0500
Received: by pxi10 with SMTP id 10so1149464pxi.33
        for <linux-omap@vger.kernel.org>; Wed, 18 Nov 2009 14:46:47 -0800 (PST)
In-Reply-To: <1258581497.750.57.camel@blitz> (Peter Barada's message of "Wed\, 18 Nov 2009 16\:58\:17 -0500")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Barada <peterb@logicpd.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap <linux-omap@vger.kernel.org>

Peter Barada <peterb@logicpd.com> writes:

> On Wed, 2009-11-18 at 08:57 -0800, Tony Lindgren wrote:
>> * Peter Barada <peterb@logicpd.com> [091118 06:20]:
>> > Is it possible to back up in time on the PM tree to find a particular
>> > commit, even across rebasings?  I'm interested in the commit used by TI
>> > to base their AM3517 work on which is:
>> > 
>> > [Commit:ef25c2a0e0]: OMAP3: PM: defconfig: enable SRF by default.
>> > 
>> > I tried:
>> > 
>> > git clone git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git
>> > git checkout -b pm origin/pm
>> > git reset --hard ef25c2a0
>> > 
>> > But that came back with:
>> > 
>> > fatal: ambiguous argument 'ef25c2a0': unknown revision or path not in
>> > the working tree.
>> > 
>> > My git 'fu' is pretty weak.  Any ideas why this doesn't work?
>> > Thanks in advance!
>> 
>> Maybe ef25c2a0e0 is some TI internal commit?
>
> I wouldn't think so.  Their comment in the release notes is:
>
> This release package includes a series of patches on top of the "pm"
> branch maintained at
> "http://git.kernel.org/?p=linux/kernel/git/tmlind/linux-omap-2.6.git;a=shortlog;h=pm". Baseline: [Commit:ef25c2a0e0]: OMAP3: PM: defconfig: enable SRF by default.
>
> 1) How can I search the linux-omap git world to see if the commit string
> exists?
>
> 2) When trees are rebased, are the previous commits in the tree lost -
> i.e. if tree A has commits A', A'', etc, and is rebased on tree B(which
> does not have the commits A', A'' in it), are the commits A', A'', etc
> lost?

When a branch is rebased, all the commit IDs in that branch change, so
finding a change by commit ID in a rebased branch (like PM branch) is
impossible.

Kevin
