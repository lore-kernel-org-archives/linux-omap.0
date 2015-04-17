From: Tero Kristo <t-kristo@ti.com>
Subject: Re: AM335x OMAP2 common clock external fixed-clock registration
Date: Fri, 17 Apr 2015 10:13:00 +0300
Message-ID: <5530B27C.9020307@ti.com>
References: <20150415140945.GA30787@deathray> <552EB152.7050306@ti.com> <20150415194707.GA11007@deathray> <CAPtuhTggHctp5ArGPEuKn2GuPzb-WnKv2_CzPrHzq8hwOR5Aqw@mail.gmail.com> <20150415205136.GA3399@deathray> <552F3B60.8050703@ti.com> <20150416161756.GA27590@deathray> <55301D7F.30708@gmail.com> <20150416220918.GA6057@deathray> <55304486.5020404@gmail.com> <20150417020048.GA27174@deathray>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:56159 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750925AbbDQHOH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 Apr 2015 03:14:07 -0400
In-Reply-To: <20150417020048.GA27174@deathray>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Michael Welling <mwelling@ieee.org>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Cc: Mike Turquette <mturquette@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Russell King <linux@arm.linux.org.uk>, devicetree <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Tony Lindgren <tony@atomide.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Daniel Mack <daniel@zonque.org>

On 04/17/2015 05:00 AM, Michael Welling wrote:
> On Fri, Apr 17, 2015 at 01:23:50AM +0200, Sebastian Hesselbarth wrote:
>> On 17.04.2015 00:09, Michael Welling wrote:
>>> On Thu, Apr 16, 2015 at 10:37:19PM +0200, Sebastian Hesselbarth wrote:
>>>> On 16.04.2015 18:17, Michael Welling wrote:
>>>>> On Thu, Apr 16, 2015 at 07:32:32AM +0300, Tero Kristo wrote:
>>>>>> On 04/15/2015 11:51 PM, Michael Welling wrote:
>>>>>>> On Wed, Apr 15, 2015 at 01:45:53PM -0700, Mike Turquette wrote:
>>>>>>>> On Wed, Apr 15, 2015 at 12:47 PM, Michael Welling <mwelling@ieee.org> wrote:
>>>> [...]
>>>>>>>>> There is still an issue with the si5351.
>>>>>>>>>
>>>>>>>>> I had to comment out the clk_put here for the frequency to show up:
>>>>>>>>> http://lxr.free-electrons.com/source/drivers/clk/clk-si5351.c#L1133
>>>>>>>>>
>>>>>>>>> Ideas?
>>>>>>>>
>>>>>>>> What is the most recent upstream commit that you are based on?
>>>>>>>
>>>>>>> I am working from 4.0.0-rc7.
>>>>>>>
>>>>>>> 7b43b47373d40d557cd7e1a84a0bd8ebc4d745ab
>>>>>>
>>>>>> Hmm, I wonder why si5351 calls clk_put immediately after of_clk_get
>>>>>> in the first place, as far as I understand this destroys the clock
>>>>>> handle, which is still being used later in the code.
>>>>>
>>>>> Not sure how this ever worked. This has been in the code since the
>>>>> initial commit.
>>>>
>>>> The reason it worked before may be related with recent rework of
>>>> clk_put() itself and clk cookies instead of pointers. I lost track on
>>>> the recent clk subsystem changes here, sorry.
>>>>
>>>> However, droping the clk immediately surely isn't right.
>>>> The thing is, we can remove the clk_put() just because there is no
>>>> _remove() for that driver. I remember that back in the days the driver
>>>> was mainlined, clk removal wasn't too easy.
>>>>
>>>> FWIW, as soon as _remove() support will be added by someone, we'll have
>>>> to rethink passing struct clk* by platform_data or at least
>>>> double-check if we ever used [of_]clk_get() to obtain it.
>>>>
>>>> Mind to send a patch removing the clk_put() on !IS_ERR and add a proper
>>>> error path instead? While of_clk_get() is the only calls that need
>>>> cleanup on error in si5351_dt_parse() we should probably move that
>>>> calls to the end of this function. Otherwise we'd also have to cleanup
>>>> on every of_parse_foo() failure.
>>>
>>> What would be the proper error path?
>>> What cleanup is required?
>>
>> A proper error path would be to release any claimed resource
>> on any error. If you look at the code, the only resources that
>> need to be released are the two clocks in question.
>
> So for every error return in the probe function and in the of si5351_dt_parse
> it needs to clk_put first right?
>
> See attached patch to see if we are on the same page.
>
>>
>>> It should be noted that there are more deep rooted issues with the driver
>>> that I have noticed. For one the driver behaves differently if the debugging
>>> is on and when it is off.
>>
>> I guess you mean #define DEBUG in the driver?
>
> Yes.
>
>>
>>> Here is what the kernel reports with debugging off:
>>
>> Do you have any measurement equipment to check what is actually set?
>
> Yes, I have an oscilloscope here at my desk.
> The reported numbers do not always correspond to the actual output in some
> cases.
>
> The ms2 output has appeared to stop working all together sometime whilest
> testing. I may have to solder a new chip on there.
>
> Could misconfiguration damage the chip?
>
>>
>>> root@som3517-som200:~# cat /sys/kernel/debug/clk/clk_summary
>>>     clock                         enable_cnt  prepare_cnt        rate   accuracy   phase
>>> ----------------------------------------------------------------------------------------
>>>   ref27                                    0            0    27000000          0 0
>>>      xtal                                  0            0    27000000          0 0
>>>         pllb                               0            0   599999994          0 0
>>>            ms0                             0            0    12499999          0 0
>>>               clk0                         0            0    12499999          0 0
>>>         plla                               0            0   599999994          0 0
>>>            ms2                             0            0     8219178          0 0
>>>               clk2                         0            0     8219178          0 0
>>>            ms1                             0            0    94117646          0 0
>>>               clk1                         0            0    94117646          0 0
>>>
>>> Here is what the kernel reports with debugging on:
>>>     clock                         enable_cnt  prepare_cnt        rate   accuracy   phase
>>> ----------------------------------------------------------------------------------------
>>>   ref27                                    0            0    27000000          0 0
>>>      xtal                                  0            0    27000000          0 0
>>>         pllb                               0            0   884736000          0 0
>>>            ms0                             0            0    18432000          0 0
>>>               clk0                         0            0    18432000          0 0
>>
>> Is this what you expect for clk0?
>
> Yes.
>
>>
>>>         plla                               0            0   897023997          0 0
>>>            ms2                             0            0    12287999          0 0
>>>               clk2                         0            0    12287999          0 0
>>
>> ditto for clk2?
>
> Yes.
>
>>
>>>            ms1                             0            0   140709646          0 0
>>>               clk1                         0            0   140709646          0 0
>>
>> This is wrong, I agree. Looks like round_rate()/recalc_rate() of msynth
>> or clkout is broken with respect to non-pll-master clocks.
>>
>> I had a quick look at drivers/clk.c too, there has been a lot of churn
>> in clk API since I last booted my device using si5351.
>>
>> Is there any way to try out a less recent kernel, let's say two or
>> three releases before 4.0?
>
> Could you provide a specific version that you think has the best chances of
> working?
>
>>
>> We should just confirm that there has been an issue with it before
>> already.
>>
>> I have no clue about the debug on/off issue at the moment.
>>
>>> Note this is with the following devicetree entry:
>>>          si5351: clock-generator {
>>>                  #address-cells = <1>;
>>>                  #size-cells = <0>;
>>>                  #clock-cells = <1>;
>>>                  compatible = "silabs,si5351a-msop";
>>>                  reg = <0x60>;
>>>                  status = "okay";
>>>
>>>                  /* connect xtal input to 27MHz reference */
>>>                  clocks = <&ref27>;
>>>
>>>                  /* connect xtal input as source of pll0 and pll1 */
>>>                  silabs,pll-source = <0 0>, <1 0>;
>>>
>>>                  clkout0: clkout0 {
>>>                          reg = <0>;
>>>                          silabs,drive-strength = <8>;
>>>                          silabs,multisynth-source = <1>;
>>>                          silabs,clock-source = <0>;
>>>                          silabs,pll-master;
>>>                          clock-frequency = <18432000>;
>>>                   };
>>>
>>>                  clkout1: clkout1 {
>>>                          reg = <1>;
>>>                          silabs,drive-strength = <8>;
>>>                          silabs,multisynth-source = <0>;
>>>                          silabs,clock-source = <0>;
>>>                          clock-frequency = <8000000>;
>>>                  };
>>>
>>>                  clkout2: clkout2 {
>>>                          reg = <2>;
>>>                          silabs,drive-strength = <8>;
>>>                          silabs,multisynth-source = <0>;
>>>                          silabs,clock-source = <0>;
>>>                          silabs,pll-master;
>>>                          clock-frequency = <12288000>;
>>>                  };
>>>          };
>>>
>>> I am losing hope that this driver is stable enough to even use in production.
>>
>> Who said it is stable for production use? The driver is written from
>> scratch based on _very_ limited information of the datasheet an appnote.
>> Also, I only have a single setup with si5351, that is no way enough to
>> test every combination.
>
> Well it is not in staging and I am sure it took much work to get it working
> for you.

non-staging doesn't mean code is absolutely bug free. Linux kernel is 
still just software, and as we know, every piece of software has bugs 
(except maybe the simplest hello-world app.)

>>
>> I never heard serious complaints before, so either you help improving
>> this driver or better ask SiLabs for a table-based driver for your
>> specific setup.
>
> I have routines to program the chip from U-Boot and Linux userspace using
> the table method. I was hoping that a mainline driver could replace these
> hackish utilities.

You can still replace your hack solution.

The beauty of linux comes in that if you find a bug someplace, you can 
just fix it, post a patch upstream, and get it fixed for good. :)

-Tero

