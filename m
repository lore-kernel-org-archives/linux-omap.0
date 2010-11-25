From: "Varadarajan, Charulatha" <charu@ti.com>
Subject: Re: [PATCH v7 05/11] OMAP2420: hwmod data: Add GPIO
Date: Thu, 25 Nov 2010 15:03:39 +0530
Message-ID: <AANLkTinEbi6V3tsCMDt4zj1jZLEzREeoq1L2ub87CbBg@mail.gmail.com>
References: <1290524213-395-1-git-send-email-charu@ti.com> <1290524213-395-6-git-send-email-charu@ti.com>
 <4CED8DF7.6040606@ti.com> <AANLkTimRK=eKBG3pqGN8Ota5EO8EdmEibQN5C3Lwfheq@mail.gmail.com>
 <4CEE1807.9040404@ti.com> <AANLkTik1p0gqe6s8t-q0koehWBhc6nceU9=T74k3iw9_@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:55525 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751374Ab0KYJeY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 25 Nov 2010 04:34:24 -0500
Received: by mail-iw0-f180.google.com with SMTP id 37so861585iwn.39
        for <linux-omap@vger.kernel.org>; Thu, 25 Nov 2010 01:34:21 -0800 (PST)
In-Reply-To: <AANLkTik1p0gqe6s8t-q0koehWBhc6nceU9=T74k3iw9_@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "paul@pwsan.com" <paul@pwsan.com>, "tony@atomide.com" <tony@atomide.com>, "Basak, Partha" <p-basak2@ti.com>

On Thu, Nov 25, 2010 at 14:01, Varadarajan, Charulatha <charu@ti.com> w=
rote:
> On Thu, Nov 25, 2010 at 13:32, Cousson, Benoit <b-cousson@ti.com> wro=
te:
>> On 11/25/2010 5:36 AM, Varadarajan, Charulatha wrote:
>>>
>>> Benoit,
>>>
>>> On Thu, Nov 25, 2010 at 03:43, Cousson, Benoit<b-cousson@ti.com> =A0=
wrote:
>>>>
>>>> On 11/23/2010 3:56 PM, Varadarajan, Charulatha wrote:
>>>>>
>>>>> Add GPIO hwmod data for OMAP2420
>>>>>
>>>>> Signed-off-by: Charulatha V<charu@ti.com>
>>>>> ---
>>>>> =A0arch/arm/mach-omap2/omap_hwmod_2420_data.c | =A0229
>>>>> ++++++++++++++++++++++++++++
>>>>> =A0arch/arm/plat-omap/include/plat/gpio.h =A0 =A0 | =A0 =A05 +
>>>>> =A02 files changed, 234 insertions(+), 0 deletions(-)
>>>>>
>>>>> diff --git a/arch/arm/mach-omap2/omap_hwmod_2420_data.c
>>>>> b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
>>>>> index a1a3dd6..c951061 100644
>>>>> --- a/arch/arm/mach-omap2/omap_hwmod_2420_data.c
>>>>> +++ b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
>>>>> @@ -17,6 +17,7 @@
>>>>> =A0#include<plat/dma.h>
>>>>> =A0#include<plat/serial.h>
>>>>> =A0#include<plat/i2c.h>
>>>>> +#include<plat/gpio.h>
>>>>> =A0#include<plat/omap24xx.h>
>>>>
>>>> Do you still need that header file?
>>>
>>> Yes, for the gpio_dev_attr
>>
>> I'm still confused, gpio_dev_attr just contains an int and a bool:
>
> I am talking about gpio.h file which is required for using
> omap_gpio_dev_attr. If you are pointing out omap24xx.h file,
> I am not sure. It was in the original code.

Okay. I checked. omap24xx.h file is no more required here
and I am deleting this header include from this file. Same for
OMAP2430 and OMAP3xxx hwmod database files too.

-V Charulatha
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
