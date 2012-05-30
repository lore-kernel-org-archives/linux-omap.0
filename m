From: Konstantin Baydarov <kbaidarov@dev.rtsoft.ru>
Subject: Re: [RFC PATCH 11/11] ARM: DT: Add support to system control module
 for OMAP4
Date: Wed, 30 May 2012 14:17:39 +0400
Message-ID: <4FC5F3C3.2000309@dev.rtsoft.ru>
References: <1337934361-1606-1-git-send-email-eduardo.valentin@ti.com> <1337934361-1606-12-git-send-email-eduardo.valentin@ti.com> <4FC49BA5.5050008@dev.rtsoft.ru> <4FC5DC9F.7080104@ti.com> <4FC5E2EE.8030504@dev.rtsoft.ru> <4FC5E7DE.2060905@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.dev.rtsoft.ru ([213.79.90.226]:57547 "HELO
	mail.dev.rtsoft.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751161Ab2E3KRn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 30 May 2012 06:17:43 -0400
In-Reply-To: <4FC5E7DE.2060905@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: Eduardo Valentin <eduardo.valentin@ti.com>, kishon@ti.com, santosh.shilimkar@ti.com, tony@atomide.com, paul@pwsan.com, balbi@ti.com, amit.kucheria@linaro.org, linux-pm@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, amit.kachhap@linaro.org

  Hi.
On 05/30/2012 01:26 PM, Cousson, Benoit wrote:
> On 5/30/2012 11:05 AM, Konstantin Baydarov wrote:
>> On 05/30/2012 12:38 PM, Cousson, Benoit wrote:
>>> On 5/29/2012 11:49 AM, Konstantin Baydarov wrote:
>>>> Hi, Eduardo.
>>>>
>>>> On 05/25/2012 12:26 PM, Eduardo Valentin wrote:
>>>>> This patch add device tree entries on OMAP4 based boards for
>>>>> System Control Module (SCM).
>
> ...
>
>>>> I believe that CPU-specific bandgap definition should be moved to
>>>> bard specific dts.
>>>
>>> Mmm, why, since it is CPU specific and not board specific. I has to
>>> be in the SoC file.
>> Speaking about omap4430 - omap4430 bandgap differs from omap4460, so
>> if omap4430 bandgap support will be added to omap-bandgap driver the
>> version of bandgap should specified in dts file. omap4.dtsi is a
>> common for omap4 boards, that is why I'm suggesting to move bandgap
>> description to probably board specific file.
>
> OK, I got your point, but in that case we could potentially define a omap4460.dtsi file.
>
>> Another solution is to
>> determine bandgap type in driver probe function, but in that case
>> "ti,omap4460-bandgap" in omap4.dtsi should be replaced to
>> "ti,omap4-bandgap".
>
> Yes, this is the best solution, but that assume that we can identify the control module version from the HW, which is not necessarily true :-(
>
> The IP_REVISION (offset = 0) value are unfortunately not documented, so we should read it to check if they are different from omap4430 and 4460.
>
> The bitfield layout in that register is:
>
> IP_REV_MAJOR: 8..10
> IP_REV_CUSTOM: 6..7
> IP_REV_MINOR: 0..5
Probably, cpu_is_omap443x() and cpu_is_omap446x() can be used in bandgap driver probe function. Actually many drivers use cpu_is_omap*():
drivers/mfd/omap-usb-host.c
drivers/mfd/twl-core.c

  BR,
    Konstantin Baydarov.

>
> Regards,
> Benoit

