From: Joel Fernandes <joelf@ti.com>
Subject: Re: Regression 3.11-rc1: omap4panda: no usb and consequently no ethernet
Date: Thu, 25 Jul 2013 22:00:43 -0500
Message-ID: <51F1E65B.4020005@ti.com>
References: <51E7AA24.6080600@broadcom.com> <51E7CEF3.5000408@ti.com> <51E7D080.6070401@broadcom.com> <51E7D1D2.1060006@ti.com> <51E7E1B7.6090104@broadcom.com> <51E7E2AD.8020106@ti.com> <51F122D5.80205@broadcom.com> <51F1E39D.2030902@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:58468 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757109Ab3GZDAy (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 25 Jul 2013 23:00:54 -0400
In-Reply-To: <51F1E39D.2030902@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: joelf@ti.com
Cc: Arend van Spriel <arend@broadcom.com>, Roger Quadros <rogerq@ti.com>, tony@atomide.com, linux-omap@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On 07/25/2013 09:49 PM, Joel Fernandes wrote:

[..]

>> Can I get back on this topic. When USB and ethernet was working for me
>> as stated above, I was not doing tftpboot. When I use tftpboot the
>> images are obtained from the tftp server, but after kernel has started
>> there is nothing in /sys/bus/usb/devices/.
> 
> I quickly tried 3.11-rc2 + Roger's USB PHY clock patch on omap4-panda-es
> and enabled following USB options:
> 
> CONFIG_USB_MUSB_HDRC=y
> CONFIG_USB_PHY=y
> CONFIG_OMAP_USB2=y
> CONFIG_OMAP_CONTROL_USB=y
> CONFIG_USB_MUSB_OMAP2PLUS=y
> CONFIG_MFD_OMAP_USB_HOST=y
> CONFIG_USB_EHCI_HCD=y
> CONFIG_USB_OHCI_HCD=y
> CONFIG_USB_EHCI_HCD_OMAP=y

Sorry I missed saying I also set had to set CONFIG_NOP_USB_XCEIV=y


Thanks,

-Joel

