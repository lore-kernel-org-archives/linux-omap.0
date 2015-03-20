From: "Grygorii.Strashko@linaro.org" <grygorii.strashko@linaro.org>
Subject: Re: [RFT OMAP1 PATCH 7/8] gpio: omap: get rid of omap_irq_to_gpio()
Date: Fri, 20 Mar 2015 22:39:27 +0200
Message-ID: <550C857F.5060705@linaro.org>
References: <1426785944-17255-1-git-send-email-grygorii.strashko@linaro.org>	<1426785944-17255-8-git-send-email-grygorii.strashko@linaro.org> <CABxcv==mH5tpvW0FOsv30A-aucyZCAKuSo95Y=LW21+EWR4uDA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CABxcv==mH5tpvW0FOsv30A-aucyZCAKuSo95Y=LW21+EWR4uDA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Javier Martinez Canillas <javier@dowhile0.org>, Grygorii Strashko <grygorii.strashko@linaro.org>, Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Santosh Shilimkar <ssantosh@kernel.org>, Kevin Hilman <khilman@deeprootsystems.com>, Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Linux GPIO List <linux-gpio@vger.kernel.org>, Linux Kernel <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On 03/20/2015 08:56 PM, Javier Martinez Canillas wrote:
> Hello Grygorii,
> 
> On Thu, Mar 19, 2015 at 6:25 PM,  <grygorii.strashko@linaro.org> wrote:
>> From: Grygorii Strashko <grygorii.strashko@linaro.org>
>>
>> Now OMAP GPIO driver prepared for omap_irq_to_gpio() removing.
>> Do it ;)
>>
>> Signed-off-by: Grygorii Strashko <grygorii.strashko@linaro.org>
> 
> I don't have access to OMAP1 boards to test but Tony did it o an
> osk5912 and Aaro can confirm that it doesn't cause regressions on
> other OMAP1 boards.

Thanks. But could you clarify one point to me please? 
"Aaro can confirm that it doesn't cause regressions on
other OMAP1 boards" - Does It mean I can add his Tested-by?
Or I still have to wait for his direct reply? 
Just to avoid any confusions ;)

> Acked-by: Javier Martinez Canillas <javier@dowhile0.org>
> 


-- 
regards,
-grygorii
