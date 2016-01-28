From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCH] clk: ti: omap3+: dpll: use non-locking version of
 clk_get_rate
Date: Thu, 28 Jan 2016 21:09:41 +0200
Message-ID: <56AA6775.5090302@ti.com>
References: <1453981067-8618-1-git-send-email-t-kristo@ti.com>
 <56A9FED1.3090903@ti.com> <20160128172215.GD19432@atomide.com>
 <56AA6261.7030503@ti.com> <20160128190026.GI19432@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <20160128190026.GI19432@atomide.com>
Sender: linux-clk-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, mturquette@baylibre.com, sboyd@codeaurora.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 01/28/2016 09:00 PM, Tony Lindgren wrote:
> * Tero Kristo <t-kristo@ti.com> [160128 10:48]:
>> On 01/28/2016 07:22 PM, Tony Lindgren wrote:
>>> * Tero Kristo <t-kristo@ti.com> [160128 03:44]:
>>>> On 01/28/2016 01:37 PM, Tero Kristo wrote:
>>>>> As the code in this file is being executed within irq context in some
>>>>> cases, we must avoid the clk_get_rate which uses mutex internally.
>>>>> Switch the code to use clk_hw_get_rate instead which is non-locking.
>>>>>
>>>>> Signed-off-by: Tero Kristo <t-kristo@ti.com>
>>>>
>>>> Ooops, sorry. Sent wrong version (read: old) of this patch, please ignore
>>>> this one. Will re-send the correct version in a bit.
>>>
>>> I think this is still needed as a fix for -rc cycle with cc: stable
>>> as otherwise we have omap4 and 5 hang if PM runtime is enabled before
>>> a suspend/resume cycle?
>>
>> Look at the other patch I sent, it should accomplish the same thing, and
>> more.
>>
>> https://www.spinics.net/lists/linux-clk/msg06094.html
>
> Right.. But is that suitable for the -rc cycle with cc stable?

Hmm yea, thats a good question, we may need to resurrect this patch 
after all.

> You should also describe the bug it causes in the change log.
> Something like:
>
> This fixes an issue where PM runtime will hang the system if
> enabled with a serial console before a suspend-resume cycle.

Yea I can add this to the desc if we want to keep this version of the patch.

-Tero


