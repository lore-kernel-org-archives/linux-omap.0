From: Paul Walmsley <paul@pwsan.com>
Subject: RE: [PATCH 2/5] OMAP: clockdomain: Arch specific funcs to handle
 deps
Date: Thu, 13 Jan 2011 23:20:38 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1101132243400.28621@utopia.booyaka.com>
References: <1294237365-10893-1-git-send-email-rnayak@ti.com> <1294237365-10893-2-git-send-email-rnayak@ti.com> <1294237365-10893-3-git-send-email-rnayak@ti.com> <alpine.DEB.2.00.1101101808530.5731@utopia.booyaka.com>
 <327d60b24fab12f48959caa67ba83c51@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-2105205760-1294986038=:28621"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:33981 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750951Ab1ANGUj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 Jan 2011 01:20:39 -0500
In-Reply-To: <327d60b24fab12f48959caa67ba83c51@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@deeprootsystems.com, Benoit Cousson <b-cousson@ti.com>, Rene Sapiens <rene.sapiens@ti.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-2105205760-1294986038=:28621
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

(adding Ren=E9 to cc)

Hi Rajendra

On Tue, 11 Jan 2011, Rajendra Nayak wrote:

> > -----Original Message-----
> > From: Paul Walmsley [mailto:paul@pwsan.com]
> > Sent: Tuesday, January 11, 2011 7:02 AM
> > To: Rajendra Nayak
> > Cc: linux-omap@vger.kernel.org; khilman@deeprootsystems.com;
> b-cousson@ti.com
> > Subject: Re: [PATCH 2/5] OMAP: clockdomain: Arch specific funcs to
> handle deps
> >
> > For example, OMAP4 has static wakeup dependencies just like OMAP2/3;
> > described in section 3.1.1.1.7.3 "Wake-Up Dependency" of the OMAP4430
> TRM
> > Rev. L.
> >
> > OMAP4 also has static sleep dependencies just like OMAP3; described in
> > section 3.1.1.1.7.1 "Static Dependency" of the OMAP4430 TRM
> > Rev. L.
>=20
> I already have some patches to support static dependencies for OMAP4.
> Still working towards getting the autogen scripts in place, they seem to
> be a bit out of sync with whats in mainline today for clockdomains.
> I can post early patches as RFC to get your views on it.

OK, great - saw that you posted these.  Will take a closer look.

> The only difference wrt OMAP3 is there is no control on OMAP4 to=20
> set/clear sleep and wakeup dependencies separately and hence they are=20
> called Static dependency and not 'Static wakeup' or 'Static sleep'.=20
> Setting a static dependency between clock domains on OMAP4 means setting=
=20
> sleep *as well as* wakeup dependency.

OK.  The design of your initial implementation of these combined=20
sleep/wakeup dependencies in the RFC series looks good to me.

> > The dynamic wakeup dependencies (section 3.1.1.1.7.2 of the TRM) and th=
e
> > hardware inactivity timer are new for OMAP4.
> >
> > What's the plan to add support for these?
>=20
> I will be working on supporting these as well. Can be supported easily=20
> on top of the clockdomain split series. Still need to get the autogen=20
> scripts updated to generate the dynamic dependency data.

OK, sounds good.

> > Based on a brief look, it would seem to make sense to add support now=
=20
> > for static sleep dependencies.  These seem quite similar to the OMAP3=
=20
> > implementation, in that they are between clockdomains.
>=20
> Again like I said above, my next patch series will add support for=20
> static (sleep and wakeup) dependencies. The other 'wakeup dependency'=20
> that the TRM section 3.1.1.1.7.3 talks about is slightly different. See=
=20
> my comments below.

OK.

> > Static wakeup dependency support appears a little more tricky, since=20
> > the dependencies are between modules and clockdomains on OMAP4, rather=
=20
> > than between clockdomains and clockdomains as they were on OMAP2/3. =20
> > One way to handle this would be to change the existing wkdep interface=
=20
> > for all OMAPs to be between modules and clockdomains; then for the=20
> > OMAP2/3 implementations, use the hwmod code/data to get the=20
> > clockdomain of the module's main_clk.  Another is to add a separate=20
> > interface to add wkdeps between a module and clockdomain, use that for=
=20
> > OMAP4, but use the existing clockdomain-to-clockdomain interface for=20
> > OMAP2/3.  It might be necessary to do both until the hwmod data is=20
> > more complete, then perhaps phase out the latter interface. =20
> > Thoughts?
>=20
> The wakeup dependency here (between a module and a clock domain) is very=
=20
> different from the static dependency (between clock domains) and very=20
> much like what the PM_<processor>_GRPSEL registers handled in OMAP3.=20
> They are used to control which processor is woken up on a given module/=
=20
> peripheral wakeup event.

According to the 34xx TRM Rev. ZH section 4.8.5.2, both the GRPSEL and=20
WKDEP bits need to be set for the target clockdomain to be awakened, if=20
the target clockdomain contains a 'processor'.  I had been under the=20
impression that these were separate mechanisms.  Is this also true for=20
OMAP4 with the WKUPDEP/STATICDEP bits?  The implication in section=20
3.1.1.1.7.3 is that the WKUPDEP bits are simply there for an=20
'acceleration'.

>  I have not given much thought on this for now but looks like this needs=
=20
> to be handled in some way using hwmod itself. I need to work some more=20
> to see how this can be handled.

OK, that's fine.  You might want to touch base with Ren=E9 Sapiens on the=
=20
GRPSEL/WKUPDEP stuff, I think he was looking at implementing GRPSEL=20
control in software.

Thanks for the summary,


- Paul
--155748971-2105205760-1294986038=:28621--
