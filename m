From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [linux-pm] [PATCH] PM: runtime PM + idle: allow usage when interrupts are disabled
Date: Mon, 23 Aug 2010 08:24:55 -0700
Message-ID: <87y6bxz708.fsf@deeprootsystems.com>
References: <1281459261-30829-1-git-send-email-khilman@deeprootsystems.com>
	<201008162318.03923.rjw@sisk.pl> <874oeqgu6w.fsf@deeprootsystems.com>
	<201008210127.46934.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:57555 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751523Ab0HWPY6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 23 Aug 2010 11:24:58 -0400
Received: by pvg2 with SMTP id 2so2299760pvg.19
        for <linux-omap@vger.kernel.org>; Mon, 23 Aug 2010 08:24:57 -0700 (PDT)
In-Reply-To: <201008210127.46934.rjw@sisk.pl> (Rafael J. Wysocki's message of
	"Sat, 21 Aug 2010 01:27:46 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-pm@lists.linux-foundation.org, linux-omap@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>, Ming Lei <tom.leiming@gmail.com>

"Rafael J. Wysocki" <rjw@sisk.pl> writes:

> On Thursday, August 19, 2010, Kevin Hilman wrote:
>> "Rafael J. Wysocki" <rjw@sisk.pl> writes:
>> 
>> > On Tuesday, August 10, 2010, Kevin Hilman wrote:
>> >> When using runtime PM in combination with CPUidle, the runtime PM
>> >> transtions of some devices may be triggered during the idle path.
>> >> Late in the idle sequence, interrupts will likely be disabled when
>> >> runtime PM for these devices is initiated.
>> >> 
>> >> Currently, the runtime PM core assumes methods are called with
>> >> interrupts enabled.  However, if it is called with interrupts
>> >> disabled, the internal locking unconditionally enables interrupts, for
>> >> example:
>> >> 
>> >> pm_runtime_put_sync()
>> >
>> > Please don't use that from interrupt context.  
>> 
>> I'm not using this in interrupt context.  I'm using it in process
>> context where interrupts are disabled, specifically, the idle thread.
>> 
>> > There's pm_runtime_put() exactly for this purpose that puts the
>> > _idle() call into a workqueue.
>> *
>> If I'm in my CPU's idle path, I don't want to activate a workqueue
>> because then I'll no longer be idle.
>
> Well, what about:
>
> -> idle
>    -> check if devices have been suspended
>        - enter idle if so
>        - call pm_request_idle() for devices
>
> The workqueue will activate and put the devices into low-power states and
> then your idle callback will be called again, with the devices suspended.

The problem with this is that after we leave idle, the decision about
which C-state to enter will likely change, which will affect the set of
devices that need to be suspended.   I'm not sure this will be an
entirely predictable process with current CPUidle governors, but it
certainly merits some more experiments.

Kevin
