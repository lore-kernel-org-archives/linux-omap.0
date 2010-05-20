From: Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 3/3 v2] musb: AM35x: Workaround for fifo read issue
Date: Thu, 20 May 2010 13:08:55 +0300
Message-ID: <20100520100855.GG9992@nokia.com>
References: <1274184586-28843-1-git-send-email-ajay.gupta@ti.com>
 <19F8576C6E063C45BE387C64729E7394044E535C95@dbde02.ent.ti.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB0322EAE899@dbde02.ent.ti.com>
 <20100520100630.GF9992@nokia.com>
Reply-To: felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20100520100630.GF9992-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Balbi Felipe (Nokia-D/Helsinki)" <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Cc: "ext Gadiyar, Anand" <gadiyar-l0cyMroinI0@public.gmane.org>, "Gupta, Ajay Kumar" <ajay.gupta-l0cyMroinI0@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "andrea.marson-0U1K5dsi4As@public.gmane.org" <andrea.marson-0U1K5dsi4As@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Thu, May 20, 2010 at 12:06:30PM +0200, Balbi Felipe (Nokia-D/Helsinki) wrote:
>arm-based only) boards and be sure it would work. We would just need to
>put something similar down for dma engines.

and of course, the same platform-code could instantiate a dma engine 
platform_device but that's trickier, I guess, since the base address 
would have to be used by two drivers, then platform code would have to 
handle synchronization.

-- 
balbi

DefectiveByDesign.org
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
