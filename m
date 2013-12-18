From: Sourav Poddar <sourav.poddar@ti.com>
Subject: Re: [PATCH 0/3] Add more device nodes for am43x gp evm.
Date: Wed, 18 Dec 2013 23:45:03 +0530
Message-ID: <52B1E627.20409@ti.com>
References: <1385537479-6959-1-git-send-email-sourav.poddar@ti.com> <52B1DEAC.4000509@ti.com> <52B1E00D.30403@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:39844 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752031Ab3LRSPO (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 18 Dec 2013 13:15:14 -0500
In-Reply-To: <52B1E00D.30403@baylibre.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <bcousson@baylibre.com>
Cc: rob.herring@calxeda.com, mark.rutland@arm.com, swarren@wwwdotorg.org, devicetree@vger.kernel.org, tony@atomide.com, balbi@ti.com, linux-omap@vger.kernel.org, nsekhar@ti.com

On Wednesday 18 December 2013 11:19 PM, Benoit Cousson wrote:
> Hi Sourav,
>
> On 18/12/2013 18:43, Sourav Poddar wrote:
>> Benoit,
>> On Wednesday 27 November 2013 01:01 PM, Sourav Poddar wrote:
>>> The patch series adds support for enabling gpio, pwm backlight and
>>> matrix gpio keys on am43x-gp-evm.
>>>
>>> Done on top of 3.13-rc1 + tero clock series(1) + Afzal's basic gp
>>> support(2).
>>>
>>> [1]: https://patchwork.kernel.org/patch/3009541/
>>> [2]: https://patchwork.kernel.org/patch/3171761/
>>>
>>> Tested on am43x-gp-evm.
>>>
>>> There is a some bug while using regulators through backlight
>>> driver on 3.13-rc1. So, tested pwm part with this patch[3].
>>>
>>> [3]: http://www.spinics.net/lists/arm-kernel/msg288215.html
>>>
>>> Sourav Poddar (3):
>>>    arm: dts: am437x-gp-evm: Enable gpio.
>>>    ARM: dts: am43x-gp-evm: Add matrix gpio keys.
>>>    ARM: dts: am437x-gp-evm: Add pwm backlight support.
>>>
>>>   arch/arm/boot/dts/am437x-gp-evm.dts |   53
>>> +++++++++++++++++++++++++++++++++++
>>>   1 files changed, 53 insertions(+), 0 deletions(-)
>>>
>> Ping on this?
>
> The series looks good, but you should rebase it on top of for_3.14/dts 
> that is based on the big cleanup branch Tony has done.
> I cannot apply it right now.
>
Ok. I will rebase it and send you the series, As you can see there is 
one dependency on afzal  basic support patch, as mentioned in
the cover letter. If you are ok with that patch, it has to go first. So, 
if you wish I can work with afzal and send you this
series and afzal patch together.

> Thanks,
> Benoit
>
>

