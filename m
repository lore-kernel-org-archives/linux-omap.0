From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: RE: [PATCH][RFC] OMAP3630: Create architecture macros and config
	entries.
Date: Fri, 25 Sep 2009 22:19:06 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB030A2738E6@dbde02.ent.ti.com>
References: <E0D41E29EB0DAC4E9F3FF173962E9E9402534261B3@dbde02.ent.ti.com>
 <74583B8642AB8841B30447520659FCA9DD85B939@dnce01.ent.ti.com>
 <A24693684029E5489D1D202277BE89444C6864B8@dlee02.ent.ti.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB0309C861E2@dbde02.ent.ti.com>
 <87pr9jdnfu.fsf@deeprootsystems.com> <20090922175815.GI14890@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:37656 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751166AbZIYQtN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 25 Sep 2009 12:49:13 -0400
In-Reply-To: <20090922175815.GI14890@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@deeprootsystems.com>
Cc: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, "Pais, Allen" <allen.pais@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Raju, Veeramanikandan" <veera@ti.com>, "Bongale, Hariprasad" <hariprasad.bongale@ti.com>

> > >> > OMAP3630 is "just" an OMAP3430 in disguise.
> > >> > I don't think it deserves a new class. It should probably be handled like
> > >> > it was done for 1610 and 1710.
> > >> >
> > >> > Theoretically, it should be considered as a 3430 ES4.0, because it is an
> > >> > OMAP3430 ES3 + couple of bug fixes + couple of improvements.
> > >> >
> > >> > I think, that the proposal from Sanjeev to support 35xx
> > >> > (http://marc.info/?l=linux-omap&m=125050987112798&w=2 ) might be leveraged
> > >> > to handle 36xx as well.
> > >> >
> > >> 
> > >> I respectfully tend to disagree with this, since there are some components
> > >> inside the chip that aren't specifically fixes, so IMHO they need to start
> > >> from scratch about silicon revisions because of that.
> > >> 
> > >> If there are many common points between 34xx/35xx/36xx, then rename the
> > >> reused functions/defines to omap3, instead of omap34xx/omap35xx/omap36xx.
> > >> 
> > >> Regards,
> > >> Sergio
> > >> 
> > >
> > > I agree with Sergio.
> > >
> > > While it is definitely possible to write code treating the 3430
> > > and the 3630 as the same, they are not the same animal. We will
> > > need to distinguish between the two at more than a few locations
> > > in code, and we might as well add the ability to do that now.
> > >
> > > I see a need to distinguish between 3430 and 3630 in several locations
> > > - there are changes in hardware IPs that are not reflected in the IP
> > > revision information (meaning we cannot always go by CPU_HAS_FEATURE() ),
> > > and we will need some kind of a cpu_is_* check for sure.
> > 
> > And you're sure these HW IP changes require software changes?  Please
> > provide examples.

Yes, I'm pretty sure some of them require software changes. No examples
on the 3630 that I can disclose right now, but consider for instance the
case of the TLL Save-and-Restore feature on 3430 - it's broken on ES3.0
and below and works great after. Or extra register bits in UHH_HOSTCONFIG
introduced in ES3.0. The HW IP versions are still the same across these
revisions, but the SOC ES version has changed.

> > 
> > So, TI is changing HW IP in a way that requires software changes and
> > not providing a way for software to detect these changes?
> > 
> > IMHO, This is completely broken HW design.

Agreed. I've already pinged some HW design folks to point this out.

> 
> I agree, we should be able to detect various processors during the
> init and then just set the necessary feature flags.

I seem not to have understood the initially proposed solution when I
made that comment. Consider the objection withdrawn.

I agree - all we require is the ability to detect the chip version at init,
and to set any flag that might be needed by code executing later.
It is a better solution.

I misunderstood the discussion to mean "the 3630 would not be detectable
as a separate chip from the 3430 at all". It doesn't really matter where we
make the distinction, as long as it is possible to add code to behave
differently on the two chips (or other revisions of the OMAP3).

Regards,
Anand
