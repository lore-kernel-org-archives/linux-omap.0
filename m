From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: Re: Build error: OMAP randconfig / mvebu
Date: Fri, 08 Feb 2013 12:06:44 +0100
Message-ID: <5114DC44.7000107@free-electrons.com>
References: <20130208100813.GN17833@n2100.arm.linux.org.uk> <2213733.Wbjy3dFgom@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:60423 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946238Ab3BHLGs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Feb 2013 06:06:48 -0500
In-Reply-To: <2213733.Wbjy3dFgom@wuerfel>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, arm@kernel.org, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>

On 02/08/2013 11:45 AM, Arnd Bergmann wrote:
> On Friday 08 February 2013 10:08:13 Russell King - ARM Linux wrote:
>> Last night's OMAP4430SDP randconfig build failed with:
>>
>> arch/arm/mach-mvebu/built-in.o: In function `armada_xp_smp_init_cpus':
>> hotplug.c:(.init.text+0x70): undefined reference to `coherency_get_cpu_count'
>> hotplug.c:(.init.text+0xb4): undefined reference to `armada_mpic_send_doorbell'
>> arch/arm/mach-mvebu/built-in.o: In function `armada_xp_smp_prepare_cpus':
>> hotplug.c:(.init.text+0x254): undefined reference to `set_cpu_coherent'
>> arch/arm/mach-mvebu/built-in.o: In function `armada_xp_boot_secondary':
>> hotplug.c:(.cpuinit.text+0x10): undefined reference to `armada_xp_boot_cpu'
>> arch/arm/mach-mvebu/built-in.o: In function `armada_xp_secondary_init':
>> hotplug.c:(.cpuinit.text+0x2c): undefined reference to `armada_xp_mpic_smp_cpu_init'
>> arch/arm/mach-mvebu/built-in.o: In function `armada_xp_secondary_startup':
>> hotplug.c:(.cpuinit.text+0x40): undefined reference to `ll_set_cpu_coherent'
>>
>> This seems to be because we ended up with CONFIG_ARCH_MVEBU=y but without
>> CONFIG_MACH_ARMADA_370_XP being set - and because of OMAP, we have SMP
>> and hotplug CPU enabled.
>>
>> Usual configs/logs available via the website.
> 
> Ok, I see. I suspect we are going to see a lot more randconfig failures
> now with all the platforms that are becoming part of multiplatform.
> 
> mvebu maintainers: this one should be easy enough to fix. Anyone
> submitting a patch?

I don't know what to do here, there is no point to build any of the files
in mach-mvebu if no SoCs are selected. So either we force to have at least
one SoCS selected if ARCH_MVEBU is selected, or we unselect  ARCH_MVEB if
no SoCs are selected.

Gregory

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
