From: NeilBrown <neilb@suse.de>
Subject: Re: patch "tty: serial: OMAP: ensure FIFO levels are set correctly
 in non-DMA" added to tty tree
Date: Fri, 3 Feb 2012 15:07:08 +1100
Message-ID: <20120203150708.386951d2@notabene.brown>
References: <13274430881471@kroah.org>
	<alpine.DEB.2.00.1201251156361.5324@utopia.booyaka.com>
	<20120126042155.GA3185@suse.de>
	<alpine.DEB.2.00.1201252124470.11174@utopia.booyaka.com>
	<20120126191604.GA15516@suse.de>
	<alpine.DEB.2.00.1201261225520.32667@utopia.booyaka.com>
	<alpine.DEB.2.00.1202021302070.586@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/PpVT4jkWiM2+FpUm.i6Bzcf"; protocol="application/pgp-signature"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:57254 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752817Ab2BCEHZ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 2 Feb 2012 23:07:25 -0500
In-Reply-To: <alpine.DEB.2.00.1202021302070.586@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Greg KH <gregkh@suse.de>, greg@kroah.com, khilman@ti.com, govindraj.raja@ti.com, tomi.valkeinen@ti.com, linux-serial@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

--Sig_/PpVT4jkWiM2+FpUm.i6Bzcf
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 2 Feb 2012 13:03:01 -0700 (MST) Paul Walmsley <paul@pwsan.com> wrot=
e:

> Hi Greg,
>=20
> On Thu, 26 Jan 2012, Paul Walmsley wrote:
>=20
> > On Thu, 26 Jan 2012, Greg KH wrote:
> >=20
> > > Ok, I've just reverted both of these patches for now, please send new
> > > ones when you have them.
> >=20
> > Thanks.  A pull request is at the bottom of this message.  The patches=
=20
> > are also available from the mailing list archives here:
> >=20
> > http://marc.info/?l=3Dlinux-arm-kernel&m=3D132754676014389&w=3D2
> > http://marc.info/?l=3Dlinux-arm-kernel&m=3D132754677914395&w=3D2
> > http://marc.info/?l=3Dlinux-arm-kernel&m=3D132754676014388&w=3D2
>=20
> Any comments on these?=20

Can I comment??...  They are good but ....

I've tried two approaches to getting serial behaviour that I am happy with.
They are with and without runtime pm.

If I enable runtime pm by setting power/autosuspend_delay_ms (e.g. to 5000)
then CPUIDLE enters lower states and I think it uses less power but I
sometimes lose the first char I type (that is known) but also I sometimes g=
et
corruption on output.

The problem seems to be that we turn off the clocks when the kernel's ring
buffer is empty rather than waiting for the UART's fifo to be empty.
So I get corruption near the end of a stream of output ... not right at the
end so something must be turning the clocks back on somehow.

I can remove this effect with:

diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-ser=
ial.c
index f809041..c7ef760 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -440,7 +440,8 @@ static unsigned int serial_omap_tx_empty(struct uart_po=
rt *port)
 	spin_lock_irqsave(&up->port.lock, flags);
 	ret =3D serial_in(up, UART_LSR) & UART_LSR_TEMT ? TIOCSER_TEMT : 0;
 	spin_unlock_irqrestore(&up->port.lock, flags);
-	pm_runtime_put(&up->pdev->dev);
+	pm_runtime_mark_last_busy(&up->pdev->dev);
+	pm_runtime_put_autosuspend(&up->pdev->dev);
 	return ret;
 }
=20

i.e. when the tx buffer is empty, so turn the clocks off immediately, but=20
wait a while for the fifo to empty.  Hopefully the auto-suspend time is
enough.

But I decided not to pursue this further as turning off the clocks seems li=
ke
the wrong thing to be doing.  The OMAP UARTs have auto-suspend/auto-wake so
I would rather depend on that.  And turning off the clocks loses that first
character at 115200 and above (not below).

So I explored leaving the runtime_pm setting as it was.  This set a maximum
latency of 4444 usec (which should be 5555 as there are 10 bits per char)=20
so it didn't get very low down the CPUIDLE levels.

So I disabled the latency setting with hardware handshaking is used (as you
suggested once):


@@ -707,28 +708,37 @@ serial_omap_set_termios(struct uart_port *port, struc=
t ktermios *termios,
 	unsigned char cval =3D 0;
 	unsigned char efr =3D 0;
 	unsigned long flags =3D 0;
-	unsigned int baud, quot;
+	unsigned int baud, quot, bits;
=20
 	switch (termios->c_cflag & CSIZE) {
 	case CS5:
 		cval =3D UART_LCR_WLEN5;
+		bits =3D 5;
 		break;
 	case CS6:
 		cval =3D UART_LCR_WLEN6;
+		bits =3D 6;
 		break;
 	case CS7:
 		cval =3D UART_LCR_WLEN7;
+		bits =3D 7;
 		break;
 	default:
 	case CS8:
 		cval =3D UART_LCR_WLEN8;
+		bits =3D 8;
 		break;
 	}
=20
-	if (termios->c_cflag & CSTOPB)
+	bits +=3D 2; /* start bit plus stop bit */
+	if (termios->c_cflag & CSTOPB) {
 		cval |=3D UART_LCR_STOP;
-	if (termios->c_cflag & PARENB)
+		bits++;
+	}
+	if (termios->c_cflag & PARENB) {
 		cval |=3D UART_LCR_PARITY;
+		bits++;
+	}
 	if (!(termios->c_cflag & PARODD))
 		cval |=3D UART_LCR_EPAR;
=20
@@ -740,8 +750,12 @@ serial_omap_set_termios(struct uart_port *port, struct=
 ktermios *termios,
 	quot =3D serial_omap_get_divisor(port, baud);
=20
 	/* calculate wakeup latency constraint */
-	up->calc_latency =3D (USEC_PER_SEC * up->port.fifosize) / (baud / 8);
+	if (termios->c_cflag & CRTSCTS)
+		up->calc_latency =3D PM_QOS_CPU_DMA_LAT_DEFAULT_VALUE;
+	else
+		up->calc_latency =3D (USEC_PER_SEC * up->port.fifosize) / (baud / bits);
 	up->latency =3D up->calc_latency;
+	printk("Calc latency: %lld\n", (unsigned long long) up->calc_latency);
 	schedule_work(&up->qos_work);
=20
 	up->dll =3D quot & 0xff;


and now CPUIDLE uses lower states (especially if I enable_off_mode).

However I am using a lot more power than in 3.2.  That probably isn't all
UART-related, but there is one interesting observation.

If I watch /sys/kernel/debug/pm_debug/time and see where the time is spent
over a 30second period when the systems is mostly idle:

With runtime_pm disabled for UARTs, both PER and CORE are permanently ON,
and MPU is OFF nearly all the time. (This is with off_mode enabled).

If I then enabled runtime_pm with a 5 second autosuspend delay:
  CORE is still permanently ON (I think the USB might be doing that).
  PER  is OFF (7 seconds) RET (15 seconds) and ON (8 seconds).
but more surprising
  MPU  is OFF (8 sec) RET (8 sec) INA (9 sec) ON (4 secs).

So we get to turn PER off at the cost of turning the MPU on a lot.
(the periods in each state are only repeatable to a precision of 20%-50%).

I understand that PER won't go OFF without runtime PM, but I would expect
it to at least go to INA as the UART is in smart-idle mode

The net result is that with runtime_pm enabled I'm seeing an extra 7mA (at
4V). That might not be very precise, but it is in the opposite direction to
my expectations.

So there is something odd here...  ideas?

NeilBrown

p.s. who should I formally submit OMAP-UART patches to?  I have a couple of
others such as the below that I should submit somewhere.


diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index 247d894..35a649f 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -54,11 +54,9 @@
=20
 struct omap_uart_state {
        int num;
-       int can_sleep;
=20
        struct list_head node;
        struct omap_hwmod *oh;
-       struct platform_device *pdev;
 };
=20
 static LIST_HEAD(uart_list);
@@ -381,8 +379,6 @@ void __init omap_serial_init_port(struct omap_board_dat=
a *bd
=20
        oh->mux =3D omap_hwmod_mux_init(bdata->pads, bdata->pads_cnt);
=20
-       uart->pdev =3D pdev;
-
        oh->dev_attr =3D uart;
=20
        if (((cpu_is_omap34xx() || cpu_is_omap44xx()) && bdata->pads)

--Sig_/PpVT4jkWiM2+FpUm.i6Bzcf
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iQIVAwUBTytdbDnsnt1WYoG5AQImPxAAl8by+PAC2d6fgSBKtSdX9Jb1G9S+hfn/
EnP0MWGNiEkCMc99ajTNF2HrU67tLux/kvsKu7FB8RbcapMZA5pLw2VedV/tXeeN
QyRieFT6Z+OcPax3bmRWEl98OyYyBSA6URFIeFI/i/MWiRl9WDdZRJHoMWl2e6nv
W/6ORmOiqmZXdssQeCZk1p29hB/9rGnDvI7g1RSe+7Xc4Lyh+fGAoxApUZkEkpjY
RwNeUlXEbDBQbH9Q0BdZjqENdcMXhcSRHf0wZEQJ5VFYh0WJ2XoO9gchu/2gK7Ac
kB2kuALGHbRbNCMjXUixw862HnS47vUd+aEEq71ZeQIKjkqy6bDN4kfh8NZ77y6V
9+LPIkDmtsHL+sscvmVVH+rtAsmhh47LRKuL8s8LqSxbdi/P0v9jlarOdv3Wxxm7
ASszwX/JV5VbCIUQqG09xq7R6pX2mnEV5EJe1j9757UNDJvQrl6a1yin45cHsNoT
u8gIH09OHQxWBEVSNqTHHaIsFdFwU2tAjDcllml+N4H3x/FbcOm2+cte0HzbkLMJ
P4AuN08pWiF2MEVq1ETf4hlC26bjg7sZZMhRx+V3rVYUvy1VaCw5RIvOUWc7l3G0
GadJ9WwlZvG1MZ3mkM0n563fSkwe2SSmCT2ihaQU1Ejg3Ptrsb8TUbH5cpRaBjwp
PZWBXMrd2+0=
=C6GH
-----END PGP SIGNATURE-----

--Sig_/PpVT4jkWiM2+FpUm.i6Bzcf--
