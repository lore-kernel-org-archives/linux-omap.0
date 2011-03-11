From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: RE: [PATCH v2 00/19] OMAP4: PM: Suspend,CPU-hotplug and CPUilde support.
Date: Fri, 11 Mar 2011 23:28:33 +0530
Message-ID: <420e5c6f0aff0bbd23b7f3e9c190ca97@mail.gmail.com>
References: <1299766095-23879-1-git-send-email-santosh.shilimkar@ti.com><87d3lycu0h.fsf@ti.com><3b3d5e28815aa8bcedf6f43688f403b5@mail.gmail.com><871v2dd58y.fsf@ti.com><f1ee9adb49c6dbc49205c5ba70007e9a@mail.gmail.com>
 <87k4g5a6n5.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:52685 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752826Ab1CKR6f (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 11 Mar 2011 12:58:35 -0500
Received: by mail-qy0-f178.google.com with SMTP id 2so2850528qyk.16
        for <linux-omap@vger.kernel.org>; Fri, 11 Mar 2011 09:58:34 -0800 (PST)
In-Reply-To: <87k4g5a6n5.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>

> -----Original Message-----
> From: Kevin Hilman [mailto:khilman@ti.com]
> Sent: Friday, March 11, 2011 11:20 PM
> To: Santosh Shilimkar
> Cc: linux-omap@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org; Rajendra Nayak
> Subject: Re: [PATCH v2 00/19] OMAP4: PM: Suspend,CPU-hotplug and
> CPUilde support.
>
> Santosh Shilimkar <santosh.shilimkar@ti.com> writes:
>
[...]

> >> I prefer to drop it completely for OMAP4.
> >>
> > OK. Lets do that.
> >
> > Just to not miss your point here, what I understood here
> > is default suspend state on OMAP$B will be off mode.
> >
> > We still keep "enable_off_mode" flag for testing so that we
> > can disable off mode to debug regressions.
> >
> > Is that right?
>
> No, I want to drop "enable_off_mode" all together for OMAP4.
>
> If you want to change any powerdomain's default next_state, you can
> use
> the <debugfs>/pm_debug/*_pwrdm/suspend controls.
>
Thanks for clarification. The change is quite trivial. Will
update the branch with this change.
After testing it, will intimate you

Regards
Santosh
