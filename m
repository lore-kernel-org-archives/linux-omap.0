From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [PATCH 2/3] usb: musb: fix compilation error in
	musb_platform_init
Date: Fri, 23 Jan 2009 12:29:42 +0200
Message-ID: <20090123102942.GS9233@scadufax.research.nokia.com>
References: <1231326846-22691-1-git-send-email-ajay.gupta@ti.com> <20090123101630.GN9233@scadufax.research.nokia.com> <200901230239.37353.david-b@pacbell.net>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:37069 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753514AbZAWKlk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 23 Jan 2009 05:41:40 -0500
Content-Disposition: inline
In-Reply-To: <200901230239.37353.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext David Brownell <david-b@pacbell.net>
Cc: felipe.balbi@nokia.com, ext Ajay Kumar Gupta <ajay.gupta@ti.com>, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org

On Fri, Jan 23, 2009 at 02:39:37AM -0800, David Brownell wrote:
> On Friday 23 January 2009, Felipe Balbi wrote:
> > > --- a/drivers/usb/musb/Kconfig
> > > +++ b/drivers/usb/musb/Kconfig
> > > @@ -11,6 +11,7 @@ config USB_MUSB_HDRC
> > > =A0=A0=A0=A0=A0=A0depends on (USB || USB_GADGET) && HAVE_CLK
> > > =A0=A0=A0=A0=A0=A0depends on !SUPERH
> > > =A0=A0=A0=A0=A0=A0select TWL4030_USB if MACH_OMAP_3430SDP
> > > +=A0=A0=A0=A0=A0select USB_OTG_UTILS if ARCH_OMAP34XX
> > > =A0=A0=A0=A0=A0=A0tristate 'Inventra Highspeed Dual Role Controll=
er (TI, ADI, ...)'
> > > =A0=A0=A0=A0=A0=A0help
> > > =A0=A0=A0=A0=A0=A0 =A0Say Y here if your system has a dual role h=
igh speed USB
>=20
> NAK -- not needed given my more-complete "another musb buildfix",
> which includes a non-conditional "select" for this.

ok, let's get yours in then

--=20
balbi
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
