From: Colin Ian King <colin.king@canonical.com>
Subject: Re: [PATCH][next] pinctrl: pinctrl-single: add allocation failure
 checking of saved_vals
Date: Thu, 7 Jun 2018 09:26:23 +0100
Message-ID: <a197ff75-627a-b0b1-1683-ef1b3ff4ebfd@canonical.com>
References: <20180606134338.4645-1-colin.king@canonical.com>
 <CAHp75Vd0Djw+nDN7u=-CLEfdDGA5QTsMueOb9EZLNnCDgso5fA@mail.gmail.com>
 <20180607073543.GP13775@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180607073543.GP13775@localhost>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Johan Hovold <johan@kernel.org>, Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, Linus Walleij <linus.walleij@linaro.org>, kernel-janitors@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, Haojian Zhuang <haojian.zhuang@linaro.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On 07/06/18 08:35, Johan Hovold wrote:
> On Wed, Jun 06, 2018 at 07:02:03PM +0300, Andy Shevchenko wrote:
>> On Wed, Jun 6, 2018 at 4:43 PM, Colin King <colin.king@canonical.com> wrote:
>>> From: Colin Ian King <colin.king@canonical.com>
>>>
>>> Currently saved_vals is being allocated and there is no check for
>>> failed allocation (which is more likely than normal when using
>>> GFP_ATOMIC).  Fix this by checking for a failed allocation and
>>> propagating this error return down the the caller chain.
>>>
>>> Detected by CoverityScan, CID#1469841 ("Dereference null return value")
>>>
>>> Fixes: 88a1dbdec682 ("pinctrl: pinctrl-single: Add functions to save and restore pinctrl context")
>>> Signed-off-by: Colin Ian King <colin.king@canonical.com>
>>> ---
>>>  drivers/pinctrl/pinctrl-single.c | 14 +++++++++++---
>>>  1 file changed, 11 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/pinctrl/pinctrl-single.c b/drivers/pinctrl/pinctrl-single.c
>>> index 9c3c00515aa0..0905ee002041 100644
>>> --- a/drivers/pinctrl/pinctrl-single.c
>>> +++ b/drivers/pinctrl/pinctrl-single.c
>>> @@ -1588,8 +1588,11 @@ static int pcs_save_context(struct pcs_device *pcs)
>>>
>>>         mux_bytes = pcs->width / BITS_PER_BYTE;
>>>
>>> -       if (!pcs->saved_vals)
>>> +       if (!pcs->saved_vals) {
>>>                 pcs->saved_vals = devm_kzalloc(pcs->dev, pcs->size, GFP_ATOMIC);
>>
>>> +               if (!pcs->saved_vals)
>>> +                       return -ENOMEM;
>>
>> Wouldn't make sense to move it out of the first condition?
>>
>> Something like
>>
>> if (!foo)
>>  foo = ...malloc(...);
>> if (!foo)
>>  return ...
> 
> No, checking for NULL immediately after the allocation is more obvious
> and easier to parse.

+1 on that
> 
> Johan
> 
