From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: RE: [PATCH 00/17] omap4: pm: suspend, hotplug and cpuilde support
Date: Thu, 3 Mar 2011 12:50:33 +0530
Message-ID: <b69f8a76bdde3e73f623c5c93c767b61@mail.gmail.com>
References: <1298112158-28469-1-git-send-email-santosh.shilimkar@ti.com> <87oc5txf0d.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:38900 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750707Ab1CCHUf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Mar 2011 02:20:35 -0500
Received: by mail-qy0-f172.google.com with SMTP id 29so5069534qyk.17
        for <linux-omap@vger.kernel.org>; Wed, 02 Mar 2011 23:20:34 -0800 (PST)
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
Will Fix that.

> Also, can you rebase this on Paul's integration-2.6.39 branch?
> There
> are several things in this series that conflict with changes there.
>
I did that already and found issues around static dependencies.
Rajendra and myself are sorting those out.

Will address the comments on this series and post v2.

Regards,
Santosh
