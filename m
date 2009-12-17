From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: RE: Anyone using an ISP1505?
Date: Fri, 18 Dec 2009 00:50:55 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB031DC20A68@dbde02.ent.ti.com>
References: <4B2A7FFB.6090909@billgatliff.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:59880 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965368AbZLQTXF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 17 Dec 2009 14:23:05 -0500
In-Reply-To: <4B2A7FFB.6090909@billgatliff.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Bill Gatliff <bgat@billgatliff.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "beagleboard@googlegroups.com" <beagleboard@googlegroups.com>

> I'm working on an OMAP3530CUS board that uses an ISP1505 USB PHY, and I
> haven't gotten much luck getting the kernel to recognize any USB
> devices.  No luck, actually.  :)  My oscilloscope and the schematic say
> that the hardware is wired up properly, I'm just wondering if anyone has
> a similar configuration that's working for them--- and which kernel they
> are using?

Is it with the OTG controller or with the EHCI controller?


The NXP ISP1505 is supposed to be transparent - no programming usually
required.

If it's with the EHCI controller, you need to take care of a couple of
issues on the board (due to the input clocking mode used in the OMAP3).

- Anand
