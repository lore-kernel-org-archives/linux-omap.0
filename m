From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: RE: [PATCH] perf: add OMAP support for the new power events
Date: Wed, 26 Jan 2011 15:36:16 +0530
Message-ID: <03564f8422854f071ee2c8caaa007ea3@mail.gmail.com>
References: <1295878857-8983-1-git-send-email-j-pihet@ti.com><8d92d0aaa1ed67af244e8b50f9de372e@mail.gmail.com>
 <AANLkTikJY2bf=ryXFAkJNZVU2A38wvEAmxipy8gJTow1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:42699 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752286Ab1AZKGT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 26 Jan 2011 05:06:19 -0500
Received: by fxm14 with SMTP id 14so804667fxm.9
        for <linux-omap@vger.kernel.org>; Wed, 26 Jan 2011 02:06:17 -0800 (PST)
In-Reply-To: <AANLkTikJY2bf=ryXFAkJNZVU2A38wvEAmxipy8gJTow1@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: Thomas Renninger <trenn@suse.de>, linux-omap@vger.kernel.org, Jean Pihet-XID <j-pihet@ti.com>

> -----Original Message-----
> From: Jean Pihet [mailto:jean.pihet@newoldbits.com]
> Sent: Wednesday, January 26, 2011 3:20 PM
> To: Santosh Shilimkar
> Cc: Thomas Renninger; linux-omap@vger.kernel.org; Jean Pihet-XID
> Subject: Re: [PATCH] perf: add OMAP support for the new power events
>
[...]

> > We need to track the actual power domain transitions as well
> > at hardware level.
> Agree
>
> > Can you please look at "pwrdm_pre_transition()" and
> > "pwrdm_post_transition()"
> > This code keep track of it using the next power state
> > and prev-power state.
> The current API only has 'trace_power_domain_target' which tracks
> the
> desired target state.
> I think we need an extra tracer 'trace_power_domain_hitstate' so
> that
> the trace parser can compare the desired ('target') and actually hit
> ('hitstate') states.
>
We use next state and previous state. 'hitstate' doesn't sound
well that's really secondary.

Do you plan to add that additional trace then ?

Regards,
Santosh
