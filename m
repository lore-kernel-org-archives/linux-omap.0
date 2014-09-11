From: Jyri Sarha <jsarha@ti.com>
Subject: Re: [PATCH] clk: add gpio gated clock
Date: Thu, 11 Sep 2014 11:44:24 +0300
Message-ID: <541160E8.5070701@ti.com>
References: <1409919694-26941-1-git-send-email-jsarha@ti.com> <20140909221408.19023.12081@quantum>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140909221408.19023.12081@quantum>
Sender: linux-kernel-owner@vger.kernel.org
To: Mike Turquette <mturquette@linaro.org>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, bcousson@baylibre.com
Cc: t-kristo@ti.com, mark.rutland@arm.com, detheridge@ti.com
List-Id: linux-omap@vger.kernel.org

On 09/10/2014 01:14 AM, Mike Turquette wrote:
> Quoting Jyri Sarha (2014-09-05 05:21:34)
>> The added gpio-gate-clock is a basic clock that can be enabled and
>> disabled trough a gpio output. The DT binding document for the clock
>> is also added. For EPROBE_DEFER handling the registering of the clock
>> has to be delayed until of_clk_get() call time.
>>
>> Signed-off-by: Jyri Sarha <jsarha@ti.com>
>> ---
>>
>> This is my final attempt to get this generic gpio controlled basic
>> clock into mainline. Of course I gladly fix any issues that the patch
>> may have. However, if there is no response, I give up and move it to TI
>> specific clocks.
>>
>
> I searched through my archives and found a post from January. You Cc'd
> me as "<mturquette@linaro.org>". Note that the address is wrapped in
> chevrons but there is no name string (e.g. "Mike Turquette").
>
> My mailer doesn't parse this well it was not flagged as to:me in my
> filters. Maybe other mailers handle this better? If you leave out the
> name string in the future then it would probably be best to drop the
> chevrons.
>

Then git send-email adds the chevrons, but in the future I'll put the 
name string there too.

>> I've been sending this patch as a part of Beaglebone-Black HDMI audio
>> patch series since last autumn. Since the previous version I have done
>> some minor cleanups and changed the clock's compatible property from
>> "gpio-clock" to "gpio-gate-clock". All the file names, comments,
>> etc. have also been changed accordingly.
>
> Is your platform the only one to take advantage of this clock type so
> far? I feel that it is esoteric enough that it shouldn't be made
> generic.
>
> The main reason is that all of the generic clock types needs to be
> overhauled at some point. E.g. the clk-gate should have its
> machine-specific logic separated from its machine-independent logic. If
> the gate clock were to populate .enable and .disable callbacks and then
> leave the actual register banging, or regmap'ing, or gpio'ing up to your
> backend driver then that would be a big improvement and would avoid the
> need to create this new clock type outright.
>
> So that's on my todo list, but it's not done yet. For your patch I think
> that putting this code into drivers/clk/ti would probably be best,
> unless other folks could use it as-is. Even if others could use it today
> I would want to remove it eventually for the reasons stated in the
> paragraph above.
>

Ok, I see. I do not know of anybody else needing a gpio gate clock at 
the moment. I'll put the driver under drivers/clk/ti unless someone 
comes forward soon.

Thanks,
Jyri
