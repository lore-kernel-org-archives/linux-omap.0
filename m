From: Rajendra Nayak <rnayak@ti.com>
Subject: RE: [PATCH 2/5] OMAP: clockdomain: Arch specific funcs to handle deps
Date: Wed, 19 Jan 2011 16:31:11 +0530
Message-ID: <084811f2c7ebdf9f8202ff3d9dad4854@mail.gmail.com>
References: <1294237365-10893-1-git-send-email-rnayak@ti.com>
 <1294237365-10893-2-git-send-email-rnayak@ti.com> <1294237365-10893-3-git-send-email-rnayak@ti.com>
 <alpine.DEB.2.00.1101101808530.5731@utopia.booyaka.com> <327d60b24fab12f48959caa67ba83c51@mail.gmail.com>
 <alpine.DEB.2.00.1101132243400.28621@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:58896 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753650Ab1ASLH3 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 19 Jan 2011 06:07:29 -0500
Received: by mail-fx0-f45.google.com with SMTP id 12so711997fxm.4
        for <linux-omap@vger.kernel.org>; Wed, 19 Jan 2011 03:07:28 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1101132243400.28621@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, khilman@deeprootsystems.com, Benoit Cousson <b-cousson@ti.com>, Rene Sapiens <rene.sapiens@ti.com>

Hi Paul,

<..>..
>
> > > Static wakeup dependency support appears a little more tricky, si=
nce
> > > the dependencies are between modules and clockdomains on OMAP4,
rather
> > > than between clockdomains and clockdomains as they were on OMAP2/=
3.
> > > One way to handle this would be to change the existing wkdep
interface
> > > for all OMAPs to be between modules and clockdomains; then for th=
e
> > > OMAP2/3 implementations, use the hwmod code/data to get the
> > > clockdomain of the module's main_clk.  Another is to add a separa=
te
> > > interface to add wkdeps between a module and clockdomain, use tha=
t
for
> > > OMAP4, but use the existing clockdomain-to-clockdomain interface =
for
> > > OMAP2/3.  It might be necessary to do both until the hwmod data i=
s
> > > more complete, then perhaps phase out the latter interface.
> > > Thoughts?
> >
> > The wakeup dependency here (between a module and a clock domain) is
very
> > different from the static dependency (between clock domains) and ve=
ry
> > much like what the PM_<processor>_GRPSEL registers handled in OMAP3=
=2E
> > They are used to control which processor is woken up on a given
module/
> > peripheral wakeup event.
>
> According to the 34xx TRM Rev. ZH section 4.8.5.2, both the GRPSEL an=
d
> WKDEP bits need to be set for the target clockdomain to be awakened, =
if
> the target clockdomain contains a 'processor'.  I had been under the
> impression that these were separate mechanisms.  Is this also true fo=
r
> OMAP4 with the WKUPDEP/STATICDEP bits?  The implication in section
> 3.1.1.1.7.3 is that the WKUPDEP bits are simply there for an
> 'acceleration'.

Yes, on OMAP4, these are used to accelerate wakeup transition
by parallelizing wakeup on several domains.
Both the func spec and the TRM seem to mention that System would
work *without* them, but with slower wakeup transitions, due to the
cascading of wakeup transition over several domains.

Also Table 3-13 in TRM Section 3.1.1.1.6 mentions the following
conditions OR'ed for a clockdomain Wakeup to happen

The SW_WKUP clock transition mode for the clock domain is set. (CLKTRCT=
RL
=3D 0x2)
OR At least one wake-up request asserted by one of the modules of the
clock domain.
OR At least one dynamic dependency(1) from another clock domain is acti=
ve.
OR At least one static dependency(1) from another clock domain is activ=
e.
OR At least one wake-up dependency(1) from a module in another clock
domain is active.

>
> >  I have not given much thought on this for now but looks like this
needs
> > to be handled in some way using hwmod itself. I need to work some m=
ore
> > to see how this can be handled.
>
> OK, that's fine.  You might want to touch base with Ren=E9 Sapiens on=
 the
> GRPSEL/WKUPDEP stuff, I think he was looking at implementing GRPSEL
> control in software.

Sure, will get in touch with him.

Thanks,
Rajendra

>
> Thanks for the summary,
>
>
> - Paul
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
