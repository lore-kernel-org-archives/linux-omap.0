From: "Zhang, Jian" <jzhang@ti.com>
Subject: RE: [PATCH] camera: c99 style structure
Date: Tue, 22 Nov 2005 08:44:20 -0600
Message-ID: <304D2A85A9643F4A991BDDF8D297BBA60181A903@dlee05.ent.ti.com>
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

I think it is as simple as a bunch of board files in the same directory
(drivers/media/video/omap2420). They don't need to go to arch/arm/mach/
directory. I believe OMAP1 frame buffer driver takes this approach.

Regards,
Jian=20

-----Original Message-----
From: Komal Shah [mailto:komal_shah802003@yahoo.com]=20
Sent: Tuesday, November 22, 2005 2:50 AM
To: Tony Lindgren; Zhang, Jian
Cc: linux-omap-open-source@linux.omap.com
Subject: Re: [PATCH] camera: c99 style structure

--- Tony Lindgren <tony@atomide.com> wrote:

> * Zhang, Jian <jzhang@ti.com> [051121 07:20]:
> > Komal,
> >=20
> > omap16xxcam.c is an OMAP specific file (OMAP1 camera I/F) instead
> of
> > board specific file. I like to keep omap16xxcam.c both board and
> sensor
> > independent. My suggestion is that moving the board code from the
> ov9640
> > sensor driver to board files and calling the board functions from
> the
> > sensor. So the sensor interface is intact.
>=20
> I like this too.

Yes, but which board file is again a confusion. I don't think
board-hx.c is a good candidate for exporting functions from that. How
about gpio-expandar-omap.c itself? _or_ should we create a new file
under mach-omap1/2 to export this two powerup/down symbols?

---Komal Shah
http://komalshah.blogspot.com/


=09
	=09
__________________________________=20
Yahoo! Mail - PC Magazine Editors' Choice 2005=20
http://mail.yahoo.com
