From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: serial on omap in current git.
Date: Sun, 12 Feb 2006 16:13:42 -0600
Message-ID: <EA12F909C0431D458B9D18A176BEE4A5044B24F9@dlee02.ent.ti.com>
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
To: Tony Lindgren <tony@atomide.com>
Cc: Linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Actually it is more like this...


if (up->port.type !=3D PORT_16750) {
	if (fcr & UART_FCR_ENABLE_FIFO) {
		/* emulated UARTs (Lucent Venus 167x) need two steps */
		serial_outp(up, UART_FCR, UART_FCR_ENABLE_FIFO);
	}
	if(uart_config[up->port.type].flags & UART_CAP_EFR){
		serial_outp(up, UART_LCR, 0xBF); /*allow access to
EFR(vs LCR)*/
		serial_outp(up, UART_EFR, UART_EFR_ECB);/*allow FCR tx
fifo write*/
		serial_outp(up, UART_LCR, 0x0); /* access back to FCR */
		serial_outp(up, UART_FCR, fcr); /* set fcr with possible
TX fifo setting */
		serial_outp(up, UART_LCR, 0xBF);
		serial_outp(up, UART_EFR, 0);
		serial_outp(up, UART_LCR, cval); /* access back to FCR
*/
	} else
		serial_outp(up, UART_FCR, fcr);

In my build your last serial hack is not necessary anymore either.

I played around a bit trying to remove several of them.  To use the
actual TX watermark interrupt set at 32bytes required too ugly of a hack
to use (not use OMAP_SCR=3D0).

A minor note is we are still only using 32 bytes of the 64 byte TX fifo
for transmits in the current code.  I'm not sure if there is an
application that this matters to.


Regards,
Richard W.


> -----Original Message-----
> From: Woodruff, Richard
> Sent: Tuesday, February 07, 2006 6:19 PM
> To: 'Tony Lindgren'
> Cc: Linux-omap-open-source@linux.omap.com
> Subject: RE: serial on omap in current git.
>=20
> Here is one it should get the FCR set correctly.  There is still
something
> wrong though.
>=20
> Regards,
> Richard W.
>=20
>=20
> > -----Original Message-----
> > From: Tony Lindgren [mailto:tony@atomide.com]
> > Sent: Tuesday, February 07, 2006 6:14 PM
> > To: Woodruff, Richard
> > Cc: Linux-omap-open-source@linux.omap.com
> > Subject: Re: serial on omap in current git.
> >
> > * Woodruff, Richard <r-woodruff2@ti.com> [060207 16:00]:
> > > Tony,
> > >
> > > Not that it fixes the issue you saw but it may half explain
others.
> With
> > > the tx threshold interrupt.
> > >
> > > 	The:
> > > 		serial_outp(up, UART_FCR, fcr) in
> > > serial8250_set_termios() won't set the UART_FCR_T_TRIG_10 as
expected
> as
> > > the UART_EFR.UART_EFR_ECB bit is not set.  Bits 5:4 of the FCR are
not
> > > settable with out the EFR bit4 set.
> > >
> > > The current code seems to only think it needs to set the ECB at
sleep
> > > time, else it just writes a 0 back into the EFR.
> >
> > Thanks. Do you have a patch around for that?
> >
> > Tony
