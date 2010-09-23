From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 1/9 v3] usb: musb: Adding names for IRQs in resource
 structure
Date: Thu, 23 Sep 2010 09:10:22 +0300
Message-ID: <20100923061022.GA2563@legolas.emea.dhcp.ti.com>
References: <1285201631-26266-1-git-send-email-hemahk@ti.com>
Reply-To: balbi-l0cyMroinI0@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1285201631-26266-1-git-send-email-hemahk-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Kalliguddi, Hema" <hemahk-l0cyMroinI0@public.gmane.org>
Cc: "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Balbi, Felipe" <balbi-l0cyMroinI0@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>, "Cousson, Benoit" <b-cousson-l0cyMroinI0@public.gmane.org>, Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Wed, Sep 22, 2010 at 07:27:11PM -0500, Kalliguddi, Hema wrote:
>Modified the Omap,Blackfin and Davinci board files to add the name of the IRQs
>in the resource structures and musb driver to use the get_irq_byname() api to
>get the mc and dma irq numbers instead of using the index as the order of
>resource definition need not be always in order of device interrupt and
>then dma interrupt
>
>Signed-off-by: Hema HK <hemahk-l0cyMroinI0@public.gmane.org>
>Cc: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
>Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
>Cc: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
>Cc: Cousson, Benoit <b-cousson-l0cyMroinI0@public.gmane.org>
>Cc: Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>

this is fine by me, but you need to Cc the other ARCH maintainers, Tony
can answer for OMAP and Kevin for DaVinci, but where's Blackfin's
maintainer ? Without all theirs ACKs for the arch-specific part, I can't
queue this to .37 and it's already quite late. If we don't get all
needed Acks by tomorrow, I doubt Greg will accept these for .37 merge
window.

-- 
balbi
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
