From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [PATCH] omap: get rid of OMAP_TAG_USB
Date: Wed, 12 Nov 2008 13:47:21 +0200
Message-ID: <20081112114721.GC7467@gandalf.research.nokia.com>
References: <1222352531-30796-1-git-send-email-felipe.balbi@nokia.com> <1222352531-30796-2-git-send-email-felipe.balbi@nokia.com> <20081024215805.GD10733@gandalf.research.nokia.com> <200811112220.33960.david-b@pacbell.net>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:52575 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751522AbYKLLrx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 12 Nov 2008 06:47:53 -0500
Content-Disposition: inline
In-Reply-To: <200811112220.33960.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext David Brownell <david-b@pacbell.net>
Cc: felipe.balbi@nokia.com, linux-omap@vger.kernel.org, tony@atomide.com

On Tue, Nov 11, 2008 at 10:20:33PM -0800, David Brownell wrote:
> On Friday 24 October 2008, Felipe Balbi wrote:
> > > --- a/arch/arm/plat-omap/include/mach/usb.h
> > > +++ b/arch/arm/plat-omap/include/mach/usb.h
> > > @@ -29,6 +29,7 @@
> > > =A0
> > > =A0void __init usb_musb_init(void);
> > > =A0void __init usb_ehci_init(void);
> > > +void omap_usb_init(struct omap_usb_config *pdata);
> > > =A0
> > > =A0#endif
> > > =A0
>=20
> That "#endif" is for the !OMAP1 branch ... so this patch
> couldn't built on on any OMAP1 platform at all.  And for
> OSK, you put the USB init in with the Mistral-specific
> init ... but most OSKs don't connect to a Mistral.
>=20
> The following patch gets it to build OK for my OSK, but
> then omap_udc hit some new locking bug.  Sigh.

Thanks for testing, I'll review the patch again ;-)

--=20
balbi
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
