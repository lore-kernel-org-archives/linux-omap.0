From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 06/17][V2] ARM: OMAP4: cpuidle - use the omap4_idle_data
 variable directly
Date: Thu, 19 Apr 2012 16:49:12 +0200
Message-ID: <4F9025E8.9020707@linaro.org>
References: <1333570371-1389-1-git-send-email-daniel.lezcano@linaro.org> <1333570371-1389-7-git-send-email-daniel.lezcano@linaro.org> <87r4vw8qfd.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:58838 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752273Ab2DSOtQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 19 Apr 2012 10:49:16 -0400
Received: by bkcik5 with SMTP id ik5so6438753bkc.19
        for <linux-omap@vger.kernel.org>; Thu, 19 Apr 2012 07:49:15 -0700 (PDT)
In-Reply-To: <87r4vw8qfd.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: santosh.shilimkar@ti.com, jean.pihet@newoldbits.com, tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, rob.lee@linaro.org, linaro-dev@lists.linaro.org

On 04/10/2012 12:56 AM, Kevin Hilman wrote:
> Daniel Lezcano<daniel.lezcano@linaro.org>  writes:
>
>> We are storing the 'omap4_idle_data' in the private data field
>> of the cpuidle device. As we are using this variable only in this fi=
le,
>> that does not really make sense. Let's use the global variable direc=
tly
>> instead dereferencing pointers in an idle critical loop.
>
> Did you notice a performance impact before this change?

No, I didn't and I don't think I will be able to measure it. But by=20
experience, when dereferencing a pointer that could leads to a cache=20
miss and impact the performances. That may not be the case here, so I=20
won't argue with that as I won't able to prove it :)

>> Also, that simplfies the code.
>
> possibly, but at the expense of clean abstractions which IMO helps re=
adability.
>
> Unless there is a real performance hit here (which I doubt), I'd pref=
er
> to leave this as is.

There are two reasons of this change. We are storing 'state_count' time=
s=20
a pointer in a private structure for state_usage but the information is=
=20
already available in the file and easily accessible.
Also, this is set in the fill_cstate function I am removing to let all=20
the initialization to be done at compile time.

=46urthermore, I don't get why we have a 'driver data' area in a struct=
ure=20
which is dedicated for the states statistics, IMHO that does not help=20
understanding. My mid-term cleanup is to kill the 'driver_data' field i=
n=20
the cpuidle core because I don't think it is at the right place.

An idea I had for consolidate all the cpuidle driver was to use the=20
containerof macro to define the architecture specific structure and=20
declare inside this structure the cpuidle driver and the devices. It is=
=20
similar on how are implemented the 'routes' for the network stack or th=
e=20
cgroup subsystems, there is a core engine handling generic structure=20
which a contained by the specific structure related to the engine's=20
user. That helps a lot for readability.

Well this is an idea but before I have to unify the cpuidle drivers cod=
e=20
to make it clear what is doable or not.



--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
