From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: Moving I2C2 init to plat-omap/devices.c  ?
Date: Wed, 15 Nov 2006 20:30:46 -0600
Message-ID: <EA12F909C0431D458B9D18A176BEE4A50899CB80@dlee02.ent.ti.com>
References: <20061116015528.GR21064@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <20061116015528.GR21064@atomide.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Tony Lindgren <tony@atomide.com>, "Syed Mohammed, Khasim" <x0khasim@ti.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

- OMAP1 and OMAP2420 use the same IP block for I2c.

- OMAP2420 has 2 instances of the same IP.
	-- We just added code in the single driver to allow 2 ports.

- OMAP2430 & OMAP3430 extended the functionality of the I2C IP.  It did
this in a mostly compatible fashion by defining previously reserved
bits.  The new function adds the ability to do high speed operation.
New interrupts, clock combinations, deeper fifos, and DMA options are
the changes.
	-- High speed allows quick power control.

- OMAP2430 has 2 IP instances of these high speed capable ports.

- OMAP3430 has 3 IP instance, driver controllable ports.  A 4th instance
is also on the chip but it is not driver controllable and is managed
directly by hardware for smart reflex protocol exchanges with the power
chip.
	-- 2430 generally uses a dedicated I2C channel to control the
power chip.
	-- 3430 uses 2 channels to the power chip, 1 control, 1
automatic.

For quicker time to functionality and isolation between release streams
we created 2 separate versions, one for 2420 and one for 2430/3430
versions.  A merged version is possible but would take a bit more time.

How things end up in this tree and the final tree is the course which
needs plotting.=20

Regards,
Richard W.


> -----Original Message-----
> From: linux-omap-open-source-bounces@linux.omap.com
[mailto:linux-omap-
> open-source-bounces@linux.omap.com] On Behalf Of Tony Lindgren
> Sent: Wednesday, November 15, 2006 7:55 PM
> To: Syed Mohammed, Khasim
> Cc: linux-omap-open-source@linux.omap.com
> Subject: Re: Moving I2C2 init to plat-omap/devices.c ?
>=20
> * Syed Mohammed, Khasim <x0khasim@ti.com> [061116 03:22]:
> > Tony,
> >
> > Agreed, it might be early to talk on 3430. I was just giving
examples of
> > I2C blocks across OMAPs.
> >
> > For my work now, I will follow the existing structure. This can be
> > discussed later along with 3430 code placement :)
>=20
> Yeah, and we may want to add some common init function where you just
> pass the port offsets or something like that.
>=20
> Regards,
>=20
> Tony
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
