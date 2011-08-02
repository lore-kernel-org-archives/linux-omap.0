From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 02/11] PM: extend PM QoS with per-device wake-up constraints
Date: Tue, 02 Aug 2011 10:49:39 -0700
Message-ID: <87bow7ln4c.fsf@ti.com>
References: <1309446685-17502-1-git-send-email-j-pihet@ti.com>
	<1309446685-17502-3-git-send-email-j-pihet@ti.com>
	<201107022310.50175.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog123.obsmtp.com ([74.125.149.149]:49794 "EHLO
	na3sys009aog123.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754330Ab1HBRto (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Aug 2011 13:49:44 -0400
Received: by pzk5 with SMTP id 5so27577pzk.3
        for <linux-omap@vger.kernel.org>; Tue, 02 Aug 2011 10:49:43 -0700 (PDT)
In-Reply-To: <201107022310.50175.rjw@sisk.pl> (Rafael J. Wysocki's message of
	"Sat, 2 Jul 2011 23:10:49 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: jean.pihet@newoldbits.com, Paul Walmsley <paul@pwsan.com>, Magnus Damm <magnus.damm@gmail.com>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org, markgross@thegnar.org, Jean Pihet <j-pihet@ti.com>

"Rafael J. Wysocki" <rjw@sisk.pl> writes:

> Hi,
>
> On Thursday, June 30, 2011, jean.pihet@newoldbits.com wrote:
>> From: Jean Pihet <j-pihet@ti.com>
>> 
>> - add a new PM QoS class PM_QOS_DEV_WAKEUP_LATENCY for device wake-up
>> constraints. Due to the per-device nature of the new class the constraints
>> list is stored inside the device dev_pm_info struct instead of the internal
>> per-class constraints lists.
>
> I think PM_QOS_DEV_LATENCY might be a better name.
>
>> The new class is only available from kernel drivers and so is not exported
>> to user space.
>
> It should be available to user space, however, because in many cases drivers
> simply have no idea what values to use (after all, the use decides if he
> wants to trade worse video playback quality for better battery life, for
> example).
>

FWIW, I think it's wrong to expose the raw per-device constraints
directly to userspace.

I think it's the responsibility of the subsystems (video, audio, input,
etc.) to expose QoS knobs to userspace as they see fit and now allow
userspace to tinker directly with QoS constraints.

Kevin

