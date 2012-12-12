From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH v2 0/3] gpio: twl4030: Correct status reporting for outputs
Date: Wed, 12 Dec 2012 11:45:59 +0000
Message-ID: <CACxGe6uMabhuKAW6P+Zow3NoviM2NyYGjDh+--r9ndEyiSkdAg@mail.gmail.com>
References: <1354791127-20545-1-git-send-email-peter.ujfalusi@ti.com>
 <CACRpkdYZcEpN-BJy=3DPAQL+QgR+EyNeyABtAPE96+2hYxOQwQ@mail.gmail.com> <50C86691.60005@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <50C86691.60005@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Wed, Dec 12, 2012 at 11:12 AM, Peter Ujfalusi <peter.ujfalusi@ti.com> wrote:
> Hi Grant,
>
> On 12/07/2012 09:09 AM, Linus Walleij wrote:
>> On Thu, Dec 6, 2012 at 11:52 AM, Peter Ujfalusi <peter.ujfalusi@ti.com> wrote:
>>
>>> As Grant commneted on the first version:
>>> https://lkml.org/lkml/2012/12/5/53
>>>
>>> Introduce bitfields to cache the directionand output status of the pins so we
>>> can report them correctly.
>>> To do this I did some cleanup within the driver to get rid of the global
>>> variables and moved them under a private structure, changed the locking as well
>>> to protect the bitfield operation.
>>> As a last patch I added a note that the PWMA/B handling should not be in this
>>> driver at all.
>>
>> This looks good to me:
>> Acked-by: Linus Walleij <linus.walleij@linaro.org>
>>
>> Since Grant was requesting the changes I'll let him decide to merge.
>
> Would you have time to take a look at this set?

I will take a look at it this week, but I cannot pick it up for v3.8
unless it is a regression bug fix from v3.6. It will have to wait for
v3.9 and it can be merged into linux-next after the v3.8 merge window
closes.

g.
