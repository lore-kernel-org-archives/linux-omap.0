From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH v7 05/11] OMAP2420: hwmod data: Add GPIO
Date: Thu, 25 Nov 2010 08:55:35 +0100
Message-ID: <4CEE1677.8030109@ti.com>
References: <1290524213-395-1-git-send-email-charu@ti.com> <1290524213-395-6-git-send-email-charu@ti.com> <4CED8DF7.6040606@ti.com> <AANLkTimRK=eKBG3pqGN8Ota5EO8EdmEibQN5C3Lwfheq@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:37989 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751146Ab0KYHzc (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 25 Nov 2010 02:55:32 -0500
In-Reply-To: <AANLkTimRK=eKBG3pqGN8Ota5EO8EdmEibQN5C3Lwfheq@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Varadarajan, Charulatha" <charu@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "paul@pwsan.com" <paul@pwsan.com>, "tony@atomide.com" <tony@atomide.com>, "Basak, Partha" <p-basak2@ti.com>

On 11/25/2010 5:36 AM, Varadarajan, Charulatha wrote:
> Benoit,
>
> On Thu, Nov 25, 2010 at 03:43, Cousson, Benoit<b-cousson@ti.com>  wrote:
>> On 11/23/2010 3:56 PM, Varadarajan, Charulatha wrote:
>>>
>>> Add GPIO hwmod data for OMAP2420
>>>
>>> Signed-off-by: Charulatha V<charu@ti.com>

[...]

>>> diff --git a/arch/arm/plat-omap/include/plat/gpio.h
>>> b/arch/arm/plat-omap/include/plat/gpio.h
>>
>> That change should not necessarily be there, it is not directly related to
>> the subject.
>>
>> Maybe that should be in an extra patch just before that one.
>
> I merged these two patches because of a comment to introduce
> new variables/structures only in the patch where they are used.
> Since "omap_gpio_dev_attr" is being used by hwmod DB I merged
> these two patches. Do you think that hwmod DB patches should not
> be merged with other patches?

Not necessarily, maybe you can just update the changelog and the subject 
to indicate that you add a new structure as well in this patch.

Benoit
