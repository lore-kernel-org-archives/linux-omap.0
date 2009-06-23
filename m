From: "Menon, Nishanth" <nm@ti.com>
Subject: RE: [PATCH] [RFC][OMAP3:I2C]Workaround for OMAP3430 I2C silicon
 errata 1.153
Date: Mon, 22 Jun 2009 23:20:48 -0500
Message-ID: <7A436F7769CA33409C6B44B358BFFF0C0115F50E6C@dlee02.ent.ti.com>
References: <CD8CC2B65FEE304DA95744A5472698F2028A41187E@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:41415 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751338AbZFWEUx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 23 Jun 2009 00:20:53 -0400
Received: from dlep35.itg.ti.com ([157.170.170.118])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id n5N4KpiW032057
	for <linux-omap@vger.kernel.org>; Mon, 22 Jun 2009 23:20:56 -0500
Received: from dlep20.itg.ti.com (localhost [127.0.0.1])
	by dlep35.itg.ti.com (8.13.7/8.13.7) with ESMTP id n5N4KoCB002502
	for <linux-omap@vger.kernel.org>; Mon, 22 Jun 2009 23:20:50 -0500 (CDT)
Received: from dlee73.ent.ti.com (localhost [127.0.0.1])
	by dlep20.itg.ti.com (8.12.11/8.12.11) with ESMTP id n5N4Koai021541
	for <linux-omap@vger.kernel.org>; Mon, 22 Jun 2009 23:20:50 -0500 (CDT)
In-Reply-To: <CD8CC2B65FEE304DA95744A5472698F2028A41187E@dlee06.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Sonasath, Moiz" <m-sonasath@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Pandita, Vikram" <vikram.pandita@ti.com>

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Sonasath, Moiz
> Sent: Monday, June 22, 2009 7:50 PM
> To: linux-omap@vger.kernel.org
> Cc: Pandita, Vikram
> Subject: [PATCH] [RFC][OMAP3:I2C]Workaround for OMAP3430 I2C silicon
> errata 1.153
> 
> This patch includes the workarround for I2C Errata 1.153: When an XRDY/XDR
> is hit, wait for XUDF before writing data to DATA_REG

Is this workaround valid for omap2430 also?

Regards,
Nishanth Menon
