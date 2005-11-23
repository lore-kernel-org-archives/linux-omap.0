From: "Zhang, Jian" <jzhang@ti.com>
Subject: RE: [PATCH] camera: c99 style structure
Date: Wed, 23 Nov 2005 09:36:18 -0600
Message-ID: <304D2A85A9643F4A991BDDF8D297BBA60187D82F@dlee05.ent.ti.com>
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

" But I was thinking to create
files under drivers/media/video/omap directory like
sensor_power_h2/h4/<custom board name> to export powerup/down function
related to sensors based on board interface."

Yes, this is what I meant.

Porting OMAP2 driver to camera_core is not straightforward. We are
developing a new sensor driver for TI/Micron camera which has sensor
context A and B. This will require the change to omap24xxcam.c. If you
want to spend time in unifying OMAP1 and OMAP2 camera drivers, I suggest
you wait until my change to omap24xxcam.c is done.

Regards,
Jian =20

-----Original Message-----
From: Komal Shah [mailto:komal_shah802003@yahoo.com]=20
Sent: Tuesday, November 22, 2005 11:40 PM
To: Zhang, Jian; Tony Lindgren
Cc: linux-omap-open-source@linux.omap.com
Subject: RE: [PATCH] camera: c99 style structure


--- "Zhang, Jian" <jzhang@ti.com> wrote:

> I think it is as simple as a bunch of board files in the same
> directory
> (drivers/media/video/omap2420). They don't need to go to
> arch/arm/mach/
> directory. I believe OMAP1 frame buffer driver takes this
> approach.

No, Imre has added OMAP2 fb support without creating new omap2
directory under drivers/video directory. But I was thinking to create
files under drivers/media/video/omap directory like
sensor_power_h2/h4/<custom board name> to export powerup/down function
related to sensors based on board interface.

Also while porting omap24xx camera interface, I want to keep the same
camera_core and sensor interface as you had suggested earlier.

---Komal Shah
http://komalshah.blogspot.com/


=09
	=09
__________________________________=20
Yahoo! Mail - PC Magazine Editors' Choice 2005=20
http://mail.yahoo.com
