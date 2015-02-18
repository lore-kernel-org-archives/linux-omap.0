From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH v3 0/4] phy: ti-pipe3: fixes for 3.19-rc
Date: Wed, 18 Feb 2015 10:00:20 +0200
Message-ID: <54E44694.4070801@ti.com>
References: <1421151802-7396-1-git-send-email-rogerq@ti.com> <20150113155409.GA2419@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150113155409.GA2419@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, kishon@ti.com
Cc: nm@ti.com, balbi@ti.com, george.cherian@ti.com, nsekhar@ti.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 13/01/15 17:54, Tony Lindgren wrote:
> * Roger Quadros <rogerq@ti.com> [150113 04:26]:
>> Hi,
>>
>> During system suspend L3INIT_960M_GFCLK and L3INIT_480M_GFCLK clocks remain
>> active on the DRA7 platform. This is because the pipe3 driver doesn't shut
>> them off as part of .suspend(). Patch 1 addresses this issue.
>>
>> SATA on both OMAP5 and DRA7 breaks when SATA drive is plugged in after a
>> system suspend/resume or if AHCI_PLATFORM driver is used as module.
>> Patches 2,3,4 fix it.
>>
>> Hope to get these patches in through the 3.19-rc cycle.
>>
>> Tony,
>>
>> Do you wish to take the DTS patches or let them go in through PHY tree?
> 
> Those look ok to me to merge along with the fixes, will ack those two.
> 

Looks like this missed 3.19-rc. My bad for not following up.

Kishon, can you please queue these for 3.20-rc? Thanks.

cheers,
-roger
