From: David Brownell <david-b@pacbell.net>
Subject: Re: OMAP2430: MUSB: Ethernet Gadget Issue
Date: Thu, 6 Dec 2007 08:17:35 -0800
Message-ID: <200712060817.35806.david-b@pacbell.net>
References: <F3AC19E99E5D024AB9E6FB2A01683D8A02D46D68@dlee10.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <F3AC19E99E5D024AB9E6FB2A01683D8A02D46D68@dlee10.ent.ti.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: "Foale, Jeff" <j-foale@ti.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

On Wednesday 05 December 2007, Foale, Jeff wrote:
>=20
> I noticed some comments in the musb_gadget.c code:
>=20
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0/* REVISIT for high ban=
dwidth, MUSB_TXCSR_P_INCOMPTX
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * probably rates repor=
ting as a host error
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 */
> The MUSB_TXCSR_P_INCOMPTX flag is set on the bad transfer. It seems to
> not be handled correctly (at all).

So it's a silicon or RTL bug then?  My generic MUSB docs say:

> > When the endpoint is being used for high-bandwidth Isochronous/Interr=
upt
> > transfers, this bit is set to indicate where a large packet has been =
split
> > into 2 or 3 packets for transmission but insufficient IN tokens have =
been
> > received to send all the parts. Note: In anything other than a high-
> > bandwidth transfer, this bit will always return 0.

Those endpoints aren't high bandwidth, or even ISO/INTR.  And yet you
report that bit isn't set to zero ...

- Dave
