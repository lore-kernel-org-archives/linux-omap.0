From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: [PATCH] omapfb vsync support
Date: Mon, 27 Feb 2006 16:24:27 -0600
Message-ID: <EA12F909C0431D458B9D18A176BEE4A50481E3A8@dlee02.ent.ti.com>
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
To: Brian Swetland <swetland@google.com>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

How come there is no disable of the interrupt?

Seems like at ioctrl the caller needs to be tracked so when he does a
close the interrupt can be disabled.

This will cause a VST enabled kernel to wake up for no good reason if
there is no application requesting it anymore.  Someone pointed out this
fact to me recently while doing power measurements.  If you have a low
power screen saver mode this can mess up expected power savings.

Regards,
Richard W.

> -----Original Message-----
> From: linux-omap-open-source-bounces@linux.omap.com
[mailto:linux-omap-
> open-source-bounces@linux.omap.com] On Behalf Of Brian Swetland
> Sent: Monday, February 27, 2006 3:59 PM
> To: linux-omap-open-source@linux.omap.com
> Subject: [PATCH] omapfb vsync support
>=20
>=20
> Here's a patch that provides the FBIO_WAITFORVSYNC ioctl
> (same one used by the ati and nvidia drivers) to the omapfb
> driver.  We could use the omap-specific ioctl, but it seemed
> to make more sense to use an existing one.  Opinions?
>=20
> Brian
