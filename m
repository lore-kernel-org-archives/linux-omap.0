From: Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
Subject: Re: AW: USB problem on beagleboard clone
Date: Wed, 19 Sep 2012 16:07:29 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1209191557210.5264@utopia.booyaka.com>
References: <5448984682E7954C9BFF27F747A9C6CA56E33A@dolphin.TIGRIS.local>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5448984682E7954C9BFF27F747A9C6CA56E33A-pd0mJjIfunmL041gAgtUOYT4S9po1h25@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Maximilian Schwerin <Maximilian.Schwerin-Uf0zVKHSUsGzQB+pC5nmwQ@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Wed, 19 Sep 2012, Maximilian Schwerin wrote:

> They're BeagleBoard XM clones. We're still trying to find out what the 
> real problem is. The problem persists across three separate layouts 
> using the same USB device and application. We're currently trying to see 
> if this is related to MUSB only by using an EHCI port on the same board 
> with the same device and application.

Perhaps you might try this patch:

http://marc.info/?l=linux-omap&m=132976109928744&w=2

Background is here:

http://comments.gmane.org/gmane.linux.ports.arm.omap/71633

The patch is for an EHCI issue, but MUSB is clocked from the same DPLL.


- Paul
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
