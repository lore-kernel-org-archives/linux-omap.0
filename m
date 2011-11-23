From: Kevin Hilman <khilman@ti.com>
Subject: Re: [linux-pm] [PATCH 4/6] OMAP3: cpuidle: next C-state decision depends on the PM QoS MPU and CORE constraints
Date: Wed, 23 Nov 2011 11:43:49 -0800
Message-ID: <877h2qbp56.fsf@ti.com>
References: <1319032263-22699-1-git-send-email-j-pihet@ti.com>
	<1319032263-22699-5-git-send-email-j-pihet@ti.com>
	<877h2y30a5.fsf@ti.com>
	<CAORVsuV5bV-p0kxhh8g4T076Dg3Mj89X_=4E+BpCSTdLiUmNZA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:50638 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754280Ab1KWTnx convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 23 Nov 2011 14:43:53 -0500
Received: by iaeo4 with SMTP id o4so2384363iae.31
        for <linux-omap@vger.kernel.org>; Wed, 23 Nov 2011 11:43:52 -0800 (PST)
In-Reply-To: <CAORVsuV5bV-p0kxhh8g4T076Dg3Mj89X_=4E+BpCSTdLiUmNZA@mail.gmail.com>
	(Jean Pihet's message of "Tue, 22 Nov 2011 20:54:14 +0100")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: linux-omap@vger.kernel.org, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, Jean Pihet <j-pihet@ti.com>

Jean Pihet <jean.pihet@newoldbits.com> writes:

> On Thu, Nov 17, 2011 at 10:29 PM, Kevin Hilman <khilman@ti.com> wrote=
:
>> jean.pihet@newoldbits.com writes:
>>
>>> From: Jean Pihet <j-pihet@ti.com>
>>>
>>> The MPU latency figures for cpuidle include the MPU itself and also
>>> the peripherals needed for the MPU to execute instructions (e.g.
>>> main memory, caches, IRQ controller, MMU etc). On OMAP3 those
>>> peripherals belong to the MPU and CORE power domains and so the
>>> cpuidle C-states are a combination of MPU and CORE states.
>>>
>>> This patch implements the relation between the cpuidle and per-
>>> device PM QoS frameworks in the OMAP3 specific idle callbacks.
>>>
>>> The chosen C-state shall satisfy the following conditions:
>>> =C2=A0. the 'valid' field is enabled,
>>> =C2=A0. it satisfies the enable_off_mode flag,
>>
>> Not directly related to this patch, but is there any reason to keep =
the
>> 'enable_off_mode' flag after this series?
> enable_off_mode could be removed completely after this series unless
> there is a need to prevent OFF mode for debug reasons.

Great.

=46or debug reasons, we can just as easily set constraints to prevent o=
ff
mode, so I would like to see it disappear.

Kevin

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
