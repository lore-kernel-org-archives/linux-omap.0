From: Javier Martinez Canillas <javier@dowhile0.org>
Subject: Re: [RFT OMAP1 PATCH 7/8] gpio: omap: get rid of omap_irq_to_gpio()
Date: Sat, 21 Mar 2015 00:44:46 +0100
Message-ID: <CABxcv==jKSjWTCDMMUg0vZzpK34tLYnwdJzPw3h6H3oU+6dZ9Q@mail.gmail.com>
References: <1426785944-17255-1-git-send-email-grygorii.strashko@linaro.org>
	<1426785944-17255-8-git-send-email-grygorii.strashko@linaro.org>
	<CABxcv==mH5tpvW0FOsv30A-aucyZCAKuSo95Y=LW21+EWR4uDA@mail.gmail.com>
	<550C857F.5060705@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <550C857F.5060705@linaro.org>
Sender: linux-gpio-owner@vger.kernel.org
To: "Grygorii.Strashko@linaro.org" <grygorii.strashko@linaro.org>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Santosh Shilimkar <ssantosh@kernel.org>, Kevin Hilman <khilman@deeprootsystems.com>, Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Linux GPIO List <linux-gpio@vger.kernel.org>, Linux Kernel <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Hello Grygorii,

On Fri, Mar 20, 2015 at 9:39 PM, Grygorii.Strashko@linaro.org
<grygorii.strashko@linaro.org> wrote:
> On 03/20/2015 08:56 PM, Javier Martinez Canillas wrote:
>> Hello Grygorii,
>>
>> On Thu, Mar 19, 2015 at 6:25 PM,  <grygorii.strashko@linaro.org> wrote:
>>> From: Grygorii Strashko <grygorii.strashko@linaro.org>
>>>
>>> Now OMAP GPIO driver prepared for omap_irq_to_gpio() removing.
>>> Do it ;)
>>>
>>> Signed-off-by: Grygorii Strashko <grygorii.strashko@linaro.org>
>>
>> I don't have access to OMAP1 boards to test but Tony did it o an
>> osk5912 and Aaro can confirm that it doesn't cause regressions on
>> other OMAP1 boards.
>
> Thanks. But could you clarify one point to me please?
> "Aaro can confirm that it doesn't cause regressions on
> other OMAP1 boards" - Does It mean I can add his Tested-by?
> Or I still have to wait for his direct reply?
> Just to avoid any confusions ;)
>

I meant that as far as I know Aaro has access to more OMAP1 systems so
he should be able to test that no regressions are added for those. But
I don't know if he would be able to test and I think your cleanups are
good so that's why I acked the patches.

Sorry for the confusion.

Best regards,
Javier
