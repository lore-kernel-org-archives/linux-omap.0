From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: [PATCH 0/3]  OMAP4: SMP: Patch series
Date: Thu, 7 May 2009 12:47:30 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02B4687E57@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:52753 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750754AbZEGHRw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 May 2009 03:17:52 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

This patch series enables SMP support for OMAP4430 development platform. This series depends on the earlier patch series sent on the mailing list. [1]

The patches are generated against mainline version 2.6.30 -rc2. The kernel is validated on the OMAP4430 software simulator platform. SMP kernel is functional with debug UART. No additional drivers are supported yet.

The series contains:

[PATCH 1/3]OMAP4: SMP: Add OMAP4430 SMP board files
[PATCH 2/3]OMAP4: SMP: Add mpu timer support for OMAP4430
[PATCH 3/3]OMAP4: SMP: Enable SMP support for OMAP4430

Regards,
Santosh

[1]:	[PATCH 0/7] OMAP4: Basic board support patch series
	http://lists.arm.linux.org.uk/lurker/message/20090428.094757.6642f1e3.en.html
