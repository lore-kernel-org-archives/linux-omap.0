From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 1/2] ARM: OMAP3: PM: remove superfluous calls to
 pwrdm_clear_all_prev_pwrst()
Date: Tue, 31 Jan 2012 00:27:57 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1201310024510.10061@utopia.booyaka.com>
References: <20120130093931.11027.31048.stgit@dusk> <20120130094312.11027.31050.stgit@dusk> <878vkopw2o.fsf@ti.com> <CAMQu2gxyY50Bno_R2v1x98-ND47CrVpZBq+wA3POXz2+7E7eEw@mail.gmail.com> <alpine.DEB.2.00.1201302359320.10061@utopia.booyaka.com>
 <CAMQu2gyACq7RFyfnyNddDg7xRbHTTqsgXwMq6Ng4WfLxaatvAw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-892981717-1327994877=:10061"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:48117 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752337Ab2AaH15 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 31 Jan 2012 02:27:57 -0500
In-Reply-To: <CAMQu2gyACq7RFyfnyNddDg7xRbHTTqsgXwMq6Ng4WfLxaatvAw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: Kevin Hilman <khilman@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tero Kristo <t-kristo@ti.com>, Rajendra Nayak <rnayak@ti.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-892981717-1327994877=:10061
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 31 Jan 2012, Shilimkar, Santosh wrote:

> On Tue, Jan 31, 2012 at 12:45 PM, Paul Walmsley <paul@pwsan.com> wrote:
> > On Tue, 31 Jan 2012, Shilimkar, Santosh wrote:
> >
> >> In this code the need is to clear only CPU and MPUPD, and hence they a=
re
> >> explicitly cleared since the pre/post transition calls can be moved to=
 PM_DEBUG
> >> in production kernels.
> >>
> >> But as you stated in current mainline kernel they are superfluous sinc=
e the
> >> pre/post calls are not under PM debug. So I am ok either way
> >
> > We're using the PM counters for the context restore skip optimization n=
ow
> > in pwrdm_get_context_loss_count(), so they've suddenly become needed ev=
en
> > when PM_DEBUG=3Dn. =A0But those counters are only needed when there are
> > devices in the CPU* powerdomains to track that can lose logic context. =
=A0I
> > don't think that's the case on OMAP4, but you would probably know bette=
r
> > than I.
> >
> Good point so the pre/post calls are must then. We should kill those extr=
a calls
> form OMAP4 code then.

I wonder if we should track how many hwmods are present in a powerdomain? =
=20
We could check that counter to determine if we could skip the access.

> > Another aspect is that previous powerstate accesses for the CPU*
> > powerdomains would theoretically go to the MPU local PRM rather than th=
e
> > system PRCM. =A0So they may actually return quickly. =A0Haven't tested =
this.
> >
> You are correct. They do.

Cool.

> > The MPUSS powerdomain might be another case, though. =A0There are a bun=
ch of
> > devices in there: the local timers, APB debug devices, etc. =A0We proba=
bly
> > have to worry about restoring context for some of those at some point.
> >
> MPUSS PD is at the global PRCM level but that one doesn't take time eithe=
r.
> You need few more cycles to reach there.
> IIRC, other power domains use to take time because of the wait_transition
> calls we had. Mostly it was because of the BUGs you fixed. When get some
> time I will profile these calls and see if we still have that issue.

That would be interesting.  I was guessing that the previous powerstate=20
registers in the global PRCM might be located in some clockdomain that was=
=20
clocked at sys_clk or the 32KiHZ clock.  But if it's really just due to=20
the wait_transition(), that might be something we can optimize...


- Paul
--155748971-892981717-1327994877=:10061--
