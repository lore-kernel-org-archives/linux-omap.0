From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: RE: [PATCH] perf: add OMAP support for the new power events
Date: Mon, 7 Feb 2011 21:42:18 +0530
Message-ID: <f3244f4cf3ff7a11a1f15d01ccae1608@mail.gmail.com>
References: <1295878857-8983-1-git-send-email-j-pihet@ti.com><8d92d0aaa1ed67af244e8b50f9de372e@mail.gmail.com><AANLkTikJY2bf=ryXFAkJNZVU2A38wvEAmxipy8gJTow1@mail.gmail.com><03564f8422854f071ee2c8caaa007ea3@mail.gmail.com>
 <AANLkTim7H_RZ2pSjSuYB1nCUkDx5K59r_i2JuSpjHVuK@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:48097 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751886Ab1BGQMU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Feb 2011 11:12:20 -0500
Received: by mail-gw0-f45.google.com with SMTP id a12so2160386gwa.18
        for <linux-omap@vger.kernel.org>; Mon, 07 Feb 2011 08:12:20 -0800 (PST)
In-Reply-To: <AANLkTim7H_RZ2pSjSuYB1nCUkDx5K59r_i2JuSpjHVuK@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Pihet <jean.pihet@newoldbits.com>, Tony Lindgren <tony@atomide.com>
Cc: Thomas Renninger <trenn@suse.de>, linux-omap@vger.kernel.org, Jean Pihet-XID <j-pihet@ti.com>

Jean,
> -----Original Message-----
> From: Jean Pihet [mailto:jean.pihet@newoldbits.com]
> Sent: Monday, February 07, 2011 9:36 PM
> To: Santosh Shilimkar; Tony Lindgren
> Cc: Thomas Renninger; linux-omap@vger.kernel.org; Jean Pihet-XID
> Subject: Re: [PATCH] perf: add OMAP support for the new power events
>
> Hi Santosh, Tony,
>
> On Wed, Jan 26, 2011 at 11:06 AM, Santosh Shilimkar
> <santosh.shilimkar@ti.com> wrote:
> >> -----Original Message-----
> >> From: Jean Pihet [mailto:jean.pihet@newoldbits.com]
> >> Sent: Wednesday, January 26, 2011 3:20 PM
> >> To: Santosh Shilimkar
> >> Cc: Thomas Renninger; linux-omap@vger.kernel.org; Jean Pihet-XID
> >> Subject: Re: [PATCH] perf: add OMAP support for the new power
> events
> >>
> > [...]
> >
> >> > We need to track the actual power domain transitions as well
> >> > at hardware level.
> >> Agree
> >>
> >> > Can you please look at "pwrdm_pre_transition()" and
> >> > "pwrdm_post_transition()"
> >> > This code keep track of it using the next power state
> >> > and prev-power state.
> >> The current API only has 'trace_power_domain_target' which tracks
> >> the
> >> desired target state.
> >> I think we need an extra tracer 'trace_power_domain_hitstate' so
> >> that
> >> the trace parser can compare the desired ('target') and actually
> hit
> >> ('hitstate') states.
> >>
> > We use next state and previous state. 'hitstate' doesn't sound
> > well that's really secondary.
> >
> > Do you plan to add that additional trace then ?
> Yes that is idea, although adding new events in the power trace API
> has been proved as quite difficult to get accepted. In any case this
> will be done separately (iow it is not part of this patch).
>
> Also this patch also supports OMAP4 since the changes are in the
> generic PM frameworks. Thanks to the OMAP PM arch guys ;p
>
> Is the patch OK? If so can it be queued in the l-o tree?
>
I just looked at from the current need of DEBUG counters
and commented what needs to be supported.

Am ok with the patch, but that means we still need to keep using
and supporting PM debug counters till we support the additional
trace events.

May be Kevin/Paul can take a call on this.

Regards,
Santosh
