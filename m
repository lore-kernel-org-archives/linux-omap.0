From: "Gadiyar, Anand" <gadiyar-l0cyMroinI0@public.gmane.org>
Subject: RE: [RFC] [PATCH 3/7] usb: ehci-omap: omap: Add OMAP4 support
Date: Fri, 20 Aug 2010 11:54:35 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB0324222B9B@dbde02.ent.ti.com>
References: <1282175377-2784-1-git-send-email-keshava_mgowda@ti.com>
 <1282175377-2784-2-git-send-email-keshava_mgowda@ti.com>
 <1282175377-2784-3-git-send-email-keshava_mgowda@ti.com>
 <1282175377-2784-4-git-send-email-keshava_mgowda@ti.com>
 <20100820053844.GB15196@nokia.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB0324222B50@dbde02.ent.ti.com>
 <20100820055204.GF15196@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100820055204.GF15196-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Content-Language: en-US
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org" <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Cc: "Munegowda, Keshava" <keshava_mgowda-l0cyMroinI0@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Felipe Balbi wrote:
> Hi,
> 
> On Fri, Aug 20, 2010 at 07:47:07AM +0200, ext Gadiyar, Anand wrote:
> >The differences between OMAP3 and OMAP4 are:
> >- The OMAP4 has a different set of clocks which do not exist 
> on OMAP3.
> >- The register bits for configuring port modes is different
> 
> is it a different ip core or just a modification of the previous ?
> 

Newer revision of the same core. But the revision registers have
completely different values. Good enough to distinguish between
the cores.

- Anand


--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
