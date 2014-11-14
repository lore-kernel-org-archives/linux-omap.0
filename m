From: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Subject: Re: [PATCH v5 0/7] Per-user clock constraints
Date: Fri, 14 Nov 2014 07:28:12 +0100
Message-ID: <CAAObsKARz=Y3J74Fm+MVOuH-ftK6yGSxWnNtd3LpHZjebKCGsg@mail.gmail.com>
References: <1414666135-14313-1-git-send-email-tomeu.vizoso@collabora.com> <20141031113358.GY32045@tbergstrom-lnx.Nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20141031113358.GY32045@tbergstrom-lnx.Nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter De Schrijver <pdeschrijver@nvidia.com>
Cc: Mike Turquette <mturquette@linaro.org>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, Stephen Boyd <sboyd@codeaurora.org>, Alex Elder <elder@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Haojian Zhuang <haojian.zhuang@linaro.org>, Jaehoon Chung <jh80.chung@samsung.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-doc@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-mips@linux-mips.org, linux-omap@vger.kernel.org, Manuel Lauss <manuel.lauss@gmail.com>, Matt Porter <mporter@linaro.org>, Ralf Baechle <ralf@linux-mips.org>, Zhangfei Gao <zhangfei.gao@linaro.org>
List-Id: linux-omap@vger.kernel.org

On 31 October 2014 12:33, Peter De Schrijver <pdeschrijver@nvidia.com> wrote:
> On Thu, Oct 30, 2014 at 11:48:26AM +0100, Tomeu Vizoso wrote:
>> Hello,
>>
>> this fifth version of the series has just one change, suggested by Stephen:

Hi Mike, how is this looking for 3.19?

Regards,

Tomeu

>> * Initialize clk.ceiling_constraint to ULONG_MAX and warn about new floor
>> constraints being higher than the existing ceiling.
>>
>> The first five patches are just cleanups that should be desirable on their own,
>> and that should make easier to review the actual per-user clock patch.
>>
>> The sixth patch actually moves the per-clock data that was stored in struct
>> clk to a new struct clk_core and adds references to it from both struct clk and
>> struct clk_hw. struct clk is now ready to contain information that is specific
>> to a given clk consumer.
>>
>> The seventh patch adds API for setting floor and ceiling constraints and stores
>> that information on the per-user struct clk, which is iterable from struct
>> clk_core.
>>
>> They are based on top of 3.18-rc1.
>>
>> http://cgit.collabora.com/git/user/tomeu/linux.git/log/?h=per-user-clk-constraints-v5
>>
>
> Acked-By: Peter De Schrijver <pdeschrijver@nvidia.com>
>
> Mike,
>
> Do you think this will be merged for 3.19?
>
> Thanks,
>
> Peter.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
