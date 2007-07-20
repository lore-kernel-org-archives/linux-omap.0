From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: clock trees
Date: Fri, 20 Jul 2007 07:30:47 -0500
Message-ID: <3B6D69C3A9EBCA4BA5DA60D9130274290176C5C7@dlee13.ent.ti.com>
References: <a5eaedfa0707200455k21535ba9l5f3aa2dc8aa0c959@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <a5eaedfa0707200455k21535ba9l5f3aa2dc8aa0c959@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Veda N <veda74@gmail.com>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

> Hi,
>     OMAP 2430 supports 5 clock frequencies 12 MHZ, 13 MHZ, 19.2-MHz,
24MHZ,
> 26MHZ

The values which matter for the DPLL are 12,13,19.2.  These are the only
ones the APLL can be tuned for.  The 24 and 26 have to be divided by 2
at the top of the tree.  24 and 26 do go around and can be used by an
external or stacked modem directly but they don't get used much by
things inside of the chip.

>     There is a rate_table clock.h/clock.c in linux kernel which has
> support
> for 13MHZ.
>=20
>     If the crystal frequency is 12/19.2 MHZ. What changes do we need
to
> make
>=20
>     in the linux kernel to support the new frequencies.
>=20
>     Does kernel really need these clock tables as they are set in the
> bootloader.

You can use what the boot loaders sets and not change it.  However, if
you want to do DVFS you will need to reprogram settings and this is what
the tables are for.

The DPLL M&N, APLLS field, 1st level divider values are different
depending on which input clock is in use.  Also, depending on the OPP
wanted the major dividers all need to change.

The table gets used when you set your virtual prcm clock to a new clock
configuration.

>     Does the kernel change the values of clocks set in the bootloader.

Yes it can.  Whether it does depend on your configuration and usage.

Regards,
Richard W.
