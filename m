From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH] ARM: OMAP5: Fix omap5 standalone build break
Date: Fri, 14 Jun 2013 14:12:37 -0400
Message-ID: <51BB5D15.8030306@ti.com>
References: <1371201107-20929-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:34064 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751382Ab3FNSNC (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 14 Jun 2013 14:13:02 -0400
In-Reply-To: <1371201107-20929-1-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Friday 14 June 2013 05:11 AM, Rajendra Nayak wrote:
> Building omap5 standalone results in the below errors..
> 
> arch/arm/mach-omap2/built-in.o: In function `scu_gp_set':
> arch/arm/mach-omap2/sleep44xx.S:132: undefined reference to `scu_power_mode'
> arch/arm/mach-omap2/built-in.o: In function `scu_gp_clear':
> arch/arm/mach-omap2/sleep44xx.S:229: undefined reference to `scu_power_mode'
> arch/arm/mach-omap2/built-in.o: In function `omap4_smp_prepare_cpus':
> arch/arm/mach-omap2/omap-smp.c:211: undefined reference to `scu_enable'
> arch/arm/mach-omap2/built-in.o: In function `omap4_smp_init_cpus':
> arch/arm/mach-omap2/omap-smp.c:185: undefined reference to `scu_get_core_count'
> 
> Fix this by adding the missing select for HAVE_ARM_SCU for SOC_OMAP5
> 
> Reported-by: Pekon Gupta <pekon@ti.com>
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> ---
NAK. Similar patch [1] was posted by Vincent a while back.
The right fix to remove the scu related dependency with OMAP5
code.

Regards,
Santosh

[1] https://patchwork.kernel.org/patch/2568091/
