From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: stacked memories
Date: Fri, 3 Aug 2007 18:28:59 -0500
Message-ID: <3B6D69C3A9EBCA4BA5DA60D913027429018FFA65@dlee13.ent.ti.com>
References: <a5eaedfa0708031514l5e467b50nf1c9a0af41445369@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <a5eaedfa0708031514l5e467b50nf1c9a0af41445369@mail.gmail.com>
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

>    What are stacked memory schemes and POP memory schemes in OMAP2430.
>=20
>    What is the difference?
>=20
>    Does stacked mean - Multiple chips of DDR one above the other?.
>=20
>    POP means one processor + one DDR + (nand/nor/one nand) ?
>=20
>    I am not sure if this is correct.
>=20
>    I came across these # defines in the x-loaders. Could anyone =
explain me
> what it means.
>=20
>=20
>  #define CFG_SDRAM_DDR         1 /* not tested */
> #define CFG_SDRAM_COMBO       2 /* not tested */
> #define CFG_2430SDRAM_DDR     3
> #define CFG_SDRAM_STACKED       4 /* not tested */

As terms in the boot loader for 24xx you have:

Generic terms:

	SIP =3D system in package (2422, 2423) here you have an OMAP+DDR in the =
same package wire bound together inside with balls on the bottom.

	POP =3D package on package (24x0-POP) here you have balls on top and =
balls on the bottom.  You 'stack' the chips on top of each other.  I =
guess they are soldered to each other.

Board specific terms:

"discrete" - separate chips.  Say 2x16 DDR devices =3D a 32bit memory as =
seen by the processor.  And likely a separate NOR or NAND chip.

"combo" - refers to the Samsung memory which has 2 ddr dies and 1 nand =
die all in one package.  This is effectively a SIP setup which you can =
buy.

As to the rest of your question, you can select STACKED but you still =
need to populate the proper MUX settings, and memory times for your =
device where ever the conditionals appear.

History is the H4 (2420) dev board had like 8 different memory =
configurations.  These were dynamically probed for.  When X-Loader was =
done these probes were unrolled into separate defines which just choose =
the correct one.  If we were to test X-Loader and supported multiple =
memories you should just choose the one you need.  So define only one =
and fill in the guts for it.

Regards,
Richard W.
