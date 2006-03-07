From: "Zhang, Jian" <jzhang@ti.com>
Subject: RE: Problem in enabling camera driver for OMAP 1510 Innovator
Date: Tue, 7 Mar 2006 11:10:03 -0600
Message-ID: <304D2A85A9643F4A991BDDF8D297BBA602835EAF@dlee05.ent.ti.com>
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
To: RAVI SHANGAR <ravishangar@gmail.com>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

We didn't spend time to make Innovator camera working at all when I
pushed the code although nothing prevents someone from adapting the code
for Innovator.

I assume you are talking about 1510 Innovator. I don't know if 1510 has
a different camera block than 1610/1710. If they differ, you will need
to write an omapcam1500.c.

Since Innovator has a different camera sensor, you will have to write a
sensor driver for it. You might be able to copy most code from ov9640
sensor driver.=20

Regards,
Jian =20

-----Original Message-----
From: linux-omap-open-source-bounces@linux.omap.com
[mailto:linux-omap-open-source-bounces@linux.omap.com] On Behalf Of RAVI
SHANGAR
Sent: Tuesday, March 07, 2006 8:09 AM
To: linux-omap-open-source@linux.omap.com
Subject: Problem in enabling camera driver for OMAP 1510 Innovator

I use the 2.6.12 kernel with OMAP 1510.

I read the messages from the archive and got that *omapcam16xx.c and
sensor_ov9640.c* must be modified or rewritten again to suit our
innovator
platform.

According to most of the archived messages, camera drivers are enabled
for
H2 and H3. But I couldn't find such specific solutions for Innovator.

Is it that 1510 Innovator hardly support camera driver or there are any
other options?

Plz give an apt solution for me to proceed further.
_______________________________________________
Linux-omap-open-source mailing list
Linux-omap-open-source@linux.omap.com
http://linux.omap.com/mailman/listinfo/linux-omap-open-source
