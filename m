From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 2/2] ARM: OMAP3: PM: cpuidle: optimize the clkdm idle latency in C1 state
Date: Fri, 01 Jun 2012 09:13:03 -0700
Message-ID: <87pq9jt3hs.fsf@ti.com>
References: <1336560912-26753-1-git-send-email-j-pihet@ti.com>
	<1336560912-26753-2-git-send-email-j-pihet@ti.com>
	<87pq9k1fhd.fsf@ti.com>
	<CAORVsuWeHJufTA+MMg1OUNjqVdoUn0M80-atnFB5B7d4jU3eDA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog131.obsmtp.com ([74.125.149.247]:56400 "EHLO
	na3sys009aog131.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S965349Ab2FAQNE convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 1 Jun 2012 12:13:04 -0400
Received: by dadv36 with SMTP id v36so2875432dad.41
        for <linux-omap@vger.kernel.org>; Fri, 01 Jun 2012 09:13:02 -0700 (PDT)
In-Reply-To: <CAORVsuWeHJufTA+MMg1OUNjqVdoUn0M80-atnFB5B7d4jU3eDA@mail.gmail.com>
	(Jean Pihet's message of "Fri, 1 Jun 2012 17:14:17 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: Grazvydas Ignotas <notasas@gmail.com>, linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, Jean Pihet <j-pihet@ti.com>

Jean Pihet <jean.pihet@newoldbits.com> writes:

> Hi Kevin,
>
> On Thu, May 31, 2012 at 6:29 PM, Kevin Hilman <khilman@ti.com> wrote:
>> jean.pihet@newoldbits.com writes:
>>
>>> From: Jean Pihet <j-pihet@ti.com>
>>>
>>> It is not needed to iterate through all the clock domains of a
>>> power domain in order to allow or deny it to idle.
>>
>> Why? =C2=A0(I know the answer, but would like it answered here.)
>>
>>> This patch allows or denies only the first registered clock domain
>>> of a power domain, and so optimizes the latency of the low power
>>> code. The functions _cpuidle_allow_idle and _cpuidle_deny_idle are
>>> not used anymore and so are removed.
>>>
>>> Signed-off-by: Jean Pihet <j-pihet@ti.com>
>>
>> Other than the changelog update, it looks good but also needs a reba=
se
>> like the previous patch.
>>
>> After that, I'll add them to my for_3.6/pm/performance branch and qu=
eue
>> for v3.6.
> The new series has been sent as '[PATCH 0/3] ARM: OMAP3: PM: optimize
> cpuidle C1 state latency' with the suggested changes (changelog
> updated, rebased on for_3.6/pm/performance).
>
> Note: with the code from the branch the CORE does not idle. The
> optimization changes have been tested OK though.

That's OK, I know the causes of the CORE idle retention problems and
have fixes for those queued up.

Thanks,

Kevin

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
