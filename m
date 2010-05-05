From: Felipe Contreras <felipe.contreras@nokia.com>
Subject: Re: [PATCH] DSPBRIDGE: MMU-Fault debugging enhancements
Date: Wed, 5 May 2010 14:58:02 +0300
Message-ID: <20100505115802.GE4265@annwn.felipec.org>
References: <496565EC904933469F292DDA3F1663E602CB04896F@dlee06.ent.ti.com>
 <x2y94a0d4531004300821v920d3240p5215a967c6c48759@mail.gmail.com>
 <C161915E2DD8304FAAE595A13B0A0948024AE50D98@dlee01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:55349 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752114Ab0EEL6T (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 May 2010 07:58:19 -0400
Content-Disposition: inline
In-Reply-To: <C161915E2DD8304FAAE595A13B0A0948024AE50D98@dlee01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Ramos Falcon, Ernesto" <ernesto@ti.com>
Cc: "Guzman Lugo, Fernando" <fernando.lugo@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Doyu Hiroshi (Nokia-D/Helsinki)" <hiroshi.doyu@nokia.com>, "Palande Ameya (Nokia-D/Helsinki)" <ameya.palande@nokia.com>

Hey Ernesto,

On Fri, Apr 30, 2010 at 09:24:15PM +0200, ext Ramos Falcon, Ernesto wrote:
> >This patch seems to be doing a lot of things. Couldn't it have been
> >split?
> >
> >Also, from the commit message it seems to implement a new feature,
> >however, I heard it's supposed to fix memory corruption too. Is that
> >true? If that's the case the code that fixes that would have to be
> >separate.
> >
> >I understand this patch was already pushed to dspbridge branch, but I
> >think such important changes should be properly recorded in the
> >history.
> 
> I agree important changes must be properly recorded but in this case
> the patch introduces only one new feature and because of the way that
> it is implemented using gpt8 overflow interrupt instead of mailbox to
> inform about the MMU Fault, the problem of the memory corruption was
> fixed indirectly, however these changes are part of the feature design
> itself and I don't see the need to split this new feature.

In general, logically independent changes should end up as separate
patches. Many times it looks like a patch cannot be split further, but
with a little bit of creativity it usually can.

I can think of one patch that switches to gpt8 overflow, and another one
that actually shows the extra information.

Anyway, I ask because we found some issues with the latest commits of
dspbridge, and I would like to isolate the memory corruption fix just to
be safe.

Also, from that description it looks like there might be still a problem
in the mailbox that is hidded by this patch... so it's more like a
workaround, not really a fix.

Cheers.

-- 
Felipe Contreras
