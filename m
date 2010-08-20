From: "Aguirre, Sergio" <saaguirre@ti.com>
Subject: omap3_defconfig: USB_OTG unmet dependencies
Date: Fri, 20 Aug 2010 14:21:27 -0500
Message-ID: <A24693684029E5489D1D202277BE89445721F86D@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:60943 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751050Ab0HTTV3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 20 Aug 2010 15:21:29 -0400
Received: from dlep33.itg.ti.com ([157.170.170.112])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id o7KJLTcG020136
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 20 Aug 2010 14:21:29 -0500
Received: from dlep26.itg.ti.com (localhost [127.0.0.1])
	by dlep33.itg.ti.com (8.13.7/8.13.7) with ESMTP id o7KJLSs3016121
	for <linux-omap@vger.kernel.org>; Fri, 20 Aug 2010 14:21:28 -0500 (CDT)
Received: from dlee73.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id o7KJLSSS011681
	for <linux-omap@vger.kernel.org>; Fri, 20 Aug 2010 14:21:28 -0500 (CDT)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi all,

Today, I tried loading the omap3_defconfig from current master commit: 

ddfc2d1 Linux-omap rebuilt: Updated to v2.6.36-rc1

And I noticed this bad Kconfig dependency:

warning: (USB_MUSB_HDRC_HCD && USB_SUPPORT && USB_MUSB_HDRC && (USB_MUSB_HOST || USB_MUSB_OTG) && USB_GADGET_MUSB_HDRC || USB_MUSB_OTG && <choice> && USB && USB_GADGET && PM && EXPERIMENTAL) selects USB_OTG which has unmet direct dependencies (USB_GADGET_OMAP && ARCH_OMAP_OTG && USB_OHCI_HCD)
warning: (USB_MUSB_HDRC_HCD && USB_SUPPORT && USB_MUSB_HDRC && (USB_MUSB_HOST || USB_MUSB_OTG) && USB_GADGET_MUSB_HDRC || USB_MUSB_OTG && <choice> && USB && USB_GADGET && PM && EXPERIMENTAL) selects USB_OTG which has unmet direct dependencies (USB_GADGET_OMAP && ARCH_OMAP_OTG && USB_OHCI_HCD)
#
# configuration written to .config
#

Is there a patch to resolve this already?

Regards,
Sergio

