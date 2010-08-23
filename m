From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [linux-pm] [PATCH] PM: runtime PM + idle: allow usage when interrupts are disabled
Date: Mon, 23 Aug 2010 08:22:02 -0700
Message-ID: <8762z11hid.fsf@deeprootsystems.com>
References: <Pine.LNX.4.44L0.1008201006430.1716-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:63189 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751589Ab0HWPWH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 23 Aug 2010 11:22:07 -0400
Received: by pwi7 with SMTP id 7so2116420pwi.19
        for <linux-omap@vger.kernel.org>; Mon, 23 Aug 2010 08:22:06 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.44L0.1008201006430.1716-100000@iolanthe.rowland.org>
	(Alan Stern's message of "Fri, 20 Aug 2010 10:14:01 -0400 (EDT)")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-pm@lists.linux-foundation.org, linux-omap@vger.kernel.org

Alan Stern <stern@rowland.harvard.edu> writes:

> On Thu, 19 Aug 2010, Kevin Hilman wrote:
>
>> > In any case, I don't really like this change.  It seems that we would
>> > be better off preventing the runtime PM calls from occurring in the
>> > first place while interrupts are disabled.  
>> 
>> Why? 
>
> Because that's how the Runtime PM framework was designed.  Drivers 
> expect interrupts to be enabled when their runtime PM callbacks are 
> invoked.  And the framework internally depends on it as well.
>
>> > In fact, it's hard to see what could cause this to happen at all.
>> 
>> As I mentioned in the changelog, this happens when trying to use runtime
>> PM in combination with CPUidle.  As has been suggested elsewhere[1],
>> there is a need to do runtime PM on some devices in combination with CPU
>> idle transitions managed by CPUidle.  However, late in the idle path,
>> at the time we want to manage these IO devices, interrupts are disabled.
>
> Then it isn't really feasible to use the runtime PM framework for those 
> devices.  Not unless the framework is extended with new functions meant 
> to be used without interrupts enabled (in which case it doesn't seem to 
> matter much whether you are in process context or not).
>
>> Currently, on OMAP, we are already managing the power state of certain
>> IO devices along with CPUidle transitions using more brute force
>> methods.  IMO, using runtime PM for this would be a much cleaner
>> approach.  The only obstacle is the assumption that the API must be
>> called with interrupts enabled.
>
> That's a big obstacle.  Why can't you manage these devices earlier, 
> while interrupts are still enabled?

Indeed, that's a good question.  I'm exploring this more thoroughly now.

Kevin



