From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 1/3] OMAP: PM: formalize idle notifications
Date: Fri, 22 Oct 2010 15:00:22 -0700
Message-ID: <8762wt7urt.fsf@deeprootsystems.com>
References: <1287617483-24170-1-git-send-email-khilman@deeprootsystems.com>
	<20101022180553.GD17595@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:53795 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752858Ab0JVWAY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 22 Oct 2010 18:00:24 -0400
Received: by pzk3 with SMTP id 3so324892pzk.19
        for <linux-omap@vger.kernel.org>; Fri, 22 Oct 2010 15:00:24 -0700 (PDT)
In-Reply-To: <20101022180553.GD17595@atomide.com> (Tony Lindgren's message of
	"Fri, 22 Oct 2010 11:05:53 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Tony Lindgren <tony@atomide.com> writes:

> * Kevin Hilman <khilman@deeprootsystems.com> [101020 16:22]:
>> Currently in the idle path, we have custom function calls into device
>> code to handle device specific actions that need to be coordinated CPU
>> idle transitions. Rather than continue this ad-hoc method of calling
>> device code from the PM core, create a formal way for device/driver
>> code to register for idle notifications.
>> 
>> Idle notifications are done late in the idle path when interrupts are
>> disabled, hence use atomic notifier chains.  These notifications will
>> also be atomic with respect to CPU idle transitions.
>
> ...
>
>> +EXPORT_SYMBOL_GPL(omap_idle_notifier_register);
>> +EXPORT_SYMBOL_GPL(omap_idle_notifier_unregister);
>
> Let's rather set this up as a generic framework to avoid adding
> more omap specific frameworks to the drivers.

Hmm, I thought I removed those EXPORT_SYMBOLs, just for that reason.  

I actually don't really intend these to be used from drivers, but only
from OMAP-specific device code.  We currently use these manly for errata
purposes, but also for UART debug purposes, and only from device code
currently.

That being said, I did consider a generic framework for this (x86_64 has
it's own idle notfiers as well), and this topic something already on the
table for LPC PM miniconf.  However, at least for OMAP, the location of
when the notifiers are triggered has to be in OMAP-specific code.  It
cannot be in the ARM-generic idle path (like they do in x86_64.)

The reason is because the idle notifiers have to be called *after* the
OMAP-specific idle path has programmed the next power states for the
various power domains.  That way, the idle notifiers can read the next
power state regs and make decisons on what they need to do (or not to
do) based on whether he power domain is going to RET, OFF, etc.

Kevin



