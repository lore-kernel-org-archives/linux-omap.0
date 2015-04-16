From: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: Re: AM335x OMAP2 common clock external fixed-clock registration
Date: Thu, 16 Apr 2015 22:37:19 +0200
Message-ID: <55301D7F.30708@gmail.com>
References: <20150414211734.GA28974@deathray> <552E0688.1020903@ti.com> <20150415140945.GA30787@deathray> <552EB152.7050306@ti.com> <20150415194707.GA11007@deathray> <CAPtuhTggHctp5ArGPEuKn2GuPzb-WnKv2_CzPrHzq8hwOR5Aqw@mail.gmail.com> <20150415205136.GA3399@deathray> <552F3B60.8050703@ti.com> <20150416161756.GA27590@deathray>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150416161756.GA27590@deathray>
Sender: linux-kernel-owner@vger.kernel.org
To: Michael Welling <mwelling@ieee.org>, Tero Kristo <t-kristo@ti.com>
Cc: Mike Turquette <mturquette@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Russell King <linux@arm.linux.org.uk>, devicetree <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Tony Lindgren <tony@atomide.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Daniel Mack <daniel@zonque.org>
List-Id: linux-omap@vger.kernel.org

On 16.04.2015 18:17, Michael Welling wrote:
> On Thu, Apr 16, 2015 at 07:32:32AM +0300, Tero Kristo wrote:
>> On 04/15/2015 11:51 PM, Michael Welling wrote:
>>> On Wed, Apr 15, 2015 at 01:45:53PM -0700, Mike Turquette wrote:
>>>> On Wed, Apr 15, 2015 at 12:47 PM, Michael Welling <mwelling@ieee.org> wrote:
[...]
>>>>> There is still an issue with the si5351.
>>>>>
>>>>> I had to comment out the clk_put here for the frequency to show up:
>>>>> http://lxr.free-electrons.com/source/drivers/clk/clk-si5351.c#L1133
>>>>>
>>>>> Ideas?
>>>>
>>>> What is the most recent upstream commit that you are based on?
>>>
>>> I am working from 4.0.0-rc7.
>>>
>>> 7b43b47373d40d557cd7e1a84a0bd8ebc4d745ab
>>
>> Hmm, I wonder why si5351 calls clk_put immediately after of_clk_get
>> in the first place, as far as I understand this destroys the clock
>> handle, which is still being used later in the code.
>
> Not sure how this ever worked. This has been in the code since the
> initial commit.

The reason it worked before may be related with recent rework of
clk_put() itself and clk cookies instead of pointers. I lost track on
the recent clk subsystem changes here, sorry.

However, droping the clk immediately surely isn't right.
The thing is, we can remove the clk_put() just because there is no
_remove() for that driver. I remember that back in the days the driver
was mainlined, clk removal wasn't too easy.

FWIW, as soon as _remove() support will be added by someone, we'll have
to rethink passing struct clk* by platform_data or at least
double-check if we ever used [of_]clk_get() to obtain it.

Mind to send a patch removing the clk_put() on !IS_ERR and add a proper
error path instead? While of_clk_get() is the only calls that need
cleanup on error in si5351_dt_parse() we should probably move that
calls to the end of this function. Otherwise we'd also have to cleanup
on every of_parse_foo() failure.

Sebastian
