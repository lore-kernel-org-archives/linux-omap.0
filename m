From: Keerthy <j-keerthy@ti.com>
Subject: Re: [PATCH] gpio: lp87565: Add support for GPIO
Date: Mon, 12 Jun 2017 20:01:15 +0530
Message-ID: <167f263d-b339-10e0-8ae2-3dea11874894@ti.com>
References: <1496286631-6295-1-git-send-email-j-keerthy@ti.com>
 <CACRpkdZFYSj0=O1PpPzWpcgV+k7WoKCDRPW3fcQ5+B-pDvEWEw@mail.gmail.com>
 <74fd6c53-7801-73eb-5236-d7a72c93d715@ti.com>
 <CACRpkdadg9im1OXbZkqMa0Bi6NqrNN7hzRWixTtNbHZsqk3WPw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <CACRpkdadg9im1OXbZkqMa0Bi6NqrNN7hzRWixTtNbHZsqk3WPw@mail.gmail.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Lee Jones <lee.jones@linaro.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Tero Kristo <t-kristo@ti.com>, Linux-OMAP <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Andrew F. Davis" <afd@ti.com>
List-Id: linux-omap@vger.kernel.org



On Monday 12 June 2017 07:34 PM, Linus Walleij wrote:
> On Sun, Jun 11, 2017 at 6:27 AM, Keerthy <j-keerthy@ti.com> wrote:
>> On Friday 09 June 2017 02:06 PM, Linus Walleij wrote:
> 
>>> If this IC has several function modes for the pins it should also
>>> be a pin controller... I know it is a lot of upfront code, but... it will
>>> benefit you in the long run. Is it really just these three pins?
>>>
>>> Maybe we should merge it into
>>> drivers/pinctrl/pinctrl-lp87565.c so that at least file placement does
>>> not become a problem later?
>>
>> No Linus. Only 2 modes. So went along the lines of
>> drivers/gpio/gpio-lp873x.c. If you are not okay with this. I can as well
>> remove this part.
> 
> It's fine. Sometimes implementing things strictly in very generic frameworks
> will become a burden because of unnecessary complexities.
> 
> Can you just document it with some comments so it is clear what
> is happening here and what the two modes are? And keep it like this
> otherwise.

Okay sure. I will do that in v2.

Thanks,
Keerthy

> 
> Yours,
> Linus Walleij
> 
