From: Paul Walmsley <paul@pwsan.com>
Subject: RE: [PATCH 2/2 v3] OMAP3: PM: SR: SmartReflex Refactor Rev4.0
Date: Tue, 27 Oct 2009 17:36:40 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.0910261123360.26141@utopia.booyaka.com>
References: <OMAP3:PM:SR: SmartReflex Refactor Rev3.0> <1256361352-9968-1-git-send-email-nm@ti.com> <1256361352-9968-2-git-send-email-nm@ti.com> <1256361352-9968-3-git-send-email-nm@ti.com> <E0D41E29EB0DAC4E9F3FF173962E9E940253EFE01B@dbde02.ent.ti.com>
 <7A436F7769CA33409C6B44B358BFFF0C012AC22837@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-219178673-1256578457=:26141"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:53852 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756810AbZJ0Xgg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 27 Oct 2009 19:36:36 -0400
In-Reply-To: <7A436F7769CA33409C6B44B358BFFF0C012AC22837@dlee02.ent.ti.com>
Content-ID: <alpine.DEB.2.00.0910270833001.16729@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>
Cc: "G, Manjunath Kondaiah" <manjugk@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Imberton Guilhem <guilhem.imberton@motorola.com>, Mike Chan <mikechan@google.com>, "Nayak, Rajendra" <rnayak@ti.com>, Roger Quadros <ext-roger.quadros@nokia.com>, Kalle Jokiniemi <ext-kalle.jokiniemi@nokia.com>, "Reddy, Teerth" <teerth@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Hogander Jouni <jouni.hogander@nokia.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-219178673-1256578457=:26141
Content-Type: TEXT/PLAIN; CHARSET=ISO-8859-7
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <alpine.DEB.2.00.0910270833002.16729@utopia.booyaka.com>

Hello Nishanth, Manjunath,=20

a comment on cpu_relax() and udelay().

On Mon, 26 Oct 2009, Menon, Nishanth wrote:

> > -----Original Message-----
> > From: G, Manjunath Kondaiah
> >=20
> > As per your comments for other patches when ever there is udelay usage,
> > cpu_relax is the better option. I see there are lot of udelay(...) call=
s
> > used in this patch. Why can't you use cpu_relax() or schedule().
> > Any specific reason?
> >=20
> Don=A2t really want to do cpu_relax in irq_locked context..

There are no restrictions on the calling context for cpu_relax(). =20
[ schedule(), of course, does have restrictions. ]

I don't understand the use of the udelay(10).  Could you please explain=20
this further?  Is it the case that if the register bit doesn't change=20
within 50 reads, that it is then not likely to change for 10 microseconds?

If that isn't how the device works, then using udelay(10) will just waste=
=20
power busy-looping in the CPU.  I would rather see this code using=20
udelay(1) between each register read if you want to ensure that you read=20
the register for at least 50 microseconds.  This would also simplify your=
=20
timeout loops considerably, which seem unnecessarily complicated.

But if the scenario above is how the device is expected to respond, then=20
these loops should have some comments to explain why the extra complexity=
=20
and power consumption of a 10 microsecond busy-loop after every 50 reads=20
is the right thing to do.


regards,

- Paul
--155748971-219178673-1256578457=:26141--
