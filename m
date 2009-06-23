From: "Hald, Ulrik Bech" <ubh@ti.com>
Subject: RE: [PATCH 1/1] i2c:OMAP3:Errata workaround for spurious RDR event
Date: Tue, 23 Jun 2009 15:12:36 +0200
Message-ID: <00695C9C8F8B4448856F48142B4AA201BDA38902@dnce02.ent.ti.com>
References: <1245702292-4383-1-git-send-email-ubh@ti.com>
 <7A436F7769CA33409C6B44B358BFFF0C0115F50E6B@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:39743 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759026AbZFWNMm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 23 Jun 2009 09:12:42 -0400
Received: from dlep36.itg.ti.com ([157.170.170.91])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id n5NDCeCp010340
	for <linux-omap@vger.kernel.org>; Tue, 23 Jun 2009 08:12:45 -0500
Received: from dlep20.itg.ti.com (localhost [127.0.0.1])
	by dlep36.itg.ti.com (8.13.8/8.13.8) with ESMTP id n5NDCdfp019806
	for <linux-omap@vger.kernel.org>; Tue, 23 Jun 2009 08:12:39 -0500 (CDT)
Received: from dnce72.ent.ti.com (localhost [127.0.0.1])
	by dlep20.itg.ti.com (8.12.11/8.12.11) with ESMTP id n5NDCc5d001195
	for <linux-omap@vger.kernel.org>; Tue, 23 Jun 2009 08:12:39 -0500 (CDT)
In-Reply-To: <7A436F7769CA33409C6B44B358BFFF0C0115F50E6B@dlee02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: Menon, Nishanth
> Sent: Monday, June 22, 2009 11:21 PM
> To: Hald, Ulrik Bech; linux-omap@vger.kernel.org
> Cc: Hald, Ulrik Bech
> Subject: RE: [PATCH 1/1] i2c:OMAP3:Errata workaround for spurious RDR
> event
> 
> 
> > -----Original Message-----
> > From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> > owner@vger.kernel.org] On Behalf Of Ulrik Bech Hald
> > Sent: Monday, June 22, 2009 11:25 PM
> > To: linux-omap@vger.kernel.org
> > Cc: Hald, Ulrik Bech
> > Subject: [PATCH 1/1] i2c:OMAP3:Errata workaround for spurious RDR event
> >
> > Under certain rare conditions, I2C_STAT[13].RDR bit may be set,
> > and the corresponding interrupt fire, even when there is no
> > data in the receive FIFO, or the I2C data transfer is still
> > ongoing. These spurious RDR events must be ignored by the
> > software.
> Is this workaround valid for omap2430 also?
> 
Yes, this workaround should also be valid for OMAP2430 errata 1.67 (equivalent errata).

> Regards,
> Nishanth Menon

BR Ulrik
