From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: [PATCH 0/3] [RFC] OMAP4: SMP: Patch series
Date: Tue, 28 Apr 2009 21:15:15 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02B42BE444@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:50459 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762076AbZD1PpX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 28 Apr 2009 11:45:23 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id n3SFjGB2031601
	for <linux-omap@vger.kernel.org>; Tue, 28 Apr 2009 10:45:22 -0500
Received: from dbde71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id n3SFjGNG004039
	for <linux-omap@vger.kernel.org>; Tue, 28 Apr 2009 21:15:16 +0530 (IST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Following is the patch series to enable SMP support for OMAP4430 development platform. This series is on top of the first series sent on the mailing list.

The patches are generated against mainline version 2.6.30 -rc2. The kernel is validated on the OMAP4430 software simulator platform. SMP kernel is functional with debug UART. No additional drivers are supported yet.

TI's OMAP4430 SOC is based on ARM Cortex-A9 SMP architecture. It's a dual core SOC with GIC used for interrupt handling and SCU for cache coherency.

The series contains:
[PATCH 1/3][RFC]OMAP4: SMP: Add OMAP4430 SMP board files
[PATCH 2/3][RFC]OMAP4: SMP: Add mpu timer support for OMAP4430
[PATCH 3/3][RFC]OMAP4: SMP: Enable SMP support for OMAP4430

Thanks in advance for the review !!

Regards,
Santosh
