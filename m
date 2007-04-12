From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: about OMAP usb Speed?
Date: Thu, 12 Apr 2007 18:59:22 -0500
Message-ID: <3B6D69C3A9EBCA4BA5DA60D913027429C2E968@dlee13.ent.ti.com>
References: <bd205c5f0704111728u57837375j22960eed269e4489@mail.gmail.com>
	<200704121530.04125.marek.vasut@gmail.com>
	<3B6D69C3A9EBCA4BA5DA60D913027429BDB8E9@dlee13.ent.ti.com>
	<782515bb0704121651u70a661daof21e51e074568fca@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <782515bb0704121651u70a661daof21e51e074568fca@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: nishanth menon <menon.nishanth@gmail.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

I don't recall the time lines for all of this.

I recall first seeing the first signs of this in early 1510 =
documentation.  The changed some text in the DM to say 1.1 to 2.0 for =
the host I think.  The client couldn't claim it as it didn't support the =
device descriptor to say it couldn't do high speed.

When 16xx came around some marketing text changed to say both had some =
2.0 pieces.  You will find it conflicting in spots.  Answers to =
questions around this came out back then.

I don't know if there really was a 1.1 plus OTG or not really.  This =
could have been documentation not catching up with marketing or maybe it =
was this way.

I'd have to research more to say confidently.  Perhaps a USB wizard like =
David B. knows this off the top of his head.

Regards,
Richard W.

> Hi Richard,
>=20
> On 4/12/07, Woodruff, Richard <r-woodruff2@ti.com> wrote:
>=20
> > Also as I recall, OTG didn't come about until the USB2.0 time frame. =
 I
> don't think you will find an OTG which claims to be 1.1.  Usually it =
is
> 2.0 compliant and adheres to some supplement level.
> Yup, OTG spec is addendum to 2.0 spec. But just for the sake for
> curiosity, Back in 2002, we did have some controllers which were
> USB1.1 compliant AND supported OTG+SRP. USB1.1 compliance was the
> chapter9 commands of 1.1 spec, host, I dont recollect if it was OHCI
> or some "non standard embedded host controller" though... in short, we
> could have USB 1.1 compliance for A-peripheral and B-peripheral(using
> OTG terminology), but support SRP&HNP becoming "USB1.1 OTG". Only i
> guess, it would be "near-compliant"(if such a word could be used) to
> specs. I would be surprised to see such devices still existing.. the
> 2.0 OTG compliance is almost common place today..
>=20
> Regards,
> Nishanth Menon
