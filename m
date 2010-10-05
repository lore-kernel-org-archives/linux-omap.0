From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH v5] power: introduce library for device-specific OPPs
Date: Tue, 05 Oct 2010 13:50:14 -0700
Message-ID: <8739skpdo9.fsf@deeprootsystems.com>
References: <1285933174-24053-1-git-send-email-nm@ti.com>
	<201010050036.23179.rjw@sisk.pl> <4CAB228C.7030902@ti.com>
	<201010052244.11403.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:47049 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755675Ab0JEUuU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Oct 2010 16:50:20 -0400
In-Reply-To: <201010052244.11403.rjw@sisk.pl> (Rafael J. Wysocki's message of
	"Tue, 5 Oct 2010 22:44:11 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Nishanth Menon <nm@ti.com>, linux-pm <linux-pm@lists.linux-foundation.org>, lkml <linux-kernel@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, linux-omap <linux-omap@vger.kernel.org>, Paul <paulmck@linux.vnet.ibm.com>

"Rafael J. Wysocki" <rjw@sisk.pl> writes:

> On Tuesday, October 05, 2010, Nishanth Menon wrote:
>> Rafael J. Wysocki had written, on 10/04/2010 05:36 PM, the following:
>> > On Friday, October 01, 2010, Nishanth Menon wrote:

[...]

>> > 
>> > I'm not really sure why so many mutexes are needed here.  I don't think you
>> > need a separate mutex in every struct device_opp object.  I'd just use
>> > dev_opp_list_lock for everything.
>> 
>> I did consider using  dev_opp_list_lock to lock everything *but* here is 
>> the contention:
>> 
>> dev_opp_list_lock locks modification for addition of domains device. 
>> This operation happens usually during init stage.
>> 
>> each domain device has multiple opps, new opps can be added, but the 
>> more often usage will probably be opp_enable and disable. domain are 
>> usually modifiable independent of each other - device_opp->lock provides 
>> device level lock allowing for each domain device opp list to be 
>> modified independent of each other. e.g. on thermal overage we may 
>> choose to lower mpu domain while a coprocessor driver in parallel might 
>> choose to disable co-processor domain in parallel.
>> 
>> Wondering why you'd like a single lock for all domains and restrict 
>> parallelization?
>
> Because of the simplicity, mostly.  If there's only a relatively short period
> when the lock will be contended for, that still is not too bad and it's much
> easier to get the synchronization right with just one lock for starters.

FWIW, I agree with Rafael

These are not going be highly contended locks, and the lock durations
are very short, so simplifying the locking is a big win for readability.

Kevin
