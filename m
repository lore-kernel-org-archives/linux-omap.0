From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH] usb: musb: omap2430: fix build failure
Date: Wed, 13 Apr 2011 15:27:44 -0700
Message-ID: <20110413222744.GB32276@kroah.com>
References: <1302025834-25729-1-git-send-email-jhovold@gmail.com>
 <20110413170139.GA26264@localhost>
 <20110413172250.GH31113@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from kroah.org ([198.145.64.141]:53449 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933313Ab1DMW1v (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 13 Apr 2011 18:27:51 -0400
Content-Disposition: inline
In-Reply-To: <20110413172250.GH31113@legolas.emea.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Johan Hovold <jhovold@gmail.com>, Greg Kroah-Hartman <gregkh@suse.de>, Hema HK <hemahk@ti.com>, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org

On Wed, Apr 13, 2011 at 08:22:51PM +0300, Felipe Balbi wrote:
> Hi,
>=20
> On Wed, Apr 13, 2011 at 07:01:39PM +0200, Johan Hovold wrote:
> > On Tue, Apr 05, 2011 at 07:50:34PM +0200, Johan Hovold wrote:
> > > Fix build failure introduced by commit
> > > 7acc6197b76edd0b932a7cbcc6cfad0a8a87f026 (usb: musb: Idle path re=
tention
> > > and offmode support for OMAP3) when building without gadget
> > > support.
> > >=20
> > >   CC      drivers/usb/musb/omap2430.o
> > > drivers/usb/musb/omap2430.c: In function =E2=80=98musb_otg_notifi=
cations=E2=80=99:
> > > drivers/usb/musb/omap2430.c:262: error: =E2=80=98struct musb=E2=80=
=99 has no member named =E2=80=98gadget_driver=E2=80=99
> >=20
> > I noted that this one wasn't included in your pull-request today. J=
ust
> > thought I'd send a reminder as I haven't received any feedback.
>=20
> Sorry about that, I missed it from my queue. I'll add and send on a
> separate pull request. Thanks for the note.

I can pick it up right now.

thanks,

greg k-h
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
