From: Tomasz Figa <tomasz.figa@gmail.com>
Subject: Re: [PATCH v10 2/8] ARM: l2c: Refactor the driver to use commit-like
 interface
Date: Fri, 02 Jan 2015 18:13:39 +0900
Message-ID: <54A66143.2080506@gmail.com>
References: <1419331716-8972-1-git-send-email-m.szyprowski@samsung.com>	<1419331716-8972-3-git-send-email-m.szyprowski@samsung.com>	<54A19C17.1020909@ti.com> <CA+Ln22G3kVA_-tsjAxbe2rqSHeLtdU2X_EhNL0uW3cUCgaWLgg@mail.gmail.com> <54A2BBDC.1020900@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <54A2BBDC.1020900@ti.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, linux-kernel <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Kyungmin Park <kyungmin.park@samsung.com>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Kukjin Kim <kgene.kim@samsung.com>, Laura Abbott <lauraa@codeaurora.org>, Linus Walleij <linus.walleij@linaro.org>, Tony Lindgren <tony@atomide.com>, Daniel Drake <drake@endlessm.com>, Jon Loeliger <loeliger@gmail.com>, Mark Rutland <mark.rutland@arm.com>, Kevin Hilman <khilman@linaro.org>
List-Id: linux-omap@vger.kernel.org

On 30.12.2014 23:51, Nishanth Menon wrote:
>>> Looks like the following also need addressing:
>>> data->save is called twice (once more after l2cof_init)
>>> l2c310_init_fns also needs l2c310_configure
>>> will be nice to use l2x0_data only after we kmemdup data in __l2c_init
>>
>> I'll check this.
> Thanks.
>

Apparently the second save in __l2c_init() is not needed and it should 
have been removed. However it might be a good idea to actually do second 
save in l2c_enable() after l2c_configure() so that the values actually 
permitted by hardware and/or secure firmware are stored.

l2c310_init_fns needs to be updated indeed.

However I'm not sure about your concern about using l2x0_data before 
kmemdup(). I don't see any code potentially doing this.

Best regards,
Tomasz
