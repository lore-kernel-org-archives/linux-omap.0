From: "Pandita, Vikram" <vikram.pandita@ti.com>
Subject: RE: [PATCH] OMAP: Zoom3: Fix Zoom3 booting issue
Date: Tue, 2 Mar 2010 21:49:55 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC3560870304195754@dbde02.ent.ti.com>
References: <1267536955-31268-1-git-send-email-manjugk@ti.com>
 <A24693684029E5489D1D202277BE894453B624B1@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:38808 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753286Ab0CBQUB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Mar 2010 11:20:01 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id o22GJw2L003922
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 2 Mar 2010 10:20:00 -0600
Received: from dbde71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id o22GJvf9019014
	for <linux-omap@vger.kernel.org>; Tue, 2 Mar 2010 21:49:57 +0530 (IST)
In-Reply-To: <A24693684029E5489D1D202277BE894453B624B1@dlee02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Aguirre, Sergio" <saaguirre@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>



> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Aguirre, Sergio
> Sent: Tuesday, March 02, 2010 10:11 AM
> To: G, Manjunath Kondaiah; linux-omap@vger.kernel.org
> Cc: G, Manjunath Kondaiah; Tony Lindgren; Shilimkar, Santosh; Raja,
> Govindraj
> Subject: RE: [PATCH] OMAP: Zoom3: Fix Zoom3 booting issue
> 
> Manju,
> 
<snip>
> 
> So, if you want to boot, take series [1] and [2], and then you should be
> able to boot with ttyS0.

Yes I could boot the zoom3 with your patchset with console on ttyS0:

Relevant Boot Log:
>Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
>serial8250.0: ttyS0 at MMIO 0x10000000 (irq = 262) is a ST16654
>console [ttyS0] enabled

> 
> Regards,
> Sergio
> 
> ---
> [1] http://marc.info/?l=linux-omap&m=126730356232287&w=2
> [2] http://marc.info/?l=linux-omap&m=126746974103007&w=2
> 
