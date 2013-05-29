From: Andrii Tseglytskyi <andrii.tseglytskyi@ti.com>
Subject: Re: [PATCH v1 0/3] PM / AVS: SmartReflex: driver misc fixes
Date: Wed, 29 May 2013 13:00:06 +0300
Message-ID: <51A5D1A6.8060603@ti.com>
References: <1369652846-14412-1-git-send-email-andrii.tseglytskyi@ti.com> <87li6ybywj.fsf@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87li6ybywj.fsf@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Kevin Hilman <khilman@linaro.org>
Cc: J Keerthy <j-keerthy@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 05/29/2013 12:03 AM, Kevin Hilman wrote:
> Andrii Tseglytskyi <andrii.tseglytskyi@ti.com> writes:
>
>> The following patch series contain several misc fixes to SmartReflex driver:
>>
>> 1. disable errgen before vpbound disable. Critical fix, needed for
>> proper work of AVS-VP communicaton protocol.
>>
>> 2. disable runtime PM on driver remove. Trivial - runtime PM cleanup.
>>
>> 3. fix driver name. Trivial - proper DRIVER_NAME was not defined
>> since SmartReflex driver was introduced with initial commit.
>>
>> Patches are based on:
>> git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>> tag: v3.10-rc2
>>
>> Verified on OMAP4430. Boot - OK. SmartReflex registers debug dump - OK
>>
>> Available on GitHub:
>> https://github.com/andriit/linux-omap-k3.8/commits/avs_sr_driver_misc_fixes_v01
>>
>> Andrii Tseglytskyi (2):
>>    PM / AVS: SmartReflex: disable runtime PM on driver remove
>>    PM / AVS: SmartReflex: fix driver name
>>
>> Nishanth Menon (1):
>>    PM / AVS: SmartReflex: disable errgen before vpbound disable
>>
>>   drivers/power/avs/smartreflex.c |   15 +++++++++++----
>>   1 file changed, 11 insertions(+), 4 deletions(-)
> I had a minor comment on PATCH 1/3, otherwise these look good for v3.11
> (since they are not regressions, they don't qualify for v3.10.)
>
> Please repost with the changes and be sure to copy linux-pm@vger.kernel.org

OK. Will Cc to linux-pm@vger.kernel.org in next patch version.
Thank you for review.

>
> Thanks,
>
> Kevin
>
