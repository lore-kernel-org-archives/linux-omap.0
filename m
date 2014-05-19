From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] ARM: OMAP2+: some hwmod data patches for v3.16
Date: Mon, 19 May 2014 09:09:02 -0700
Message-ID: <20140519160901.GC4849@atomide.com>
References: <alpine.DEB.2.02.1405160444200.29738@utopia.booyaka.com>
 <5375CE74.6000603@ti.com>
 <20140516212327.GI12881@atomide.com>
 <5379C866.2040404@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:18802 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751790AbaESQJK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 19 May 2014 12:09:10 -0400
Content-Disposition: inline
In-Reply-To: <5379C866.2040404@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Tomi Valkeinen <tomi.valkeinen@ti.com> [140519 02:02]:
> On 17/05/14 00:23, Tony Lindgren wrote:
> > * Tomi Valkeinen <tomi.valkeinen@ti.com> [140516 01:39]:
> >> Hi Paul,
> >>
> >> On 16/05/14 07:45, Paul Walmsley wrote:
> >>> Hi Tony
> >>>
> >>> The following changes since commit d1db0eea852497762cab43b905b879dfcd3b8987:
> >>>
> >>>   Linux 3.15-rc3 (2014-04-27 19:29:27 -0700)
> >>>
> >>> are available in the git repository at:
> >>>
> >>>   git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending.git for-v3.16/hwmod-a
> >>>
> >>> for you to fetch changes up to 433480707967187a74ced38bd38edba749998013:
> >>>
> >>>   ARM: OMAP2+: hwmod: OMAP5 DSS hwmod data (2014-05-14 12:26:10 -0600)
> >>>
> >>> ----------------------------------------------------------------
> >>> First (and possibly last) set of hwmod data changes for v3.16.  This
> >>> set should clean up some obsolete OMAP4 hwmod data, and add OMAP5 DSS
> >>> support.
> >>
> >> What about the AM43xx hwmod data I sent in the same series:
> >>
> >> http://article.gmane.org/gmane.linux.ports.arm.omap/114192
> > 
> > I guess the issue there is that there's no way for Paul or much
> > anybody else to check it against any documentation or hardware :(
> > 
> > Is this just cut and paste code, or has you verified it against
> > the documentation and the hardare?
> 
> It's a cut and paste from TI's kernel, I did not write it. I have tested
> it on two different AM4xxx boards, and reviewed it, although I have not
> checked every individual bit of information there as it's a bit
> difficult to find information of all the details.
> 
> The AM43xx's DSS is more or less a subset of the DSS in OMAP3, so while
> a proper bit-for-bit review cannot be done without AM43xx documentation,
> a  "looks sane" review can be done against OMAP3.

OK thanks for reviewing it. Looks like Rajendra found few issues, so
I'm personally fine with your and Rajendra's acks on it. Paul may
have still other comments though.

Regards,

Tony

