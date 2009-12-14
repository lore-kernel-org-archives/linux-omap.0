From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [PATCH 3/3] musb: Add 'extvbus' in musb_hdrc_platform_data
Date: Mon, 14 Dec 2009 18:37:46 +0200
Message-ID: <20091214163746.GC31829@nokia.com>
References: <1260797982-28880-1-git-send-email-ajay.gupta@ti.com>
 <1260797982-28880-2-git-send-email-ajay.gupta@ti.com>
 <1260797982-28880-3-git-send-email-ajay.gupta@ti.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:50202 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751486AbZLNQiW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 14 Dec 2009 11:38:22 -0500
Content-Disposition: inline
In-Reply-To: <1260797982-28880-3-git-send-email-ajay.gupta@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Ajay Kumar Gupta <ajay.gupta@ti.com>
Cc: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Balbi Felipe (Nokia-D/Helsinki)" <felipe.balbi@nokia.com>, "david-b@pacbell.net" <david-b@pacbell.net>

Hi,

On Mon, Dec 14, 2009 at 02:39:42PM +0100, ext Ajay Kumar Gupta wrote:
>diff --git a/drivers/usb/musb/musb_regs.h b/drivers/usb/musb/musb_regs.h
>index 8ca8f23..cba724d 100644
>--- a/drivers/usb/musb/musb_regs.h
>+++ b/drivers/usb/musb/musb_regs.h
>@@ -72,6 +72,10 @@
> #define MUSB_DEVCTL_HR		0x02
> #define MUSB_DEVCTL_SESSION	0x01
>
>+/* ULPI VBUSCONTROL */
>+#define ULPI_USE_EXTVBUS	0x01
>+#define ULPI_USE_EXTVBUSIND	0x02

shouldn't these go to drivers/usb/otg/ulpi.c or include/usb/ulpi.h ?

or is this musb specific ?? If it's musb specific, please prepend with 
MUSB_

-- 
balbi
