From: Gary Thomas <gary@mlbassoc.com>
Subject: Re: Problem trying to pull particular commit from PM tree
Date: Wed, 18 Nov 2009 14:56:53 -0700
Message-ID: <4B046DA5.1040907@mlbassoc.com>
References: <1258554311.750.33.camel@blitz>	 <20091118165738.GJ29266@atomide.com> <1258581497.750.57.camel@blitz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from hermes.mlbassoc.com ([76.76.67.137]:37417 "EHLO
	mail.chez-thomas.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755791AbZKRV4s (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 Nov 2009 16:56:48 -0500
In-Reply-To: <1258581497.750.57.camel@blitz>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Barada <peterb@logicpd.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap <linux-omap@vger.kernel.org>

On 11/18/2009 02:58 PM, Peter Barada wrote:
> On Wed, 2009-11-18 at 08:57 -0800, Tony Lindgren wrote:
>> * Peter Barada<peterb@logicpd.com>  [091118 06:20]:
>>> Is it possible to back up in time on the PM tree to find a particular
>>> commit, even across rebasings?  I'm interested in the commit used by TI
>>> to base their AM3517 work on which is:
>>>
>>> [Commit:ef25c2a0e0]: OMAP3: PM: defconfig: enable SRF by default.
>>>
>>> I tried:
>>>
>>> git clone git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git
>>> git checkout -b pm origin/pm
>>> git reset --hard ef25c2a0
>>>
>>> But that came back with:
>>>
>>> fatal: ambiguous argument 'ef25c2a0': unknown revision or path not in
>>> the working tree.
>>>
>>> My git 'fu' is pretty weak.  Any ideas why this doesn't work?
>>> Thanks in advance!
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

Did you try specifying the entire key 'ef25c2a0e0', not just 'ef25c2a0'?

-- 
------------------------------------------------------------
Gary Thomas                 |  Consulting for the
MLB Associates              |    Embedded world
------------------------------------------------------------
