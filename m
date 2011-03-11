From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: RE: [PATCH v2 00/19] OMAP4: PM: Suspend, CPU-hotplug and CPUilde support.
Date: Fri, 11 Mar 2011 18:01:12 +0530
Message-ID: <49a5273c412bf9193a9f930e990d22d4@mail.gmail.com>
References: <1299766095-23879-1-git-send-email-santosh.shilimkar@ti.com>
 <87d3lycu0h.fsf@ti.com> 3b3d5e28815aa8bcedf6f43688f403b5@mail.gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog106.obsmtp.com ([74.125.149.77]:46366 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752674Ab1CKMbQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 11 Mar 2011 07:31:16 -0500
Received: by qyk27 with SMTP id 27so2493489qyk.6
        for <linux-omap@vger.kernel.org>; Fri, 11 Mar 2011 04:31:14 -0800 (PST)
In-Reply-To: 3b3d5e28815aa8bcedf6f43688f403b5@mail.gmail.com
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, Rajendra Nayak <rnayak@ti.com>, linux-arm-kernel@lists.infradead.org

Kevin,
> -----Original Message-----
> From: Santosh Shilimkar [mailto:santosh.shilimkar@ti.com]
> Sent: Friday, March 11, 2011 11:22 AM
> To: Kevin Hilman
> Cc: 'linux-omap@vger.kernel.org'; Rajendra Nayak; 'linux-arm-
> kernel@lists.infradead.org'
> Subject: RE: [PATCH v2 00/19] OMAP4: PM: Suspend, CPU-hotplug and
> CPUilde support.
>
> > -----Original Message-----
> > From: Kevin Hilman [mailto:khilman@ti.com]
> > Sent: Friday, March 11, 2011 7:13 AM
> > To: Santosh Shilimkar
> > Cc: linux-omap@vger.kernel.org; rnayak@ti.com; linux-arm-
> > kernel@lists.infradead.org
> > Subject: Re: [PATCH v2 00/19] OMAP4: PM: Suspend, CPU-hotplug and
> > CPUilde support.
> >
> > Hi Santosh,
> >
> > Santosh Shilimkar <santosh.shilimkar@ti.com> writes:
> [....]
>
> >
> > This series doesn't boot on ES1 (boot log below.)  Do we need to
> > totally prevent WFI on ES1?
> >
Nope. WFI is ok.
The ES1.0 boot issue on pm-core branch doesn't seems to
be related to this series. Without this series as well
OMAP4 ES1.0 is not booting for me. When I disable
CONFIG_PM + WATCHDOG fix, it booted ok. I will
git-bisect this later on pm-core branch.

> > Also, if we want a CPUidle enabled kernel to boot on all silicon,
> > it will need a omap_rev() check during init to ensure it doesn't
> > override the default idle path.
> >
OMAP4 PM series already takes care of not overriding
the default idle path for ES1.0. The omap4_mpuss_init()
fails on ES1.0 and hence the CPUidle init is skipped in
that case.

Just to further check, I pulled the latest omap-for-linus
branch and merged Paul's pull-request into it. Then
applied OMAP4 PM series and I got a boot crash, a different
one. This was again related to clock-domain initialization
and static deps. I fixed this issue by avoiding omap4_pm_init()
code running on ES1.0. With this boot on ES1.0 works fine now
with OMAP4 PM series.

Posted the patch for the same.
https://patchwork.kernel.org/patch/628231/


The rebased series against
	Latest 'omap-for-linus + Paul's pull-request'
have pushed to below branch.

git://dev.omapzoom.org/pub/scm/santosh/kernel-omap4-base.git
omap4_pm_for-next_v3

Regards,
Santosh
