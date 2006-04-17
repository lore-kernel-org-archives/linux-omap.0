From: "Ishigami, Tatsuya" <ishigami@ti.com>
Subject: RE: FIFO_FULL on camera driver
Date: Sun, 16 Apr 2006 20:48:37 -0500
Message-ID: <3D54759CE5A8F64BB2078090E91D50A2311DBD@dlee08.ent.ti.com>
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
To: "Carlos, John J DA CIV USA ATC" <john.carlos@atc.army.mil>
Cc: Linux-Omap-Open-Source <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Hello John,

 As you might notice, the OMAP5912 doesn't specify the maximum
bandwidth with frame pulse, but with CAM.LCK (dot clock) as

	TMX5912 (used for OSK Rev.C)	24MHz
	TMP/TMS5912( OSK Rev.D)	48MHz

 You might want to check if your new decoder doesn't hit this
limit. In TMP/TMS device, the camera module is driven with
the ULPD-48MHz & ARMXOR_CK directly, which cannot
be configured but fixed.

 If you allocate the buffer in DDR, please try it in the OMAP
internal RAM, which is much faster.

 Regards,
 Ishigami

-----Original Message-----
From: Carlos, John J DA CIV USA ATC
Sent: Tuesday, April 11, 2006 11:38 PM
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

John=20
_______________________________________________
Linux-omap-open-source mailing list
Linux-omap-open-source@linux.omap.com
http://linux.omap.com/mailman/listinfo/linux-omap-open-source
