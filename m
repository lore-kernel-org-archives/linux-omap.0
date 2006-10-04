From: "Ishigami, Tatsuya" <ishigami@ti.com>
Subject: RE: Help with LCD on OSK
Date: Wed, 4 Oct 2006 15:36:56 -0500
Message-ID: <772F5D89C5E0734B8A86D85DFC6A202404BA265B@dlee03.ent.ti.com>
References: <CC7B089C59ED6841BAE28F1EA69A854387371D@EXCHDB.admin.wpi.edu>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <CC7B089C59ED6841BAE28F1EA69A854387371D@EXCHDB.admin.wpi.edu>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: "Sideleau, Scott R" <srs@WPI.EDU>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hello,
=20
> It's a grascale video LCD (320x240 from Hantronix) with
> it's 4x data lines connected to LCD.P2, LCD.P4, LCD.P6,
> and LCD.P8.

 Is its specification (or datasheet)  available public, ideally on-line?

> I've looked at lcd_osk.c and lcdc.c in .../arch/arm/drivers/plat-omap,
> but do not readily see what I need to modify to get things working.

 Well, you might first want to understand each parameter with
the display controller datamanual.

	http://focus.ti.com/lit/ug/spru764b/spru764b.pdf

> I do not know how to tell if the driver is installed and loading
> correctly with my current kernel.

 I hope this page might help.

	http://oskfordummies.hp.infoseek.co.jp/howto/lcd.html

> As this is a university project, I'm on a tight schedule

 Probably you already know, but the OSK LCD board is already
is available from the 3rd parties.

	http://www.aditec.co.kr/2005_aditec/img/aglm.pdf

=09
http://www.mistralsoftware.com/html/product/opendoc.php?document_url=3Dom=
a
p_products/QVLM.pdf

 Good luck,

 Regards,
 Ishigami

-----Original Message-----
From: Sideleau, Scott R [mailto:srs@WPI.EDU]=20
Sent: Wednesday, October 04, 2006 9:30 AM
To: linux-omap-open-source@linux.omap.com
Subject: Help with LCD on OSK

Hello,

I was hoping I might be able to get some assistance with getting an
external,
custom LCD working with the OSK.  It's driver board currently connects
to the
OSK via the 80-pin HiRose connector to Expansion Slot C on the OSK.

It's a grascale video LCD (320x240 from Hantronix) with it's 4x data
lines
connected to LCD.P2, LCD.P4, LCD.P6, and LCD.P8.

I've looked at lcd_osk.c and lcdc.c in .../arch/arm/drivers/plat-omap,
but do
not readily see what I need to modify to get things working.

In addition, I do not know how to tell if the driver is installed and
loading
correctly with my current kernel.

Any help and/or direction (to documentation or otherwise) would be
greatly
appreciated.  As this is a university project, I'm on a tight schedule
and
would appreciate any response... really.

Thanks in advance.
______________________________________________
Scott R. Sideleau
ECE '07, Worcester Polytechnic Institute
@ MQP Ireland A'06, University of Limerick
+353 61-307310 / srs@wpi.edu
