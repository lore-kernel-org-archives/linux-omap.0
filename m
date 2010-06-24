From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [PATCH 2/8] MUSB: make non-OMAP platforms build with
 CONFIG_PM=y
Date: Thu, 24 Jun 2010 09:02:24 +0300
Message-ID: <20100624060224.GE8078@nokia.com>
References: <1276771242-5201-1-git-send-email-ajay.gupta@ti.com>
 <1276771242-5201-2-git-send-email-ajay.gupta@ti.com>
 <1276771242-5201-3-git-send-email-ajay.gupta@ti.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:30330 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753005Ab0FXGEv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Jun 2010 02:04:51 -0400
Content-Disposition: inline
In-Reply-To: <1276771242-5201-3-git-send-email-ajay.gupta@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Ajay Kumar Gupta <ajay.gupta@ti.com>
Cc: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Balbi Felipe (Nokia-D/Helsinki)" <felipe.balbi@nokia.com>, "gregkh@suse.de" <gregkh@suse.de>, Sergei Shtylyov <sshtylyov@ru.mvista.com>

On Thu, Jun 17, 2010 at 12:40:35PM +0200, ext Ajay Kumar Gupta wrote:
>From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
>
>Attempt to build MUSB driver with CONFIG_PM=y (e.g. in the OTG mode) on DaVinci
>results in these link errors:
>
>drivers/built-in.o: In function `musb_restore_context':
>led-triggers.c:(.text+0x714d8): undefined reference to
>`musb_platform_restore_context'
>drivers/built-in.o: In function `musb_save_context':
>led-triggers.c:(.text+0x71788): undefined reference to
>`musb_platform_save_context'
>
>This turned out to be caused by commit 9957dd97ec5e98dd334f87ade1d9a0b24d1f86eb
>(usb: musb: Fix compile error for omaps for musb_hdrc). Revert it, taking into
>account the rename of CONFIG_ARCH_OMAP34XX into CONFIG_ARCH_OMAP3 (which that
>commit fixed in a completely inappropriate way) and the recent addition of
>OMAP4 support.
>
>Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
>Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>

Acked-by: Felipe Balbi <felipe.balbi@nokia.com>
-- 
balbi

DefectiveByDesign.org
