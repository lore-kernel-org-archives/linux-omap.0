From: Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v6 3/6] mfd: ti_am335x_tscadc: Remove unwanted reg_se_cache
 save
Date: Wed, 25 Feb 2015 09:37:25 +0530
Message-ID: <54ED4A7D.4060609@ti.com>
References: <1420609779-11156-1-git-send-email-vigneshr@ti.com> <1420609779-11156-4-git-send-email-vigneshr@ti.com> <20150120115325.GK13701@x1> <54BE4CD1.1020709@ti.com> <20150120160410.GL13701@x1> <54BF7C14.1080907@ti.com> <54D30BE5.4070906@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <54D30BE5.4070906-l0cyMroinI0@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Hartmut Knaack <knaack.h-Mmb7MZpHnFY@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Benoit Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Peter Meerwald <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Brad Griffis <bgriffis-l0cyMroinI0@public.gmane.org>, Paul Gortmaker <paul.gortmaker-CWA4WttNNZF54TAoqtyWWQ@public.gmane.org>, Sanjeev Sharma <sanjeev_sharma-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>, Jan Kardell <jan.kardell-KSZdJiTw9mzQT0dZR+AlfA@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap@
List-Id: linux-omap@vger.kernel.org

Hi,

On Thursday 05 February 2015 11:51 AM, Vignesh R wrote:
> 
> 
> On Wednesday 21 January 2015 03:44 PM, Vignesh R wrote:
>> On Tuesday 20 January 2015 09:34 PM, Lee Jones wrote:
>>> On Tue, 20 Jan 2015, R, Vignesh wrote:
>>>> On 1/20/2015 5:23 PM, Lee Jones wrote:
>>>>> On Wed, 07 Jan 2015, Vignesh R wrote:
>>>>>
>>>>>> In one shot mode, sequencer automatically disables all enabled steps at
>>>>>> the end of each cycle. (both ADC steps and TSC steps) Hence these steps
>>>>>> need not be saved in reg_se_cache for clearing these steps at a later
>>>>>> stage.
>>>>>> Also, when ADC wakes up Sequencer should not be busy executing any of the
>>>>>> config steps except for the charge step. Previously charge step was 1 ADC
>>>>>> clock cycle and hence it was ignored.
>>>>>> TSC steps are always disabled at the end of each conversion cycle, hence
>>>>>> there is no need to explicitly disable TSC steps by writing 0 to REG_SE.
>>>>>>
>>>>>> Signed-off-by: Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>
>>>>>> ---
>>>>>>
>>>>>> v5:
>>>>>>  - Remove unnecessary clearing of REG_SE
>>>>>>
>>>>>>  drivers/mfd/ti_am335x_tscadc.c       | 13 +++++--------
>>>>>>  include/linux/mfd/ti_am335x_tscadc.h |  1 +
>>>>>>  2 files changed, 6 insertions(+), 8 deletions(-)
>>>>>
>>>>> Looks fine.
>>>>>
>>>>> For my own reference:
>>>>>   Acked-by: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>>>>>
>>>>> Can this patch be applied on its own?
>>>>>
>>>>
>>>> I prefer to wait until input patches are picked up.
>>>
>>> I have no problem with that, but is there a technical reason why?
>>>
>>
>> Nothing, in particular. This patch alone has no impact on the
>> performance of TSC/ADC unit. Patch 2/6 is necessary to observe the
>> changes caused by this series. Hence, please wait until those patches
>> are picked up.
> 
> Input maintainer has applied other patches. You can pick this one.

Gentle ping... Can you pull this patch into 4.0-rc? Other patches of
this series are already in mainline.

Regards
Vignesh
