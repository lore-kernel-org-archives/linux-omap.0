From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH] usb: musb: omap2430: fix build failure
Date: Wed, 13 Apr 2011 20:22:51 +0300
Message-ID: <20110413172250.GH31113@legolas.emea.dhcp.ti.com>
References: <1302025834-25729-1-git-send-email-jhovold@gmail.com>
 <20110413170139.GA26264@localhost>
Reply-To: balbi-l0cyMroinI0@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20110413170139.GA26264@localhost>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Johan Hovold <jhovold-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Greg Kroah-Hartman <gregkh-l3A5Bk7waGM@public.gmane.org>, Hema HK <hemahk-l0cyMroinI0@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi,

On Wed, Apr 13, 2011 at 07:01:39PM +0200, Johan Hovold wrote:
> On Tue, Apr 05, 2011 at 07:50:34PM +0200, Johan Hovold wrote:
> > Fix build failure introduced by commit
> > 7acc6197b76edd0b932a7cbcc6cfad0a8a87f026 (usb: musb: Idle path rete=
ntion
> > and offmode support for OMAP3) when building without gadget
> > support.
> >=20
> >   CC      drivers/usb/musb/omap2430.o
> > drivers/usb/musb/omap2430.c: In function =E2=80=98musb_otg_notifica=
tions=E2=80=99:
> > drivers/usb/musb/omap2430.c:262: error: =E2=80=98struct musb=E2=80=99=
 has no member named =E2=80=98gadget_driver=E2=80=99
>=20
> I noted that this one wasn't included in your pull-request today. Jus=
t
> thought I'd send a reminder as I haven't received any feedback.

Sorry about that, I missed it from my queue. I'll add and send on a
separate pull request. Thanks for the note.

--=20
balbi
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
