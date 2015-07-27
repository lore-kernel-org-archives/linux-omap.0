From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH v3 0/3] phy: ti-pipe3: dra7: sata: allow suspend to RAM
 (core-retention)
Date: Mon, 27 Jul 2015 13:37:01 +0300
Message-ID: <55B609CD.7010403@ti.com>
References: <1437140844-6032-1-git-send-email-rogerq@ti.com> <55B60618.5010902@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <55B60618.5010902@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: kishon@ti.com, tony@atomide.com
Cc: nm@ti.com, nsekhar@ti.com, balbi@ti.com, grygorii.strashko@ti.com, t-kristo@ti.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 27/07/15 13:21, Roger Quadros wrote:
> Kishon & Tony,
> 
> You can please pick the first 2 patches for -next.

Sorry, I meant for -rc.

> 
> The 3rd patch is not required for SATA and I will send it as
> a separate series.

This can go in -next.

cheers,
-roger

> 
> cheers,
> -roger
> 
> On 17/07/15 16:47, Roger Quadros wrote:
>> Hi,
>>
>> Implement workaround for SATA errata i783 (SATA Lockup After SATA DPLL Unlock/Relock)
>> so that we can now turn off sata_refclk to support suspend-to-ram without preventing
>> core-retention.
>>
>> Depends on http://article.gmane.org/gmane.linux.ports.arm.omap/126670.
>>
>> Changelog:
>> v3:
>> - used scm_conf node in dra7.dtsi for control register access.
>>
>> v2:
>> - Fixed pcie disable_clocks. Addressed review comments.
>>
>> cheers,
>> -roger
>>
>> Roger Quadros (3):
>>   phy: ti-pipe3: i783 workaround for SATA lockup after dpll
>>     unlock/relock
>>   ARM: dts: dra7: Add syscon-pllreset syscon to SATA PHY
>>   ARM: dts: dra7: Add scm_conf1 node and remove redundant nodes
>>
>>  Documentation/devicetree/bindings/phy/ti-phy.txt | 16 +++++++
>>  arch/arm/boot/dts/dra7.dtsi                      | 20 ++++----
>>  drivers/phy/phy-ti-pipe3.c                       | 61 +++++++++++++++++++++---
>>  3 files changed, 80 insertions(+), 17 deletions(-)
>>
