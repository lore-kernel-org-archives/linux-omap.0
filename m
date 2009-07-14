From: Kalle Valo <kalle.valo@iki.fi>
Subject: Re: N8x0 to mainline patches
Date: Tue, 14 Jul 2009 08:10:22 +0300
Message-ID: <87my776e9t.fsf@litku.valot.fi>
References: <200907130950.09887.luke@dashjr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f228.google.com ([209.85.218.228]:46154 "EHLO
	mail-bw0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753423AbZGNFK0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Jul 2009 01:10:26 -0400
Received: by bwz28 with SMTP id 28so558546bwz.37
        for <linux-omap@vger.kernel.org>; Mon, 13 Jul 2009 22:10:24 -0700 (PDT)
In-Reply-To: <200907130950.09887.luke@dashjr.org> (Luke-Jr's message of "Mon\, 13 Jul 2009 09\:49\:55 -0500")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Luke-Jr <luke@dashjr.org>
Cc: linux-omap@vger.kernel.org

"Luke-Jr" <luke@dashjr.org> writes:

> I noticed that the patch adding board-n8x0.c seems to be much smaller
> than the older one used in Linux-OMAP. In particular, it lacks the
> keymaps and such. Are those somewhere else now?

It's just not implemented yet. If you look at the plan, you see lots of
things we need to implement:

http://www.elinux.org/N800#The_Plan

> Was the Linux-OMAP keyboard bug taken into consideration for the new
> keyboard config struct?

I'm not familiar with the issue. But if it makes sense, sure, we want to
include the fix.

-- 
Kalle Valo
