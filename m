From: "Subbrathnam, Swaminathan" <swami.iyer-l0cyMroinI0@public.gmane.org>
Subject: RE: Patch [2/2] DaVinci CPPI TX DMA tasklet
Date: Fri, 22 Aug 2008 14:42:31 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC3560870229E8162A@dbde02.ent.ti.com>
References: <48AD8526.8080206@gmail.com>
 <FCCFB4CDC6E5564B9182F639FC3560870229F52485@dbde02.ent.ti.com>
 <20080822072308.GB9474@gandalf.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20080822072308.GB9474-f9ZlEuEWxVfta4EC/59zMBl4MBrZKKet0E9HWUfgJXw@public.gmane.org>
Content-Language: en-US
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org" <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Cc: Dmitry Krivoschekov <dmitry.krivoschekov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Felipe,
< afaict, endpoint interrupt is generated case we get a short packet. Then
< dma engine won't send that last short packet and an enpoint interrupt
< will be generated, from that point you decide if you wanna use PIO or
< reprogram the dma for mode 0.
	
DaVinci CPPI TX DMA requires operating in Mode 1 and only DMA interrupts are raised and endpoint interrupts are not raised (excepting under error conditions).


Regards

Swami

(Type "pspproducts" in you web browser for PSP info)

http://dbdwss01.india.ti.com/pspproducts/

PSP downloads at : http://software.ti.com/swcoe/intranet/reports/pds/PSP_releases.php

Office : +91-80-25048629

-----Original Message-----
From: Felipe Balbi [mailto:felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org] 
Sent: Friday, August 22, 2008 12:53 PM
To: Subbrathnam, Swaminathan
Cc: Dmitry Krivoschekov; linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org
Subject: Re: Patch [2/2] DaVinci CPPI TX DMA tasklet

On Fri, Aug 22, 2008 at 07:01:26AM +0530, ext Subbrathnam, Swaminathan wrote:
> <Swami> When in DMA mode (mode 1) Endpoint interrupt does not get
> generated (only DMA completion interrupt) and hence cannot rely on that.

afaict, endpoint interrupt is generated case we get a short packet. Then
dma engine won't send that last short packet and an enpoint interrupt
will be generated, from that point you decide if you wanna use PIO or
reprogram the dma for mode 0.

-- 
balbi

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
