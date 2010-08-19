From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [linux-pm] [PATCH] PM: runtime PM + idle: allow usage when interrupts are disabled
Date: Thu, 19 Aug 2010 14:37:43 -0700
Message-ID: <874oeqgu6w.fsf@deeprootsystems.com>
References: <1281459261-30829-1-git-send-email-khilman@deeprootsystems.com>
	<201008162318.03923.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:39909 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753703Ab0HSVhq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 19 Aug 2010 17:37:46 -0400
Received: by pzk26 with SMTP id 26so940238pzk.19
        for <linux-omap@vger.kernel.org>; Thu, 19 Aug 2010 14:37:45 -0700 (PDT)
In-Reply-To: <201008162318.03923.rjw@sisk.pl> (Rafael J. Wysocki's message of
	"Mon, 16 Aug 2010 23:18:03 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-pm@lists.linux-foundation.org, linux-omap@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>, Ming Lei <tom.leiming@gmail.com>

"Rafael J. Wysocki" <rjw@sisk.pl> writes:

> On Tuesday, August 10, 2010, Kevin Hilman wrote:
>> When using runtime PM in combination with CPUidle, the runtime PM
>> transtions of some devices may be triggered during the idle path.
>> Late in the idle sequence, interrupts will likely be disabled when
>> runtime PM for these devices is initiated.
>> 
>> Currently, the runtime PM core assumes methods are called with
>> interrupts enabled.  However, if it is called with interrupts
>> disabled, the internal locking unconditionally enables interrupts, for
>> example:
>> 
>> pm_runtime_put_sync()
>
> Please don't use that from interrupt context.  

I'm not using this in interrupt context.  I'm using it in process
context where interrupts are disabled, specifically, the idle thread.

> There's pm_runtime_put() exactly for this purpose that puts the
> _idle() call into a workqueue.

If I'm in my CPU's idle path, I don't want to activate a workqueue
because then I'll no longer be idle.

Kevin
