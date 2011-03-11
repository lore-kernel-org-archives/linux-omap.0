From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: RE: [PATCH v2 00/19] OMAP4: PM: Suspend, CPU-hotplug and CPUilde support.
Date: Fri, 11 Mar 2011 11:22:26 +0530
Message-ID: <3b3d5e28815aa8bcedf6f43688f403b5@mail.gmail.com>
References: <1299766095-23879-1-git-send-email-santosh.shilimkar@ti.com> <87d3lycu0h.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:42770 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751388Ab1CKFw3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 11 Mar 2011 00:52:29 -0500
Received: by mail-qw0-f47.google.com with SMTP id 2so1822106qwi.6
        for <linux-omap@vger.kernel.org>; Thu, 10 Mar 2011 21:52:28 -0800 (PST)
In-Reply-To: <87d3lycu0h.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, Rajendra Nayak <rnayak@ti.com>, linux-arm-kernel@lists.infradead.org

> -----Original Message-----
> From: Kevin Hilman [mailto:khilman@ti.com]
> Sent: Friday, March 11, 2011 7:13 AM
> To: Santosh Shilimkar
> Cc: linux-omap@vger.kernel.org; rnayak@ti.com; linux-arm-
> kernel@lists.infradead.org
> Subject: Re: [PATCH v2 00/19] OMAP4: PM: Suspend, CPU-hotplug and
> CPUilde support.
>
> Hi Santosh,
>
> Santosh Shilimkar <santosh.shilimkar@ti.com> writes:
[....]

>
> This series doesn't boot on ES1 (boot log below.)  Do we need to
> totally prevent WFI on ES1?
>
> Also, if we want a CPUidle enabled kernel to boot on all silicon, it
> will need a omap_rev() check during init to ensure it doesn't
> override the default idle path.
>
Make sense. Will try it on ES1.0 silicon.


[....]

> > off-mode debugfs control:
> > 	enable: $echo 1 > /proc/sys/debug/pm_debug/enable_off_mode
> > 	disable: $echo 0 > /proc/sys/debug/pm_debug/enable_off_mode
>
> Without enabling off-mode, I took CPU1 offline and see that it
> immediatly goes off.  This makes sense based on the HW, but not in
> light
> of the enable_off_mode flag.  For OMAP4, maybe it makes sense to not
> have the enable_off_mode flag at all?   We'll be getting rid of it
> on OMAP3 as soon as the constraints framework is ready, so maybe it
> makes sense to just go without it for OMAP4?
>
Actually that's expected since enable_off_mode flag doesn't manage CPUX
power domain states and they are always hit OFF. CSWR isn't
supported on CPUX power domains as captured in the series. But
I agree with you that it might be confusing.

[...]
> More confusion: another test (also with CPUidle enabled), I see that
> the MPU and DSS are also hitting off-mode:
>
This behavior changed when we dropped enable_off_mode flag to updated
C-states in favor of prepare() hooks. DSS showing OFF mode is because
of debug counter issue. DSS PD doesn't support previous power state
which these counter code is trying to read. There are couple of
patches from Rajendra and Thara do address this counter issues but
they are bit of hacky. May be we can get them on the list to discuss
further.

So just to summaries, on OMAP$ 'enable_off_mode' flag is
used __only__ in Suspend. CPUx power domain always hit OFF
mode no matter what is state of this flag because CSWR isn't
supported on these PD's.

We could remove this flag as well but thought that this might be
useful especially when we add CORE RET, DEVICE OFF support.

May be we keep this till the constraint frameworks comes in and
then drop it once for all. I am ok with whatever direction you
decide here.

Regards,
Santosh
