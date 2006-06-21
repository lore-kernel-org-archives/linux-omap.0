From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: Power domain addition.
Date: Wed, 21 Jun 2006 08:24:28 -0500
Message-ID: <EA12F909C0431D458B9D18A176BEE4A5064652ED@dlee02.ent.ti.com>
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
To: Komal Shah <komal_shah802003@yahoo.com>, Tony Lindgren <tony@atomide.com>
Cc: linux-omap-open-source@linux.omap.com, sampsa.fabritius@nokia.com
List-Id: linux-omap@vger.kernel.org

Yes, see below for the reasons.  I guess the basic point is it still
won't boot with out an Irda fix up.  I only highlighted the problem and
supplied a rough hack.  Whoever looks after Irda should get it fixed, or
have it removed from the default configuration.  It is possible its just
a compiler bug which then make it a little less clear.  The bug is from
a union structure of a u8 and u16 generating only byte aligned code
which is a no-no when used with a lrdh.

> Well, I have tried the latest kernel, but with MT_MEMORY and no PM
> support kernel stops here:
>=20
> ----------snip------------------
> <5>Linux version 2.6.17-omap1-gea5858eb-dirty (komal@everest) (gcc
> version 3.4.0
>  20040409 (CodeSourcery ARM Q1A 2004)) #49 Wed Jun 21 23:43:30 IST
2006
> CPU: Some Random V6 Processor [4107b362] revision 2 (ARMv6TEJ)
> Machine: OMAP2420 H4 board
> Memory policy: ECC disabled, Data cache writeback
> <7>On node 0 totalpages: 32768
> <7>  DMA zone: 32768 pages, LIFO batch:7
> <6>OMAP2420
> <4>BUG: map for 0x4020f000 at 0xd0000000 can not be mapped using
pages,
> ignoring
> .
> <6>SRAM: Mapped pa 0x4020f000 to va 0xd0000000 size: 0x100000

This is because you can't just change MT_DEVICE to MT_MEMORY with out
changing the mapping size.  Templates are not given for PTE generation
only section entries.  That is why I changed the size to 1024*1024. As
indicated I tried a quick extension to make my own type but found it
must also change the code which sets the EXEC bit and didn't want to do
that, so just increased the to something which would generate what I
want.


> ----------snip------------------
>=20
> And with MT_DEVICE and PM support, it stops after IrDA driver
> initialzing message:

This is due to the misalignment in the Irda structure.  Your root file
system must have a script which activates this path as mine does.

This is why I added the hack to the irlamp structure.  Else it would not
boot.

Regards,
Richard W.
