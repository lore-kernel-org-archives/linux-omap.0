From: Tero Kristo <t-kristo@ti.com>
Subject: Re: AM335x OMAP2 common clock external fixed-clock registration
Date: Wed, 15 Apr 2015 21:43:30 +0300
Message-ID: <552EB152.7050306@ti.com>
References: <20150414211734.GA28974@deathray> <552E0688.1020903@ti.com> <20150415140945.GA30787@deathray>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150415140945.GA30787@deathray>
Sender: linux-kernel-owner@vger.kernel.org
To: Michael Welling <mwelling@ieee.org>
Cc: Mike Turquette <mturquette@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Russell King <linux@arm.linux.org.uk>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, gregkh@linuxfoundation.org, Daniel Mack <daniel@zonque.org>
List-Id: linux-omap@vger.kernel.org

On 04/15/2015 05:09 PM, Michael Welling wrote:
> On Wed, Apr 15, 2015 at 09:34:48AM +0300, Tero Kristo wrote:
>> On 04/15/2015 12:17 AM, Michael Welling wrote:
>>> Greetings,
>>>
>>> I have developed an AM3354 based SoM and it uses an external SI5351 clock
>>> generator to drive the clock inputs for an external duart and I2S audio
>>> master clock. With the registration according to the documentation the
>>> reference clock is not being detected and hence the clock generator is
>>> not working as expect.
>>>
>>> After trying many different things, I started to look around the mailing
>>> lists to find information related to this issue.
>>>
>>> I came acrossed post that has the exact same issue:
>>> https://lkml.org/lkml/2013/2/18/468
>>>
>>> Seeing as the patch did not land upstream, I am wondering if there is
>>> a solution that I am not seeing.
>>>
>>> I am willing to provide a patch given appropriate guidance.
>>
>> Hi Michael,
>>
>> The info on the email you referenced is kind of obsolete, TI SoCs
>> are calling of_clk_init() during boot now, and thus external clock
>> nodes should be registered fine also. Maybe you can provide the
>> actual DTS patch you are trying out so we can help better...? Are
>
> See attached patch and console output.

I see a bug in your dt data.

<snip>

+	clocks {
+		ref27: ref27 {
+			#clock-cells = <0>;
+			compatibale = "fixed-clock";

This should be compatible, right? DT is annoying in that it doesn't 
verify property names.

+			clock-frequency = <27000000>;
+		};
+	};

-Tero

>
>> you seeing any boot time error / warning prints for your new clock?
>
> With the debug messages on you see that the reference clock is not being
> detected.
>
> Whilest debugging I found that the of_clk_get is returning an error no matter
> which clock I pass it:
> http://lxr.free-electrons.com/source/drivers/clk/clk-si5351.c#L1131
>
>>
>> -Tero
