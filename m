From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 1/2] ARM: OMAP3: PM: remove superfluous calls to
 pwrdm_clear_all_prev_pwrst()
Date: Thu, 2 Feb 2012 01:33:38 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1202020041220.10541@utopia.booyaka.com>
References: <20120130093931.11027.31048.stgit@dusk> <20120130094312.11027.31050.stgit@dusk> <878vkopw2o.fsf@ti.com> <87mx93ok5y.fsf@ti.com> <alpine.DEB.2.00.1202011218190.10541@utopia.booyaka.com>
 <CAMQu2gzVt3K6cuZcbvfNZegimyXz8F4N__A6vDBSyL4QfSnbTw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-1809992936-1328171618=:10541"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:35641 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754821Ab2BBIdj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 2 Feb 2012 03:33:39 -0500
In-Reply-To: <CAMQu2gzVt3K6cuZcbvfNZegimyXz8F4N__A6vDBSyL4QfSnbTw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: Rajendra Nayak <rnayak@ti.com>, Tero Kristo <t-kristo@ti.com>, Kevin Hilman <khilman@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-1809992936-1328171618=:10541
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi

On Thu, 2 Feb 2012, Shilimkar, Santosh wrote:

> On Thu, Feb 2, 2012 at 12:57 AM, Paul Walmsley <paul@pwsan.com> wrote:
>
> > N.B., I haven't looked at this file before. =A0There are a few other th=
ings
> > that don't look right that hopefully someone can take the initiative to
> > fix. =A0For example, those calls to mpuss_clear_prev_logic_pwrst() and
> > cpu_clear_prev_logic_pwrst() should be removed as well. =A0That should =
be
> > done by pwrdm_clear_all_prev_pwrst() in mach-omap2/powerdomain44xx.c.
> > Currently it's not, so that needs to be patched.
> >
> We(rajendra and myself) discussed this some time back with Benoit and we =
agreed
> that for CPU and MPU power domains which are needed very early in the PM =
power
> up sequence, we can do direct APIs..

Looking at the call sites, don't these calls occur quite late in boot,=20
after everything is initialized?  I see calls from a late_initcall() and a=
=20
suspend entry function.  Am I missing something?

> These calls were in critical path and the PD API's proposed for context c=
lear
> and logic clear were use to iterate over all power domains.

The code iterates over all powerdomains anyway a few lines above those=20
calls, right?

If the code only needs to iterate over a subset, let's discuss what you=20
need and a different iterator can be implemented in the powerdomain code.

> It is only recently we got clear context etc some reasonable form
> even though it still iterates over all hwmod etc which is really overhead=
=2E

Which mainline PM calls iterate over all hwmods?

> Also you need to create 'pdev' etc for context-loss kind of APIs and
> we all thought that that makes things un-ncessary complicated and
> lengthy.

Could you point out the code that you are referring to?  I seem to be=20
missing it :-(

If the existing powerdomain API is missing something you need, there's no=
=20
problem to add it.  It makes things easier to debug and more portable in=20
the long term if there is a clean, standard interface.  Another hope is=20
that more of the PM code can be shared.

In terms of performance, it seems pretty unlikely that one would be able=20
to measure a meaningful performance difference, unless we are missing an=20
API call that was needed?  As we were discussing before, device reads are=
=20
likely to dominate the profile.

Flipping through the code, I see that code is getting duplicated again. =20
We now have three identical copies of clkdms_setup().  The OMAP4=20
pwrdms_setup() is doing string comparisons to skip powerdomains -- that's=
=20
also pretty fragile; that should be controlled through powerdomain flags=20
or some similar mechanism.  Once that's fixed, it looks to me like that=20
function could be shared with the OMAP34xx pwrdms_setup()?  Looks like we=
=20
could also share omap{3,4}_pm_suspend() and omap{2,3,4}_pm_{begin,end}?

It would be good if we can keep working towards making as much of this=20
code as common as possible.  If already-tested code can be reused, that=20
should cut down on bugs and maintainer workload.  Also, we can avoid=20
adding unnecessary lines of diff; we are trying to cut that down too..

> > Also all of the open-coded powerdomain register accesses in
> > omap-mpuss-lowpower.c should be removed - those should all go through
> > pwrdm_*() functions...
> >
>  I will have another look at the code with your recent power domain=20
> clean-ups and see what all can be moved to generic APIs.

That would be great!


- Paul
--155748971-1809992936-1328171618=:10541--
