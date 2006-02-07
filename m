From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: omap clock.h question
Date: Tue, 7 Feb 2006 15:41:40 -0600
Message-ID: <EA12F909C0431D458B9D18A176BEE4A504365ACD@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Tony Lindgren <tony@atomide.com>
Cc: Linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org


> > What's the correct way to support this?  Define another clock struct
> > with the same name, but setup for 730?
>=20
> Yes, just add another clock for 730. BTW, the mmc driver is about to
> change where you just request mmc_ick and mmc_fck on all omaps.

Is that what RMK meant...  I was wondering if he meant you stash away a
number of clocks and a list of them in the dev structure.  That way you
could just call clock enable for all need clocks based on private data.
Who is to say 2 is enough, or 3, in the future.

I wasn't all that clear on exactly what was meant, but that was my first
thought.

Regards,
Richard W.
