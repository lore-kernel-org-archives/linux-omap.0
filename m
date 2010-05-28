From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH 1/3 v3] AM35x: Add musb support
Date: Fri, 28 May 2010 07:41:22 -0700 (PDT)
Message-ID: <579055.3526.qm@web180308.mail.gq1.yahoo.com>
References: <4BFFCE8C.40909@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4BFFCE8C.40909-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>, Sergei Shtylyov <sshtylyov-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org



--- On Fri, 5/28/10, Sergei Shtylyov <sshtylyov-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org> wrote:
> 
> Ajay Kumar Gupta wrote:
> 
> > AM35x has musb interface (version 1.8) and uses CPPI41
> DMA engine.
> > It has USB phy built inside the IP itself.

So it's more like DaVinci (earlier CPPI as well as
integrated PHY) than OMAP3...

> > Also added ARCH_AM35x which is required to
> differentiate musb ips
> > between OMAP3x and AM35x. 

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
