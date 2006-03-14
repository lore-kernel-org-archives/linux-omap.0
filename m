From: "Zhang, Jian" <jzhang@ti.com>
Subject: RE: [PATCH] Fix OV9640 sensor and add h4 sensor power functions
Date: Tue, 14 Mar 2006 10:06:04 -0600
Message-ID: <304D2A85A9643F4A991BDDF8D297BBA602949824@dlee05.ent.ti.com>
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

I have strncpy in my code and don't experience any issue. I don't know
when it became strlcpy.

Regards,
Jian

-----Original Message-----
From: Komal Shah [mailto:komal_shah802003@yahoo.com]=20
Sent: Tuesday, March 14, 2006 9:21 AM
To: linux-omap-open-source@linux.omap.com
Cc: david.cohen@indt.org.br; Zhang, Jian
Subject: [PATCH] Fix OV9640 sensor and add h4 sensor power functions

David/Jian,

In the current sensor_ov9640.c implemention in git tree, strlcpy in
ov9640_sensor_init crashes, so it better to move it outside
ov9640_sensor structure. Also the patch adds h4 sensor power function.

David, you should have faced this error, if you are working on porting
the camera driver to latest git tree :)


---
Move i2c_driver out of ov9640_sensor structure and
add H4 camera sensor powerup/down functions.

Signed-off-by: Komal Shah <komal_shah802003@yahoo.com>

---Komal Shah
http://komalshah.blogspot.com/

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around=20
http://mail.yahoo.com=20
