From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: Choice of Reference Design Board
Date: Fri, 16 Nov 2007 12:55:07 -0600
Message-ID: <3B6D69C3A9EBCA4BA5DA60D9130274290282B5B2@dlee13.ent.ti.com>
References: <20071116113252.GA22378@segfault.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-reply-to: <20071116113252.GA22378@segfault.net>
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

> I'm a network enthusiast. I've worked with GSM for the last 2 years. =
I've
> written my own GMSK decoder, bit error correction, and frame decoder. =
I've
> used the USRP (www.ettus.com) as a receiver.
>=20
> I'm excited about the capability of the OMAP. I would like to do some
> development on a OMAP reference board. I've a hard time finding one
> that gives me access to layer1 gsm frames.
>=20
> I saw the OMAP1510/5910 and OMAP5912 starter kits. The description =
does
> not explain the level of access to the GSM data.
>=20
> I think the OMAP730 would be best for me but I can not find a place to
> get one of the reference design platform (P2).
>=20
> Can somebody point me into the right direction?

You will find there are a few OMAP variants.  Many are used in phones. =20

On high end phones the chip set usually consists of 2 chips, an =
application processor and a modem processor.  The data you are looking =
for generally passes over some chip to chip link.  This link varies per =
vendor.  It might be on uart, usb, ssi, shared external memory...

On lower or mid phones you might find the app and modem are controlled =
from the same chip (either on 1 core, or some kind of multi-core, on 1 =
chip).  If its multi-core it is similar to the above but likely just =
shares via internal memory and some mailbox, but could be other.  You =
probably won't find as may single core ones in Linux as there are GPL =
worries for vendors.  There is some active research in virtualization as =
a way to try and address that.

For lower cost platforms you can get the OSK series.  TI also has other =
references platforms but are harder to get and cost more.  If you can =
wait a couple months you will likely see several low cost platforms =
starting to come out which may suit your itches much better.

Regards,
Richard W.
