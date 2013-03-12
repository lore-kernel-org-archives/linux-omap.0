From: kishon <kishon@ti.com>
Subject: Re: [PATCH 2/7] usb: otg: twl4030-usb: ignore duplicate events
Date: Tue, 12 Mar 2013 19:02:33 +0530
Message-ID: <513F2E71.7020502@ti.com>
References: <1362877681-8102-1-git-send-email-notasas@gmail.com> <1362877681-8102-3-git-send-email-notasas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:59530 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754149Ab3CLNdY (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 12 Mar 2013 09:33:24 -0400
In-Reply-To: <1362877681-8102-3-git-send-email-notasas@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, Felipe Balbi <balbi@ti.com>, NeilBrown <neilb@suse.de>

Hi,

On Sunday 10 March 2013 06:37 AM, Grazvydas Ignotas wrote:
> In some rare cases we may get multiple interrupts that will generate
> duplicate omap_musb_mailbox() calls. This is a problem because each
> VBUS/ID event generates runtime_pm call in OMAP glue code, causing
> unbalanced gets or puts and breaking PM.

Did you actually observed multiple interrupts? Actually we thought 
debouncing should be handled in hardware.
>
> The same goes for initial state, glue already defaults to "no cable"
> state, so only bother it if we have VBUS or ID.
>
> Signed-off-by: Grazvydas Ignotas <notasas@gmail.com>
Reviewed-by: Kishon Vijay Abraham I <kishon@ti.com>

Thanks
Kishon
