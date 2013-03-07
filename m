From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [PATCH 00/10] usb: phy: cleanups to Kconfig and directories
Date: Thu, 07 Mar 2013 14:20:36 -0700
Message-ID: <513904A4.7040101@wwwdotorg.org>
References: <1362648969-13737-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1362648969-13737-1-git-send-email-balbi-l0cyMroinI0@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Cc: Linux USB Mailing List <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, cbou-JGs/UdohzUI@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 03/07/2013 02:35 AM, Felipe Balbi wrote:
> Hi folks,
> 
> inspired by Paul's DWC2 patchset which added usb_otg_state_string()
> (a copy of otg_state_string()) I have now renamed otg_state_string()
> to usb_otg_state_string(), moved it to usb-common, then moved all
> phy drivers to drivers/usb/phy/ and completely deleted the otg directory.
> 
> We're also removing CONFIG_USB_OTG_UTILS since that has lots its
> meaning long ago.
> 
> I have compiled all patches with allyes, allno and allmod configs,
> but please make sure to test on your platforms to make sure we're
> not leaking any more problems to mainline.

What branch do the patches apply to? They didn't "git am" for me on
either next-20130305, nor
git://git.kernel.org/pub/scm/linux/kernel/git/balbi/usb.git next.
