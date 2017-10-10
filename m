From: Keerthy <j-keerthy@ti.com>
Subject: Re: [PATCH] regulator: lp873x: Update the enable mask for LDOs and
 BUCKs
Date: Tue, 10 Oct 2017 07:34:52 +0530
Message-ID: <0e3aba27-d17a-1c3a-f384-5e393310668b@ti.com>
References: <1506515140-26058-1-git-send-email-j-keerthy@ti.com>
 <20171009142053.rogvykzmoatduv6i@sirena.co.uk>
 <72182869-6102-1178-91c4-0be632d4be32@ti.com>
 <20171009155026.63aghfli7bkemiux@sirena.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171009155026.63aghfli7bkemiux@sirena.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Tero Kristo <t-kristo@ti.com>
Cc: linux-kernel@vger.kernel.org, lee.jones@linaro.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org



On Monday 09 October 2017 09:20 PM, Mark Brown wrote:
> On Mon, Oct 09, 2017 at 06:35:14PM +0300, Tero Kristo wrote:
> 
>> The EN signal coming in to the PMIC is actually used to poweroff the system
>> completely. There is no other mechanism for doing this in lp873x based
>> systems, they removed the bit for controlling dev-power-off from the
>> register space. If the EN bit is down for a specific regulator, it won't go
>> down when attempting to poweroff the system, otherwise the state of a
>> regulator is the result of (EN_PIN | EN_BIT).
> 
> This should be clear from the changelog (and probably the code as well).
> 
>> I wonder if we should tie this somehow to the system-power-controller
>> property though.... If the PMIC is not system-power-controller, we should
>> disable the EN_PIN_CTRL from all regulators so that they don't go down if
>> the EN_PIN itself is floating for example.
> 
> Seems plausible, if someone does decided to use control at runtime the
> behaviour can always be changed if the GPIO is present.

Okay. So Implement a poweroff function where EN pin magic is done based
on system-power-controller property?

> 
