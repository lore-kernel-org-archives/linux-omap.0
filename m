From: Vaibhav Hiremath <hvaibhav@ti.com>
Subject: Re: [PATCH 01/10] ARM: OMAP3/4: cpuidle: fix sparse and checkpatch
 warnings
Date: Wed, 12 Dec 2012 14:01:05 +0530
Message-ID: <50C840C9.5000407@ti.com>
References: <20121209011755.19716.25244.stgit@dusk.lan> <20121209012334.19716.44831.stgit@dusk.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:36243 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751160Ab2LLIbN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 12 Dec 2012 03:31:13 -0500
In-Reply-To: <20121209012334.19716.44831.stgit@dusk.lan>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>



On 12/9/2012 6:53 AM, Paul Walmsley wrote:
> Fix the following sparse warnings in the OMAP3/4 CPUIdle code:
> 
> arch/arm/mach-omap2/cpuidle34xx.c:272:1: warning: symbol 'omap3_idle_dev' was not declared. Should it be static?
> arch/arm/mach-omap2/cpuidle34xx.c:274:23: warning: symbol 'omap3_idle_driver' was not declared. Should it be static?
> arch/arm/mach-omap2/cpuidle44xx.c:164:1: warning: symbol 'omap4_idle_dev' was not declared. Should it be static?
> arch/arm/mach-omap2/cpuidle44xx.c:166:23: warning: symbol 'omap4_idle_driver' was not declared. Should it be static?
> 
> Also fix the following checkpatch warnings:
> 
> WARNING: please, no space before tabs
> #44: FILE: arch/arm/mach-omap2/cpuidle34xx.c:105:
> +^I.name = ^I"omap3_idle",$
> 
> WARNING: please, no space before tabs
> #45: FILE: arch/arm/mach-omap2/cpuidle34xx.c:106:
> +^I.owner = ^ITHIS_MODULE,$
> 
> ERROR: code indent should use tabs where possible
> #211: FILE: arch/arm/mach-omap2/cpuidle44xx.c:74:
> +                        /* C2 - CPU0 OFF + CPU1 OFF + MPU CSWR */$
> 
> 

Paul,

I am using your "paul-linux-pwrdm_post_fpwrst_devel_a_3.9" branch, where
all the patches which you have posted are present (I believe so) and I
am getting following sparse warning -


  CHECK   arch/arm/mach-omap2/powerdomain.c
arch/arm/mach-omap2/powerdomain.c:811:2: warning: context imbalance in
'pwrdm_lock': unexpected unlock
arch/arm/mach-omap2/powerdomain.c:811:2:    default context: wanted 1, got 0
include/linux/spinlock.h:340:2: warning: context problem in
'pwrdm_unlock': '_raw_spin_unlock_irqrestore' expected different context
include/linux/spinlock.h:340:2:    context 'lock': wanted >= 1, got 0
arch/arm/mach-omap2/powerdomain.c:1130:14: warning: context problem in
'pwrdm_state_switch': 'pwrdm_unlock' expected different context
arch/arm/mach-omap2/powerdomain.c:1130:14:    default context: wanted >=
1, got 0
arch/arm/mach-omap2/powerdomain.c:1295:14: warning: context problem in
'pwrdm_set_next_fpwrst': 'pwrdm_unlock' expected different context
arch/arm/mach-omap2/powerdomain.c:1295:14:    default context: wanted >=
1, got 0
arch/arm/mach-omap2/powerdomain.c:1317:14: warning: context problem in
'pwrdm_read_next_fpwrst': 'pwrdm_unlock' expected different context
arch/arm/mach-omap2/powerdomain.c:1317:14:    default context: wanted >=
1, got 0
arch/arm/mach-omap2/powerdomain.c:1382:14: warning: context problem in
'pwrdm_set_fpwrst': 'pwrdm_unlock' expected different context
arch/arm/mach-omap2/powerdomain.c:1382:14:    default context: wanted >=
1, got 0
arch/arm/mach-omap2/powerdomain.c:1407:14: warning: context problem in
'pwrdm_read_fpwrst': 'pwrdm_unlock' expected different context
arch/arm/mach-omap2/powerdomain.c:1407:14:    default context: wanted >=
1, got 0
arch/arm/mach-omap2/powerdomain.c:1432:14: warning: context problem in
'pwrdm_read_prev_fpwrst': 'pwrdm_unlock' expected different context
arch/arm/mach-omap2/powerdomain.c:1432:14:    default context: wanted >=
1, got 0
arch/arm/mach-omap2/powerdomain.c:1505:14: warning: context problem in
'pwrdm_dbg_show_counter': 'pwrdm_unlock' expected different context
arch/arm/mach-omap2/powerdomain.c:1505:14:    default context: wanted >=
1, got 0
arch/arm/mach-omap2/powerdomain.c:1542:14: warning: context problem in
'pwrdm_dbg_show_timer': 'pwrdm_unlock' expected different context
arch/arm/mach-omap2/powerdomain.c:1542:14:    default context: wanted >=
1, got 0
  CC      arch/arm/mach-omap2/powerdomain.o



On the other hand, I have boot tested it on BeagleBone platform.

Thanks,
Vaibhav
