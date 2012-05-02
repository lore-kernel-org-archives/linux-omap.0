From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 00/18][V3] ARM: OMAP3/4 : cpuidle34xx and cpuidle44xx cleanups
Date: Wed, 2 May 2012 11:50:04 +0530
Message-ID: <CAMQu2gxDV0fW+_38+3siKA+sJv6=PXMBAJs9DSkV8sEdv78EUw@mail.gmail.com>
References: <1335276339-11135-1-git-send-email-daniel.lezcano@linaro.org>
 <4F98740F.1020402@linaro.org> <87vckgltdg.fsf@ti.com> <4F9F9BC1.9020908@linaro.org>
 <CAMQu2gzK=u1kkbv9nzRyO3xbqVhZkf0KP=ceCyNteSituBZPrg@mail.gmail.com> <4F9FB8F0.80901@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog121.obsmtp.com ([74.125.149.145]:35482 "EHLO
	na3sys009aog121.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753137Ab2EBGU0 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 2 May 2012 02:20:26 -0400
Received: by qabg27 with SMTP id g27so2817873qab.0
        for <linux-omap@vger.kernel.org>; Tue, 01 May 2012 23:20:24 -0700 (PDT)
In-Reply-To: <4F9FB8F0.80901@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Kevin Hilman <khilman@ti.com>, linaro-dev@lists.linaro.org, patches@linaro.org, tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Tue, May 1, 2012 at 3:50 PM, Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
> On 05/01/2012 11:55 AM, Shilimkar, Santosh wrote:
>>
>> On May 1, 2012 1:46 PM, "Daniel Lezcano"<daniel.lezcano@linaro.org>
>> =A0wrote:
>>>
>>> On 05/01/2012 12:58 AM, Kevin Hilman wrote:
>>>>
>>>> Daniel Lezcano<daniel.lezcano@linaro.org> =A0 writes:
>>>>
>>>>> On 04/24/2012 04:05 PM, Daniel Lezcano wrote:
>>>>>>
>>>>>> This patchset makes some cleanup on these cpuidle drivers
>>>>>> and consolidate the code across both architecture.
>>>>>>
>>>>>> Tested on OMAP3 (igepV2).
>>>>>> Partially tested on OMAP4 (pandaboard), without offlining the cp=
u1.
>>>>
>>>>
>>>> Without offlining CPU1, none of this code is executed. =A0Can you =
test
>>>> with CPU1 offlined?
>>>
>>>
>>> Unfortunately my OMAP4 board burned :/ I am waiting for a new one.
>>> Rob tested the series but when he unplugged the cpu1, the kernel pa=
nics
>>
>> for another reason. I guess the problem should have been fixed since=
 the
>> last testing.
>>>
>>> =A0Rob ? Do you mind the test the series again, the problem you wer=
e facing
>>
>> when unplugging the cpu1 may have been fixed.
>> Have already tested this series on omap4 with cpu offline as well as=
 with
>> couple idle series on top of it.
>> I haven't finished omap3 testing and hence not reported yet. Omap4
>> continies to work with subject series.
>
>
> Great !
>
> I tested it on omap3 igepv2 board and it works fine too.
>
=46inished OMAP3 testing too. have already reviewed the series before.
=46or entire series,
Reviewed-tested-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

Regards
Santosh
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
