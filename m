From: Kevin Hilman <khilman@ti.com>
Subject: Re: [linux-pm] [RFC/PATCH v2] PM / Runtime: allow _put_sync() from interrupts-disabled context
Date: Tue, 26 Jul 2011 17:28:39 -0700
Message-ID: <87r55cpnwo.fsf@ti.com>
References: <1311371188-28879-1-git-send-email-khilman@ti.com>
	<201107240102.09698.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:45960 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751064Ab1G0A2m (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 26 Jul 2011 20:28:42 -0400
Received: by mail-pz0-f52.google.com with SMTP id 13so1715065pzd.11
        for <linux-omap@vger.kernel.org>; Tue, 26 Jul 2011 17:28:42 -0700 (PDT)
In-Reply-To: <201107240102.09698.rjw@sisk.pl> (Rafael J. Wysocki's message of
	"Sun, 24 Jul 2011 01:02:09 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-pm@lists.linux-foundation.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Alan Stern <stern@rowland.harvard.edu>, Colin Cross <ccross@android.com>

"Rafael J. Wysocki" <rjw@sisk.pl> writes:

> On Friday, July 22, 2011, Kevin Hilman wrote:
>> Currently the use of pm_runtime_put_sync() is not safe from
>> interrupts-disabled context because rpm_idle() will release the
>> spinlock and enable interrupts for the idle callbacks.  This enables
>> interrupts during a time where interrupts were expected to be
>> disabled, and can have strange side effects on drivers that expected
>> interrupts to be disabled.
>> 
>> This is not a bug since the documentation clearly states that only
>> _put_sync_suspend() is safe in IRQ-safe mode.
>> 
>> However, pm_runtime_put_sync() could be made safe when in IRQ-safe
>> mode by releasing the spinlock but not re-enabling interrupts, which
>> is what this patch aims to do.
>> 
>> Problem was found when using some buggy drivers that set
>> pm_runtime_irq_safe() and used _put_sync() in interrupts-disabled
>> context.
>> 
>> The offending drivers have been fixed to use _put_sync_suspend(),
>> But this patch is an RFC to see if it might make sense to allow
>> using _put_sync() from interrupts-disabled context.
>
> OK, I'm going to take this for 3.2.
>

OK, great.  Thanks.

Might want to just drop the last paragraph from the changelog since it
doesn't really belong in the permanant history.

Kevin
