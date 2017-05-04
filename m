From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCH] clk: Add functions to save and restore clock/dpll context
 en-masse
Date: Thu, 4 May 2017 11:58:24 +0300
Message-ID: <aeff99c8-48d5-48f0-ec90-ffa8d3630ae5@ti.com>
References: <1492492369-19662-1-git-send-email-j-keerthy@ti.com>
 <20170503185251.GR23750@n2100.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <20170503185251.GR23750@n2100.armlinux.org.uk>
Sender: linux-clk-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@armlinux.org.uk>, Keerthy <j-keerthy@ti.com>
Cc: sboyd@codeaurora.org, mturquette@baylibre.com, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Russ Dill <Russ.Dill@ti.com>
List-Id: linux-omap@vger.kernel.org

On 03/05/17 21:52, Russell King - ARM Linux wrote:
> On Tue, Apr 18, 2017 at 10:42:49AM +0530, Keerthy wrote:
>> From: Russ Dill <Russ.Dill@ti.com>
>>
>> The clock/dpll registers are in the WKUP power domain. Under both RTC-only
>> suspend and hibernation, these registers are lost. Hence save/restore
>> them accordingly.
>
> This looks like a huge hammer, and I think this will cause problems for
> some systems, especially where some clocks are on remote devices which
> need to be controlled via I2C buses.

Actually, if you look at the generic part of the code, it is not called 
from anywhere right now, but it just implements the support for 
save/restore. Also, for external clocks, no save/restore is implemented, 
and you would need to handle those separately anyway. Consider an 
external clock that is fed from SoC internal source; basically you need 
to disable this clock before going to the deep idle state, and enable it 
only after everything has been restored. If you keep it enabled over a 
deep idle, its source clock will potentially die causing issues.

>
> The generic part walks all root clocks in the system, and all children
> of those clocks.  If we have clocks on an I2C device, then we could
> very well end up with a circular dependency - the I2C controller needs
> its clocks restored in order for control of the clocks on the I2C device
> to be accessible.

For generic external clocks, I would not expect any save/restore is 
required at all, except for the potentially required enable/disable 
calls which would need to be handled either by some driver or SoC 
specific PM core.

> So, I think this needs more thought - clocks are not just about core SoC
> clocks - and cracking this nut with such a big hammer is likely to cause
> regressions all over the place.

This won't cause any regressions as it is not called by default from 
anywhere. A SoC needs to introduce the functionality for entering a deep 
idle state, and call the clk save/restore functionality from there.

-Tero

