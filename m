From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] usb: musb: omap2430: fix build failure
Date: Thu, 14 Apr 2011 13:34:10 +0300
Message-ID: <20110414103409.GD14319@legolas.emea.dhcp.ti.com>
References: <1302025834-25729-1-git-send-email-jhovold@gmail.com>
 <20110413170139.GA26264@localhost>
 <20110413172250.GH31113@legolas.emea.dhcp.ti.com>
 <20110413222744.GB32276@kroah.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog106.obsmtp.com ([74.125.149.77]:39321 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758702Ab1DNKeP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 14 Apr 2011 06:34:15 -0400
Content-Disposition: inline
In-Reply-To: <20110413222744.GB32276@kroah.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: Felipe Balbi <balbi@ti.com>, Johan Hovold <jhovold@gmail.com>, Greg Kroah-Hartman <gregkh@suse.de>, Hema HK <hemahk@ti.com>, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org

On Wed, Apr 13, 2011 at 03:27:44PM -0700, Greg KH wrote:
> On Wed, Apr 13, 2011 at 08:22:51PM +0300, Felipe Balbi wrote:
> > Hi,
> >=20
> > On Wed, Apr 13, 2011 at 07:01:39PM +0200, Johan Hovold wrote:
> > > On Tue, Apr 05, 2011 at 07:50:34PM +0200, Johan Hovold wrote:
> > > > Fix build failure introduced by commit
> > > > 7acc6197b76edd0b932a7cbcc6cfad0a8a87f026 (usb: musb: Idle path =
retention
> > > > and offmode support for OMAP3) when building without gadget
> > > > support.
> > > >=20
> > > >   CC      drivers/usb/musb/omap2430.o
> > > > drivers/usb/musb/omap2430.c: In function =E2=80=98musb_otg_noti=
fications=E2=80=99:
> > > > drivers/usb/musb/omap2430.c:262: error: =E2=80=98struct musb=E2=
=80=99 has no member named =E2=80=98gadget_driver=E2=80=99
> > >=20
> > > I noted that this one wasn't included in your pull-request today.=
 Just
> > > thought I'd send a reminder as I haven't received any feedback.
> >=20
> > Sorry about that, I missed it from my queue. I'll add and send on a
> > separate pull request. Thanks for the note.
>=20
> I can pick it up right now.

Thanks Greg, here's my SOB line:

Signed-off-by: Felipe Balbi <balbi@ti.com>

--=20
balbi
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
