From: "Zhang, Jian" <jzhang@ti.com>
Subject: RE: gpio interrupt support
Date: Thu, 29 Dec 2005 16:04:02 -0600
Message-ID: <304D2A85A9643F4A991BDDF8D297BBA601CF6C41@dlee05.ent.ti.com>
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
To: Brian Swetland <swetland@google.com>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

gpio.c extends the system IRQs by the number of OMAP GPIO pins. You use
request_irq() to subscribe a GPIO IRQ. See Ethernet driver for details.

Regards,
Jian

-----Original Message-----
From: linux-omap-open-source-bounces+jzhang=3Dti.com@linux.omap.com
[mailto:linux-omap-open-source-bounces+jzhang=3Dti.com@linux.omap.com] =
On
Behalf Of Brian Swetland
Sent: Thursday, December 29, 2005 3:25 PM
To: linux-omap-open-source@linux.omap.com
Subject: gpio interrupt support


I need to handle interrupts from omap gpios... it looks like there's
code for (most of?) this in plat-omap/gpio.c, but the interrupt related
functions are static and not exported.  Is this functionality incomplete
or is there some other way to register gpio interrupt handlers that I'm
overlooking?

Thanks,

Brian
_______________________________________________
Linux-omap-open-source mailing list
Linux-omap-open-source@linux.omap.com
http://linux.omap.com/mailman/listinfo/linux-omap-open-source
