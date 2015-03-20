From: Javier Martinez Canillas <javier@dowhile0.org>
Subject: Re: [PATCH 1/8] gpio: omap: convert omap_gpio_is_input() to use gpio offset
Date: Fri, 20 Mar 2015 19:37:05 +0100
Message-ID: <CABxcv=n01ksf8Onprrj6kYdp5V5yp94_OGnzbX0Rk=z7kvUAYw@mail.gmail.com>
References: <1426785944-17255-1-git-send-email-grygorii.strashko@linaro.org>
	<1426785944-17255-2-git-send-email-grygorii.strashko@linaro.org>
	<550C4E12.8070204@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <550C4E12.8070204@oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "santosh.shilimkar@oracle.com" <santosh.shilimkar@oracle.com>
Cc: grygorii.strashko@linaro.org, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Santosh Shilimkar <ssantosh@kernel.org>, Kevin Hilman <khilman@deeprootsystems.com>, Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Linux GPIO List <linux-gpio@vger.kernel.org>, Linux Kernel <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Fri, Mar 20, 2015 at 5:42 PM, santosh.shilimkar@oracle.com
<santosh.shilimkar@oracle.com> wrote:
> On 3/19/15 10:25 AM, grygorii.strashko@linaro.org wrote:
>>
>> From: Grygorii Strashko <grygorii.strashko@linaro.org>
>>
>> Convert omap_gpio_is_input() to use GPIO offset instead of mask and,
>> in such way, make code simpler and remove few lines of code.
>>
>> Signed-off-by: Grygorii Strashko <grygorii.strashko@linaro.org>
>> ---
>
>
> Acked-by: Santosh Shilimkar <ssantosh@kernel.org>

Acked-by: Javier Martinez Canillas <javier@dowhile0.org>
