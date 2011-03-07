From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 1/2] OMAP3: cpuidle: prevent CORE power domain from going to RET or OFF when DSS is on
Date: Mon, 07 Mar 2011 11:06:03 -0800
Message-ID: <871v2i7ntw.fsf@ti.com>
References: <20110301220833.32613.54669.stgit@twilight.localdomain>
	<20110301224918.32613.95176.stgit@twilight.localdomain>
	<87pqq7pz27.fsf@ti.com>
	<854C6400F5AA6644BA6FE7953F3E769B0380F12F@008-AM1MPN1-013.mgdnok.nokia.com>
	<87lj0uj048.fsf@ti.com>
	<854C6400F5AA6644BA6FE7953F3E769B0380FE45@008-AM1MPN1-013.mgdnok.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:50110 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754816Ab1CGTGI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Mar 2011 14:06:08 -0500
Received: by gwaa18 with SMTP id a18so2122442gwa.3
        for <linux-omap@vger.kernel.org>; Mon, 07 Mar 2011 11:06:06 -0800 (PST)
In-Reply-To: <854C6400F5AA6644BA6FE7953F3E769B0380FE45@008-AM1MPN1-013.mgdnok.nokia.com>
	(Tero Kristo's message of "Mon, 7 Mar 2011 12:02:22 +0000")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero.Kristo@nokia.com
Cc: paul@pwsan.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

<Tero.Kristo@nokia.com> writes:

[...]

>>>>>
>>>>> +	/* If DSS is active, prevent CORE RET/OFF */
>>>>> +	dss_state = pwrdm_read_pwrst(dss_pd);
>>>>> +	if (dss_state == PWRDM_POWER_ON &&
>>>>> +	    core_next_state != PWRDM_POWER_ON)
>>>>> +		core_next_state = PWRDM_POWER_INACTIVE;
>>>>> +
>>>>
>>>>Due to sleepdeps/autodeps, when this code runs, DSS powerdomain is
>>>>always on.  The result is that CORE is always set to INACTIVE.
>>>
>>> Now I recall that someone was asking about a patch similar to this
>>> earlier, and had the same issue with DSS sleepdep collision.
>>
>>>
>>> What is the reason for having the sleepdep for DSS powerdomain anyway?
>>> At least I can't see any reason why the sleepdep for DSS should be
>>> set. In my opinion it should be perfectly okay for DSS domain to idle
>>> independently of MPU/CORE, as this is going to be better for power
>>> consumption also.
>>
>>Agreed, but currently the sleepdeps with MPU are automatically managed
>>(by clkdm autodeps and hwmod initiator deps.)  Until we have merged a
>>solution to more selectively enable sleepdeps (or remove them) $SUBJECT
>>patch cannot be merged.
>
> Ok I thought this is the case... it would be possible to implement a
> temporary/permanent solution that uses idle status check instead of
> pwrdm state check, and prevent core idle if dss is not going to
> idle. What is the current status with those idlest patches anyway?

Paul will have to answer that one.

Kevin
