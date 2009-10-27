From: Gabi Voiculescu <boy3dfx2@yahoo.com>
Subject: looking for presence of PMN interrupt in OMAP3530
Date: Tue, 27 Oct 2009 13:24:04 -0700 (PDT)
Message-ID: <547648.15600.qm@web113808.mail.gq1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from n4-vm0.bullet.mail.gq1.yahoo.com ([67.195.9.7]:36697 "HELO
	n4-vm0.bullet.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1756766AbZJ0UYB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 27 Oct 2009 16:24:01 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hello.

I am working on porting a piece of code that makes use of irq on top of the performance counters (PMN) present in the OMAP3530's
Cortex A8 MPU.

This code is ported from an armv6 platform (arm1176 cpu). On the original platform (pb1176) the interrupt number into the IC was known from the
documentation (39). 

I am unable to find the interrupt number for the performance counters and can not believe the TI people left the line unconnected to the GIC when they build the OMAP3530.

I have searched in the TI documentation: Interrupt table (starting on page 1074 in http://focus.ti.com/lit/ug/spruff6b/spruff6b.pdf ) for a suitable entry but did not find it.

I have tried to program a counter overflow and unmask the first 4 IRQs in
the MPU in the hope that one of these is the PMU irq, again without
success.

***********

Did anybody get into this documentation problem?

Did he find a fix for it?

Is there a PMN interrupt in the OMAP3530 IC Interrupt table?

***********

Thank you,
Gabi Voiculescu



      

