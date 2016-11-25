From: Nicolae Rosia <nicolae.rosia.oss@gmail.com>
Subject: Re: [PATCH] regulator: twl6030: add dependency on OF
Date: Fri, 25 Nov 2016 15:09:43 +0200
Message-ID: <CAKP5S=1Ds0-cz7qHiRbLPQj2e0fwaPXFExhRBcZ5qMkWUTaumA@mail.gmail.com>
References: <20161125074335.6947-1-Nicolae_Rosia@mentor.com> <20161125130337.lf33cysb4cyq6axl@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161125130337.lf33cysb4cyq6axl@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Nicolae Rosia <Nicolae_Rosia@mentor.com>, Liam Girdwood <lgirdwood@gmail.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi,

On Fri, Nov 25, 2016 at 3:03 PM, Mark Brown <broonie@kernel.org> wrote:
> On Fri, Nov 25, 2016 at 09:43:35AM +0200, Nicolae Rosia wrote:
>
>> This driver was converted to device tree only,
>> add dependency on OF symbol and drop of_match_ptr
>
> These are two different changes :(
>
Ok, will send a patch only for Kconfig.

>>  config REGULATOR_TWL4030
>>       tristate "TI TWL4030/TWL5030/TWL6030/TPS659x0 PMIC"
>>       depends on TWL4030_CORE
>> +     depends on OF
>
> This should be OF || COMPILE_TEST so people can still get build coverage
> without DT.
>
Ok.

>> --- a/drivers/regulator/twl6030-regulator.c
>> +++ b/drivers/regulator/twl6030-regulator.c
>> @@ -773,7 +773,7 @@ static struct platform_driver twlreg_driver = {
>>        */
>>       .driver  = {
>>               .name  = "twl6030_reg",
>> -             .of_match_table = of_match_ptr(twl_of_match),
>> +             .of_match_table = twl_of_match,
>
> This buys us nothing, it's not going to make any practical difference
> but on the other hand it costs nothing to have it there either.  The
> only impact I can see this having is causing someone doing a cut'n'paste
> to miss the of_match_ptr() out.
I did this because I received a comment on another patch [0].

Thanks,
Nicolae

[0] https://patchwork.ozlabs.org/patch/694021/
