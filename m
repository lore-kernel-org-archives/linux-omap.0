From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [RFC] [PATCH 6/7] usb: ehci: Introduce
 CONFIG_USB_EHCI_HCD_OMAP3
Date: Fri, 20 Aug 2010 12:13:37 +0300
Message-ID: <20100820091336.GC31377@nokia.com>
References: <1282175377-2784-2-git-send-email-keshava_mgowda@ti.com>
 <1282175377-2784-3-git-send-email-keshava_mgowda@ti.com>
 <1282175377-2784-4-git-send-email-keshava_mgowda@ti.com>
 <1282175377-2784-5-git-send-email-keshava_mgowda@ti.com>
 <1282175377-2784-6-git-send-email-keshava_mgowda@ti.com>
 <1282175377-2784-7-git-send-email-keshava_mgowda@ti.com>
 <20100820054507.GE15196@nokia.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB0324222B65@dbde02.ent.ti.com>
 <20100820061322.GG15196@nokia.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB0324222BA9@dbde02.ent.ti.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:52555 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751397Ab0HTJOE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 20 Aug 2010 05:14:04 -0400
Content-Disposition: inline
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB0324222BA9@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Gadiyar, Anand" <gadiyar@ti.com>
Cc: "Balbi Felipe (Nokia-MS/Helsinki)" <felipe.balbi@nokia.com>, "Munegowda, Keshava" <keshava_mgowda@ti.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Fri, Aug 20, 2010 at 08:32:04AM +0200, ext Gadiyar, Anand wrote:
>We have the ability to support OMAP2 and OMAP3 in the same kernel
>image (for example when you build with omap3_defconfig).
>
>So USB_ARCH_HAS_EHCI will get selected due to OMAP3 being present.
>
>However, no platform devices will be registered in the OMAP2 board files,
>so this should be okay (will try this on OMAP2 to check).

correct :-) so it shouldn't be a problem the driver won't try to probe.

-- 
balbi

DefectiveByDesign.org
