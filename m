From: Ezequiel Garcia <ezequiel.garcia-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: AM335x USB DMA seems broken on ISOC URBs
Date: Mon, 20 Jan 2014 08:25:28 -0300
Message-ID: <20140120112527.GA10382@localhost>
References: <20131222055945.GA7194@localhost>
 <20140117162723.GB3843@localhost>
 <52DA99D8.8010003@zonque.org>
 <52DD055C.1090806@zonque.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <52DD055C.1090806-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>
Cc: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Mon, Jan 20, 2014 at 12:15:40PM +0100, Daniel Mack wrote:
> On 01/18/2014 04:12 PM, Daniel Mack wrote:
> > On 01/17/2014 05:27 PM, Ezequiel Garcia wrote:
> >> On Sun, Dec 22, 2013 at 02:59:45AM -0300, Ezequiel Garcia wrote:
>=20
> >>> While doing some experiments with the stk1160 driver (for "Easyca=
p" TV video
> >>> capture devices), ran into problems using v3.13-rc4. The problem =
is that the
> >>> stk1160 IRQ handler receives no URBs at all.
>=20
> [...]
>=20
> > Let me know if you find anything - I hope to find some time to do
> > similar tests on AM33xx based hardware.
>=20
> I tried using an USB headset connected to a AM33xx based board, using
> kernel v3.13.
>=20
> The good news is that aplay gives me sound, so there's nothing genera=
lly
> wrong with isochronous streams on musb_dsps/cppi41.
>=20

Hm.. interesting. I wonder what's the difference between those URBs and
the video URBs involved in stk1160 operation. Maybe the size of each
buffer transfered?

Can anybody bring some light on this?
--=20
Ezequiel Garc=C3=ADa, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
