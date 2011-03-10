From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH] perf: add OMAP support for the new power events
Date: Thu, 10 Mar 2011 09:17:00 +0100
Message-ID: <AANLkTi=4PXfF9upXi4hJ5unVyhWSzLBdejbitydy2vpn@mail.gmail.com>
References: <1298052645-4164-1-git-send-email-j-pihet@ti.com>
	<1299147943-2929-1-git-send-email-j-pihet@ti.com>
	<alpine.DEB.2.00.1103091759300.15132@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f181.google.com ([209.85.216.181]:39461 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751041Ab1CJIRB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 10 Mar 2011 03:17:01 -0500
Received: by qyg14 with SMTP id 14so1201410qyg.19
        for <linux-omap@vger.kernel.org>; Thu, 10 Mar 2011 00:17:00 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1103091759300.15132@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Thomas Renninger <trenn@suse.de>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@ti.com>, Jean Pihet <j-pihet@ti.com>

Hi Paul,

On Thu, Mar 10, 2011 at 2:04 AM, Paul Walmsley <paul@pwsan.com> wrote:
> On Thu, 3 Mar 2011, Jean Pihet wrote:
>
>> The patch adds the new power management trace points for
>> the OMAP architecture.
>>
>> The trace points are for:
>> - default idle handler. Since the cpuidle framework is
>> =A0 instrumented in the generic way there is no need to
>> =A0 add trace points in the OMAP specific cpuidle handler;
>> - cpufreq (DVFS),
>> - SoC clocks changes (enable, disable, set_rate),
>> - power domain states: the desired target state and -if different-
>> =A0 the actually hit state.
>>
>> Because of the generic nature of the changes, OMAP3 and OMAP4 are su=
pported.
>>
>> Tested on OMAP3 with suspend/resume, cpuidle, basic DVFS.
>>
>> Signed-off-by: Jean Pihet <j-pihet@ti.com>
>
> In terms of tracing powerdomain state changes, since OMAP powerdomain=
s can
> potentially transition without the MPU knowing about it, some powerdo=
main
> transitions will be missed by these. =A0(The software counters miss t=
hem
> too.) =A0The only way to be certain about these is to watch the debug
> observability lines. =A0Still, it is the rare board that brings out d=
ebobs
> lines. =A0So this seems reasonable, as long as people don't expect 10=
0%
> coverage.
OK that is correct. The events are tracing SW events only, i.e. a
trace is generated when a decision is made wrt next power states,
clock changes etc.
A remark: the OMAP4+ HW tracing modules do support the changes of
power domains states. There definitely is more to come on that topic!

Thanks for reviewing!
Jean

>
> For the clock and powerdomain changes,
>
> Acked-by: Paul Walmsley <paul@pwsan.com>
>
>
> - Paul
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
