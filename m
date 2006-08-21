From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: OMAP2 irq.c IVA_INTC base
Date: Mon, 21 Aug 2006 16:52:06 -0500
Message-ID: <EA12F909C0431D458B9D18A176BEE4A507360674@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
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
To: Komal Shah <komal_shah802003@yahoo.com>, linux-omap-open-source@linux.omap.com, paul.mundt@nokia.com
List-Id: linux-omap@vger.kernel.org

> I want one clarification about IVA_INTC base address in irq.c. I think
> that 0x40000000 address is only accessible in the IVA-MPU domain _not_
> in L3 domain, then how we are going to initialize it from ARM11 side?
I
> believe that it should be initialized by framework running on IVA1.0.

Yes I think that is correct.  The 0x40000000 is an IVA-ARM7 local bus
address.  The IVA-INTC is NOT accessible through the IVA-L3-Slave Port.
The current TRM does say this directly and indirectly in a few spots and
in figures.

The L3 address of 0x40000000 is for the internal mask ROM.

> We have only access to IVA registers of various blocks and
> co-processors which are mapped in the L3 domain.

That is correct.  The (interface slave port) ISP decodes incoming
transactions from the IVA-L3 slave port.  It provides L3 access to
things like the MMU, SYSC, and memories.  There is no path to the INTC.

Further I asked a bridge person here and they confirmed that the IVA
code is responsible for setting up the INTC.

Regards,
Richard W.
