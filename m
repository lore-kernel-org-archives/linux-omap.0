From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 00/18][V3] ARM: OMAP3/4 : cpuidle34xx and cpuidle44xx
 cleanups
Date: Tue, 01 May 2012 10:16:01 +0200
Message-ID: <4F9F9BC1.9020908@linaro.org>
References: <1335276339-11135-1-git-send-email-daniel.lezcano@linaro.org> <4F98740F.1020402@linaro.org> <87vckgltdg.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:59780 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752375Ab2EAIQA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 May 2012 04:16:00 -0400
Received: by eekc41 with SMTP id c41so867739eek.19
        for <linux-omap@vger.kernel.org>; Tue, 01 May 2012 01:15:59 -0700 (PDT)
In-Reply-To: <87vckgltdg.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: santosh.shilimkar@ti.com, jean.pihet@newoldbits.com, tony@atomide.com, linux-omap@vger.kernel.org, linaro-dev@lists.linaro.org, linux-arm-kernel@lists.infradead.org, patches@linaro.org, Mike Turquette <mturquette@linaro.org>

On 05/01/2012 12:58 AM, Kevin Hilman wrote:
> Daniel Lezcano<daniel.lezcano@linaro.org>  writes:
>
>> On 04/24/2012 04:05 PM, Daniel Lezcano wrote:
>>> This patchset makes some cleanup on these cpuidle drivers
>>> and consolidate the code across both architecture.
>>>
>>> Tested on OMAP3 (igepV2).
>>> Partially tested on OMAP4 (pandaboard), without offlining the cpu1.
>
> Without offlining CPU1, none of this code is executed.  Can you test
> with CPU1 offlined?

Unfortunately my OMAP4 board burned :/ I am waiting for a new one.
Rob tested the series but when he unplugged the cpu1, the kernel panics=
=20
for another reason. I guess the problem should have been fixed since th=
e=20
last testing.

Rob ? Do you mind the test the series again, the problem you were facin=
g=20
when unplugging the cpu1 may have been fixed.

Mike ? if you have time, is it possible you test it on your board ?

>> Hi,>>
>> could be this patchset considered for inclusion ?
>>
>
> Yes.   This is a good series, and a great cleanup.
>
> Unfortunately, there is lots of OMAP PM code to review at the moment =
so
> there's a bit of a lag in my ability to review and test.

Ok, sure. I understand, no pressure :)

Thanks a lot.

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
