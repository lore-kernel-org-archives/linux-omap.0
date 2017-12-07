From: Michael Turquette <mturquette@baylibre.com>
Subject: Re: [GIT PULL] clk: ti: clkctrl driver updates for 4.16 merge window
Date: Thu, 7 Dec 2017 10:38:55 -0800
Message-ID: <CAEG3pNAZKVSaU8k6QzPesF9j_ARHGuX7brJ+XzBj=Y7ON+JbYA@mail.gmail.com>
References: <fe379081-62e6-11c9-285d-234e2d1a61e4@ti.com> <20171207072911.GA4283@codeaurora.org>
 <fd7ff1b4-00c3-ce6b-9415-85799661bf8e@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <fd7ff1b4-00c3-ce6b-9415-85799661bf8e@ti.com>
Sender: linux-clk-owner@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: Stephen Boyd <sboyd@codeaurora.org>, linux-clk <linux-clk@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>
List-Id: linux-omap@vger.kernel.org

Hi Tero,

On Thu, Dec 7, 2017 at 12:09 AM, Tero Kristo <t-kristo@ti.com> wrote:
> On 07/12/17 09:29, Stephen Boyd wrote:
>>
>> On 12/05, Tero Kristo wrote:
>>>
>>> Hi Stephen, Mike,
>>>
>>> This pull request contains the v2 of the series posted
>>> (https://www.spinics.net/lists/linux-omap/msg140042.html), with
>>> Stephen's acks added to the mentioned patches, and just applied on
>>> top of 4.15-rc1. I actually wonder if you wanted to add your acks to
>>> the rest of the patches also, but couldn't find any comment about
>>> this anywhere.
>>>
>>> -Tero
>>>
>>> ====
>>>
>>> The following changes since commit
>>> 4fbd8d194f06c8a3fd2af1ce560ddb31f7ec8323:
>>>
>>>    Linux 4.15-rc1 (2017-11-26 16:01:47 -0800)
>>>
>>> are available in the git repository at:
>>>
>>>    https://github.com/t-kristo/linux-pm.git 4.15-rc1-clkctrl-driver
>>>
>>> for you to fetch changes up to fe7020e64f042db4b5ca50c358b232e866523447:
>>>
>>>    clk: ti: omap4: clkctrl data fixes for opt-clocks (2017-12-01
>>> 15:18:08 +0200)
>>
>>
>> Pulled into clk-next.
>
>
> Thanks.
>
>> Did you want to sign a tag instead of
>> sending a plain branch? My ack isn't necessary on anything.
>>
>
> Just a plain branch. Never signed a tag so far, do you have guidelines
> someplace if you prefer this in future?

"git tag -s" is all you need to know. It's nice to keep that tag on
your public tree until the next -rc1, but not strictly necessary.

Ideally PRs should used signed tags, as it lets us verify a trusted tree.

Regards,
Mike

>
> -Tero
>
> --
> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
> Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
