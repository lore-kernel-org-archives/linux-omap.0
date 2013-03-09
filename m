From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [PATCH 00/10] usb: phy: cleanups to Kconfig and directories
Date: Fri, 08 Mar 2013 17:10:52 -0700
Message-ID: <513A7E0C.3060904@wwwdotorg.org>
References: <1362648969-13737-1-git-send-email-balbi@ti.com> <201303082308.31499.arnd@arndb.de> <513A72E8.2070707@wwwdotorg.org> <201303082356.35033.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <201303082356.35033.arnd-r2nGTMty4D4@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Cc: balbi-l0cyMroinI0@public.gmane.org, Linux USB Mailing List <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, cbou-JGs/UdohzUI@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 03/08/2013 04:56 PM, Arnd Bergmann wrote:
> On Friday 08 March 2013, Stephen Warren wrote:
>>> config USB_ULPI_VIEWPORT
>>>       def_bool y
>>>       depends on USB_EHCI_TEGRA
>>>
>>> If USB_ULPI_VIEWPORT has any other dependencies, the best solution
>>> in the above scenario is to make USB_EHCI_TEGRA depend on those.
>>
>> USB_ULPI_VIEWPORT is, AFAIK, a generic piece of infra-structure that
>> USB_EHCI_TEGRA depends upon.
> 
> Sorry, I was probably confusing the symbol names. I meant whatever
> you were going to "select" from USB_EHCI_TEGRA.

Ah OK, that'd be the Tegra PHY driver. Except now that I look, it
doesn't actually have its own Kconfig symbol (the Makefile builds it if
the Tegra EHCI driver is enabled). Perhaps it should? Otherwise, I guess
the Tegra EHCI driver Kconfig symbol would just have to depend on
everything that it and the PHY driver depend on.
