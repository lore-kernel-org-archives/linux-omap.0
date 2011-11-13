From: Ming Lei <tom.leiming@gmail.com>
Subject: [QUESTION] omap iommu: a generic IOMMU?
Date: Sun, 13 Nov 2011 19:04:51 +0800
Message-ID: <CACVXFVPLgXfcpE9x2KKbU=r9_+ZeEbfo1TGndvm6yi34V15tPA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:38810 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751281Ab1KMLEv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 13 Nov 2011 06:04:51 -0500
Received: by ggnb2 with SMTP id b2so5383557ggn.19
        for <linux-omap@vger.kernel.org>; Sun, 13 Nov 2011 03:04:51 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Omar Ramirez Luna <omar.ramirez@ti.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Joerg Roedel <joerg.roedel@amd.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi  guys,

I found that omap-iommu.c has been under drivers/iommu for some time.

Just be curious, is it a generic IOMMU so that it can be used by all IO
peripherals in OMAP4?  Could you give some use cases about
the omap-iommu in kernel?

>From related source code[1] and OMAP4 TRM[2], looks like the omap iommu
only belongs to Cortex-M3 MPU subsystem inside OMAP4 chip, so I am wondering
why introduces the driver for arm v7 based linux kernel...

[1], arch/arm/mach-omap2/omap-iommu.c
[2], "20.5 MMU Register Manual" of "omap4 TRM Version O"

thanks,
-- 
Ming Lei
