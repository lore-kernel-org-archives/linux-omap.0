From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: Choice of Reference Design Board
Date: Sun, 18 Nov 2007 07:47:38 -0600
Message-ID: <3B6D69C3A9EBCA4BA5DA60D9130274290282B830@dlee13.ent.ti.com>
References: <20071116113252.GA22378@segfault.net><3B6D69C3A9EBCA4BA5DA60D9130274290282B5B2@dlee13.ent.ti.com>
	<20071118101248.GF22378@segfault.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-reply-to: <20071118101248.GF22378@segfault.net>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Steve Mueller <steve@segfault.net>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi,

> I found the OMAP 5912 OSK but it does not seem to come with any
> GSM capability. The diagram does not show a GSM baseband chip and the
> picture of a board does not show a plug for the antenna or a sim =
socket.

Yes that design was targeted elsewhere and came out of our catalog =
group.

Designs from the wireless group usually have some way to get a modem in =
the picture.

The high end chips might have a socket to add a modem, where the lower =
end ones have a modem on it.
=20
> The OMAP 730 Reference Design Platform (P2) seems to have all this.
> It is currently only available to handset manufacturers (correct?).

I'm not sure of how these are gotten, inside of TI it's a link.  There =
are a few which fit this P2, F-Sample, G-Sample, ...

> Unfortunately I'm not a handset manufacturer. I'm an independent =
developer
> fascinated by GSM and the OMAP. Is there any way I can purchase a P2 =
from
> TI or from a TI partner?

I'll pass your mail on and see what the answer is today for the legacy =
platforms.

As I was saying before, I know of suitable platforms which should be =
coming and that may be the best.  However, it will be a bit before =
details are available.

Regards,
Richard W.

> >
> > You will find there are a few OMAP variants.  Many are used in =
phones.
> >
> > On high end phones the chip set usually consists of 2 chips, an
> application processor and a modem processor.  The data you are looking =
for
> generally passes over some chip to chip link.  This link varies per
> vendor.  It might be on uart, usb, ssi, shared external memory...
> >
> > On lower or mid phones you might find the app and modem are =
controlled
> from the same chip (either on 1 core, or some kind of multi-core, on 1
> chip).  If its multi-core it is similar to the above but likely just
> shares via internal memory and some mailbox, but could be other.  You
> probably won't find as may single core ones in Linux as there are GPL
> worries for vendors.  There is some active research in virtualization =
as a
> way to try and address that.
> >
> > For lower cost platforms you can get the OSK series.  TI also has =
other
> references platforms but are harder to get and cost more.  If you can =
wait
> a couple months you will likely see several low cost platforms =
starting to
> come out which may suit your itches much better.
> >
> > Regards,
> > Richard W.
> >
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
