From: "Kondaiah G, Manjunath" <manjugk@ti.com>
Subject: RE: Access GPIO, OMAP 5912 OSK
Date: Wed, 12 Jul 2006 19:18:50 +0530
Message-ID: <45F366B1BC4F7C4A895F0F34C41E61A501D2DF3B@dbde01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
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
To: Birger Kroon <Birger.Kroon@sys.teleca.se>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Birger,

Refer to arch/arm/plat-omap/gpio.c=20

You can make use of these API's to control your custom peripherals.

omap_request_gpio;
omap_free_gpio;
omap_set_gpio_direction;
omap_set_gpio_dataout;
omap_get_gpio_datain;

Br,
-Manjunath

-----Original Message-----
From: linux-omap-open-source-bounces@linux.omap.com =
[mailto:linux-omap-open-source-bounces@linux.omap.com] On Behalf Of =
Birger Kroon
Sent: Wednesday, July 12, 2006 12:47 PM
To: linux-omap-open-source@linux.omap.com
Subject: Access GPIO, OMAP 5912 OSK

Hi list...
=20
* I have some custom peripherals that I want to control via GPIOs, =
either from a driver (kernel space) or an application (user space).
* Is there some sort of API to do this or do I have to write my own?
=20
Any ideas are welcome...
=20
Regards
// Birger
=20
=20
Birger Kroon=20
Software Engineer=20
Automotive Solutions

Teleca Sweden West AB=20
Lindholmspiren 9=20
SE-417 56 G=F6teborg=20
Sweden=20
Tel +46 31 744 80 00=20
Fax +46 31 744 80 01=20

Direct +46 31 744 80 87=20
Mobile +46 703 79 19 11=20
birger.kroon@sys.teleca.se=20
www.teleca.com
=20
_______________________________________________
Linux-omap-open-source mailing list
Linux-omap-open-source@linux.omap.com
http://linux.omap.com/mailman/listinfo/linux-omap-open-source
