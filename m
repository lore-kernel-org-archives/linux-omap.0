From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH 05/16] remoteproc/pru: Add pru-specific debugfs support
Date: Tue, 18 Dec 2018 17:51:12 +0200
Message-ID: <5C191770.9090804@ti.com>
References: <1543218769-5507-1-git-send-email-rogerq@ti.com>
 <1543218769-5507-6-git-send-email-rogerq@ti.com>
 <d0e227e3-39dc-dfc8-b94c-3d9d072f6562@lechnology.com>
 <5BFFBCAC.9000004@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5BFFBCAC.9000004@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: David Lechner <david@lechnology.com>, ohad@wizery.com, bjorn.andersson@linaro.org, Mark Brown <broonie@kernel.org>
Cc: tony@atomide.com, robh+dt@kernel.org, bcousson@baylibre.com, ssantosh@kernel.org, s-anna@ti.com, nsekhar@ti.com, t-kristo@ti.com, nsaulnier@ti.com, jreeder@ti.com, m-karicheri2@ti.com, woods.technical@gmail.com, linux-omap@vger.kernel.org, linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

+Mark

David,

On 29/11/18 12:17, Roger Quadros wrote:
> On 27/11/18 00:37, David Lechner wrote:
>> On 11/26/18 1:52 AM, Roger Quadros wrote:
>>> From: Suman Anna <s-anna@ti.com>
>>>
>>> The remoteproc core creates certain standard debugfs entries,
>>> that does not give a whole lot of useful information for the
>>> PRUs. The PRU remoteproc driver is enhanced to add additional
>>> debugfs entries for PRU. These will be auto-cleaned up when
>>> the parent rproc debug directory is removed.
>>>
>>> The enhanced debugfs support adds two new entries: 'regs' and
>>> 'single_step'. The 'regs' dumps out the useful CTRL sub-module
>>> registers as well as each of the 32 GPREGs and CT_REGs registers.
>>> The GPREGs and CT_REGs though are printed only when the PRU is
>>> halted and accessible as per the IP design.
>>>
>>
>> If the driver used regmap to access the CTRL I/O memory, then
>> 'regs' wouldn't be needed since regmap already does debugfs.
>>
> 
> ok, we could split out CTRL from this and use regmap.
> 

I was thinking of using regmap for both control and debug
but regmap_mmio only supports one iomap even though it supports
multiple ranges.

What can we do here?

The control and debug regions even though separate are right
next to each other

reg = <0x34000 0x3000>,
	<0x22000 0x400>,
	<0x22400 0x100>;
reg-names = "iram", "control", "debug";

We could combine control and debug into one iomap and use
2 regmap ranges. But this is really working around the
regmap_mmio limitation of not being able to use more than one ioremaps.

Mark, any suggestions?

Is it meaningful to support __devm_regmap_init_mmio_clk()
with separate iomem regions for the ranges?

cheers,
-roger

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
