From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCHv9 2/8] ARM: OMAP4: PM: add errata support
Date: Tue, 06 Nov 2012 13:52:43 -0800
Message-ID: <87d2zq761g.fsf@deeprootsystems.com>
References: <1350552010-28760-1-git-send-email-t-kristo@ti.com>
	<1350552010-28760-3-git-send-email-t-kristo@ti.com>
	<87zk2vekye.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:47293 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753137Ab2KFVwq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 Nov 2012 16:52:46 -0500
Received: by mail-pa0-f46.google.com with SMTP id hz1so639076pad.19
        for <linux-omap@vger.kernel.org>; Tue, 06 Nov 2012 13:52:46 -0800 (PST)
In-Reply-To: <87zk2vekye.fsf@deeprootsystems.com> (Kevin Hilman's message of
	"Mon, 05 Nov 2012 14:36:25 -0800")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, linux-arm-kernel@lists.infradead.org

Kevin Hilman <khilman@deeprootsystems.com> writes:

> Tero Kristo <t-kristo@ti.com> writes:
>
>> Added similar PM errata flag support as omap3 has. This should be used
>> in similar manner, set the flags during init time, and check the flag
>> values during runtime.
>>
>> Signed-off-by: Tero Kristo <t-kristo@ti.com>
>
> These allow basic suspend/resume to work on 4460/Panda-ES, so I'm going
> to queue these up as fixes.
>
> However, since they're not technically regressions, it may be too late
> to get them in for v3.7, but they'll be in for v3.8 for sure.

To be more specific, I'm planning on queuing patches 2, 3 and 6 as fixes
for v3.8 (branch: for_3.8/fixes/pm).

Paul has already queued patch 1, so that leaves patches 4, 5, 7 & 8.

I think we can get this series in for v3.8 if we drop the functional
pwrst dependency.  To test, I dropped patches 5 & 7, and tested on
4430/Panda and 4460/Panda-ES (with latest mainline u-boot) and CORE
is hitting retention just fine in suspend.

If you can respin patch 8 based on the feedback from Felipe, I'll queue
up patches 4 & 8 for v3.8 as well, then we'll at least have CORE
retention in suspend in mainline.  Then, the  rest can be done when
functional pwrsts are ready.

Kevin

P.S. do you have any patches to add any OMAP4 CPUidle support for CORE
     retention?
Paul has already queued patch 1, and that leaves the 

