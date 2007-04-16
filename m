From: "Kipisz, Steven" <s-kipisz2@ti.com>
Subject: RE: usb camera in osk5912 ; bus power : urgent
Date: Mon, 16 Apr 2007 06:10:17 -0500
Message-ID: <B62D67BD8EC3324C8A3DACEEA1A0D6C6012B8369@dlee12.ent.ti.com>
References: <201180.10923.qm@web51411.mail.re2.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <201180.10923.qm@web51411.mail.re2.yahoo.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: karthik <skarthikeyan_17@yahoo.com>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Use a USB hub.  I have connected a 4 port hub and then connected various
devices to the hub.

Steve K.

-----Original Message-----
From: linux-omap-open-source-bounces@linux.omap.com
[mailto:linux-omap-open-source-bounces@linux.omap.com] On Behalf Of
karthik
Sent: Saturday, April 14, 2007 3:20 PM
To: linux-omap-open-source@linux.omap.com
Subject: usb camera in osk5912 ; bus power : urgent

Hi,
I tried connecting creative videoblaster webcam go, and another logitech
webcam to osk5912. i get  the message

usb 1-1: new full speed USB device using ohci and address 2
usb 1-1: rejected 1 configuration due to insufficient available bus
power
usb 1-1: no configuration chosen from 1 choice

How do i increase bus power? can i connect usb hubs? do i need Y cables
that have there own alternative power? =20
i have a Y cable that comes with external portable hard disks i tried
using that with one end connected to my PC and the other two ends to cam
and kit. The light in the camera glows but i get teh same error message
from linux (without Y cable, the light does not glow).=20
It is the same with two other cameras.=20
i checked pin 1 and 4.. it gives 5 volts.=20

------
# cat /sys/devices/platform/ohci/usb1/1-1/idProduct
08b2
# cat /sys/devices/platform/ohci/usb1/1-1/idVendor
046d
#
------
Please treat this as urgent.

regs karthik

      =20
---------------------------------
Ahhh...imagining that irresistible "new car" smell?
 Check outnew cars at Yahoo! Autos.
_______________________________________________
Linux-omap-open-source mailing list
Linux-omap-open-source@linux.omap.com
http://linux.omap.com/mailman/listinfo/linux-omap-open-source
