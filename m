From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v5 3/7] arm: perf: support device with other non-irq
 resources
Date: Tue, 25 Oct 2011 05:00:34 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1110250459160.12667@utopia.booyaka.com>
References: <1319467559-5518-1-git-send-email-ming.lei@canonical.com> <1319467559-5518-4-git-send-email-ming.lei@canonical.com> <20111024150814.GA4771@mudshark.cambridge.arm.com> <CACVXFVOzQ0QEnaAb=mLFdr7AU3H3TsT=wXcNgtqeUGVLXahd4Q@mail.gmail.com>
 <20111025083420.GA6184@mudshark.cambridge.arm.com> <alpine.DEB.2.00.1110250242130.27118@utopia.booyaka.com> <CACVXFVOVeuWpVGSUP-sDDbiWb=W8XVB+PDYns4ttK9+ty0GMmA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-1290372816-1319540434=:12667"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:55394 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751864Ab1JYLAf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 25 Oct 2011 07:00:35 -0400
In-Reply-To: <CACVXFVOVeuWpVGSUP-sDDbiWb=W8XVB+PDYns4ttK9+ty0GMmA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ming Lei <ming.lei@canonical.com>
Cc: Will Deacon <will.deacon@arm.com>, b-cousson@ti.com, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "tony@atomide.com" <tony@atomide.com>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-1290372816-1319540434=:12667
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

+ Beno=EEt

Hi

On Tue, 25 Oct 2011, Ming Lei wrote:

> On Tue, Oct 25, 2011 at 4:44 PM, Paul Walmsley <paul@pwsan.com> wrote:
> > On Tue, 25 Oct 2011, Will Deacon wrote:
> >
> >> Hurrah! If you can get the OMAP / hwmod bits acked by the OMAP guys th=
en I'm
> >> happy to take the perf and PMU changes into my tree.
> >
> > I'd suggest that you take the perf/PMU stuff yourself if you are happy
> > with it, and then we'll deal with the OMAP bits ourselves, since it loo=
ks
> > like they aren't dependent on each other, and the OMAP parts will need
> > changes.
>=20
> One omap4 patch(struct arm_pmu_platdata related) depends on 2/7, which
> need to be rebased. But I still suggest that arm perf/PMU stuff may be
> merged first.
>=20
> Paul, expect your comments on OMAP4 parts.

Beno=EEt is the right person to review OMAP4 hwmod data.

- Paul
--155748971-1290372816-1319540434=:12667--
