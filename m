From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCHv4 00/35] ARM: OMAP2+: PRCM / SCM cleanups against 4.0-rc1
Date: Thu, 19 Mar 2015 10:05:00 +0200
Message-ID: <550A832C.6020804@ti.com>
References: <1426689860-17537-1-git-send-email-t-kristo@ti.com> <20150319000058.GM11954@valkosipuli.retiisi.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:36418 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751129AbbCSIFh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 19 Mar 2015 04:05:37 -0400
In-Reply-To: <20150319000058.GM11954@valkosipuli.retiisi.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sakari Ailus <sakari.ailus@iki.fi>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, paul@pwsan.com, linux-arm-kernel@lists.infradead.org

On 03/19/2015 02:00 AM, Sakari Ailus wrote:
> Hi Tero,
>
> On Wed, Mar 18, 2015 at 04:43:45PM +0200, Tero Kristo wrote:
>> Hi,
>>
>> Changes in this set compared to v3:
>>
>> - Changed the SCM module DT node layout based on comments from Tony;
>>    basically the wkup / core are split into their own nodes now. This
>>    applies for omap3, omap4, omap5 and dra7, rest of the SoCs have their
>>    control module integrated as one instance (Patch 26, 30, 33, 34)
>> - Changed the tisyscon node name to scm_conf. This name is more
>>    descriptive for the purpose being used, scm_conf was already used
>>    as an alias (Patch 24, 25, 27, 29)
>> - Rest of the patches have no changes compared to v3.
>>
>> Testing done:
>> - am335x-evm      : boot
>> - am335x-evmsk    : boot
>> - am3517-evm      : boot
>> - am43x-epos-evm  : boot
>> - am437x-gp-evm   : boot
>> - omap3-beagle-xm : boot
>> - omap3-beagle    : boot, suspend-resume (ret/off), cpuidle (ret/off)
>> - am335x-boneblack: boot
>> - am335x-bone     : boot
>> - dra7xx-evm      : boot
>> - omap3-n900      : boot
>> - omap5-uevm      : boot
>> - omap4-panda-es  : boot, suspend-resume (ret), cpuidle (ret)
>> - omap4-panda     : boot
>> - omap2430-sdp    : boot
>> - omap3430-sdp    : boot
>> - omap4-sdp-es23plus: boot
>>
>> Test branch pushed at:
>> - tree: https://github.com/t-kristo/linux-pm.git
>> - branch: 4.0-rc1-prcm-cleanup-v4
>
> I tried compiling this, but I get a few linker errors:

Right, I always forget about silly people who do things like OMAP3 only 
builds or something.... Shall be fixed.

-Tero

>
> arch/arm/mach-omap2/built-in.o:(.init.data+0x47d8): undefined reference to `am33xx_prm_init'
> arch/arm/mach-omap2/built-in.o:(.init.data+0x47f0): undefined reference to `omap44xx_prm_init'
> arch/arm/mach-omap2/built-in.o:(.init.data+0x4808): undefined reference to `omap2xxx_prm_init'
> arch/arm/mach-omap2/built-in.o:(.init.data+0x4838): undefined reference to `omap44xx_prm_init'
> arch/arm/mach-omap2/built-in.o:(.init.data+0x4868): undefined reference to `omap44xx_prm_init'
> arch/arm/mach-omap2/built-in.o:(.init.data+0x4880): undefined reference to `omap44xx_prm_init'
> arch/arm/mach-omap2/built-in.o:(.init.data+0x4898): undefined reference to `omap2xxx_cm_init'
> arch/arm/mach-omap2/built-in.o:(.init.data+0x48c8): undefined reference to `omap4_cm_init'
> arch/arm/mach-omap2/built-in.o:(.init.data+0x48e0): undefined reference to `omap4_cm_init'
> arch/arm/mach-omap2/built-in.o:(.init.data+0x48f8): undefined reference to `am33xx_cm_init'
> arch/arm/mach-omap2/built-in.o:(.init.data+0x4910): undefined reference to `omap4_cm_init'
>
> .config attached.
>

