From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCH v3 0/9] DRA7xx core support
Date: Mon, 12 Aug 2013 13:57:13 +0530
Message-ID: <52089C61.20001@ti.com>
References: <1375633657-6835-1-git-send-email-rnayak@ti.com> <5208835A.6000506@ti.com> <20130812082431.GI7656@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:54184 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751321Ab3HLI1p (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 12 Aug 2013 04:27:45 -0400
In-Reply-To: <20130812082431.GI7656@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, paul@pwsan.com, khilman@linaro.org, benoit.cousson@gmail.com, r.sricharan@ti.com, ambresh@ti.com, sourav.poddar@ti.com, santosh.shilimkar@ti.com, nm@ti.com, balbi@ti.com

On Monday 12 August 2013 01:54 PM, Tony Lindgren wrote:
> * Rajendra Nayak <rnayak@ti.com> [130811 23:47]:
>> On Sunday 04 August 2013 09:57 PM, Rajendra Nayak wrote:
>>> Changes in v3:
>>> -1- Dropped some clock/dpll framework builds for dra7
>>> -2- Added all instances of IPs in dtsi file
>>> -3- dtsi does a 'disabled' by default and dts enables as needed
>>> -4- soc_is_dra7xx() based on DT compatible instead of using ID code
>>>
>>> Changes in v2:
>>> -1- Fixed minor changelog details
>>> -2- Dropped the SRAM support patch since we need to move to drivers/misc/sram.c
>>> -3- Added DTS update patches to this series which were earlier posted as
>>> part of the data series (Since they don't have much objections as against the
>>> other in-kernel data files)
>>> -4- Updated the EVM dts file with pin config details for uart/mcspi and i2c
>>>
>>> DRA7xx based SoCs' are high-performance, infotainment application devices,
>>> based on enhanced OMAP architecture integrated on a 28nm
>>> technology.
>>>
>>> The DRA7xx family is composed of DRA75x and DRA74x devices.
>>> The current device for which the patches add support is the
>>> DRA752 SoC.
>>>
>>> Most of the core IPs are similar to those found on the OMAP5
>>> devices, including the dual cortex-A15 based MPU subsystem,
>>> which has helped quite some reuse from existing OMAP5 support.
>>>
>>> This series contains only core support patches and none of
>>> the PRCM and hwmod data needed for the device to boot.
>>
>> Tony, any chance of this series making it to 3.12?
> 
> Looks OK to me, want to do a pull request against -rc5 for me?

Sure, will do. Thanks.

> 
> Regards,
> 
> Tony
> 

