From: Vignesh R <vigneshr@ti.com>
Subject: Re: [PATCH v4] ARM: dts: dra7: Fix up unaligned access setting for
 PCIe EP
Date: Fri, 28 Sep 2018 10:58:16 +0530
Message-ID: <eb3bb7ba-e32d-aa0f-1877-985ab3d6fe4c@ti.com>
References: <20180925052151.9537-1-vigneshr@ti.com>
 <20180926172711.GW5662@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180926172711.GW5662@atomide.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org



On Wednesday 26 September 2018 10:57 PM, Tony Lindgren wrote:
> * Vignesh R <vigneshr@ti.com> [180924 22:25]:
>> Bit positions of PCIE_SS1_AXI2OCP_LEGACY_MODE_ENABLE and
>> PCIE_SS1_AXI2OCP_LEGACY_MODE_ENABLE in CTRL_CORE_SMA_SW_7 are
>> incorrectly documented in the TRM. In fact, the bit positions are
>> swapped. Update the DT bindings for PCIe EP to reflect the same.
>>
>> Fixes: d23f3839fe97 ("ARM: dts: DRA7: Add pcie1 dt node for EP mode")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Vignesh R <vigneshr@ti.com>
>> ---
>>
>> This patch is split from v3 here:
>> https://lore.kernel.org/patchwork/cover/967020/
>> Patch can be applied standalone and has no dependencies on other patches
>> in v3.
> 
> Hmm is this needed for v4.19-rc cycle or can this wait for
> v4.20 merge window?
> 

v4.20 should be fine.


-- 
Regards
Vignesh
