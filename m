From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: RE: [PATCH 00/17] omap4: pm: suspend, hotplug and cpuilde support
Date: Fri, 4 Mar 2011 22:50:23 +0530
Message-ID: <aac02e1097a15c84cf795db5bfc49b48@mail.gmail.com>
References: <1298112158-28469-1-git-send-email-santosh.shilimkar@ti.com> <87oc5txf0d.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:36165 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759851Ab1CDRUd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 Mar 2011 12:20:33 -0500
Received: by mail-qw0-f41.google.com with SMTP id 7so1927671qwd.28
        for <linux-omap@vger.kernel.org>; Fri, 04 Mar 2011 09:20:31 -0800 (PST)
In-reply-to: <87oc5txf0d.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

> -----Original Message-----
> From: Kevin Hilman [mailto:khilman@ti.com]
> Sent: Thursday, March 03, 2011 5:16 AM
> To: Santosh Shilimkar
> Cc: linux-omap@vger.kernel.org; linux-arm-kernel@lists.infradead.org
> Subject: Re: [PATCH 00/17] omap4: pm: suspend, hotplug and cpuilde
> support
>
> Santosh Shilimkar <santosh.shilimkar@ti.com> writes:
>
> > This series adds OMAP4 suspend and cpuidle support till MPU
> subsystem
> > (MPUSS) off-mode. The suspend on SMP machines uses cpu-hotplug
> > infrastructure to take down the non-boot CPUs. We put secondary
> > CPU(CPU1 in OMAP4) to OFF state via cpu-hotplug.
> > In cpuidle too, low power states are attempted only when the
> > CPU1 is put to OFF state via cpu-hotplug because of hardware
> > constraints.
>
> Minor nit on patch subjects:  both OMAP and PM are acronyms, please
> capitalize.
>
> Also, can you rebase this on Paul's integration-2.6.39 branch?
> There
> are several things in this series that conflict with changes there.
>

Rebased branch against your pm-core.

git://dev.omapzoom.org/pub/scm/santosh/kernel-omap4-base.git
omap4_pm_for-next

Regards,
Santosh
