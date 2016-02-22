From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH v5 00/26] memory: omap-gpmc: mtd: nand: Support GPMC NAND
 on non-OMAP platforms
Date: Mon, 22 Feb 2016 22:05:08 +0200
Message-ID: <56CB69F4.8040306@ti.com>
References: <1455916548-3441-1-git-send-email-rogerq@ti.com>
 <20160219220442.GR21202@atomide.com> <56CADFD5.2040205@ti.com>
 <20160222164234.GD13417@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160222164234.GD13417@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: computersforpeace@gmail.com, dwmw2@infradead.org, ezequiel@vanguardiasur.com.ar, javier@dowhile0.org, fcooper@ti.com, nsekhar@ti.com, linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 22/02/16 18:42, Tony Lindgren wrote:
> * Roger Quadros <rogerq@ti.com> [160222 02:16]:
>> On 20/02/16 00:04, Tony Lindgren wrote:
>>> * Roger Quadros <rogerq@ti.com> [160219 13:27]:
>>>> Hi,
>>>>
>>>> @Tony
>>>> Patches 15 and 24 are new and will need your review.
>>>> I've modified patch 22 to include the new am335x boards introduced since v4.4.
>>>>
>>>> Patches are based on top of omap-for-v4.6/dt so that the DT changes apply cleanly.
>>>
>>> Looks OK to me. Can we merge the dts changes separately? Otherwise
>>> we will easily end up with tons of conflicts..
>>
>> I agree. But we just need to keep in mind that NAND functionality will be
>> broken till all the patches in this series are merged. We don't maintain
>> backward compatibility with the old DT implementation.
> 
> Please let's not do that! That breaks booting and git bisect.
> It's better to have a minimal branch where each patch boots fine.

Understood. I'll send out a patch set with only the minimal DT changes
that doesn't break anything. This should be a preparatory step for
the DT clean up.

> 
> Also, I think you should at least print a warning for the old
> binding. Otherwise people with out of tree boards will have
> hard time updating their patches to send to mainline tree.

OK. I'll add this warning mechanism to the omap-gpmc driver.

cheers,
-roger
