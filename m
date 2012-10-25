From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH 4/4] OMAP: mtd: gpmc: add DT bindings for GPMC timings
 and NAND
Date: Thu, 25 Oct 2012 08:22:55 -0500
Message-ID: <50893D2F.6080205@ti.com>
References: <1350935758-9215-1-git-send-email-zonque@gmail.com> <1350935758-9215-5-git-send-email-zonque@gmail.com> <50889BB2.3090107@ti.com> <508909CC.9000000@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:37427 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759522Ab2JYNW7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Oct 2012 09:22:59 -0400
In-Reply-To: <508909CC.9000000@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Daniel Mack <zonque@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, x0148406@ti.com, tony@atomide.com, paul@pwsan.com, nsekhar@ti.com


On 10/25/2012 04:43 AM, Daniel Mack wrote:
> Hi Jon,
> 
> On 25.10.2012 03:53, Jon Hunter wrote:
>>
>> On 10/22/2012 02:55 PM, Daniel Mack wrote:
> 
>>> +Example for an AM33xx board:
>>> +
>>> +	gpmc: gpmc@50000000 {
>>> +		compatible = "ti,gpmc";
>>> +		ti,hwmods = "gpmc";
>>> +		reg = <0x50000000 0x1000000>;
>>
>> Nit-pick, that size is quite large for a register range. I recommend
>> looking at the HWMOD data file
>> (arch/arm/mach-omap2/omap_hwmod_33xx_data.c) and see how much space is
>> allocated for the registers (see structure am33xx_gpmc_addr_space).
> 
> Yeah but reserving the entire memory as per the reference manual also
> prvents other from poking around in the same register space. Is there a
> scenario in which it would of disadvantage to reserve all that memory?

1. It chews up a large chunk of virtual memory space unnecessarily. For
   devices not using HIGHMEM and wish to use say 512MB of RAM, virtual
   memory space can be constrained.
2. We don't do that today probably because of #1.

Cheers
Jon
