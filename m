From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: RE: [PATCH v2 00/19] OMAP4: PM: Suspend, CPU-hotplug and CPUilde support.
Date: Fri, 25 Mar 2011 12:35:00 +0530
Message-ID: <86f296cd6f86c03bc066efaf7cf2b537@mail.gmail.com>
References: <1299766095-23879-1-git-send-email-santosh.shilimkar@ti.com><87d3lycu0h.fsf@ti.com><49a5273c412bf9193a9f930e990d22d4@mail.gmail.com><87pqpxbqho.fsf@ti.com>
 <87mxkk1rni.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:36406 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932268Ab1CYHFH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 25 Mar 2011 03:05:07 -0400
Received: by gwj22 with SMTP id 22so425234gwj.21
        for <linux-omap@vger.kernel.org>; Fri, 25 Mar 2011 00:05:06 -0700 (PDT)
In-Reply-To: <87mxkk1rni.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, Rajendra Nayak <rnayak@ti.com>, linux-arm-kernel@lists.infradead.org

Kevin,
> -----Original Message-----
> From: Kevin Hilman [mailto:khilman@ti.com]
> Sent: Thursday, March 24, 2011 8:40 PM
> To: Santosh Shilimkar
> Cc: linux-omap@vger.kernel.org; Rajendra Nayak; linux-arm-
> kernel@lists.infradead.org
> Subject: Re: [PATCH v2 00/19] OMAP4: PM: Suspend, CPU-hotplug and
> CPUilde support.
>

[...]

>
> Hi Santosh,
>
> Can you rebase and repost your v3 series, I'd like to get this
> queued up early in the 2.6.40 dev cycle.
>
> You can base on my current pm-core branch, which also has Russell's
> devel-stable branch merged in.
>
I pulled your latest pm-core branch
------
commit 61cbb3172176b84c106bf0f4c32317c472932ab5
Merge: d0cf394... da19719...
Author: Kevin Hilman <khilman@ti.com>
Date:   Wed Mar 23 16:33:01 2011 -0700

    Merge branch 'for_2.6.40/pm-misc' into pm-reset
-----------------
Looks like Russell's devel branch isn't merged in pm-core.
I didn't find the relevant patches.

By the way the relevant ARM patches are already in
mainline. So if the pm-core is rebased against latest
mainline, we can get those changes as well.

Regards,
Santosh
