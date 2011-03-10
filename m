From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH] perf: add OMAP support for the new power events
Date: Thu, 10 Mar 2011 10:15:05 -0800
Message-ID: <87k4g6deqe.fsf@ti.com>
References: <1298052645-4164-1-git-send-email-j-pihet@ti.com>
	<1299147943-2929-1-git-send-email-j-pihet@ti.com>
	<878vwnvnvj.fsf@ti.com>
	<AANLkTikaQ69Rt9Q6vtm8F_S=qLftM=yqjrUcTqj2Rihm@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:56361 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752030Ab1CJSPL convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 10 Mar 2011 13:15:11 -0500
Received: by mail-gy0-f169.google.com with SMTP id 13so1041582gyb.14
        for <linux-omap@vger.kernel.org>; Thu, 10 Mar 2011 10:15:09 -0800 (PST)
In-Reply-To: <AANLkTikaQ69Rt9Q6vtm8F_S=qLftM=yqjrUcTqj2Rihm@mail.gmail.com>
	(Jean Pihet's message of "Thu, 10 Mar 2011 09:09:37 +0100")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: Thomas Renninger <trenn@suse.de>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Jean Pihet <j-pihet@ti.com>

Jean Pihet <jean.pihet@newoldbits.com> writes:

> On Thu, Mar 10, 2011 at 1:08 AM, Kevin Hilman <khilman@ti.com> wrote:
>> Jean Pihet <jean.pihet@newoldbits.com> writes:
>>
>>> The patch adds the new power management trace points for
>>> the OMAP architecture.
>>>
>>> The trace points are for:
>>> - default idle handler. Since the cpuidle framework is
>>> =C2=A0 instrumented in the generic way there is no need to
>>> =C2=A0 add trace points in the OMAP specific cpuidle handler;
>>> - cpufreq (DVFS),
>>
>> Minor: AFAICT, this patch doesn't instrument CPUfreq.
> The generic framework provides a cpu_frequency event. Furthermore the
> clock_set_rate events are reporting the various SoC clock rate
> changes.
> Indeed the changelog is not accurate enough. Is '- cpufreq (DVFS)
> events are covered by the generic cpu_frequency events and the SoC
> clock changes events' better?

I'd prefer to just leave this out as either way, I find it confusing
based on the content of this patch.

Kevin
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
