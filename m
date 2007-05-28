From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: write memory barrier
Date: Sun, 27 May 2007 19:47:40 -0500
Message-ID: <3B6D69C3A9EBCA4BA5DA60D91302742901158463@dlee13.ent.ti.com>
References: <1180304111.3430.31.camel@Dogbert.NOE.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <1180304111.3430.31.camel@Dogbert.NOE.nokia.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Igor Stoppa <igor.stoppa@nokia.com>, Linux OMAP ml <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Some more specifics might be helpful.

Generally, the commit of a divider change should happen in SRAM.  Much
of the effects should be synchronized with the commit for the clocks in
listed as delayed.  When dividing by 2 SDRC/GPMC timings might require
changes to keep their buses visible.

Some clocks do have some side effects of changes, but it might be
unlikely you access them quickly enough to see the effect.  M/N changes
take a while.  Depending on I to F clock ratios and posted/non-posted
timers might take a bit.
=20
Regards,
Richard W.


> Hi,
> I am wondering if/when i should use a barrier: I am changing the
> settings of the dividers and such operation requires writing to
> prcm_clkcfg_ctrl after programminig the new set of dividers.
>=20
> So far it seems to work without barriers, but i'm wodering if i'm just
> been lucky, while the OMAP2 TRM seems to refer only to interacting
with
> the INTC, when referrinig to memory barriers.
>=20
> I have also checked the ARM1136 TRM but couldn't find anything that
> would seem to be related to my problem.
>=20
> Thanks in advance for any info.
>=20
> --
> Cheers, Igor
>=20
> Igor Stoppa <igor.stoppa@nokia.com>
> (Nokia Multimedia - CP - OSSO / Helsinki, Finland)
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
