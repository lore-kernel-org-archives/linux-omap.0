From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH 0/2] MUSB: 2 patches to fix some bug found on Blackfin
Date: Wed, 21 May 2008 13:04:52 -0700
Message-ID: <200805211304.53082.david-b@pacbell.net>
References: <1211022081-27298-1-git-send-email-cooloney@kernel.org> <200805211014.45170.david-b@pacbell.net> <61cdb2dcc22913ddefddd7b4a6faede3@felipebalbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <61cdb2dcc22913ddefddd7b4a6faede3-uiRdBs8odbtmTBlB0Cgj/Q@public.gmane.org>
Content-Disposition: inline
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <me-uiRdBs8odbtmTBlB0Cgj/Q@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Bryan Wu <cooloney-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Wednesday 21 May 2008, Felipe Balbi wrote:
>=20
> > I'm all for getting the musb_hdrc driver into the 2.6.27 queue...
> > I presume there are still some infrastructure changes in usbcore
> > that block that merge? =A0It'd be nice if we could merge musb_hdrc
> > without those changes (OTG related) and then update that stuff
> > separately.
>=20
> Ok then, I'll prepare the patches during the next week and post
> here on l-o so people can comment.

When it's a USB patch, please post to linux-usb.  Most of the
relevant reviewers won't be on Linux-OMAP.  ;)

That said, I'm looking forward to seeing the www.beagleboard.org
hardware [1] become more generally available.  That will make some
musb_hdrc hardware available in a more developer-friendly rig than,
say, an N810 tablet.  And it might well get more folk in a position
where they can use that driver!  (I think some Blackfin devboards
are available already, but they're more pricey.)

- Dave

[1] http://www.elinux.org/BeagleBoard
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
