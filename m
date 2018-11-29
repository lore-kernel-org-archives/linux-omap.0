From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH 05/16] remoteproc/pru: Add pru-specific debugfs support
Date: Thu, 29 Nov 2018 12:17:16 +0200
Message-ID: <5BFFBCAC.9000004@ti.com>
References: <1543218769-5507-1-git-send-email-rogerq@ti.com>
 <1543218769-5507-6-git-send-email-rogerq@ti.com>
 <d0e227e3-39dc-dfc8-b94c-3d9d072f6562@lechnology.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <d0e227e3-39dc-dfc8-b94c-3d9d072f6562@lechnology.com>
Sender: linux-kernel-owner@vger.kernel.org
To: David Lechner <david@lechnology.com>, ohad@wizery.com, bjorn.andersson@linaro.org
Cc: tony@atomide.com, robh+dt@kernel.org, bcousson@baylibre.com, ssantosh@kernel.org, s-anna@ti.com, nsekhar@ti.com, t-kristo@ti.com, nsaulnier@ti.com, jreeder@ti.com, m-karicheri2@ti.com, woods.technical@gmail.com, linux-omap@vger.kernel.org, linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 27/11/18 00:37, David Lechner wrote:
> On 11/26/18 1:52 AM, Roger Quadros wrote:
>> From: Suman Anna <s-anna@ti.com>
>>
>> The remoteproc core creates certain standard debugfs entries,
>> that does not give a whole lot of useful information for the
>> PRUs. The PRU remoteproc driver is enhanced to add additional
>> debugfs entries for PRU. These will be auto-cleaned up when
>> the parent rproc debug directory is removed.
>>
>> The enhanced debugfs support adds two new entries: 'regs' and
>> 'single_step'. The 'regs' dumps out the useful CTRL sub-module
>> registers as well as each of the 32 GPREGs and CT_REGs registers.
>> The GPREGs and CT_REGs though are printed only when the PRU is
>> halted and accessible as per the IP design.
>>
> 
> If the driver used regmap to access the CTRL I/O memory, then
> 'regs' wouldn't be needed since regmap already does debugfs.
> 

ok, we could split out CTRL from this and use regmap.

cheers,
-roger

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
