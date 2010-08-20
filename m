From: "Gadiyar, Anand" <gadiyar-l0cyMroinI0@public.gmane.org>
Subject: RE: [RFC] [PATCH 3/7] usb: ehci-omap: omap: Add OMAP4 support
Date: Fri, 20 Aug 2010 11:17:07 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB0324222B50@dbde02.ent.ti.com>
References: <1282175377-2784-1-git-send-email-keshava_mgowda@ti.com>
 <1282175377-2784-2-git-send-email-keshava_mgowda@ti.com>
 <1282175377-2784-3-git-send-email-keshava_mgowda@ti.com>
 <1282175377-2784-4-git-send-email-keshava_mgowda@ti.com>
 <20100820053844.GB15196@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100820053844.GB15196-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Content-Language: en-US
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org" <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, "Munegowda, Keshava" <keshava_mgowda-l0cyMroinI0@public.gmane.org>
Cc: "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Felipe Balbi wrote:
> On Thu, Aug 19, 2010 at 01:49:33AM +0200, ext Keshava Munegowda wrote:
> >@@ -298,7 +327,163 @@ static int omap_start_ehc(struct ehci_hc
> > 	}
> >
> > 	if (cpu_is_omap44xx()) {
> >-		/* TODO */
> 
> driver should never make use of cpu_is_omap* calls neither machine_is_* 
> for that matter. Driver shouldn't care about correct clock names either. 
> You need to find a better to handle differences between omap3 and omap4.
> 

The differences between OMAP3 and OMAP4 are:
- The OMAP4 has a different set of clocks which do not exist on OMAP3.
- The register bits for configuring port modes is different

For the clock handling:
One approach: On OMAP3, have a set of dummy clocks corresponding to the
per-port clocks on OMAP4. Then the driver wouldn't need to know which
SoC it is running on.

Another approach:
Have a different glue layer driver for OMAP4.

For the register bit differences, we do need to know which SoC we are
running on to be able to use the correct register bits. For this, 

One approach:
At the very minimum, we need a set of clocks to be enabled to be able to
read the UHH_REVISION register, and we could use that to figure out which
bits we need to use.

The other approach I can think of is to have platform data tell us (I'm
guessing this is a bad idea).

What do you think?

- Anand


--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
