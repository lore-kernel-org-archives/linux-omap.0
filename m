From: Grygorii Strashko <grygorii.strashko@linaro.org>
Subject: Re: [PATCH] thermal: ti-soc-thermal: bandgap: Fix build warning if !CONFIG_PM_SLEEP
Date: Wed, 25 Feb 2015 10:44:23 +0200
Message-ID: <CAO5CWPKK-LL24cNnhbLeDzQ=Fj_zfTWWY_m3PT8KGCH7fGj3Dw@mail.gmail.com>
References: <1423234546-10458-1-git-send-email-grygorii.strashko@linaro.org>
	<20150209150106.GB21362@kahuna>
	<54ECA053.8000809@linaro.org>
	<20150224180324.GA3448@developer.amazonguestwifi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <20150224180324.GA3448@developer.amazonguestwifi.org>
Sender: linux-pm-owner@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Nishanth Menon <nm@ti.com>, Zhang Rui <rui.zhang@intel.com>, Paul Walmsley <paul@pwsan.com>, Viresh Kumar <viresh.kumar@linaro.org>, Sumit Semwal <sumit.semwal@linaro.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, linux-pm@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 24 February 2015 at 20:03, Eduardo Valentin <edubezval@gmail.com> wrote:
> On Tue, Feb 24, 2015 at 06:01:23PM +0200, Grygorii.Strashko@linaro.org wrote:
>> On 02/09/2015 05:01 PM, Nishanth Menon wrote:
>> > On 16:55-20150206, grygorii.strashko@linaro.org wrote:
>> >> From: Grygorii Strashko <Grygorii.Strashko@linaro.org>
>> >>
>> >> Fix following build warning if CONFIG_PM_SLEEP is not set:
>> >>
>> >> drivers/thermal/ti-soc-thermal/ti-bandgap.c:1478:12: warning: 'ti_bandgap_suspend' defined but not used [-Wunused-function]
>> >>   static int ti_bandgap_suspend(struct device *dev)
>> >>              ^
>> >
>> > Suggest aligning with Paul as well:
>> > https://patchwork.kernel.org/patch/5795391/
>>
>> ^Paul Walmsley wrote: Oh, nothing to be confused by, I just missed the
>>  earlier patch. I withdraw mine.
>>
>> >
>> > Otherwise:
>> > Acked-by: Nishanth Menon <nm@ti.com>
>> >
>>
>> It looks like this patch is missed in 4.0-rc1, so could it be merged
>> during rc cycle or you'd like me to resend it?
>> (I've rechecked - it can be applied on top of Linux 4.0-rc1 without any issues)
>
>
> No need to resend. I will add to my -fixes queue.
>

Thanks.


-- 
Best regards,
-grygorii
