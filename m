From: Benoit Cousson <bcousson@baylibre.com>
Subject: Re: [PATCH 0/3] Add more device nodes for am43x gp evm.
Date: Wed, 18 Dec 2013 19:51:24 +0100
Message-ID: <52B1EEAC.2010109@baylibre.com>
References: <1385537479-6959-1-git-send-email-sourav.poddar@ti.com> <52B1DEAC.4000509@ti.com> <52B1E00D.30403@baylibre.com> <52B1E627.20409@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pd0-f177.google.com ([209.85.192.177]:39200 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755757Ab3LRSv2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 Dec 2013 13:51:28 -0500
Received: by mail-pd0-f177.google.com with SMTP id q10so38910pdj.36
        for <linux-omap@vger.kernel.org>; Wed, 18 Dec 2013 10:51:28 -0800 (PST)
In-Reply-To: <52B1E627.20409@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sourav Poddar <sourav.poddar@ti.com>
Cc: rob.herring@calxeda.com, mark.rutland@arm.com, swarren@wwwdotorg.org, devicetree@vger.kernel.org, tony@atomide.com, balbi@ti.com, linux-omap@vger.kernel.org, nsekhar@ti.com

On 18/12/2013 19:15, Sourav Poddar wrote:
> On Wednesday 18 December 2013 11:19 PM, Benoit Cousson wrote:
>> Hi Sourav,
>>
>> On 18/12/2013 18:43, Sourav Poddar wrote:
>>> Benoit,
>>> On Wednesday 27 November 2013 01:01 PM, Sourav Poddar wrote:
>>>> The patch series adds support for enabling gpio, pwm backlight and
>>>> matrix gpio keys on am43x-gp-evm.
>>>>
>>>> Done on top of 3.13-rc1 + tero clock series(1) + Afzal's basic gp
>>>> support(2).
>>>>
>>>> [1]: https://patchwork.kernel.org/patch/3009541/
>>>> [2]: https://patchwork.kernel.org/patch/3171761/
>>>>
>>>> Tested on am43x-gp-evm.
>>>>
>>>> There is a some bug while using regulators through backlight
>>>> driver on 3.13-rc1. So, tested pwm part with this patch[3].
>>>>
>>>> [3]: http://www.spinics.net/lists/arm-kernel/msg288215.html
>>>>
>>>> Sourav Poddar (3):
>>>>    arm: dts: am437x-gp-evm: Enable gpio.
>>>>    ARM: dts: am43x-gp-evm: Add matrix gpio keys.
>>>>    ARM: dts: am437x-gp-evm: Add pwm backlight support.
>>>>
>>>>   arch/arm/boot/dts/am437x-gp-evm.dts |   53
>>>> +++++++++++++++++++++++++++++++++++
>>>>   1 files changed, 53 insertions(+), 0 deletions(-)
>>>>
>>> Ping on this?
>>
>> The series looks good, but you should rebase it on top of for_3.14/d=
ts
>> that is based on the big cleanup branch Tony has done.
>> I cannot apply it right now.
>>
> Ok. I will rebase it and send you the series, As you can see there is
> one dependency on afzal  basic support patch, as mentioned in
> the cover letter. If you are ok with that patch, it has to go first. =
So,
> if you wish I can work with afzal and send you this
> series and afzal patch together.

Yes, go ahead and repost the whole series with the depency.

BTW, could you do that as well with your other series?

Thanks,
Benoit
--=20
Beno=EEt Cousson
BayLibre
Embedded Linux Technology Lab
www.baylibre.com
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
