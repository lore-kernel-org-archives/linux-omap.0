From: "Zhang, Jian" <jzhang@ti.com>
Subject: RE: [omap24xx] camera driver porting
Date: Wed, 23 Nov 2005 09:30:13 -0600
Message-ID: <304D2A85A9643F4A991BDDF8D297BBA60187D818@dlee05.ent.ti.com>
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

Good question. OMAP1 and OMAP2 camera drivers were developed
independently. OMAP1 has a 3-layer architecture while OMAP2 has a
2-layer architecture. OMAP2 driver takes advantage of the display
subsystem for preview. Splitting V4l2 stuff from the existing
omap24xxcam.c is not straightforward.

I thought about the same thing one year ago and didn't do anything
useful due to the schedule constraint. So I ended up with OMAP1 and
OMAP2 only share the sensor driver. As for now, I don't have the plan to
do the splitting work.=20

Regards,
Jian

-----Original Message-----
From: Komal Shah [mailto:komal_shah802003@yahoo.com]=20
Sent: Wednesday, November 23, 2005 5:09 AM
To: linux-omap-open-source@linux.omap.com
Cc: Zhang, Jian
Subject: [omap24xx] camera driver porting

Jian,

Some more points about omap24xx camera driver porting to
existing framework on linux-omap-git tree.

o How to handle csr_error used in omap24xxcam.c with
camera_core_sgdma_process(), as defines for csr_error is specific to
omap2 platform, so it should be passed from platform specific
file(omap24xxcam.c) to camera_core.c, but how?=20

o How to port omap24xxcam_error_handler(), as it calls
omap24xxcam_sg_dma_sync()? Error handler is specific to 24xx so, should
be implemented from omap24xxcam.c , but then we can't call
sg_dma_sync() from omap24xxcam.c as it should be in camera_core.c ?

---Komal Shah
http://komalshah.blogspot.com/


	=09
__________________________________=20
Yahoo! FareChase: Search multiple travel sites in one click.
http://farechase.yahoo.com
