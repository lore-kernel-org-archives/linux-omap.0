From: Suman Anna <s-anna@ti.com>
Subject: Re: [PATCH 0/3] omap: hwmod: add default reset handling support
Date: Tue, 9 Feb 2016 11:44:45 -0600
Message-ID: <56BA258D.3040002@ti.com>
References: <1454929941-23949-1-git-send-email-kishon@ti.com>
 <56B9037C.2050203@ti.com> <56B9767D.7000708@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <56B9767D.7000708@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, bhelgaas@google.com, richardcochran@gmail.com
Cc: Russell King <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, bcousson@baylibre.com, nsekhar@ti.com, Dave Gerlach <d-gerlach@ti.com>
List-Id: linux-omap@vger.kernel.org

On 02/08/2016 11:17 PM, Kishon Vijay Abraham I wrote:
> Hi,
> 
> On Tuesday 09 February 2016 02:37 AM, Suman Anna wrote:
>> On 02/08/2016 05:12 AM, Kishon Vijay Abraham I wrote:
>>> Add a new hwmod flag to indicate custom reset handling and use it
>>> for devices that require custom reset handling (like dsp, ipu, iva).
>>>
>>> Tested PCIe on dra7-evm and dra72-evm.
>>> I need help in testing DSP, IPU, IVA, PRU, GFX, M3 in other platforms.
>>> Or a way to test these cores to see if reset is not broken. Suman?
>>
>> I won't be able to test this week, and have requested Dave to check on
>> wkup_m3_rproc driver atleast. I see one potential issue (see my commment
>> on the other thread), but can confirm that only after testing.
>>
>> Have you tested multiple probe/removal sequences? Can you check the
>> return status on the _hardreset_deassert call with your PCIe driver,
>> believe even that one would return an error on multiple probes.
> 
> hmm.. the PCIe driver is built-in and can't be made as module because of other
> issues in PCIe core. But looks like the first deassert succeeded since I didn't
> observe the boot hang because of PCIe.

You can try unbind and bind through sysfs, it should result in a remove
and probe even if your driver is built-in.

regards
Suman
>>
>>>
>>> I'll post this series once again after performing these tests.
>>>
>>> Paul Walmsley (3):
>>>   ARM: omap2+: omap_hwmod: introduce hwmod flag for custom reset
>>>     handling
>>>   ARM: OMAP2+: hwmod: use HWMOD_CUSTOM_HARDRESET for custom reset
>>>     handling
>>>   ARM: OMAP2+: hwmod: Add default reset handling
>>>
>>>  arch/arm/mach-omap2/omap_hwmod.c                   |   16 +++++++++++-----
>>>  arch/arm/mach-omap2/omap_hwmod.h                   |   12 ++++++++++++
>>>  arch/arm/mach-omap2/omap_hwmod_2420_data.c         |    2 ++
>>>  arch/arm/mach-omap2/omap_hwmod_2430_data.c         |    1 +
>>>  .../mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c |    2 ++
>>>  arch/arm/mach-omap2/omap_hwmod_33xx_data.c         |    1 +
>>>  arch/arm/mach-omap2/omap_hwmod_3xxx_data.c         |    3 +++
>>>  arch/arm/mach-omap2/omap_hwmod_43xx_data.c         |    1 +
>>>  arch/arm/mach-omap2/omap_hwmod_44xx_data.c         |    6 ++++++
>>>  arch/arm/mach-omap2/omap_hwmod_54xx_data.c         |    2 ++
>>>  10 files changed, 41 insertions(+), 5 deletions(-)
>>>
>>
