From: Kevin Hilman <khilman@ti.com>
Subject: Re: OMAP3EVM not booting on l-o master
Date: Tue, 01 May 2012 07:08:00 -0700
Message-ID: <87y5pchu4f.fsf@ti.com>
References: <C8443D0743D26F4388EA172BF4E2A7A9317C3A03@DBDE01.ent.ti.com>
	<C8443D0743D26F4388EA172BF4E2A7A9317C3B18@DBDE01.ent.ti.com>
	<alpine.DEB.2.00.1204050330380.10302@utopia.booyaka.com>
	<alpine.DEB.2.00.1204050403460.10302@utopia.booyaka.com>
	<C8443D0743D26F4388EA172BF4E2A7A9317C4B44@DBDE01.ent.ti.com>
	<alpine.DEB.2.00.1204051303000.10302@utopia.booyaka.com>
	<C8443D0743D26F4388EA172BF4E2A7A9317C5DB6@DBDE01.ent.ti.com>
	<alpine.DEB.2.00.1204060111400.10302@utopia.booyaka.com>
	<C8443D0743D26F4388EA172BF4E2A7A9317C5EEF@DBDE01.ent.ti.com>
	<1335173044.2149.64.camel@sokoban> <87obqhawig.fsf@ti.com>
	<1335532591.2149.163.camel@sokoban> <87fwbowyuu.fsf@ti.com>
	<1335790016.2149.185.camel@sokoban> <87vckht0lf.fsf@ti.com>
	<C8443D0743D26F4388EA172BF4E2A7A93E97C988@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog125.obsmtp.com ([74.125.149.153]:49986 "EHLO
	na3sys009aog125.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752959Ab2EAOIG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 May 2012 10:08:06 -0400
Received: by ghrr14 with SMTP id r14so2969864ghr.4
        for <linux-omap@vger.kernel.org>; Tue, 01 May 2012 07:08:03 -0700 (PDT)
In-Reply-To: <C8443D0743D26F4388EA172BF4E2A7A93E97C988@DBDE01.ent.ti.com>
	(Afzal Mohammed's message of "Tue, 1 May 2012 12:55:25 +0000")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Mohammed, Afzal" <afzal@ti.com>
Cc: "Kristo, Tero" <t-kristo@ti.com>, Paul Walmsley <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

"Mohammed, Afzal" <afzal@ti.com> writes:

> Hi Kevin,
>
> On Tue, May 01, 2012 at 02:10:28, Hilman, Kevin wrote:
>> 
>> Afzal, care to give this one a test as well?  It should have the same
>> result but is a more targetted fix.  With and ack from Tero and a
>> Tested-by from you, I'll post this to the list and and queue it up for
>> v3.5.
>
> Over what commit id, should this patch be applied ?, unable to apply it over
> "297624c ARM: OMAP3: PM: Remove IO Daisychain control from cpuidle", the
> one that I tested your previous patch.

Oops, my fault.

Below is a version that applies on top of the IO chain branch currently
in Paul's tree[1].

Kevin

[1] git://git.pwsan.com/linux-2.6 io_chain_devel_3.5


>From d94f04eea40686cd9db8e9dbd8dbf3c02edca07f Mon Sep 17 00:00:00 2001
From: Kevin Hilman <khilman@ti.com>
Date: Tue, 1 May 2012 07:06:42 -0700
Subject: [PATCH] ARM: OMAP3: PM: leave PRCM interrupts disabled until
 explicitly enabled.

By default, request_irq() will auto-enable the requested IRQ.

For PRCM interrupts, we may want to avoid that until the PM core code
is fully ready to handle the interrupts.  This is particularily true
for IO pad interrupts on OMAP3, which are shared between the hwmod
core and the PRM core.

In order to avoid PRCM IO-chain interrupts until the PM core is ready
to handle them, ready, set the IRQ_NOAUTOEN flag for the PRCM IO-chain
interrupt,  which means it will remain disabled after request_irq().

Then, explicitly enable the PRCM interrupts after the request_irq() in
the PM core (but not in the hwmod core.)

Special thanks to Tero Kristo for suggesting to isolate the fix to
only the IO-chain interrupt on OMAP3 instead of all PRCM interrupts.

Cc: Tero Kristo <t-kristo@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap2/pm34xx.c       |    1 +
 arch/arm/mach-omap2/prm2xxx_3xxx.c |   10 ++++++++--
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 3e6b564..745a151 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -685,6 +685,7 @@ static int __init omap3_pm_init(void)
 	ret = request_irq(omap_prcm_event_to_irq("io"),
 		_prcm_int_handle_io, IRQF_SHARED | IRQF_NO_SUSPEND, "pm_io",
 		omap3_pm_init);
+	enable_irq(omap_prcm_event_to_irq("io"));
 
 	if (ret) {
 		pr_err("pm: Failed to request pm_io irq\n");
diff --git a/arch/arm/mach-omap2/prm2xxx_3xxx.c b/arch/arm/mach-omap2/prm2xxx_3xxx.c
index 1471a33..a8c6bd8 100644
--- a/arch/arm/mach-omap2/prm2xxx_3xxx.c
+++ b/arch/arm/mach-omap2/prm2xxx_3xxx.c
@@ -350,10 +350,16 @@ static void __init omap3xxx_prm_enable_io_wakeup(void)
 
 static int __init omap3xxx_prcm_init(void)
 {
+	int ret = 0;
+
 	if (cpu_is_omap34xx()) {
 		omap3xxx_prm_enable_io_wakeup();
-		return omap_prcm_register_chain_handler(&omap3_prcm_irq_setup);
+		ret = omap_prcm_register_chain_handler(&omap3_prcm_irq_setup);
+		if (!ret)
+			irq_set_status_flags(omap_prcm_event_to_irq("io"),
+					     IRQ_NOAUTOEN);
 	}
-	return 0;
+
+	return ret;
 }
 subsys_initcall(omap3xxx_prcm_init);
-- 
1.7.9.2

