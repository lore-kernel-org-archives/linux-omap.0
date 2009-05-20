From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] OMAP3: PM: remove save/restore of exception handler state
Date: Wed, 20 May 2009 09:12:25 -0700
Message-ID: <87d4a3rbx2.fsf@deeprootsystems.com>
References: <1242753878-28325-1-git-send-email-khilman@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.174]:37999 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755477AbZETQM0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 20 May 2009 12:12:26 -0400
Received: by wf-out-1314.google.com with SMTP id 26so178199wfd.4
        for <linux-omap@vger.kernel.org>; Wed, 20 May 2009 09:12:28 -0700 (PDT)
In-Reply-To: <1242753878-28325-1-git-send-email-khilman@deeprootsystems.com> (Kevin Hilman's message of "Tue\, 19 May 2009 10\:24\:38 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Kevin Hilman <khilman@deeprootsystems.com> writes:

> The exception handler state for the various modes of the processor
> (FIQ, IRQ, ABORT, UNDEF, SYSTEM) does not need a full context
> save/restore.  Only the stack pointers for the used modes need a
> save/restore and this is done already in the ARM-generic cpu_init()
> function.
>
> So, this patch drops the full save/restore and calls cpu_init()
> immiediately after returning from SRAM.
>
> Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>

Pushing to the PM branch.

Kevin
