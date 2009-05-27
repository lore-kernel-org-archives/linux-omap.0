From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: [PATCH 0/4]ARM: OMAP4: SMP: Patch series
Date: Wed, 27 May 2009 21:52:38 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02B4BE36E4@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:46018 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754729AbZE0QXE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 27 May 2009 12:23:04 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>

Russell,
I have rebased this series on top of your arm-smp patches and my earlier basic omap4 patches.
Series is based of kernel.org 2.6.30-rc6 ( commit:1406de8e11eb043681297adf86d6892ff8efc27a). This series have dependency on [1],[2],[3],[4] and latest mach-types

The series contains:
	[PATCH 1/4] ARM: OMAP4: SMP: Add OMAP4430 SMP board files
	[PATCH 2/4] ARM: OMAP4: SMP: Add mpu timer support for OMAP4430
	[PATCH 3/4] ARM: OMAP4: SMP: Enable SMP support for OMAP4430
	[PATCH 4/4] ARM: OMAP4: SMP: Update defconfig for OMAP4430

Regards,
Santosh

[1]:	Russell's arm-smp patch series + one of my patch
	http://ftp.arm.linux.org.uk/pub/linux/arm/kernel/git-cur/arm:smp.diff

[2]:	Tony's : [PATCH 0/5] More header clean-up
	http://www.mail-archive.com/linux-omap@vger.kernel.org/msg12231.html

[3]:	Mine [PATCH 0/4] OMAP: Cleanup series.
	http://lists.arm.linux.org.uk/lurker/message/20090519.131647.c2c471ef.en.html
	
[4]:	Mine [PATCH 0/4] ARM: OMPA4: Basic boot patch series based on linux-omap
	http://lists.arm.linux.org.uk/lurker/message/20090520.125900.9209eb81.en.html
	

Regards,
Santosh