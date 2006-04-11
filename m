From: "Zhang, Jian" <jzhang@ti.com>
Subject: RE: FIFO_FULL on camera driver
Date: Tue, 11 Apr 2006 10:29:21 -0500
Message-ID: <304D2A85A9643F4A991BDDF8D297BBA602DE3312@dlee05.ent.ti.com>
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
To: "Carlos, John J DA CIV USA ATC" <john.carlos@atc.army.mil>, Linux-Omap-Open-Source <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

John,

Did you mean that the driver worked for a different sensor at slower
rate? So the first question I want to ask is that does the new sensor
ever work? You may want to configure the new sensor at a slow rate (say
10FPS) first.

Do you process the data and capture the data in sequential or in
parallel? I do recall the OMAP1 camera driver does a software rotation
of the captured data to frame buffer sequentially with the capture.=20

Regards,
Jian  =20

-----Original Message-----
From: Carlos, John J DA CIV USA ATC [mailto:john.carlos@atc.army.mil]=20
Sent: Tuesday, April 11, 2006 10:03 AM
To: Zhang, Jian; Carlos, John J DA CIV USA ATC; Linux-Omap-Open-Source
Subject: RE: FIFO_FULL on camera driver

Hi Jian,

  I don't do any processing till after I read a full buffer.  Not sure
why I
am over running the buffer do you know a spec on the speed the camera
interface can handle.  As I mentioned the period on the frame is about
12
msec faster then the cmos sensor I have that works.

Thanks again,
John=20

-----Original Message-----
From: Zhang, Jian [mailto:jzhang@ti.com]=20
Sent: Tuesday, April 11, 2006 10:45 AM
To: Carlos, John J DA CIV USA ATC; Linux-Omap-Open-Source
Subject: RE: FIFO_FULL on camera driver

The driver may not be the cause for the FIFO overflow. It is most likely
that your post-processing code is not running fast enough.

Regards,
Jian =20

-----Original Message-----
From: linux-omap-open-source-bounces@linux.omap.com
[mailto:linux-omap-open-source-bounces@linux.omap.com] On Behalf Of
Carlos,
John J DA CIV USA ATC
Sent: Tuesday, April 11, 2006 9:38 AM
To: Linux-Omap-Open-Source
Subject: FIFO_FULL on camera driver

Hello All,

	I am using 2.6.14-rc1-omap1 on OSK5912.  I am working with a
video
decoder with a 8 bit camera interface.  When I run a test application to
collect data I get FIFO_FULL error messages.  The frame pulse is about
33msec period.  This is a bit faster the a cmos sensor I use that works
fine
(45 msec period).  What clocking can be adjusted to stop the fifo
overrun?

Thanks,

John
_______________________________________________
Linux-omap-open-source mailing list
Linux-omap-open-source@linux.omap.com
http://linux.omap.com/mailman/listinfo/linux-omap-open-source
