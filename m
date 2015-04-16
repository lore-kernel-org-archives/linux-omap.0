From: Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: AM335x OMAP2 common clock external fixed-clock registration
Date: Fri, 17 Apr 2015 01:23:50 +0200
Message-ID: <55304486.5020404@gmail.com>
References: <20150414211734.GA28974@deathray> <552E0688.1020903@ti.com> <20150415140945.GA30787@deathray> <552EB152.7050306@ti.com> <20150415194707.GA11007@deathray> <CAPtuhTggHctp5ArGPEuKn2GuPzb-WnKv2_CzPrHzq8hwOR5Aqw@mail.gmail.com> <20150415205136.GA3399@deathray> <552F3B60.8050703@ti.com> <20150416161756.GA27590@deathray> <55301D7F.30708@gmail.com> <20150416220918.GA6057@deathray>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150416220918.GA6057@deathray>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Michael Welling <mwelling-EkmVulN54Sk@public.gmane.org>
Cc: Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>, Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On 17.04.2015 00:09, Michael Welling wrote:
> On Thu, Apr 16, 2015 at 10:37:19PM +0200, Sebastian Hesselbarth wrote:
>> On 16.04.2015 18:17, Michael Welling wrote:
>>> On Thu, Apr 16, 2015 at 07:32:32AM +0300, Tero Kristo wrote:
>>>> On 04/15/2015 11:51 PM, Michael Welling wrote:
>>>>> On Wed, Apr 15, 2015 at 01:45:53PM -0700, Mike Turquette wrote:
>>>>>> On Wed, Apr 15, 2015 at 12:47 PM, Michael Welling <mwelling-EkmVulN54Sk@public.gmane.org> wrote:
>> [...]
>>>>>>> There is still an issue with the si5351.
>>>>>>>
>>>>>>> I had to comment out the clk_put here for the frequency to show up:
>>>>>>> http://lxr.free-electrons.com/source/drivers/clk/clk-si5351.c#L1133
>>>>>>>
>>>>>>> Ideas?
>>>>>>
>>>>>> What is the most recent upstream commit that you are based on?
>>>>>
>>>>> I am working from 4.0.0-rc7.
>>>>>
>>>>> 7b43b47373d40d557cd7e1a84a0bd8ebc4d745ab
>>>>
>>>> Hmm, I wonder why si5351 calls clk_put immediately after of_clk_get
>>>> in the first place, as far as I understand this destroys the clock
>>>> handle, which is still being used later in the code.
>>>
>>> Not sure how this ever worked. This has been in the code since the
>>> initial commit.
>>
>> The reason it worked before may be related with recent rework of
>> clk_put() itself and clk cookies instead of pointers. I lost track on
>> the recent clk subsystem changes here, sorry.
>>
>> However, droping the clk immediately surely isn't right.
>> The thing is, we can remove the clk_put() just because there is no
>> _remove() for that driver. I remember that back in the days the driver
>> was mainlined, clk removal wasn't too easy.
>>
>> FWIW, as soon as _remove() support will be added by someone, we'll have
>> to rethink passing struct clk* by platform_data or at least
>> double-check if we ever used [of_]clk_get() to obtain it.
>>
>> Mind to send a patch removing the clk_put() on !IS_ERR and add a proper
>> error path instead? While of_clk_get() is the only calls that need
>> cleanup on error in si5351_dt_parse() we should probably move that
>> calls to the end of this function. Otherwise we'd also have to cleanup
>> on every of_parse_foo() failure.
>
> What would be the proper error path?
> What cleanup is required?

A proper error path would be to release any claimed resource
on any error. If you look at the code, the only resources that
need to be released are the two clocks in question.

> It should be noted that there are more deep rooted issues with the driver
> that I have noticed. For one the driver behaves differently if the debugging
> is on and when it is off.

I guess you mean #define DEBUG in the driver?

> Here is what the kernel reports with debugging off:

Do you have any measurement equipment to check what is actually set?

> root@som3517-som200:~# cat /sys/kernel/debug/clk/clk_summary
>     clock                         enable_cnt  prepare_cnt        rate   accuracy   phase
> ----------------------------------------------------------------------------------------
>   ref27                                    0            0    27000000          0 0
>      xtal                                  0            0    27000000          0 0
>         pllb                               0            0   599999994          0 0
>            ms0                             0            0    12499999          0 0
>               clk0                         0            0    12499999          0 0
>         plla                               0            0   599999994          0 0
>            ms2                             0            0     8219178          0 0
>               clk2                         0            0     8219178          0 0
>            ms1                             0            0    94117646          0 0
>               clk1                         0            0    94117646          0 0
>
> Here is what the kernel reports with debugging on:
>     clock                         enable_cnt  prepare_cnt        rate   accuracy   phase
> ----------------------------------------------------------------------------------------
>   ref27                                    0            0    27000000          0 0
>      xtal                                  0            0    27000000          0 0
>         pllb                               0            0   884736000          0 0
>            ms0                             0            0    18432000          0 0
>               clk0                         0            0    18432000          0 0

Is this what you expect for clk0?

>         plla                               0            0   897023997          0 0
>            ms2                             0            0    12287999          0 0
>               clk2                         0            0    12287999          0 0

ditto for clk2?

>            ms1                             0            0   140709646          0 0
>               clk1                         0            0   140709646          0 0

This is wrong, I agree. Looks like round_rate()/recalc_rate() of msynth
or clkout is broken with respect to non-pll-master clocks.

I had a quick look at drivers/clk.c too, there has been a lot of churn
in clk API since I last booted my device using si5351.

Is there any way to try out a less recent kernel, let's say two or
three releases before 4.0?

We should just confirm that there has been an issue with it before
already.

I have no clue about the debug on/off issue at the moment.

> Note this is with the following devicetree entry:
>          si5351: clock-generator {
>                  #address-cells = <1>;
>                  #size-cells = <0>;
>                  #clock-cells = <1>;
>                  compatible = "silabs,si5351a-msop";
>                  reg = <0x60>;
>                  status = "okay";
>
>                  /* connect xtal input to 27MHz reference */
>                  clocks = <&ref27>;
>
>                  /* connect xtal input as source of pll0 and pll1 */
>                  silabs,pll-source = <0 0>, <1 0>;
>
>                  clkout0: clkout0 {
>                          reg = <0>;
>                          silabs,drive-strength = <8>;
>                          silabs,multisynth-source = <1>;
>                          silabs,clock-source = <0>;
>                          silabs,pll-master;
>                          clock-frequency = <18432000>;
>                   };
>
>                  clkout1: clkout1 {
>                          reg = <1>;
>                          silabs,drive-strength = <8>;
>                          silabs,multisynth-source = <0>;
>                          silabs,clock-source = <0>;
>                          clock-frequency = <8000000>;
>                  };
>
>                  clkout2: clkout2 {
>                          reg = <2>;
>                          silabs,drive-strength = <8>;
>                          silabs,multisynth-source = <0>;
>                          silabs,clock-source = <0>;
>                          silabs,pll-master;
>                          clock-frequency = <12288000>;
>                  };
>          };
>
> I am losing hope that this driver is stable enough to even use in production.

Who said it is stable for production use? The driver is written from
scratch based on _very_ limited information of the datasheet an appnote.
Also, I only have a single setup with si5351, that is no way enough to
test every combination.

I never heard serious complaints before, so either you help improving
this driver or better ask SiLabs for a table-based driver for your
specific setup.

Sebastian
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
