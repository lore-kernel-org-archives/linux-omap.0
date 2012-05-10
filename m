From: Sricharan R <r.sricharan@ti.com>
Subject: RE: [PATCH 00/13] ARM: OMAP5: Add minimal OMAP5 SOC support
Date: Thu, 10 May 2012 23:13:16 +0530
Message-ID: <e02393fc87c4e06ce1d783a03747aff7@mail.gmail.com>
References: <1336029982-31898-1-git-send-email-r.sricharan@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog122.obsmtp.com ([74.125.149.147]:57083 "EHLO
	na3sys009aog122.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760674Ab2EJRnV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 10 May 2012 13:43:21 -0400
Received: by lbbgm6 with SMTP id gm6so1576499lbb.5
        for <linux-omap@vger.kernel.org>; Thu, 10 May 2012 10:43:18 -0700 (PDT)
In-Reply-To: <1336029982-31898-1-git-send-email-r.sricharan@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, tony@atomide.com, Benoit Cousson <b-cousson@ti.com>

Hi Tony,

> -----Original Message-----
> From: R Sricharan [mailto:r.sricharan@ti.com]
> Sent: Thursday, May 03, 2012 12:56 PM
> To: linux-omap@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org; santosh.shilimkar@ti.com;
> tony@atomide.com; b-cousson@ti.com; r.sricharan@ti.com
> Subject: [PATCH 00/13] ARM: OMAP5: Add minimal OMAP5 SOC support
>
> The series adds minimal OMAP5 support.
> OMAP5430 has a dual core Cortex-A15 based MPU subsystem with 2MB
> L2 cache. The SOC has many compatible blocks with OMAP4 SOCS and
> hence large part of the peripherals are re-used.
>
> OMAP5432 is another variant of OMAP5430, with a
> memory controller supporting DDR3 and SATA.
>
 OMAP5 V2 series is ready with all comments addressed, but I have
 below dependencies to be merged to apply my series against your
 cleanup-soc branch

 1) git://git.pwsan.com/linux-2.6 hwmod_soc_conditional_cleanup_3.5
 2) git://git.pwsan.com/linux-2.6 hwmod_data_cleanup_3.5
 3) https://github.com/hvaibhav/am335x-linux   32ksync-timer-cleanup
 4) http://www.spinics.net/lists/arm-kernel/msg174461.html

 Can you please let me know how you want me to prepare the series
 with these dependencies.

Thanks,
 Sricharan
