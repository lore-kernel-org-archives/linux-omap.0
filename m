From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [PATCH 09/10] usb: ehci: tegra: check against CONFIG_USB_PHY
Date: Thu, 07 Mar 2013 13:54:53 -0700
Message-ID: <5138FE9D.7040702@wwwdotorg.org>
References: <1362648969-13737-1-git-send-email-balbi@ti.com> <1362648969-13737-10-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1362648969-13737-10-git-send-email-balbi-l0cyMroinI0@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Cc: Linux USB Mailing List <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, cbou-JGs/UdohzUI@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 03/07/2013 02:36 AM, Felipe Balbi wrote:
> CONFIG_USB_OTG_UTILS will be removed very
> soon, so we should check CONFIG_USB_PHY
> instead.

The Tegra EHCI driver isn't very useful without the Tegra PHY driver.
Perhaps its Kconfig should simply "select USB_PHY", and the ifdefs be
removed rather than modified?
