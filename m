From: "Menon, Nishanth" <nm@ti.com>
Subject: RE: [PATCH 1/1] i2c:OMAP3:Errata workaround for spurious RDR event
Date: Mon, 22 Jun 2009 23:20:35 -0500
Message-ID: <7A436F7769CA33409C6B44B358BFFF0C0115F50E6B@dlee02.ent.ti.com>
References: <1245702292-4383-1-git-send-email-ubh@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:35050 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751247AbZFWEUk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 23 Jun 2009 00:20:40 -0400
Received: from dlep34.itg.ti.com ([157.170.170.115])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id n5N4KcZ3016213
	for <linux-omap@vger.kernel.org>; Mon, 22 Jun 2009 23:20:43 -0500
Received: from dlep20.itg.ti.com (localhost [127.0.0.1])
	by dlep34.itg.ti.com (8.13.7/8.13.7) with ESMTP id n5N4Kbt6023375
	for <linux-omap@vger.kernel.org>; Mon, 22 Jun 2009 23:20:37 -0500 (CDT)
Received: from dlee75.ent.ti.com (localhost [127.0.0.1])
	by dlep20.itg.ti.com (8.12.11/8.12.11) with ESMTP id n5N4KbnY021476
	for <linux-omap@vger.kernel.org>; Mon, 22 Jun 2009 23:20:37 -0500 (CDT)
In-Reply-To: <1245702292-4383-1-git-send-email-ubh@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Hald, Ulrik Bech" <ubh@ti.com>


> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Ulrik Bech Hald
> Sent: Monday, June 22, 2009 11:25 PM
> To: linux-omap@vger.kernel.org
> Cc: Hald, Ulrik Bech
> Subject: [PATCH 1/1] i2c:OMAP3:Errata workaround for spurious RDR event
> 
> Under certain rare conditions, I2C_STAT[13].RDR bit may be set,
> and the corresponding interrupt fire, even when there is no
> data in the receive FIFO, or the I2C data transfer is still
> ongoing. These spurious RDR events must be ignored by the
> software.
Is this workaround valid for omap2430 also?

Regards,
Nishanth Menon
