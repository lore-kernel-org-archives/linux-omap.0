From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: Power domain addition.
Date: Wed, 21 Jun 2006 10:24:08 -0500
Message-ID: <EA12F909C0431D458B9D18A176BEE4A5064655AA@dlee02.ent.ti.com>
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
Cc: linux-omap-open-source@linux.omap.com, sampsa.fabritius@nokia.com
List-Id: linux-omap@vger.kernel.org

> > a union structure of a u8 and u16 generating only byte aligned code
> > which is a no-no when used with a lrdh.
>=20
> I can submit the patch for removing IrDA from the defconfig, but
before
> that I will build the latest omap git tree, with code-sourcery 2005Q1B
> release and will see that it stops at the same point or not.

One other possible bit which I didn't look for was how the structure
base address was assigned.  If it was automatic or if some had manually
assigned a pointer. If it was automatic then its likely a compiler bug,
if someone just assigned it with out aligning it that would be something
which could be fixed in code.

rkw
