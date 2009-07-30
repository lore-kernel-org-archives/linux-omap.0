From: "Pandita, Vikram" <vikram.pandita@ti.com>
Subject: RE: drivers that require headers in mach-omap
Date: Thu, 30 Jul 2009 21:14:48 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC35608702F58506D2@dbde02.ent.ti.com>
References: <8bb80c380907281849i1cd271f3n64a391327cd8bb5e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:55499 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751851AbZG3PpC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 30 Jul 2009 11:45:02 -0400
In-Reply-To: <8bb80c380907281849i1cd271f3n64a391327cd8bb5e@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mike Chan <mike@android.com>, Kevin Hilman <khilman@deeprootsystems.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


>-----Original Message-----
>From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Mike
>Chan
>Sent: Tuesday, July 28, 2009 8:49 PM
>To: Kevin Hilman; linux-omap@vger.kernel.org
>Subject: drivers that require headers in mach-omap
>
>Omap folks, how are drivers that require access to prm and cm
>registers via cm_read_mod_reg() etc... suppose to access these?
>
>For example if drivers/usb/host/ohci-omap.c wanted to call:
>cm_read_mod_reg(OMAP3430ES2_USBHOST_MOD, CM_IDLEST);

The design was supposed to encapsulate the PRCM API's from drivers.
Driver has control over the iclk and fclk and the clock framework would take care of any CM/PRM register settings.

Accessing these registers in drivers would make the driver non-compatible for non-omap platforms.

>
>It seems some of the headers in mach-omap2 should be in
>plat-omap/include/mach, or is there a more elegant way? The other
>alternatives are to register calls in all the board files, or #include
>../../.. both do not seem very elegant to me.
>
>-- Mike
>--
>To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html

