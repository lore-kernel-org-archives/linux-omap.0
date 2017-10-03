From: Santosh Shilimkar <santosh.shilimkar@oracle.com>
Subject: Re: [RESEND PATCH] gpio: omap: Fix lost edge interrupts
Date: Tue, 3 Oct 2017 11:15:38 -0700
Message-ID: <e7de2f01-bb4b-184e-64b1-f46796ad7636@oracle.com>
References: <20171003161705.23398-1-grygorii.strashko@ti.com>
 <7b8f3c6a-0f4b-98ed-3887-91a01ed6cdbb@oracle.com>
 <81906eda-58ac-38e3-bc0a-8ead2b6aa8df@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <81906eda-58ac-38e3-bc0a-8ead2b6aa8df@ti.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Tony Lindgren <tony@atomide.com>, Santosh Shilimkar <ssantosh@kernel.org>, linux-omap@vger.kernel.org, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, Ladislav Michl <ladis@linux-mips.org>
List-Id: linux-omap@vger.kernel.org

On 10/3/2017 9:52 AM, Grygorii Strashko wrote:
> Hi Santosh,
> 
> On 10/03/2017 11:41 AM, Santosh Shilimkar wrote:
>>

[...]

>> This was one of the concern I was thinking when GPIO IRQ conversion
>> was done. Grygorii since you did that conversion, can you please
>> check since I see now that the irq code is becoming increasingly
>> complex.
> 
> This patch was developed in coop with Ladislav and he intensively tested it and
> this patch actually simplifies IRQ handling. Also, OMAP driver parts which
> this patch touches are ancient.
> 
Good to know that its being tested and thanksfor the background.

regards,
Santosh
