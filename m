From: "Zhang, Jian" <jzhang@ti.com>
Subject: RE: [PATCH] camera: c99 style structure
Date: Mon, 21 Nov 2005 09:19:33 -0600
Message-ID: <304D2A85A9643F4A991BDDF8D297BBA60181A12C@dlee05.ent.ti.com>
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
To: Komal Shah <komal_shah802003@yahoo.com>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Komal,

omap16xxcam.c is an OMAP specific file (OMAP1 camera I/F) instead of
board specific file. I like to keep omap16xxcam.c both board and sensor
independent. My suggestion is that moving the board code from the ov9640
sensor driver to board files and calling the board functions from the
sensor. So the sensor interface is intact.

Regards,
Jian=20

-----Original Message-----
From: Komal Shah [mailto:komal_shah802003@yahoo.com]=20
Sent: Monday, November 21, 2005 8:01 AM
To: linux-omap-open-source@linux.omap.com
Cc: Zhang, Jian
Subject: [PATCH] camera: c99 style structure

Tony,

I have attached the patch to update the structures in 16xxcam.c and
sensor file to c99 way and fixes compilation of drivers on h3.

Jian,
I am planning to move sensor_powerup/powerdown to board specific file
(here omap16xxcam.c), before start porting camera driver to 24xx, any
suggestions?

Signed-off-by: Komal Shah <komal_shah802003@yahoo.com>

---Komal Shah
http://komalshah.blogspot.com/


	=09
__________________________________=20
Yahoo! FareChase: Search multiple travel sites in one click.
http://farechase.yahoo.com
