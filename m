From: "Ishigami, Tatsuya" <ishigami@ti.com>
Subject: RE: sd cards support on osk5912
Date: Fri, 14 Apr 2006 04:04:15 -0500
Message-ID: <3D54759CE5A8F64BB2078090E91D50A22729E7@dlee08.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-class: urn:content-classes:message
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Ram <vshrirama@gmail.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hello,

 It seems only small changes are needed.
 http://oskfordummies.hp.infoseek.co.jp/howto/mmcsd.html

 Regards,
 Ishigami=20

-----Original Message-----
From: Ram
Sent: Monday, April 10, 2006 6:53 PM
To: linux-omap-open-source@linux.omap.com
Subject: sd cards support on osk5912

Hi,
   I have kernel sources 2.6.16 for mmc/sd card support. MMC/SD
Drivers are present in drivers/mmc.

   The MMC/SD Card  Support (Platform init routinues) are there for
innovator board.
    (board-innovator.c).

   If i want OSK to support SD (SD I/F is on a addon board to OSK)

  What changes i need to make in the kernel sources so that drivers
can access SD  cards.

  Please Advice,

  Regards,
   sriram
_______________________________________________
Linux-omap-open-source mailing list
Linux-omap-open-source@linux.omap.com
http://linux.omap.com/mailman/listinfo/linux-omap-open-source
