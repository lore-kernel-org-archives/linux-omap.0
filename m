From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH v2 3/3] drivers: cleanup Kconfig stuff
Date: Wed, 20 Oct 2010 15:54:07 +0300
Message-ID: <20101020125407.GE2433@legolas.emea.dhcp.ti.com>
References: <1287482608-11320-1-git-send-email-felipe.contreras@gmail.com>
 <1287482608-11320-4-git-send-email-felipe.contreras@gmail.com>
 <4CBD9FD5.506@nokia.com>
 <AANLkTinRRyrXzqEu=u+CCYkmSNGm03SSo1tVG=5_wdpo@mail.gmail.com>
 <4CBE9E69.6060803@nokia.com>
 <AANLkTinOYDBMVZ3ibG3Md7jdOuOC6NkGWaugvHwT6uqF@mail.gmail.com>
 <4CBEB312.7060400@nokia.com>
 <AANLkTikom=eRFqCJmYE+k1zn5K2MR9s8HhNXtjOvUqvr@mail.gmail.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <AANLkTikom=eRFqCJmYE+k1zn5K2MR9s8HhNXtjOvUqvr@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: Roger Quadros <roger.quadros@nokia.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>, linux-main <linux-kernel@vger.kernel.org>, Greg KH <greg@kroah.com>, "Balbi, Felipe" <balbi@ti.com>, Tony Lindgren <tony@atomide.com>
List-Id: linux-omap@vger.kernel.org

On Wed, Oct 20, 2010 at 04:23:13AM -0500, Felipe Contreras wrote:
>Ok, but USB_OMAP is not supposed to work on the N900? (I tried and it didn't)

ooooh, that's old. That's from the omap1. It's the old omap_udc.c

>I don't think so, because people might not want USB at all. The ideal
>case would be for USB_GADGET_MUSB_HDRC to be selected automatically
>when the user selects USB and USB_GADGET, but that's not happening
>because USB_GADGET_OMAP is selected first (all the dependencies are
>met).

And how is that different from:

default y if ARCH_OMAP3 ? If you don't want USB at all, you'll disable
it by hand, the default is on. Select on board Kconfig.

-- 
balbi
