From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: Query ISP1301 with OMAP
Date: Thu, 15 May 2008 11:04:54 -0700
Message-ID: <200805151104.55234.david-b@pacbell.net>
References: <FCCFB4CDC6E5564B9182F639FC356087012929E676@dbde02.ent.ti.com> <FCCFB4CDC6E5564B9182F639FC356087012929E715@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <FCCFB4CDC6E5564B9182F639FC356087012929E715-/tLxBxkBPtCIQmiDNMet8wC/G2K4zDHf@public.gmane.org>
Content-Disposition: inline
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Pandita, Vikram" <vikram.pandita-l0cyMroinI0@public.gmane.org>
Cc: "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Thursday 15 May 2008, Pandita, Vikram wrote:
> Another observation:
> There is a comment in isp1301_omap.c file:
>=20
> static void power_up(struct isp1301 *isp)
> =A0 =A0 =A0 =A0 /* do this only when cpu is driving transceiver,
> =A0 =A0 =A0 =A0 =A0* so host won't see a low speed device...
> =A0 =A0 =A0 =A0 =A0*/
>=20
> Could anyone give more details as to what this means?

The "this" was putting the transceiver into DAT_SEO mode,
so evidently there were problems observed doing that
earlier in the setup sequence -- before the immediately
preceding line which took it out of USB suspend mode.

The comment before those functions is relevant to your
general question (how to set it up for 3-pin host-only
mode):  some of the details presumed setup like an H2
board needed, and the DAT_SEO bit was one of them.

The H2 board certainly supported both host and peripheral
modes, and as I recall from the dusty mists of time it
didn't use three wire signaling.  So I suspect that you
won't be able to reuse much of that init code.  You'll
need to dig through the chip docs to figure out how it
needs to be set up.

- Dave

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
