From: Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [PATCH v5 0/7] irqchip: Move OMAP{4,5}/DRA7 to use stacked domains
Date: Tue, 24 Feb 2015 09:04:26 +0000
Message-ID: <54EC3E9A.5010807@arm.com>
References: <1424713459-6824-1-git-send-email-marc.zyngier@arm.com> <20150223230205.GJ32521@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:33486 "EHLO
	usa-sjc-mx-foss1.foss.arm.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751253AbbBXJEa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 24 Feb 2015 04:04:30 -0500
In-Reply-To: <20150223230205.GJ32521@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Benoit Cousson <bcousson@baylibre.com>, Nishanth Menon <nm@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>, Jason Cooper <jason@lakedaemon.net>, Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <Mark.Rutland@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On 23/02/15 23:02, Tony Lindgren wrote:
> * Marc Zyngier <marc.zyngier@arm.com> [150223 09:48]:
>> This series is extracted from [4], which is trying to remove all
>> traces of gic_arch_extn from the tree. As some maintainers are more
>> responsive than others (understatement of the year...), I've decided
>> to split it per sub-arch, and get it moving, at least partially.
>>
>> This series addresses OMAP{4,5} by converting the WUGEN to stacked
>> domains. The DRA7 crossbar gets the same treatment.
>>
>> It is worth realizing that:
>>
>> - I haven't been able to test this as much as I would have wanted to
>>   (it's only been tested on omap4 and omap5).
>>
>> - This actively *breaks* existing setups. Once you boot a new kernel
>>   with an old DT, suspend/resume *will* be broken. Old kernels on a
>>   new DT won't even boot! You've been warned. This really outline the
>>   necessity of actually describing the HW in device trees...
> 
> Could we parse still the old binding and produce warning for the
> case when a new kernel is booted with the old DT? That would make
> it easier for people to debug what's going on.

There's a number of strategies:
- Looking up the default, top-level interrupt controller:
  if that's the GIC, scream.
- Lookup the crossbar:
  if it exists, but is not an interrupt controller, scream as well.
- Lookup the WUGEN:
  if it doesn't exist, scream again.

The last one is pretty easy to implement:

diff --git a/arch/arm/mach-omap2/omap4-common.c b/arch/arm/mach-omap2/omap4-common.c
index fba1ba7..7bb116a 100644
--- a/arch/arm/mach-omap2/omap4-common.c
+++ b/arch/arm/mach-omap2/omap4-common.c
@@ -277,6 +277,12 @@ void __init omap_gic_of_init(void)
 {
 	struct device_node *np;
 
+	intc_node = of_find_matching_node(NULL, intc_match);
+	if (WARN_ON(!intc_node)) {
+		pr_err("No WUGEN found in DT, system will misbehave.\n");
+		pr_err("UPDATE YOUR DEVICE TREE!\n");
+	}
+
 	/* Extract GIC distributor and TWD bases for OMAP4460 ROM Errata WA */
 	if (!cpu_is_omap446x())
 		goto skip_errata_init;

This should cover both OMAP4, OMAP5 and DRA7.

What do you think?

	M.
-- 
Jazz is not dead. It just smells funny...
