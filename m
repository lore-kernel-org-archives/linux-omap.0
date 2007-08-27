From: <Tuukka.Tikkanen@elektrobit.com>
Subject: RE: [PATCH 28/28] omap2 clock: handle (almost) all clock
	autoidlingviathe clock framework
Date: Mon, 27 Aug 2007 17:13:55 +0300
Message-ID: <3E32F84CD6CB95498A35B353CA3B930C0672FD@fioues08.ebgroup.elektrobit.com>
References: <20070820095347.933473149@pwsan.com><20070820095532.728389316@pwsan.com>
	<3B6D69C3A9EBCA4BA5DA60D91302742901AD7C60@dlee13.ent.ti.com>
	<3E32F84CD6CB95498A35B353CA3B930C0672EE@fioues08.ebgroup.elektrobit.com>
	<Pine.LNX.4.64.0708270139510.17118@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="----------=_1188224125-5307-22"
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <Pine.LNX.4.64.0708270139510.17118@utopia.booyaka.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: paul@pwsan.com
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

This is a multi-part message in MIME format...

------------=_1188224125-5307-22
Content-class: urn:content-classes:message
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

=20

From: paul@utopia.booyaka.com [mailto:paul@utopia.booyaka.com] On Behalf
Of Paul Walmsley
>=20
> On Thu, 23 Aug 2007, Tuukka.Tikkanen@elektrobit.com wrote:
>=20
> > One minor detail to note is that on OMAP2 the sleep code sometimes
has
> > to disable the autoidle feature on certain clocks. Not doing so
would
> > prevent desired functionality. This - at least the action of setting
the
> > autoidle state - of course could be handled via the clock framework.
> > However, it was deemed to be unnecessary extra layer, as the sleep
code
> > already has to be very aware of the hardware its running on and any
> > abstraction is useless. I think at least timers and DMA have some
> > special restrictions in pm.c. Thus the original design of PM code
> > handling the autoidle bits.
>=20
> Hi Tuukka,
>=20
> I took a quick look at pm.c, it configures ICLK autoidling for SDMA
and=20
> GPT*, and sleep.S doesn't look like it touches the autoidle regs.
Could=20
> you point me at the code you're talking about?

Sorry for the false alarm, guys. The code I was thinking about lives in
OMAP1 tree. The clock framework updates variable called
arm_idlect1_mask. That value is programmed after some masking into
hardware in omap_pm_idle when entering sleep state. Essentially what we
have there is a mask of clocks that may not be autoidled during that
particular idle call.

The OMAP2 tree seems to handle its special cases in another way by
skipping the sleep completely.

Tuukka


----------------------------------------------------------------
Please note: This e-mail may contain confidential information
intended solely for the addressee. If you have received this
e-mail in error, please do not disclose it to anyone, notify
the sender promptly, and delete the message from your system.
Thank you.


------------=_1188224125-5307-22
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


------------=_1188224125-5307-22--
