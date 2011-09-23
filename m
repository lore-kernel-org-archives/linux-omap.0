From: "Munegowda, Keshava" <keshava_mgowda@ti.com>
Subject: Re: [PATCH 1/5 v11] arm: omap: usb: ehci and ohci hwmod structures
 for omap4
Date: Fri, 23 Sep 2011 17:00:47 +0530
Message-ID: <CAP05o4+DT8hL8A_e6WBpV9ptZ4XYYKgM=UQa8uiRH2ox6ZP-4A@mail.gmail.com>
References: <1316691479-1849-1-git-send-email-keshava_mgowda@ti.com>
	<1316691479-1849-2-git-send-email-keshava_mgowda@ti.com>
	<alpine.DEB.2.00.1109221213500.10719@utopia.booyaka.com>
	<4E7B8C68.7020407@ti.com>
	<alpine.DEB.2.00.1109221524560.10719@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog124.obsmtp.com ([74.125.149.151]:40116 "EHLO
	na3sys009aog124.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753425Ab1IWLas convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 23 Sep 2011 07:30:48 -0400
In-Reply-To: <alpine.DEB.2.00.1109221524560.10719@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "Cousson, Benoit" <b-cousson@ti.com>, "parthab@india.ti.com" <parthab@india.ti.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Balbi, Felipe" <balbi@ti.com>, "Gadiyar, Anand" <gadiyar@ti.com>, "sameo@linux.intel.com" <sameo@linux.intel.com>, "tony@atomide.com" <tony@atomide.com>, "Hilman, Kevin" <khilman@ti.com>, "johnstul@us.ibm.com" <johnstul@us.ibm.com>, "Sripathy, Vishwanath" <vishwanath.bs@ti.com>

> So I'd suggest one of two approaches:
>
> 1. If the pin muxing can follow the PM runtime status of the UHH IP b=
lock,
> =A0 then the pin mux data should be associated with the UHH hwmod.


No, the mux is applicable only to ehci and ohci , where as
sysconfig is applicable to uhh ( usb_host_hs class).


> 2. If the pin muxing must follow the EHCI/OHCI IP block PM runtime st=
atus,
> =A0 then drivers/mfd/omap-usb-host.c is what should be handling the
> =A0 remuxing. =A0omap-usb-host.c can set the dev_pm_ops of the EHCI/O=
HCI
> =A0 platform_devices to point to functions either in
> =A0 arch/arm/mach-omap2/usb-host.c, or local functions that call into
> =A0 mach-omap2/usb-host.c functions to handle pin remuxing. =A0(Those
> =A0 function pointers should be provided to the MFD driver in some cl=
ean way,
> =A0 like via platform_data.)

The dev_pm_ops of ehci should exist in  /drivers/usb/host/ehci-omap.c a=
nd
dev_pm_ops of phci should exist in  /drivers/usb/host/ohci-omap3.c.
In the existing design, the omap-usb-host.c host can not access the
platform driver
of ehci and ohci.
But, through function pointers it is possible to send the platform
data to ehci and ohci
drivers to handle pin remuxing; but we will not able to use tero's
patches; and it will prevent
our future design activity for remote wakeup of ehci and ohci.

please let me know if you have thoughts on this.


Regards
Keshava
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
