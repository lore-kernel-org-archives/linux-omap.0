From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [linux-pm] [PATCH 4/6] OMAP3: cpuidle: next C-state decision
 depends on the PM QoS MPU and CORE constraints
Date: Mon, 12 Dec 2011 17:26:10 +0100
Message-ID: <CAORVsuXDNUEYnP=7E8+Ny8J2ShkhBCS-GG+vET1MCcUjxVCBCg@mail.gmail.com>
References: <1319032263-22699-1-git-send-email-j-pihet@ti.com>
	<1319032263-22699-5-git-send-email-j-pihet@ti.com>
	<877h2y30a5.fsf@ti.com>
	<CAORVsuV5bV-p0kxhh8g4T076Dg3Mj89X_=4E+BpCSTdLiUmNZA@mail.gmail.com>
	<877h2qbp56.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:58195 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751334Ab1LLQ0L convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 12 Dec 2011 11:26:11 -0500
Received: by vcbfk14 with SMTP id fk14so3865129vcb.19
        for <linux-omap@vger.kernel.org>; Mon, 12 Dec 2011 08:26:10 -0800 (PST)
In-Reply-To: <877h2qbp56.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, Jean Pihet <j-pihet@ti.com>

Hi Kevin,

On Wed, Nov 23, 2011 at 8:43 PM, Kevin Hilman <khilman@ti.com> wrote:
> Jean Pihet <jean.pihet@newoldbits.com> writes:
>
>> On Thu, Nov 17, 2011 at 10:29 PM, Kevin Hilman <khilman@ti.com> wrot=
e:
>>> jean.pihet@newoldbits.com writes:
>>>
>>>> From: Jean Pihet <j-pihet@ti.com>
>>>>
>>>> The MPU latency figures for cpuidle include the MPU itself and als=
o
>>>> the peripherals needed for the MPU to execute instructions (e.g.
>>>> main memory, caches, IRQ controller, MMU etc). On OMAP3 those
>>>> peripherals belong to the MPU and CORE power domains and so the
>>>> cpuidle C-states are a combination of MPU and CORE states.
>>>>
>>>> This patch implements the relation between the cpuidle and per-
>>>> device PM QoS frameworks in the OMAP3 specific idle callbacks.
>>>>
>>>> The chosen C-state shall satisfy the following conditions:
>>>> =A0. the 'valid' field is enabled,
>>>> =A0. it satisfies the enable_off_mode flag,
>>>
>>> Not directly related to this patch, but is there any reason to keep=
 the
>>> 'enable_off_mode' flag after this series?
>> enable_off_mode could be removed completely after this series unless
>> there is a need to prevent OFF mode for debug reasons.
>
> Great.
>
> For debug reasons, we can just as easily set constraints to prevent o=
ff
> mode, so I would like to see it disappear.
I have a WIP patch that removes the enable_off_mode flag and will post
it as soon as this series is in the upstream pipe.

Thanks,
Jean

>
> Kevin
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
