From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v5 4/7] arm: omap4: hwmod: introduce emu hwmod
Date: Sat, 19 Nov 2011 20:27:19 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1111192019200.30133@utopia.booyaka.com>
References: <1319467559-5518-1-git-send-email-ming.lei@canonical.com> <1319467559-5518-5-git-send-email-ming.lei@canonical.com> <alpine.DEB.2.00.1111080750130.10451@utopia.booyaka.com> <CACVXFVMSJUT2Ac+bWetrLpbyOs6PqY+npNHsbvHipEVZ0gWdgQ@mail.gmail.com>
 <alpine.DEB.2.00.1111100152430.4195@utopia.booyaka.com> <4EC6566C.70202@ti.com> <20111118145635.GB17991@mudshark.cambridge.arm.com> <CACVXFVNuz62+2DzOks3-0io2Ni=LK5SJienU4GcGRMtkh92vvQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-438451069-1321759212=:30133"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:42178 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755153Ab1KTD1U (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 19 Nov 2011 22:27:20 -0500
In-Reply-To: <CACVXFVNuz62+2DzOks3-0io2Ni=LK5SJienU4GcGRMtkh92vvQ@mail.gmail.com>
Content-ID: <alpine.DEB.2.00.1111192020260.30133@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ming Lei <ming.lei@canonical.com>, Will Deacon <will.deacon@arm.com>
Cc: "Cousson, Benoit" <b-cousson@ti.com>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "tony@atomide.com" <tony@atomide.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-438451069-1321759212=:30133
Content-Type: TEXT/PLAIN; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <alpine.DEB.2.00.1111192020261.30133@utopia.booyaka.com>

Hi

On Sat, 19 Nov 2011, Ming Lei wrote:

> On Fri, Nov 18, 2011 at 10:56 PM, Will Deacon <will.deacon@arm.com> wrote=
:
>
> > Ming Lei - can you take this into your patch series please?
>=20
> Yes, I have made omap4 pmu work already with Benoit's patch,
> and if no one has objections on other patches(5/7, 6/7, 7/7), I
> can post out the next version for -next tree.
>=20
> > Then we'll have:
> >
> > =A0 =A0 =A0 =A0- The two perf patches in my tree
> > =A0 =A0 =A0 =A0- The hwmod fix in Tony's tree (pending pull)
> > =A0 =A0 =A0 =A0- Your patches plus this one for hooking everything toge=
ther
> >
> > The sooner we can push these into -next, the better.

The OMAP-specific parts should be queued up in my/Beno=EEt's/Tony's trees,=
=20
rather than placed directly into -next.  Otherwise they are likely to=20
generate merge conflicts with other OMAP changes that we may generate.

So I'd suggest splitting patches 1-3 off into a separate series that Will=
=20
can pass on to -next if he wishes.


- Paul
--155748971-438451069-1321759212=:30133--
