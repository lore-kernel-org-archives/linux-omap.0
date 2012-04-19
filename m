From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 00/17][V2] ARM: OMAP3/4 : cpuidle34xx and cpuidle44xx
 cleanups
Date: Thu, 19 Apr 2012 16:03:56 +0200
Message-ID: <4F901B4C.2090905@linaro.org>
References: <1333570371-1389-1-git-send-email-daniel.lezcano@linaro.org> <87vcl87am5.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:60107 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753017Ab2DSOEB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 19 Apr 2012 10:04:01 -0400
Received: by bkcik5 with SMTP id ik5so6393751bkc.19
        for <linux-omap@vger.kernel.org>; Thu, 19 Apr 2012 07:04:00 -0700 (PDT)
In-Reply-To: <87vcl87am5.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: santosh.shilimkar@ti.com, jean.pihet@newoldbits.com, tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, rob.lee@linaro.org, linaro-dev@lists.linaro.org, patches@linaro.org

On 04/10/2012 01:23 AM, Kevin Hilman wrote:
> Daniel Lezcano<daniel.lezcano@linaro.org>  writes:
>
>> This patchset makes some cleanup on these cpuidle drivers
>> and consolidate the code across both architecture.
>
> Thanks for this really nice cleanup.  I have some comments on specifi=
c
> patches, but here's some general comments:
>
> Some minor comments:
>
> First, please be sure all patches have a descriptive changelog.  Yes,
> even simple ones need changelogs.  In particular, maintainers are
> looking for the "why" of a patch, not just the "what" or "how".
>
> Second, this series introduced a couple sparse warnings:
>
> /work/kernel/omap/pm/arch/arm/mach-omap2/cpuidle44xx.c:134:1: warning=
: symbol 'omap4_idle_dev' was not declared. Should it be static?
> /work/kernel/omap/pm/arch/arm/mach-omap2/cpuidle44xx.c:136:23: warnin=
g: symbol 'omap4_idle_driver' was not declared. Should it be static?

Ok, I probably missed it. I will fix that it in the next version.

Thanks for reviewing.

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
