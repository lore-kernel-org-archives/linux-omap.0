From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: How to program flash of custom OMAP board?
Date: Sat, 6 May 2006 08:58:42 -0500
Message-ID: <EA12F909C0431D458B9D18A176BEE4A5058CE39B@dlee02.ent.ti.com>
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
To: Li Weichen <iaadoa@gmail.com>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Perhaps it needs a tweak. In the OMAP u-boots I've worked on, I made
sure to add a couple checks to see if the address it was executing from
was SDRAM or its compiled address.  If that is the case it should skip
the clock and DDR init phases as you can't be running in DDR if it
wasn't inited (ie via gel).

It might be these were removed when the OSK port was done.  They
shouldn't be to hard to put back.  If they are missing you will crash
when the memory goes away underneath the code executing.

Regards,
Richard W.

> -----Original Message-----
> From: Li Weichen [mailto:iaadoa@gmail.com]
> Sent: Saturday, May 06, 2006 3:16 AM
> To: Woodruff, Richard; linux-omap-open-source@linux.omap.com
> Subject: RE: How to program flash of custom OMAP board?
>=20
> > For many OMAP-u-boot ports, if you have a JTAG debugger, you can
connect
> > to the board, initialize clocks & ddr via script, load u-boot into
> > memory and execute it.  Now you can download using either your JTAG
or
> > ether the image you want to burn and use u-boot to burn that image.
> >
> But after I load the u-boot and run, it seems not work, only stop at
the
> beginning of the codes and there is not any information at the UART.
