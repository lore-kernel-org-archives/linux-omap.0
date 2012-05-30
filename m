From: Konstantin Baydarov <kbaidarov@dev.rtsoft.ru>
Subject: Re: [RFC PATCH 11/11] ARM: DT: Add support to system control module
 for OMAP4
Date: Wed, 30 May 2012 13:05:50 +0400
Message-ID: <4FC5E2EE.8030504@dev.rtsoft.ru>
References: <1337934361-1606-1-git-send-email-eduardo.valentin@ti.com> <1337934361-1606-12-git-send-email-eduardo.valentin@ti.com> <4FC49BA5.5050008@dev.rtsoft.ru> <4FC5DC9F.7080104@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.dev.rtsoft.ru ([213.79.90.226]:59877 "HELO
	mail.dev.rtsoft.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S932433Ab2E3JFx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 30 May 2012 05:05:53 -0400
In-Reply-To: <4FC5DC9F.7080104@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: Eduardo Valentin <eduardo.valentin@ti.com>, kishon@ti.com, santosh.shilimkar@ti.com, tony@atomide.com, paul@pwsan.com, balbi@ti.com, amit.kucheria@linaro.org, linux-pm@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, amit.kachhap@linaro.org, Konstantin Baydarov <kbaidarov@dev.rtsoft.ru>

On 05/30/2012 12:38 PM, Cousson, Benoit wrote:
> On 5/29/2012 11:49 AM, Konstantin Baydarov wrote:
>>    Hi, Eduardo.
>>
>> On 05/25/2012 12:26 PM, Eduardo Valentin wrote:
>>> This patch add device tree entries on OMAP4 based boards
>>> for System Control Module (SCM).
>>>
>>> Signed-off-by: Eduardo Valentin<eduardo.valentin@ti.com>
>>> ---
>>>   arch/arm/boot/dts/omap4.dtsi |   13 +++++++++++++
>>>   1 files changed, 13 insertions(+), 0 deletions(-)
>>>
>>> diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
>>> index 359c497..d2cb392 100644
>>> --- a/arch/arm/boot/dts/omap4.dtsi
>>> +++ b/arch/arm/boot/dts/omap4.dtsi
>>> @@ -272,5 +272,18 @@
>>>               ti,hwmods = "mmc5";
>>>               ti,needs-special-reset;
>>>           };
>>> +
>>> +        ctrl_module_core: ctrl_module_core@4a002000 {
>>> +            compatible = "ti,omap4-control";
>>> +            ti,hwmods = "ctrl_module_core";
>>> +            bandgap {
>>> +                compatible = "ti,omap4460-bandgap";
>>> +                interrupts =<0 126 4>; /* talert */
>>> +                ti,tshut-gpio =<86>; /* tshut */
>>> +            };
>> I believe that CPU-specific bandgap definition should be moved to bard specific dts.
>
> Mmm, why, since it is CPU specific and not board specific. I has to be in the SoC file.
Speaking about omap4430 - omap4430 bandgap differs from omap4460, so if omap4430 bandgap support will be added to omap-bandgap driver the version of bandgap should specified in dts file. omap4.dtsi is a common for omap4 boards, that is why I'm suggesting to move bandgap description to probably board specific file.
Another solution is to determine bandgap type in driver probe function, but in that case "ti,omap4460-bandgap" in omap4.dtsi should be replaced to "ti,omap4-bandgap".

  BR,
    Konstantin Baydarov.

> Regards,
> Benoit

