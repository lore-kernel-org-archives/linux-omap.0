From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: Noise causes gpio interrupt
Date: Thu, 25 Jan 2007 09:01:16 -0600
Message-ID: <3B6D69C3A9EBCA4BA5DA60D9130274293301B0@dlee13.ent.ti.com>
References: <9C23CDD79DA20A479D4615857B2E2C47080FF2@dlee13.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <9C23CDD79DA20A479D4615857B2E2C47080FF2@dlee13.ent.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: "Syed Mohammed, Khasim" <x0khasim@ti.com>, Arnold <abo_gwapo@yahoo.com>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Depending on the polarity and the circuit you might also get away
configuring the internal pull-up/down to try and help mask any noise.

In the past for some early designs I recall things like the lcd inducing
noise on the touch screen interrupt.  For that I believe we dumped an
external pull up one the line to stop it (along with board routing and
bits to diminish the noise).  The internal pull's aren't so strong, but
if your on the edge and the driver of that line can force the state it
might be enough to mask it.

Regards,
Richard W.
=20

> -----Original Message-----
> From: linux-omap-open-source-bounces@linux.omap.com=20
> [mailto:linux-omap-open-source-bounces@linux.omap.com] On=20
> Behalf Of Syed Mohammed, Khasim
> Sent: Thursday, January 25, 2007 3:44 AM
> To: Arnold; linux-omap-open-source@linux.omap.com
> Subject: RE: Noise causes gpio interrupt=20
>=20
> I don't know about the GPIO module in 5912. If you have, you=20
> can try configuring your GPIO interrupt to level instead of=20
> edge interrupt. I don't know if debounce time can help you in=20
> fixing this.
> =20
> Regards,
> Khasim=20
>=20
> ________________________________
>=20
> From: linux-omap-open-source-bounces@linux.omap.com on behalf=20
> of Arnold
> Sent: Thu 1/25/2007 3:40 AM
> To: linux-omap-open-source@linux.omap.com
> Subject: Noise causes gpio interrupt=20
>=20
>=20
>=20
> Hi All,
>=20
> I am working on omap5912 and I am using linux 2.6.17.
> I am using a gpio to handle interrupts. I believe that I am=20
> having a noise interrupt which my firmware thinks is a really=20
> interrupt. Is there a way to distinguish a noise interrupt=20
> from a real interrupt?
>=20
>=20
> Thanks,
> Arnold
>=20
>=20
>=20
> ______________________________________________________________
> ______________________
> Now that's room service!  Choose from over 150,000 hotels in=20
> 45,000 destinations on Yahoo! Travel to find your fit.
> http://farechase.yahoo.com/promo-generic-14795097
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
>=20
>=20
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
>=20
