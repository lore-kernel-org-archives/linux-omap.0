From: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Subject: Re: [RESEND PATCH v2 1/5] ir-rx51: Fix build after multiarch changes
 broke it
Date: Mon, 27 Jun 2016 21:19:19 +0300
Message-ID: <57716E27.2040702@gmail.com>
References: <1466623341-30130-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
 <1466623341-30130-2-git-send-email-ivo.g.dimitrov.75@gmail.com>
 <201606231948.51640@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pwm-owner@vger.kernel.org>
In-Reply-To: <201606231948.51640@pali>
Sender: linux-pwm-owner@vger.kernel.org
To: =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali.rohar@gmail.com>
Cc: robh+dt@kernel.org, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, thierry.reding@gmail.com, bcousson@baylibre.com, tony@atomide.com, linux@arm.linux.org.uk, mchehab@osg.samsung.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org, sre@kernel.org, pavel@ucw.cz, Neil Armstrong <narmstrong@baylibre.com>
List-Id: linux-omap@vger.kernel.org



On 23.06.2016 20:48, Pali Roh=C3=A1r wrote:
> On Wednesday 22 June 2016 21:22:17 Ivaylo Dimitrov wrote:
>> The ir-rx51 driver for n900 has been disabled since the multiarch
>> changes as plat include directory no longer is SoC specific.
>>
>> Let's fix it with minimal changes to pass the dmtimer calls in
>> pdata. Then the following changes can be done while things can
>> be tested to be working for each change:
>>
>> 1. Change the non-pwm dmtimer to use just hrtimer if possible
>>
>> 2. Change the pwm dmtimer to use Linux PWM API with the new
>>     drivers/pwm/pwm-omap-dmtimer.c and remove the direct calls
>>     to dmtimer functions
>>
>> 3. Parse configuration from device tree and drop the pdata
>>
>> Note compilation of this depends on the previous patch
>> "ARM: OMAP2+: Add more functions to pwm pdata for ir-rx51".
>
> I think that this extensive description is not needed for commit
> message. Just for email discussion.
>

I guess Tony can strip the description a bit before applying.

Ivo
