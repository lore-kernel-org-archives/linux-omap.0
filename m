From: "Zhang, Jian" <jzhang@ti.com>
Subject: RE: [PATCH] omap camera
Date: Fri, 10 Feb 2006 15:17:42 -0600
Message-ID: <304D2A85A9643F4A991BDDF8D297BBA60244D4DE@dlee05.ent.ti.com>
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
To: David Cohen <david.cohen@indt.org.br>, Linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

David,

Considering the difference between OMAP1 and OMAP2 camera interface,
abstracting a unified hardware interface and a unified V4L2 routing
layer might be difficult, and they will surely break the existing OMAP1
code and OMAP2 code. Keeping the current 3-layer architecture for OMAP1
and the 2-layer architecture for OMAP2 is the easiest. An updated
camera_core for OMAP2 doesn't gain us anything unless we plan to merge
it with omap1 camera_core eventually.

Regards,
Jian =20


-----Original Message-----
From: linux-omap-open-source-bounces@linux.omap.com
[mailto:linux-omap-open-source-bounces@linux.omap.com] On Behalf Of
David Cohen
Sent: Friday, February 10, 2006 3:03 PM
To: Linux-omap-open-source@linux.omap.com
Subject: [PATCH] omap camera

Hi all,

I've updated the driver for OMAP 24xx camera from TI (kernel version
2.6.10). It is now working with the public omap tree.
Is there anybody else working with camera driver?
I don't think it is appropriate to use a common driver (camera_core) for
the omap 2420 and 1611/1710. I guess creating a common driver for omap1
(current camera_core) and other for omap2 (an updated camera_core) could
be better. Any comment?

BR,

David Cohen
