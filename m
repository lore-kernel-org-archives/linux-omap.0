From: "Hemanth V" <hemanthv@ti.com>
Subject: RE: [PATCH 1/7] pwm: Add pwm core driver
Date: Tue, 28 Sep 2010 15:04:43 +0530 (IST)
Message-ID: <19145.10.24.255.18.1285666483.squirrel@dbdmail.itg.ti.com>
References: <1285659648-21409-1-git-send-email-arun.murthy@stericsson.com>   
    <1285659648-21409-2-git-send-email-arun.murthy@stericsson.com>   
    <201009281114.31223.anarsoul@gmail.com>   
    <F45880696056844FA6A73F415B568C69532DC2FA8F@EXDCVYMBSTM006.EQ1STM.local>
    <63731.10.24.255.18.1285663815.squirrel@dbdmail.itg.ti.com>
    <F45880696056844FA6A73F415B568C69532DC2FB21@EXDCVYMBSTM006.EQ1STM.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mips-bounce@linux-mips.org>
In-Reply-To: <F45880696056844FA6A73F415B568C69532DC2FB21@EXDCVYMBSTM006.EQ1STM.loca
     l>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
To: Arun MURTHY <arun.murthy@stericsson.com>, linux-omap@vger.kernel.org
Cc: Vasily Khoruzhick <anarsoul@gmail.com>, "eric.y.miao@gmail.com" <eric.y.miao@gmail.com>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "grinberg@compulab.co.il" <grinberg@compulab.co.il>, "mike@compulab.co.il" <mike@compulab.co.il>, "robert.jarzmik@free.fr" <robert.jarzmik@free.fr>, "marek.vasut@gmail.com" <marek.vasut@gmail.com>, "drwyrm@gmail.com" <drwyrm@gmail.com>, "stefan@openezx.org" <stefan@openezx.org>, "laforge@openezx.org" <laforge@openezx.org>, "ospite@studenti.unina.it" <ospite@studenti.unina.it>, "philipp.zabel@gmail.com" <philipp.zabel@gmail.com>, "mad_soft@inbox.ru" <mad_soft@inbox.ru>, "maz@misterjones.org" <maz@misterjones.org>, "daniel@caiaq.de" <daniel@caiaq.de>, "haojian.zhuang@marvell.com" <haojian.zhuang@marvell.com>, timur@free
List-Id: linux-omap@vger.kernel.org

>> >> On 28 of September 2010 10:40:42 Arun Murthy wrote:
>> >> > The existing pwm based led and backlight driver makes use of the
>> >> > pwm(include/linux/pwm.h). So all the board specific pwm drivers
>> will
>> >> > be exposing the same set of function name as in
>> include/linux/pwm.h.
>> >> > As a result build fails.
>> >>
>> >> Which build fails? One with multi-SoC support? Please be more
>> specific.
>> > Sure will add this in v2.
>> >
>>
>> Could you clarify for the benefit of all, which specific issues you are
>> trying to address with this patch series
> 1. Now since all the pwm driver export same set of function(pwm_enable, pwm_disable,..), if it happens that there are two pwm driver enabled this
> leads to re-declaration and results in build failure. The proper way to handle this would be to have a pwm core function, and let all the pwm
> drivers register to the pwm core driver.
> 2. The above scenario also occurs in place of multi-soc environment. Lets say OMAP has a pwm module and that is being used for primary lcd backlight
> and twl has a backlight that is being used for controlling the charging led brightness. In this case there exists 2 pwm drivers and one pwm driver
> will be used by pwm_bl.c and other by leds-pwm.c

Speaking specifically of OMAP4, twl6030 supports multiple PWMs i.e for display/keypad backlight, charging
led. But there should not be need for multiple drivers since twl6030-pwm should be able to support
all these (currently it doesnot though). So there would single pwm_enable, pwm_disable exported and driver
internally takes care configuring the correct PWM based on id. Would it not be similar
situation for other hardware also.

Thanks
Hemanth
