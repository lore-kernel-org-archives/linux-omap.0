From: "Shilimkar, Santosh" <santosh.shilimkar-l0cyMroinI0@public.gmane.org>
Subject: RE: [RFC] [PATCH 3/7] usb: ehci-omap: omap: Add OMAP4 support
Date: Fri, 20 Aug 2010 11:31:59 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02C6722F44@dbde02.ent.ti.com>
References: <1282175377-2784-1-git-send-email-keshava_mgowda@ti.com>
 <1282175377-2784-2-git-send-email-keshava_mgowda@ti.com>
 <1282175377-2784-3-git-send-email-keshava_mgowda@ti.com>
 <1282175377-2784-4-git-send-email-keshava_mgowda@ti.com>
 <20100820053844.GB15196@nokia.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB0324222B50@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB0324222B50-/tLxBxkBPtCIQmiDNMet8wC/G2K4zDHf@public.gmane.org>
Content-Language: en-US
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Gadiyar, Anand" <gadiyar-l0cyMroinI0@public.gmane.org>, "felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org" <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, "Munegowda, Keshava" <keshava_mgowda-l0cyMroinI0@public.gmane.org>, "Cousson, Benoit" <b-cousson-l0cyMroinI0@public.gmane.org>, paul@pwsan.
Cc: "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

+ Benoit, Paul
> -----Original Message-----
> From: linux-omap-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org [mailto:linux-omap-
> owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org] On Behalf Of Gadiyar, Anand
> Sent: Friday, August 20, 2010 11:17 AM
> To: felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org; Munegowda, Keshava
> Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Subject: RE: [RFC] [PATCH 3/7] usb: ehci-omap: omap: Add OMAP4 support
> 
> Felipe Balbi wrote:
> > On Thu, Aug 19, 2010 at 01:49:33AM +0200, ext Keshava Munegowda wrote:
> > >@@ -298,7 +327,163 @@ static int omap_start_ehc(struct ehci_hc
> > > 	}
> > >
> > > 	if (cpu_is_omap44xx()) {
> > >-		/* TODO */
> >
> > driver should never make use of cpu_is_omap* calls neither machine_is_*
> > for that matter. Driver shouldn't care about correct clock names either.
> > You need to find a better to handle differences between omap3 and omap4.
> >
> 
> The differences between OMAP3 and OMAP4 are:
> - The OMAP4 has a different set of clocks which do not exist on OMAP3.
> - The register bits for configuring port modes is different
> 
> For the clock handling:
> One approach: On OMAP3, have a set of dummy clocks corresponding to the
> per-port clocks on OMAP4. Then the driver wouldn't need to know which
> SoC it is running on.
> 
One similar problem was with GFX between OMAP4 versions. The clock
tree was completely different. Even DSS on OMAP3 and OMAP4 has different
clock tree.
Paul and Benoit suggested that this can be handled within the framework.
I know USB is a special case because of different scenario's has different
clock needs.

You can list down the problems here. May be we can handle this in
a more generic way using the frameworks rather than glue layer.

Regards,
Santosh
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
