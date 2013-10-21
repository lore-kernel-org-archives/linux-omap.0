From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH 1/2] ARM: dts: omap5-uevm: remove always_on, boot_on from
 smps10_out1
Date: Mon, 21 Oct 2013 15:33:20 +0530
Message-ID: <5264FBE8.4070704@ti.com>
References: <1381402195-29257-1-git-send-email-kishon@ti.com> <525E9206.9010501@ti.com> <525E9434.1090006@ti.com> <526043E3.3070302@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:35793 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752761Ab3JUKEC (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 21 Oct 2013 06:04:02 -0400
In-Reply-To: <526043E3.3070302@baylibre.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <bcousson@baylibre.com>
Cc: Nishanth Menon <nm@ti.com>, mark.rutland@arm.com, devicetree@vger.kernel.org, linux@arm.linux.org.uk, pawel.moll@arm.com, ijc+devicetree@hellion.org.uk, tony@atomide.com, swarren@wwwdotorg.org, linux-kernel@vger.kernel.org, rob.herring@calxeda.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Friday 18 October 2013 01:39 AM, Benoit Cousson wrote:
> Hi Kishon,
> 
> On 16/10/2013 15:27, Nishanth Menon wrote:
>> On 10/16/2013 08:17 AM, Kishon Vijay Abraham I wrote:
>>> Benoit,
>>>
>>> On Thursday 10 October 2013 04:19 PM, Kishon Vijay Abraham I wrote:
>>>> smps10 should be enabled only in the case of host mode. So stop
>>>> doing always_on, boot_on from smps10_out1. The driver will enable it in host
>>>> mode.
>>>
>>> Can you take this patch too?
>>
>> Acked-by: Nishanth Menon <nm@ti.com>
> 
> I've just applied it.

Thanks :-)

-Kishon
> 
> Thanks,
> Benoit
> 
> 

