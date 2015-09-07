From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [PATCH 0/7] gpio: omap: fixes and improvements
Date: Mon, 7 Sep 2015 14:40:39 +0300
Message-ID: <55ED77B7.8020406@ti.com>
References: <1439896258-26449-1-git-send-email-grygorii.strashko@ti.com>
 <CACRpkdZCGJ3JHxPCaiKkMAGZoxFVY7VbkhkJwBJdiP_452KNLg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <CACRpkdZCGJ3JHxPCaiKkMAGZoxFVY7VbkhkJwBJdiP_452KNLg@mail.gmail.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Alexandre Courbot <gnurou@gmail.com>, Santosh Shilimkar <ssantosh@kernel.org>, Kevin Hilman <khilman@deeprootsystems.com>, Tony Lindgren <tony@atomide.com>, Javier Martinez Canillas <javier@dowhile0.org>, Linux-OMAP <linux-omap@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Philipp Schrader <philipp@peloton-tech.com>, Austin Schuh <austin@peloton-tech.com>
List-Id: linux-omap@vger.kernel.org

+Cc: Austin, Philipp

On 08/26/2015 10:53 AM, Linus Walleij wrote:
> On Tue, Aug 18, 2015 at 1:10 PM, Grygorii Strashko
> <grygorii.strashko@ti.com> wrote:
>
>> This patch series contains set of trivial fixes and improvements, and also
>> patches which fixes wrong APIs usage in atomic context as for -RT as for
>> non-RT kernel. The final goal of this series is to make TI OMAP GPIO
>> driver compatible with -RT kernel as much as possible.
>>
>> Patch 1-4: trivial fixes and improvements
>> Patch 5: fixes wrong CLK clk_prepare/unprepare APIs usage in atomic contexet
>
> I've applied patches 1-5 with Santosh's ACK and Tony's Tested-by.
>
>> Patch 6(rfc): required to be compatible with -RT kernel, because PM runtime
>>   can't be used in atimic context on -RT.
>> Patch 7(rfc): This patch converts TI OMAP GPIO driver to use generic irq
>>   handler instead of chained IRQ handler. This way OMAP GPIO driver will be
>>   compatible with RT kernel where it will be forced thread IRQ handler
>>   while in non-RT kernel it still will be executed in HW IRQ context.
>
> Waiting for more feedback here.
>
> Yours,
> Linus Walleij
>

I've got some feedback here.
Patches were tested on to of TI -RT tree ti-rt-linux-4.1.y.



-------- Forwarded Message --------
Subject: Re: [PATCH 0/7] gpio: omap: fixes and improvements
Date: Fri, 4 Sep 2015 21:42:03 +0000
From: Austin Schuh <austin@peloton-tech.com>
To: grygorii.strashko@ti.com
CC: Philipp Schrader <philipp@peloton-tech.com>

Hi Grygorii,

We are running the entire patchset on top of
a7a6541db840cc4514a26fc12cc1bc94d1b9e873 from the git://
git.ti.com/ti-linux-kernel/ti-linux-kernel.git tree. I've pushed the
system pretty hard overnight and haven't seen any instability (with lockdep
enabled. We used to get splats pretty fast).

I wasn't on lkml when you sent the patchset out, so I'm not sure how to
best reply to the original thread with this info.

Tested-by: Austin Schuh <austin@peloton-tech.com>

Austin
-------- Forwarded Message --------

-- 
regards,
-grygorii
