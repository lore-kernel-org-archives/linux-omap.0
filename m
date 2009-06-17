From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [APPLIED] [PATCH 2/2] OMAP: Zoom2: Fix file system loading issue
Date: Wed, 17 Jun 2009 08:54:39 -0700
Message-ID: <87vdmuyhxc.fsf@deeprootsystems.com>
References: <notify-1245247047@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f189.google.com ([209.85.216.189]:52961 "EHLO
	mail-px0-f189.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752667AbZFQPyk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 17 Jun 2009 11:54:40 -0400
Received: by pxi27 with SMTP id 27so476651pxi.33
        for <linux-omap@vger.kernel.org>; Wed, 17 Jun 2009 08:54:42 -0700 (PDT)
In-Reply-To: <notify-1245247047@atomide.com> (Tony Lindgren's message of "Wed\, 17 Jun 2009 09\:57\:26 -0400")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, vikram.pandita@ti.com
Cc: linux-omap@vger.kernel.org

Tony Lindgren <tony@atomide.com> writes:

> This patch has been applied to the linux-omap
> by youw fwiendly patch wobot.
>
> Branch in linux-omap: omap-fixes
>
> Initial commit ID (Likely to change): f84eca35d44fd64cdde542f12d08eb04ca534954
>
> PatchWorks
> http://patchwork.kernel.org/patch/29668/
>
> Git (Likely to change, and takes a while to get mirrored)
> http://git.kernel.org/?p=linux/kernel/git/tmlind/linux-omap-2.6.git;a=commit;h=f84eca35d44fd64cdde542f12d08eb04ca534954

Sorry, I didn't get to this beforethe merge, but $SUBJECT for this
patch is wrong and not terribly helpful.  It refers to the symptom, bu
tnot the root cause.

It should be something like: 

OMAP3: Zoom2: pass IRQ triggering flags for serial driver

Kevin


