From: "Menon, Nishanth" <nm@ti.com>
Subject: RE: [PATCH 2/2 v3] OMAP3: PM: SR: SmartReflex Refactor Rev4.0
Date: Wed, 28 Oct 2009 00:17:47 -0500
Message-ID: <7A436F7769CA33409C6B44B358BFFF0C012AD6CFAA@dlee02.ent.ti.com>
References: <OMAP3:PM:SR: SmartReflex Refactor Rev3.0>
 <1256361352-9968-1-git-send-email-nm@ti.com>
 <1256361352-9968-2-git-send-email-nm@ti.com>
 <1256361352-9968-3-git-send-email-nm@ti.com>
 <E0D41E29EB0DAC4E9F3FF173962E9E940253EFE01B@dbde02.ent.ti.com>
 <7A436F7769CA33409C6B44B358BFFF0C012AC22837@dlee02.ent.ti.com>
 <alpine.DEB.2.00.0910261123360.26141@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-7
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:33705 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757330AbZJ1FRx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 28 Oct 2009 01:17:53 -0400
In-Reply-To: <alpine.DEB.2.00.0910261123360.26141@utopia.booyaka.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "G, Manjunath Kondaiah" <manjugk@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Imberton Guilhem <guilhem.imberton@motorola.com>, Mike Chan <mikechan@google.com>, "Nayak, Rajendra" <rnayak@ti.com>, Roger Quadros <ext-roger.quadros@nokia.com>, Kalle Jokiniemi <ext-kalle.jokiniemi@nokia.com>, "Reddy, Teerth" <teerth@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Hogander Jouni <jouni.hogander@nokia.com>

> -----Original Message-----
> owner@vger.kernel.org] On Behalf Of Paul Walmsley
> Sent: Wednesday, October 28, 2009 1:37 AM
>=20
[..]
> a comment on cpu_relax() and udelay().
>=20
> On Mon, 26 Oct 2009, Menon, Nishanth wrote:
>=20
> > > -----Original Message-----
> > > From: G, Manjunath Kondaiah
> > >
> > > As per your comments for other patches when ever there is udelay =
usage,
> > > cpu_relax is the better option. I see there are lot of udelay(...=
)
> calls
> > > used in this patch. Why can't you use cpu_relax() or schedule().
> > > Any specific reason?
> > >
> > Don=A2t really want to do cpu_relax in irq_locked context..
>=20
> There are no restrictions on the calling context for cpu_relax().
> [ schedule(), of course, does have restrictions. ]
Thanks..
>=20
> I don't understand the use of the udelay(10).  Could you please expla=
in
> this further?  Is it the case that if the register bit doesn't change
> within 50 reads, that it is then not likely to change for 10 microsec=
onds?
The delay of 10 used is in vcbypass command -> the loop actually waits =
for the i2c command to get thru.. depending on the speed of the bus con=
figured and cpu speed, 50 iterations might not be enough, but yes, a ud=
elay(1) loop in addition to cpu_relax might be better..

>=20
> If that isn't how the device works, then using udelay(10) will just w=
aste
> power busy-looping in the CPU.  I would rather see this code using
> udelay(1) between each register read if you want to ensure that you r=
ead
> the register for at least 50 microseconds.  This would also simplify =
your
> timeout loops considerably, which seem unnecessarily complicated.
Ack.

Regards,
Nishanth Menon
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
