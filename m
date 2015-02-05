From: Vignesh R <vigneshr@ti.com>
Subject: Re: [PATCH v6 3/6] mfd: ti_am335x_tscadc: Remove unwanted reg_se_cache
 save
Date: Thu, 5 Feb 2015 11:51:25 +0530
Message-ID: <54D30BE5.4070906@ti.com>
References: <1420609779-11156-1-git-send-email-vigneshr@ti.com> <1420609779-11156-4-git-send-email-vigneshr@ti.com> <20150120115325.GK13701@x1> <54BE4CD1.1020709@ti.com> <20150120160410.GL13701@x1> <54BF7C14.1080907@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:45788 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751061AbbBEGWw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 5 Feb 2015 01:22:52 -0500
In-Reply-To: <54BF7C14.1080907@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Benoit Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald <pmeerw@pmeerw.net>, Samuel Ortiz <sameo@linux.intel.com>, Brad Griffis <bgriffis@ti.com>, Paul Gortmaker <paul.gortmaker@windriver.com>, Sanjeev Sharma <sanjeev_sharma@mentor.com>, Jan Kardell <jan.kardell@telliq.com>, Felipe Balbi <balbi@ti.com>, Wolfram Sang <wsa@the-dreams.de>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@



On Wednesday 21 January 2015 03:44 PM, Vignesh R wrote:
> On Tuesday 20 January 2015 09:34 PM, Lee Jones wrote:
>> On Tue, 20 Jan 2015, R, Vignesh wrote:
>>> On 1/20/2015 5:23 PM, Lee Jones wrote:
>>>> On Wed, 07 Jan 2015, Vignesh R wrote:
>>>>
>>>>> In one shot mode, sequencer automatically disables all enabled steps at
>>>>> the end of each cycle. (both ADC steps and TSC steps) Hence these steps
>>>>> need not be saved in reg_se_cache for clearing these steps at a later
>>>>> stage.
>>>>> Also, when ADC wakes up Sequencer should not be busy executing any of the
>>>>> config steps except for the charge step. Previously charge step was 1 ADC
>>>>> clock cycle and hence it was ignored.
>>>>> TSC steps are always disabled at the end of each conversion cycle, hence
>>>>> there is no need to explicitly disable TSC steps by writing 0 to REG_SE.
>>>>>
>>>>> Signed-off-by: Vignesh R <vigneshr@ti.com>
>>>>> ---
>>>>>
>>>>> v5:
>>>>>  - Remove unnecessary clearing of REG_SE
>>>>>
>>>>>  drivers/mfd/ti_am335x_tscadc.c       | 13 +++++--------
>>>>>  include/linux/mfd/ti_am335x_tscadc.h |  1 +
>>>>>  2 files changed, 6 insertions(+), 8 deletions(-)
>>>>
>>>> Looks fine.
>>>>
>>>> For my own reference:
>>>>   Acked-by: Lee Jones <lee.jones@linaro.org>
>>>>
>>>> Can this patch be applied on its own?
>>>>
>>>
>>> I prefer to wait until input patches are picked up.
>>
>> I have no problem with that, but is there a technical reason why?
>>
> 
> Nothing, in particular. This patch alone has no impact on the
> performance of TSC/ADC unit. Patch 2/6 is necessary to observe the
> changes caused by this series. Hence, please wait until those patches
> are picked up.

Input maintainer has applied other patches. You can pick this one.

Regards
Vignesh R
