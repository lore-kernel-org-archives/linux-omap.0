From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 01/16] ARM: OMAP2 Provide function to enable/disable
	uart clocks
Date: Wed, 20 Aug 2008 10:28:14 +0300
Message-ID: <20080820072813.GB28862@atomide.com>
References: <1212803277-18007-1-git-send-email-tony@atomide.com> <1212803277-18007-2-git-send-email-tony@atomide.com> <20080819164013.GA17034@flint.arm.linux.org.uk> <87r68k6xse.fsf@trdhcp146196.ntc.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:59333 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751727AbYHTH2V (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 20 Aug 2008 03:28:21 -0400
Content-Disposition: inline
In-Reply-To: <87r68k6xse.fsf@trdhcp146196.ntc.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?iso-8859-1?Q?H=F6gander?= Jouni <jouni.hogander@nokia.com>
Cc: ext Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org

* H=F6gander Jouni <jouni.hogander@nokia.com> [080820 08:50]:
> "ext Russell King - ARM Linux" <linux@arm.linux.org.uk> writes:
>=20
> > On Fri, Jun 06, 2008 at 06:47:42PM -0700, Tony Lindgren wrote:
> >> This patch adds common function to enable/disable omap2/3 uart
> >> clocks. Enabled uarts are passed by bootloader in atags and clocks=
 for
> >> these enabled uarts are touched.
> >
> > In some ways, this patch is a good thing, in others it's outrageous=
=2E
> >
> >> -static struct clk * uart1_ick =3D NULL;
> >> -static struct clk * uart1_fck =3D NULL;
> >> -static struct clk * uart2_ick =3D NULL;
> >> -static struct clk * uart2_fck =3D NULL;
> >> -static struct clk * uart3_ick =3D NULL;
> >> -static struct clk * uart3_fck =3D NULL;
> >> +static struct clk *uart_ick[OMAP_MAX_NR_PORTS];
> >> +static struct clk *uart_fck[OMAP_MAX_NR_PORTS];
> >> =20
> >>  static struct plat_serial8250_port serial_platform_data[] =3D {
> >>  	{
> >> -		.membase	=3D (char *)IO_ADDRESS(OMAP_UART1_BASE),
> >> +		.membase	=3D (__force void __iomem *)IO_ADDRESS(OMAP_UART1_BASE=
),
> >
> > __force in drivers is a big no no, immediate patch rejection.  Driv=
ers
> > do not use __force.
> >
> > The reason for adding __iomem is to pick up where people are doing
> > stupid things with pointers, and __force is added in _private_ code
> > (eg, functions supporting IO, mapping functions, etc) to provide a
> > way of saying "this is part of the infrastructure and its permitted
> > to do this conversion."
> >
> > The correct place for that cast, in its entirety, is inside the
> > IO_ADDRESS macro.
> >
> >> @@ -71,7 +67,7 @@ static inline void serial_write_reg(struct plat_=
serial8250_port *p, int offset,
> >>  				    int value)
> >>  {
> >>  	offset <<=3D p->regshift;
> >> -	__raw_writeb(value, (unsigned long)(p->membase + offset));
> >> +	__raw_writeb(value, p->membase + offset);
> >
> > Good.
> >
> >> @@ -87,10 +83,27 @@ static inline void __init omap_serial_reset(st=
ruct plat_serial8250_port *p)
> >>  	serial_write_reg(p, UART_OMAP_SYSC, (0x02 << 3) | (1 << 2) | (1 =
<< 0));
> >>  }
> >> =20
> >> -void __init omap_serial_init()
> >> +void omap_serial_enable_clocks(int enable)
> >> +{
> >> +	int i;
> >> +	for (i =3D 0; i < OMAP_MAX_NR_PORTS; i++) {
> >> +		if (uart_ick[i] && uart_fck[i]) {
> >> +			if (enable) {
> >> +				clk_enable(uart_ick[i]);
> >> +				clk_enable(uart_fck[i]);
> >> +			} else {
> >> +				clk_disable(uart_ick[i]);
> >> +				clk_disable(uart_fck[i]);
> >> +			}
> >> +		}
> >> +	}
> >> +}
> >
> > Urgh.  Why enable all clocks?  I thought OMAP was about being as le=
an
> > and mean as possible as far as power management goes, so why enable
> > everything and disable everything?
>=20
> Not everything, just those that are marked as a enabled by a
> bootloader. This mean basically serial-console uart. If all three oma=
p
> uarts are used as a serial console, then this function will
> disable/enable clocks for all of them.

Or marked as enabled in board-*.c file. The omap ATAGs are not going
to mainline tree as discussed earlier and will get removed from l-o
tree eventually also. Any bootloader tags must be generic, such as
ATAG_UART or something similar.

> > Looking at the omapzoom tree, this function isn't even referenced b=
y
> > another part of the kernel, so maybe this function is just cruft?
>=20
> This function is added for dynamic PM to have a mean to enable/disabl=
e
> serial console clocks. My intention is to be able to have PM when
> serial console is used without need to reboot the device and changing
> atags from the bootloader. There are patches on linux-omap list which=
 are
> using this. They are not pushed yet.

The long term solution is to switch to omap-uart instead of 8250.c so w=
e
can support DMA and dynamic power and clocking.

>=20
> >
> >> +		sprintf(name, "uart%d_ick", i+1);
> >> +		uart_ick[i] =3D clk_get(NULL, name);
> >> +		if (IS_ERR(uart_ick[i])) {
> >> +			printk(KERN_ERR "Could not get uart%d_ick\n", i+1);
> >> +			uart_ick[i] =3D NULL;
> >> +		} else
> >> +			clk_enable(uart_ick[i]);
> >> +
> >> +		sprintf(name, "uart%d_fck", i+1);
> >> +		uart_fck[i] =3D clk_get(NULL, name);
> >> +		if (IS_ERR(uart_fck[i])) {
> >> +			printk(KERN_ERR "Could not get uart%d_fck\n", i+1);
> >> +			uart_fck[i] =3D NULL;
> >> +		} else
> >> +			clk_enable(uart_fck[i]);
> >
> > Definitely an improvement, but still some way to go yet... but not =
a
> > reason not to get this in (once the above issues have been resolved=
=2E)
> >
> >
>=20
> --=20
> Jouni H=F6gander
>=20
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
