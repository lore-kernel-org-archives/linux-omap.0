From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: OMAP PM status?
Date: Wed, 12 Aug 2009 16:22:22 -0700
Message-ID: <873a7wsjm9.fsf@deeprootsystems.com>
References: <87bpmkkegw.fsf@litku.valot.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.171]:49837 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752874AbZHLXWY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 12 Aug 2009 19:22:24 -0400
Received: by wf-out-1314.google.com with SMTP id 26so113151wfd.4
        for <linux-omap@vger.kernel.org>; Wed, 12 Aug 2009 16:22:25 -0700 (PDT)
In-Reply-To: <87bpmkkegw.fsf@litku.valot.fi> (Kalle Valo's message of "Wed\, 12 Aug 2009 22\:40\:47 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kalle Valo <kalle.valo@iki.fi>
Cc: linux-omap@vger.kernel.org

Hi Kalle,

Kalle Valo <kalle.valo@iki.fi> writes:

> as you might guess, I'm eagerly waiting for OMAP PM support to hit
> mainline :) I'm just curious, what's the current status? Are we
> going to get PM support in 2.6.32?

Hmmm, good question.  To avoid giving an answer that can be archived
and used against me, I updated the PM branch wiki page[1] with a
'mainline plans' section[2] which I can edit as plans slip^Wchange. :)

> Especially I'm interested about 2420 support for n8x0.

Well, I'm afraid I've done basically no testing for OMAP2, and have
been focusing solely on OMAP3.  I'm pretty sure things at least should
compile for OMAP2, as care has been taken to keep OMAP2 up to speed
with OMAP3 for the base features, but I haven't done any boot testing
on OMAP2 for some time.

That being said, all the infrastructure for OMAP2 that was in
linux-omap is already in mainline so will work as good as it did in
linux-omap.  The last time I actually tried PM on OMAP2, I found/fixed
a bug[3] in the asm sleep code for OMAP2 that was causing fault.  At
least it no longer faults when suspended

Of course, I'll be glad to take any OMAP2 patches/fixes and get them
upstream with the rest of my changes, but I'm afraid with my current
plans, I do not have the cycles to spend on OMAP2.

Kevin


[1] http://elinux.org/OMAP_Power_Management
[2] http://elinux.org/OMAP_Power_Management#mainline_plans
[3] http://git.kernel.org/?p=linux/kernel/git/tmlind/linux-omap-2.6.git;a=commit;h=c4adf767e0569c712f7c44ba37c4df9b47ea4121
