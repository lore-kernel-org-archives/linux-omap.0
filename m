From: Nishanth Menon <nm@ti.com>
Subject: [next-20140702]Build regression omap2plus_defconfig, multi_v7_defconfig
 builds fine
Date: Wed, 2 Jul 2014 07:26:40 -0500
Message-ID: <53B3FA80.9090403@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:35934 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751134AbaGBM0m (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Jul 2014 08:26:42 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "tony@atomide.com" <tony@atomide.com>
Cc: linux-omap <linux-omap@vger.kernel.org>

Tony,

make omap2plus_defconfig ;make zImage on next-20140702

>   LD      fs/built-in.o
> scripts/mod/modpost.c: In function =91remove_dot=92:
> scripts/mod/modpost.c:1710:10: warning: ignoring return value of =91s=
trtoul=92, declared with attribute warn_unused_result [-Wunused-result]
> arch/arm/kernel/return_address.c:63:2: warning: #warning "TODO: retur=
n_address should use unwind tables" [-Wcpp]
> arch/arm/kernel/return_address.c:63:2: warning: #warning "TODO: retur=
n_address should use unwind tables" [-Wcpp]
> In file included from arch/arm/kernel/perf_event_cpu.c:69:0:
> arch/arm/kernel/perf_event_v6.c: In function =91armv6_1136_pmu_init=92=
:
> arch/arm/kernel/perf_event_v6.c:498:2: error: expected =91;=92 before=
 =91return=92
> arch/arm/kernel/perf_event_v6.c:499:1: warning: no return statement i=
n function returning non-void [-Wreturn-type]
> arch/arm/kernel/perf_event_v6.c: In function =91armv6_1156_pmu_init=92=
:
> arch/arm/kernel/perf_event_v6.c:505:2: error: expected =91;=92 before=
 =91return=92
> arch/arm/kernel/perf_event_v6.c:506:1: warning: no return statement i=
n function returning non-void [-Wreturn-type]
> arch/arm/kernel/perf_event_v6.c: In function =91armv6_1176_pmu_init=92=
:
> arch/arm/kernel/perf_event_v6.c:512:2: error: expected =91;=92 before=
 =91return=92
> arch/arm/kernel/perf_event_v6.c:513:1: warning: no return statement i=
n function returning non-void [-Wreturn-type]
> make[1]: *** [arch/arm/kernel/perf_event_cpu.o] Error 1
> make: *** [arch/arm/kernel] Error 2
> make: *** Waiting for unfinished jobs....
> fs/direct-io.c: In function =91__blockdev_direct_IO=92:
> fs/direct-io.c:1011:12: warning: =91to=92 may be used uninitialized i=
n this function [-Wuninitialized]
> fs/direct-io.c:913:16: note: =91to=92 was declared here
> fs/direct-io.c:920:9: warning: =91from=92 may be used uninitialized i=
n this function [-Wuninitialized]
> fs/direct-io.c:913:10: note: =91from=92 was declared here

multi_v7_defconfig seems to build fine.

--=20
Regards,
Nishanth Menon
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
