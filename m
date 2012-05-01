From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 00/18][V3] ARM: OMAP3/4 : cpuidle34xx and cpuidle44xx
 cleanups
Date: Tue, 01 May 2012 12:20:32 +0200
Message-ID: <4F9FB8F0.80901@linaro.org>
References: <1335276339-11135-1-git-send-email-daniel.lezcano@linaro.org> <4F98740F.1020402@linaro.org> <87vckgltdg.fsf@ti.com> <4F9F9BC1.9020908@linaro.org> <CAMQu2gzK=u1kkbv9nzRyO3xbqVhZkf0KP=ceCyNteSituBZPrg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:46046 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754428Ab2EAKUc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 May 2012 06:20:32 -0400
Received: by eekc41 with SMTP id c41so891060eek.19
        for <linux-omap@vger.kernel.org>; Tue, 01 May 2012 03:20:31 -0700 (PDT)
In-Reply-To: <CAMQu2gzK=u1kkbv9nzRyO3xbqVhZkf0KP=ceCyNteSituBZPrg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, Kevin Hilman <khilman@ti.com>, linaro-dev@lists.linaro.org, patches@linaro.org, tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 05/01/2012 11:55 AM, Shilimkar, Santosh wrote:
> On May 1, 2012 1:46 PM, "Daniel Lezcano"<daniel.lezcano@linaro.org>  =
wrote:
>> On 05/01/2012 12:58 AM, Kevin Hilman wrote:
>>> Daniel Lezcano<daniel.lezcano@linaro.org>   writes:
>>>
>>>> On 04/24/2012 04:05 PM, Daniel Lezcano wrote:
>>>>> This patchset makes some cleanup on these cpuidle drivers
>>>>> and consolidate the code across both architecture.
>>>>>
>>>>> Tested on OMAP3 (igepV2).
>>>>> Partially tested on OMAP4 (pandaboard), without offlining the cpu=
1.
>>>
>>> Without offlining CPU1, none of this code is executed.  Can you tes=
t
>>> with CPU1 offlined?
>>
>> Unfortunately my OMAP4 board burned :/ I am waiting for a new one.
>> Rob tested the series but when he unplugged the cpu1, the kernel pan=
ics
> for another reason. I guess the problem should have been fixed since =
the
> last testing.
>>   Rob ? Do you mind the test the series again, the problem you were =
facing
> when unplugging the cpu1 may have been fixed.
> Have already tested this series on omap4 with cpu offline as well as =
with
> couple idle series on top of it.
> I haven't finished omap3 testing and hence not reported yet. Omap4
> continies to work with subject series.

Great !

I tested it on omap3 igepv2 board and it works fine too.

Thanks for testing

-- Daniel.


--=20
  <http://www.linaro.org/>  Linaro.org =E2=94=82 Open source software f=
or ARM SoCs

=46ollow Linaro:<http://www.facebook.com/pages/Linaro>  Facebook |
<http://twitter.com/#!/linaroorg>  Twitter |
<http://www.linaro.org/linaro-blog/>  Blog


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
