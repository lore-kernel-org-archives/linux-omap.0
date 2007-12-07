From: "Hunter, Jon" <jon-hunter@ti.com>
Subject: RE: OMAP2430: MUSB: Ethernet Gadget Issue
Date: Fri, 7 Dec 2007 14:55:06 -0600
Message-ID: <5573C19A4BBDB441BED2A44157E9705302C29F22@dlee12.ent.ti.com>
References: <200711231226.44592.david-b@pacbell.net>
	<F3AC19E99E5D024AB9E6FB2A01683D8A02C381EE@dlee10.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <F3AC19E99E5D024AB9E6FB2A01683D8A02C381EE@dlee10.ent.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: "Foale, Jeff" <j-foale@ti.com>, David Brownell <david-b@pacbell.net>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

> We discovered the root cause is that on the OMAP TX side, a=20
> DMA transfer
> is initiated but never completes due to the completion interrupt never
> happening.
>=20
> We still do not know why the interrupt doesn't happen.


Just to be clear, Jeff was able to track down the state the driver when
the failure occurs, but I would not say that we truly understand the
"root cause" of why the interrupt does not occur.

Jon=20
