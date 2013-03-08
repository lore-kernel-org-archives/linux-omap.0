From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [PATCH 00/10] usb: phy: cleanups to Kconfig and directories
Date: Fri, 8 Mar 2013 23:08:31 +0000
Message-ID: <201303082308.31499.arnd@arndb.de>
References: <1362648969-13737-1-git-send-email-balbi@ti.com> <20130308182623.GD900@arwen.pp.htv.fi> <513A2FDD.2040800@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <513A2FDD.2040800-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Cc: balbi-l0cyMroinI0@public.gmane.org, Linux USB Mailing List <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, cbou-JGs/UdohzUI@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Friday 08 March 2013, Stephen Warren wrote:
> Yes, I think it should instead work like:
> 
> ARCH_TEGRA* selects nothing in particular related to USB.
> 
> The Tegra EHCI controller Kconfig depends on ARCH_TEGRA so it doesn't
> show up for other builds.

Yes, that's fine.

> I hope it's OK for the EHCI controller to select USB_ARCH_HAS_EHCI?

I think that would create a circular dependency, which Kconfig will
refuse. We talked about the USB_ARCH_HAS_* Kconfig symbols recently
and Alan Stern agreed to my suggestion of removing all of them,
reworking the logic so we can always enable USB and EHCI but even
when there is no bus glue enabled.

I'll have to do a proper patch one of these days, or find someone in
my team to do it right for all the corner cases.

> The Tegra PHY Kconfig probably shouldn't be user-visible (relying on
> being selected by the Tegra EHCI controller) and itself selects
> anything it relies on.
> 
> Does that sound reasonable?

It is often safer to express the logic using "depends on" than using
"select", e.g. doing

config USB_EHCI_TEGRA
	bool "EHCI support for NVIDIA Tegra"
	depends on USB_EHCI_HCD
	depends on ARCH_TEGRA

config USB_ULPI_VIEWPORT
	def_bool y
	depends on USB_EHCI_TEGRA

If USB_ULPI_VIEWPORT has any other dependencies, the best solution
in the above scenario is to make USB_EHCI_TEGRA depend on those.

	Arnd
