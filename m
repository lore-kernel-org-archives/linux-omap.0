From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCHv2 0/9] clk: ti: add support for clkctrl clocks
Date: Tue, 28 Mar 2017 08:41:33 +0300
Message-ID: <8abeeabd-0339-b332-fc3d-a80ee33ba966@ti.com>
References: <1489741781-12816-1-git-send-email-t-kristo@ti.com>
 <20170317152536.GT20572@atomide.com>
 <94d20a17-5072-ffab-3529-4bbb14327a10@ti.com>
 <20170323010057.GI10760@atomide.com> <20170323170210.GL10760@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <20170323170210.GL10760@atomide.com>
Sender: linux-clk-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-clk@vger.kernel.org, linux-omap@vger.kernel.org, sboyd@codeaurora.org, mturquette@baylibre.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 23/03/17 19:02, Tony Lindgren wrote:
> * Tony Lindgren <tony@atomide.com> [170322 18:03]:
>> * Tero Kristo <t-kristo@ti.com> [170317 14:39]:
>>> On 17/03/17 17:25, Tony Lindgren wrote:
>>>> * Tero Kristo <t-kristo@ti.com> [170317 02:12]:
>>>>> Any additional testing on omap4 welcome as this series basically
>>>>> tweaks every possible peripheral clock on the SoC.
>>>>
>>>> Without the last patch in this series, booting fails for me:
>>>>
>>>> [    5.074890] l4_per_cm:clk:0120:0: failed to disable
>>>> [    5.085113] l4_per_cm:clk:0128:0: failed to disable
>>>>
>>>> Care to check that booting keeps working for each patch in the
>>>> series to avoid breaking git bisect for booting?
>>>
>>> Hmm, I think patch 8+9 need to be squashed then. I can double check this
>>> next week though.
>>
>> Also looks like with this set merged HDMI stops working on
>> omap4 with:
>>
>> HDMIWP: omapdss HDMIWP error: Failed to set PHY power mode to 1
>
> Forgot to mention that's with omapdrm with encoder-tpd12s015 and
> encoder-tfp410 modules loaded to get HDMI working. Here's more verbose
> dmesg output in case that provides more clues:
>
> [   91.042877] omapdss HDMICORE error: operation stopped when reading edid
> [   91.078308] [drm] Enabling DMM ywrap scrolling
> [   91.099243] omapdss HDMIWP error: Failed to set PHY power mode to 1
> [   91.107879] omapdss HDMI error: failed to power on device
> [   91.107879] omapdrm omapdrm.0: Failed to enable display 'hdmi': -5
> [   91.359619] omapdrm omapdrm.0: atomic complete timeout (pipe 0)!
> [   91.619964] omapdrm omapdrm.0: atomic complete timeout (pipe 0)!
> [   91.620300] Console: switching to colour frame buffer device 128x48
> [   91.682434] omapdrm omapdrm.0: fb0: omapdrm frame buffer device
> [   91.770812] [drm] Initialized omapdrm 1.0.0 20110917 for omapdrm.0 on minor 0
> [   92.818054] omapdss HDMICORE error: operation stopped when reading edid
> [   93.090087] omapdrm omapdrm.0: atomic complete timeout (pipe 0)!
> [   93.349853] omapdrm omapdrm.0: atomic complete timeout (pipe 0)!

I have an idea what is wrong here, and also an idea how to fix it. 
Basically the display clock hierarchy is kind of special from hwmod 
point of view, so need to tweak the data for this a bit. This should not 
result into code changes if my idea works out well.

I'll try to have a look at this during this week still, I've been busy 
with some bug fixing lately.

-Tero
