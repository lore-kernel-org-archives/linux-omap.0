From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [linux-pm] [PATCH] PM: runtime PM + idle: allow usage when interrupts are disabled
Date: Thu, 19 Aug 2010 14:30:05 -0700
Message-ID: <87lj82gujm.fsf@deeprootsystems.com>
References: <Pine.LNX.4.44L0.1008132112090.24267-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:48991 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751101Ab0HSVaJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 19 Aug 2010 17:30:09 -0400
Received: by pzk26 with SMTP id 26so937673pzk.19
        for <linux-omap@vger.kernel.org>; Thu, 19 Aug 2010 14:30:08 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.44L0.1008132112090.24267-100000@netrider.rowland.org>
	(Alan Stern's message of "Fri, 13 Aug 2010 21:15:37 -0400 (EDT)")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-pm@lists.linux-foundation.org, linux-omap@vger.kernel.org

Alan Stern <stern@rowland.harvard.edu> writes:

> On Tue, 10 Aug 2010, Kevin Hilman wrote:
>
>> When using runtime PM in combination with CPUidle, the runtime PM
>> transtions of some devices may be triggered during the idle path.
>> Late in the idle sequence, interrupts will likely be disabled when
>> runtime PM for these devices is initiated.
>> 
>> Currently, the runtime PM core assumes methods are called with
>> interrupts enabled.  However, if it is called with interrupts
>> disabled, the internal locking unconditionally enables interrupts, for
>> example:
>
> ...
>
>> Unconditionally enabling interrupts late in the idle sequence is not
>> desired behavior.  To fix, use the save/restore versions of the
>> spinlock API.
>> 
>> Reported-by: Partha Basak <p-basak2@ti.com>
>> Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
>> ---
>> RFC: I'm not crazy about having the 'flags' in struct dev_pm_info, but
>> since the locks are taken and released in separate functions, this
>> seems better than changing the function APIs to pass around the flags.
>
> There are restrictions on what you're allowed to do with the flags, but 
> I don't remember exactly what they are.
>
> In any case, I don't really like this change.  It seems that we would
> be better off preventing the runtime PM calls from occurring in the
> first place while interrupts are disabled.  

Why? 

> In fact, it's hard to see what could cause this to happen at all.

As I mentioned in the changelog, this happens when trying to use runtime
PM in combination with CPUidle.  As has been suggested elsewhere[1],
there is a need to do runtime PM on some devices in combination with CPU
idle transitions managed by CPUidle.  However, late in the idle path,
at the time we want to manage these IO devices, interrupts are disabled.

Currently, on OMAP, we are already managing the power state of certain
IO devices along with CPUidle transitions using more brute force
methods.  IMO, using runtime PM for this would be a much cleaner
approach.  The only obstacle is the assumption that the API must be
called with interrupts enabled.

Kevin

[1] http://www.linuxplumbersconf.org/2010/ocw/proposals/717
