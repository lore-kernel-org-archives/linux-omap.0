From: "Dasgupta, Romit" <romit@ti.com>
Subject: RE: Memory performance / Cache problem
Date: Mon, 12 Oct 2009 14:37:56 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301DDE1FF1D@dbde02.ent.ti.com>
References: <20091012083806.323990@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:52802 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755259AbZJLJIj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 12 Oct 2009 05:08:39 -0400
In-Reply-To: <20091012083806.323990@gmx.net>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "epsi@gmx.de" <epsi@gmx.de>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Please update to the latest HEAD on the linux-omap pm branch. In the gitweb it shows
b7ecc865c5f0885fae4c4401fa78a24084f45c40

Thanks,
-Romit


>-----Original Message-----
>From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
>owner@vger.kernel.org] On Behalf Of epsi@gmx.de
>Sent: Monday, October 12, 2009 2:08 PM
>To: linux-omap@vger.kernel.org
>Subject: RE: Memory performance / Cache problem
>
>Linux version 2.6.31 (star@localhost) (gcc version 4.3.3 (Sourcery G++ Lite 2009q1-
>203) ) #1 Mon Oct 12 08:30:58 CEST 2009
>CPU: ARMv7 Processor [411fc082] revision 2 (ARMv7), cr=10c53c7f
>CPU: VIPT nonaliasing data cache, VIPT nonaliasing instruction cache
>Machine: OMAP3 EVM
>Memory policy: ECC disabled, Data cache writeback
>OMAP3430 ES2.1
>SRAM: Mapped pa 0x40200000 to va 0xe3000000 size: 0x100000
>Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 32512
>
>I see, you get the message about L2 Cache, which I don't have
>Do you know how to enable this?
>Shoudn't the kernel configure all this things - not rely on bootloader?
>I am using the U-Boot 2008.10 (TIs PSP)
>The old 22 kernel is independet from the uboot in this issue.
>
>Thanks
>Steffen
>--
>Jetzt kostenlos herunterladen: Internet Explorer 8 und Mozilla Firefox 3.5 -
>sicherer, schneller und einfacher! http://portal.gmx.net/de/go/atbrowser
>--
>To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html

