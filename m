From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH] perf: add OMAP support for the new power events
Date: Mon, 7 Feb 2011 17:05:37 +0100
Message-ID: <AANLkTim7H_RZ2pSjSuYB1nCUkDx5K59r_i2JuSpjHVuK@mail.gmail.com>
References: <1295878857-8983-1-git-send-email-j-pihet@ti.com>
	<8d92d0aaa1ed67af244e8b50f9de372e@mail.gmail.com>
	<AANLkTikJY2bf=ryXFAkJNZVU2A38wvEAmxipy8gJTow1@mail.gmail.com>
	<03564f8422854f071ee2c8caaa007ea3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:55020 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751318Ab1BGQFj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Feb 2011 11:05:39 -0500
Received: by qwa26 with SMTP id 26so3531703qwa.19
        for <linux-omap@vger.kernel.org>; Mon, 07 Feb 2011 08:05:38 -0800 (PST)
In-Reply-To: <03564f8422854f071ee2c8caaa007ea3@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>, Tony Lindgren <tony@atomide.com>
Cc: Thomas Renninger <trenn@suse.de>, linux-omap@vger.kernel.org, Jean Pihet-XID <j-pihet@ti.com>

Hi Santosh, Tony,

On Wed, Jan 26, 2011 at 11:06 AM, Santosh Shilimkar
<santosh.shilimkar@ti.com> wrote:
>> -----Original Message-----
>> From: Jean Pihet [mailto:jean.pihet@newoldbits.com]
>> Sent: Wednesday, January 26, 2011 3:20 PM
>> To: Santosh Shilimkar
>> Cc: Thomas Renninger; linux-omap@vger.kernel.org; Jean Pihet-XID
>> Subject: Re: [PATCH] perf: add OMAP support for the new power events
>>
> [...]
>
>> > We need to track the actual power domain transitions as well
>> > at hardware level.
>> Agree
>>
>> > Can you please look at "pwrdm_pre_transition()" and
>> > "pwrdm_post_transition()"
>> > This code keep track of it using the next power state
>> > and prev-power state.
>> The current API only has 'trace_power_domain_target' which tracks
>> the
>> desired target state.
>> I think we need an extra tracer 'trace_power_domain_hitstate' so
>> that
>> the trace parser can compare the desired ('target') and actually hit
>> ('hitstate') states.
>>
> We use next state and previous state. 'hitstate' doesn't sound
> well that's really secondary.
>
> Do you plan to add that additional trace then ?
Yes that is idea, although adding new events in the power trace API
has been proved as quite difficult to get accepted. In any case this
will be done separately (iow it is not part of this patch).

Also this patch also supports OMAP4 since the changes are in the
generic PM frameworks. Thanks to the OMAP PM arch guys ;p

Is the patch OK? If so can it be queued in the l-o tree?

>
> Regards,
> Santosh
>

Regards,
Jean
