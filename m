From: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Subject: RE: 2430 GPIO programming example ?
Date: Sun, 12 Aug 2007 10:27:15 -0500
Message-ID: <9C23CDD79DA20A479D4615857B2E2C470184ABAF@dlee13.ent.ti.com>
References: <57314e840708120736m56a034d8ke73c08ec2b4041ee@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <57314e840708120736m56a034d8ke73c08ec2b4041ee@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Budhee Jamaich <budheej@gmail.com>, "Woodruff, Richard" <r-woodruff2@ti.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

>thank you. but can you just please tell me shortly what is the effect
>of these functions ? it will greatly help me to understand the examples =
i
>find:
>
>extern void omap_disable_gpio_wakeup(int gpio);
>extern int  omap_enable_gpio_wakeup(int gpio,int idlemode);
>extern void gpio_unmask_irq(unsigned int irq);
>
Actually if you have a TRM around then looking at the code and getting =
the functionality behind each of these API is not very difficult. They =
are less than 10 lines.

As name suggests, the following APIs are used to enable/disable GPIO pin =
interrupt capability. The mask one is not exported as it's binded to =
demux driver, the unmask one is exported don't remember why, you have to =
grep a bit.
gpio_unmask_irq
gpio_mask_irq

When system goes in suspend state, it can be put back to resume state =
using any of the available GPIO pins. These APIs enable/disable this =
functionality.
omap_enable_gpio_wakeup
omap_disable_gpio_wakeup

Regards,
Khasim
