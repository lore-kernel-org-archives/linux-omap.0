From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH v2 2/3] usb: trivial Kconfig cleanups
Date: Wed, 20 Oct 2010 21:25:16 +0300
Message-ID: <20101020182516.GD3958@legolas.emea.dhcp.ti.com>
References: <1287482608-11320-1-git-send-email-felipe.contreras@gmail.com>
 <1287482608-11320-3-git-send-email-felipe.contreras@gmail.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1287482608-11320-3-git-send-email-felipe.contreras@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>, linux-main <linux-kernel@vger.kernel.org>, Greg KH <greg@kroah.com>, "Balbi, Felipe" <balbi@ti.com>, Tony Lindgren <tony@atomide.com>
List-Id: linux-omap@vger.kernel.org

On Tue, Oct 19, 2010 at 05:03:27AM -0500, Felipe Contreras wrote:
>Note: USB_GADGET_MUSB_HDRC is already defined in usb/gadget.
>
>Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
>---
> drivers/usb/core/Kconfig   |    3 ---
> drivers/usb/gadget/Kconfig |    2 +-
> drivers/usb/musb/Kconfig   |   17 ++++-------------

for drivers/usb/musb/Kconfig:

Acked-by: Felipe Balbi <balbi@ti.com>

-- 
balbi
