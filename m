From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: [PATCH] ARM: OMAP: Add minimal OMAP2430 support
Date: Sun, 11 Jun 2006 07:15:29 -0500
Message-ID: <EA12F909C0431D458B9D18A176BEE4A506200328@dlee02.ent.ti.com>
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
To: Komal Shah <komal_shah802003@yahoo.com>, Tony Lindgren <tony@atomide.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org


> After looking at the files which are needed to change for
> prcm_read/write[l], clock.c needs the major update. I hope Richard is
> OK with going from __REG32(...) to __raw_read/write[l] based prcm_rw
> wrappers?
>=20
> Anyways, I have started doing that changes for other files.

I picked up this encoding from USB which uses it also.  In general it
makes any kind of porting and sharing between some of our internal code
bases easier.  It has a nice property of also being more compact (in C
file coding space) then other forms.

As far as portability goes header files do hide the any differences and
we use it seamlessly between 2420 and 2430 dispute them having very
different maps.   It won't give you a single binary which runs across
OMAP1/OMAP2/OMAP3 but as you use a different compiler target v5, v6,
cortex, which produces incompatible binaries that has somewhat a lesser
importance.

Regards,
Richard W.
