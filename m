From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: [PATCH] - Fix MMC -- was  H4 boot with latest git kernel
Date: Mon, 19 Feb 2007 10:04:27 -0600
Message-ID: <3B6D69C3A9EBCA4BA5DA60D9130274295B9C49@dlee13.ent.ti.com>
References: <5d5443650702090324g6048af71u17f20a55f823edda@mail.gmail.com>
	<20070209165157.GB22121@atomide.com>
	<3B6D69C3A9EBCA4BA5DA60D913027429509132@dlee13.ent.ti.com>
	<20070210174121.GA5291@atomide.com>
	<20070210190845.GA19642@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <20070210190845.GA19642@atomide.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: tony@atomide.com
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

> > Thanks. Looks like we're still doing the MMC powerup wrong for omap
> > though. I made a patch for that a while back but it got forgotten
> > for some reason:
> >
> > http://lkml.org/lkml/2006/5/4/44
> >
> > I'll refresh that patch so we can make sure it works on all
platforms.
>=20
> Here are the refreshed patches to try.

The board does work with these patches also.  It's a cleaner way to fix
it up even if it is more than a line ;)

Regards,
Richard W.
