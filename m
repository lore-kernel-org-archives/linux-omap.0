From: "Hunter, Jon" <jon-hunter@ti.com>
Subject: RE: OMAP2430: MUSB: Ethernet Gadget Issue
Date: Fri, 7 Dec 2007 14:55:04 -0600
Message-ID: <5573C19A4BBDB441BED2A44157E9705302C29F21@dlee12.ent.ti.com>
References: <F3AC19E99E5D024AB9E6FB2A01683D8A02D46D68@dlee10.ent.ti.com>
	<200712060817.35806.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <200712060817.35806.david-b@pacbell.net>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: David Brownell <david-b@pacbell.net>, "Foale, Jeff" <j-foale@ti.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

> So it's a silicon or RTL bug then?  My generic MUSB docs say:


At this point I do not believe that we have enough evidence to say that
it is either a software or a hardware bug. However, if let me know if
you have any inputs on this. =20

As Jeff mentioned before we know that transfers stop because a interrupt
on the tx side from the DMA controller does not occur, but we still do
not know why and we are still trying to track down the root cause.=20

Cheers
Jon
