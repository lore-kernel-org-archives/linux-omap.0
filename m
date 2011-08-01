From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [RFC/PATCH 7/7] WIP: HACK/RFC: omap_device: begin to decouple
	platform_device from omap_device
Date: Mon, 1 Aug 2011 21:07:43 +0100
Message-ID: <20110801200743.GA21535@n2100.arm.linux.org.uk>
References: <1311292338-11830-1-git-send-email-khilman@ti.com> <1311292338-11830-9-git-send-email-khilman@ti.com> <20110730120332.GA15539@n2100.arm.linux.org.uk> <20110731025807.GA24334@ponder.secretlab.ca> <20110731150540.GA3019@n2100.arm.linux.org.uk> <871ux5nnop.fsf@ti.com> <CACxGe6t4tNeD-Pn6WFt1XOMC=_Q0cf4uD3kRkOckKH+S1JUJDA@mail.gmail.com> <20110801185009.GA5217@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:42258 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752821Ab1HAUIA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 1 Aug 2011 16:08:00 -0400
Content-Disposition: inline
In-Reply-To: <20110801185009.GA5217@legolas.emea.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Grant Likely <grant.likely@secretlab.ca>, Kevin Hilman <khilman@ti.com>, linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, "G. Manjunath Kondaiah" <manjugk@ti.com>, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org

On Mon, Aug 01, 2011 at 09:50:09PM +0300, Felipe Balbi wrote:
> Hi,
>=20
> On Mon, Aug 01, 2011 at 04:44:20PM +0100, Grant Likely wrote:
> > On Mon, Aug 1, 2011 at 4:42 PM, Kevin Hilman <khilman@ti.com> wrote=
:
> > > diff --git a/arch/arm/include/asm/device.h b/arch/arm/include/asm=
/device.h
> > > index 9f390ce..bb777cd 100644
> > > --- a/arch/arm/include/asm/device.h
> > > +++ b/arch/arm/include/asm/device.h
> > > @@ -13,6 +13,7 @@ struct dev_archdata {
> > > =A0};
> > >
> > > =A0struct pdev_archdata {
> > > + =A0 =A0 =A0 void *p;
> > > =A0};
> >=20
> > struct omap_device *p;
> >=20
> > Otherwise it is just asking for type safety problems.
>=20
> considering that struct omap_device isn't ARM-wide, is it really wise=
 to
> to do that ? I guess a void * will do better here.

Help the typechecker do its job.  As we have only one (at the moment...=
)
And make it:

+struct omap_device;

 struct pdev_archdata {
+#ifdef CONFIG_ARCH_OMAP
+	struct omap_device *omap;
+#endif
 };

for bonus points, so we only get the additional pointer for OMAP.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
