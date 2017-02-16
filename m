From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH] ARM: dts: Add dra7 iodelay configuration and use it for
 MMC
Date: Thu, 16 Feb 2017 19:28:39 +0530
Message-ID: <58A5B00F.7050705@ti.com>
References: <20161230183732.5595-1-tony@atomide.com>
 <20161230183732.5595-3-tony@atomide.com> <20161230184914.GC3940@atomide.com>
 <20170214185120.GL21809@atomide.com>
 <932aa035-27c9-0bb4-ffe2-81959aea6662@ti.com> <58A44B02.10204@ti.com>
 <20170215155002.GN21809@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <20170215155002.GN21809@atomide.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Nishanth Menon <nm@ti.com>, Gary Bisson <gary.bisson@boundarydevices.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, linux-omap@vger.kernel.org, Lokesh Vutla <lokeshvutla@ti.com>, Linus Walleij <linus.walleij@linaro.org>
List-Id: linux-omap@vger.kernel.org

Hi,

On Wednesday 15 February 2017 09:20 PM, Tony Lindgren wrote:
> * Kishon Vijay Abraham I <kishon@ti.com> [170215 04:36]:
>> On Wednesday 15 February 2017 12:27 AM, Nishanth Menon wrote:
>>> On 02/14/2017 12:51 PM, Tony Lindgren wrote:
>>>> Nishanth,
>>>>
>>>> * Tony Lindgren <tony@atomide.com> [161230 10:50]:
>>>>> Add dra7 iodelay configuration and use it for MMC.
>>>>
>>>> I just noticed that this patch should probably be:
>>>>
>>>> From: Nishanth Menon <nm@ti.com>
>>>>
>>>> I think I just added the description to the patch.
>>>>
>>>> Can you please confirm and reply with your Signed-off-by
>>>> if that's the case?
>>>>
>>>
>>> Though I had introduced the node [
>>> http://git.ti.com/ti-linux-kernel/ti-linux-kernel/commit/34661cbccc679bb8d91768bc78495e94e6d40f1f
>>> ], the x15 values were first introduced by Kishon.
>>>
>>> http://git.ti.com/ti-linux-kernel/ti-linux-kernel/commit/1463b1e8facb7180f5679b373411b3fbeb1608fd
>>>
>>>
>>> personally, From or not really does'nt matter as long as we can get the
>>> solution in.
>>>
>>> So, as long as it helps..
>>> Signed-off-by: Nishanth Menon <nm@ti.com>
> ...
>> I had to remove the iodelay added here based on datasheet (patch [1]).
> 
> OK thanks for the info. So we have multiple authors and as Kishon added
> the working values I suggest we credit the patch for Kishon.
> 
>> I also wanted to confirm if "MODE_SELECT" should be added in pinctrl values
>> like [2] for adding manual mode iodelay because that seems to be missing in
>> this patch.
> 
> Oh OK. If it's needed then yeah let's update it for that too. Can you
> please check it? And then send an updated version of this patch with
> "From" credited to you? Just update the description to say "Based on
> earlier patches in TI Linux kernel tree done by Nishanth Menon and
> Kishon Vijay Abraham I".

Sure, I'll send it along with adding UHS mode support patches.

Thanks
Kishon
