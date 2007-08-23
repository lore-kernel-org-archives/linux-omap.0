From: <Tuukka.Tikkanen@elektrobit.com>
Subject: RE: [PATCH 28/28] omap2 clock: handle (almost) all clock
	autoidlingviathe clock framework
Date: Thu, 23 Aug 2007 12:21:17 +0300
Message-ID: <3E32F84CD6CB95498A35B353CA3B930C0672EE@fioues08.ebgroup.elektrobit.com>
References: <20070820095347.933473149@pwsan.com><20070820095532.728389316@pwsan.com>
	<3B6D69C3A9EBCA4BA5DA60D91302742901AD7C60@dlee13.ent.ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="----------=_1187861122-6190-14"
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <3B6D69C3A9EBCA4BA5DA60D91302742901AD7C60@dlee13.ent.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: r-woodruff2@ti.com, paul@pwsan.com, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

This is a multi-part message in MIME format...

------------=_1187861122-6190-14
Content-class: urn:content-classes:message
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-----Original Message-----
> Subject: RE: [PATCH 28/28] omap2 clock: handle (almost) all clock
autoidlingviathe clock framework
>=20
> Hi Paul,
>=20
> > Existing OMAP2 code autoidles clocks via pm.c.  OMAP clock framework
> > already has some support for enabling autoidle mode via the
allow_idle
> > function; however, this is currently unused.  Take advantage of this
> > support by adding autoidle register and bit information for each
> > clock, defining an omap2_clk_allow_idle() function, and adding a
> > framework-wide function, clk_allow_idle_all(), to autoidle all
clocks,
> > intended to be called on init.  Remove all but the APLL/DPLL
autoidle
> > bit twiddling from pm.c -- we don't yet have generalized support for
> APLL
> > autoidle.  Handling autoidle via the clock framework ensures that we
> only
> > touch clocks that are currently configured.
>=20
> I thought about doing this back when OMAP1 added this when I was more
> active on OMAP2.  However, I dropped it as it didn't have enough
'bang'
> in this form.  I think these registers (even in OMAP1) are widely
> mis-understood.  This is partially a TRM issue and one of complexity.

One minor detail to note is that on OMAP2 the sleep code sometimes has
to disable the autoidle feature on certain clocks. Not doing so would
prevent desired functionality. This - at least the action of setting the
autoidle state - of course could be handled via the clock framework.
However, it was deemed to be unnecessary extra layer, as the sleep code
already has to be very aware of the hardware its running on and any
abstraction is useless. I think at least timers and DMA have some
special restrictions in pm.c. Thus the original design of PM code
handling the autoidle bits.

Tuukka


----------------------------------------------------------------
Please note: This e-mail may contain confidential information
intended solely for the addressee. If you have received this
e-mail in error, please do not disclose it to anyone, notify
the sender promptly, and delete the message from your system.
Thank you.


------------=_1187861122-6190-14
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


------------=_1187861122-6190-14--
