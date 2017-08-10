From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH 1/2] ARM: dts: am571x-idk: Fix GPIO polarity for MMC1 card
 detect
Date: Thu, 10 Aug 2017 13:15:15 +0530
Message-ID: <f75b361c-a8a8-f6c0-dd8a-cca5522e5181@ti.com>
References: <20170808052057.24433-1-kishon@ti.com>
 <20170809220800.GJ3934@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
In-Reply-To: <20170809220800.GJ3934@atomide.com>
Sender: linux-mmc-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Russell King <linux@armlinux.org.uk>, Ulf Hansson <ulf.hansson@linaro.org>, nsekhar@ti.com, linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Tony,

On Thursday 10 August 2017 03:38 AM, Tony Lindgren wrote:
> * Kishon Vijay Abraham I <kishon@ti.com> [170807 22:22]:
>> The GPIO polarity for MMC1 card detect is set to '0' which means
>> active-high. However the polarity should be active-low. Fix it
>> here.
> 
> Can these wait for v4.14 merge window or do these fix known
> issues?

These can go in the next merge window. I didn't observe any issue without this
in omap_hsmmc driver.

Thanks
Kishon
