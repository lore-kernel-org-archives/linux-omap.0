From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 2/2] ARM: OMAP3/4: consolidate cpuidle Makefile
Date: Tue, 08 May 2012 23:02:20 +0200
Message-ID: <4FA989DC.2030800@linaro.org>
References: <1336151921-9485-1-git-send-email-daniel.lezcano@linaro.org> <1336151921-9485-3-git-send-email-daniel.lezcano@linaro.org> <87wr4mmmgn.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:37036 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754601Ab2EHVCT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 May 2012 17:02:19 -0400
Received: by eeit10 with SMTP id t10so496746eei.19
        for <linux-omap@vger.kernel.org>; Tue, 08 May 2012 14:02:18 -0700 (PDT)
In-Reply-To: <87wr4mmmgn.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: santosh.shilimkar@ti.com, jean.pihet@newoldbits.com, tony@atomide.com, linux-omap@vger.kernel.org, linaro-dev@lists.linaro.org, linux-arm-kernel@lists.infradead.org, patches@linaro.org

On 05/08/2012 10:44 PM, Kevin Hilman wrote:
> Daniel Lezcano<daniel.lezcano@linaro.org>  writes:
>
>> Define a CPU_IDLE section in the makefile, declare the functions in
>> the header files conforming to the kernel coding rules and remove th=
e
>> 'define's in the C files.
>>
>> CONFIG_PM is enabled when CPU_IDLE is enabled because the cpuidle dr=
ivers
>> use some functions from the pm subsystem.
>>
>> Signed-off-by: Daniel Lezcano<daniel.lezcano@linaro.org>
>> Reviewed-by: Jean Pihet<j-pihet@ti.com>
>
> The changelog doesn't really answer "why" this change is needed.  IOW=
, I
> don't understand from the changelog exactly what problem this patch i=
s
> trying to solve.
>
> AFAICT, it's just shuffling around the dependencies, and changes the
> omap*_idle_init() calls into inline nops instead of function call nop=
s.

Ok, I will modify the changelog. I'm always bad with the changelogs,=20
this is something I have to improve :) I'm the first one to be happy=20
when I find a nice description in the patches log.

Thanks.

   -- Daniel

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
