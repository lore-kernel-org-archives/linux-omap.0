From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: RE: Kernel hang on OMAP3 based Beagle board, RTC issue?
Date: Sat, 5 Jul 2008 18:52:47 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB022BFE73BE@dbde02.ent.ti.com>
References: <486BDD2A.5070500@googlemail.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB022BB6621C@dbde02.ent.ti.com>
 <AF70E37B-038B-4117-B69F-B2BCD9EFF6AA@student.utwente.nl>
 <486F21F6.7020208@googlemail.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB022BFE73A2@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:35213 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753129AbYGENW5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 5 Jul 2008 09:22:57 -0400
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB022BFE73A2@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gadiyar, Anand" <gadiyar@ti.com>, Dirk Behme <dirk.behme@googlemail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi All,

<snip>

> > > Tried that and I get the same hang, so I don't think the RTC is to  blame.
> >
> > Short update just in case anybody has an idea:
> >
> > Gadiyar spent some time with git-bisect (thanks!):
> >
> > It seems that the bad commit is probably between:
> > # good: [3ffec4e18484c34838fa341de3848306c29ecd5d] 24XX: PM: Move pm.c to pm24xx.c
> > and sleep.S to sleep24xx.S
> > and # bad: [458776cfe389ff03bd6c56c47e059df0778cdfca] OMAP3430SDP:
> > Enable config options CONFIG_OMAP_RESET_CLOCKS and CONFIG_SUSPEND
> >
> > This is a 9-patch series by Jouni Hogander related to suspend and
> > power-management.
> >
> > Dirk
>
> I'm still working on the git-bisect. I'm currently waiting
> for ten minutes
> after boot before marking a commit good or bad. If the hang
> happens more
> than ten minutes after boot, I might miss that and mark the
> commit good - so
> I will re-check the good commits one more time and confirm.
>
> - Anand

As far as I can tell, the beagle hang issue aries after this commit:

397f49cde4e75cf662a23814097db35f3e6c6b62 is first bad commit
commit 397f49cde4e75cf662a23814097db35f3e6c6b62
Author: Jouni Hogander <jouni.hogander@nokia.com>
Date:   Fri May 16 13:58:25 2008 +0300

    34XX: PM: Initial version of suspend and dynamic retention

    This is initial version of suspend and dynamic retention for
    34xx. Omap is tried to put to full retention on suspend and pm_idle.

    Signed-off-by: Jouni Hogander <jouni.hogander@nokia.com>
    Signed-off-by: Tony Lindgren <tony@atomide.com>


Could someone please test and confirm if the previous commit works without a hang?
I waited for around 20 minutes and did not observe a hang.

These were the last two good commits I got from git-bisect.
# good: [1c66e10c850950a84da68cafb07022eab5e7eec0] 34XX: Suspend: Take suspend sram code from ti cdp kernel
git-bisect good 1c66e10c850950a84da68cafb07022eab5e7eec0
# good: [131ce2d1dd5081f97885419678a8b3211c7c2dee] 34XX: Add miscellaneous definitions related to 34xx

Regards,
Anand
