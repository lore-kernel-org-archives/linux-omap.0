From: Tony Lindgren <tony@atomide.com>
Subject: Re: Latest OMAP4 build errors
Date: Wed, 7 Mar 2012 14:44:59 -0800
Message-ID: <20120307224459.GJ12083@atomide.com>
References: <20120228090209.GC18045@n2100.arm.linux.org.uk>
 <CAK=WgbZEDr_fYSonBQr3XNcTx5vefsH7LJfqycaxsqg-yechWQ@mail.gmail.com>
 <20120306165545.GB15392@n2100.arm.linux.org.uk>
 <201203061701.54141.arnd@arndb.de>
 <20120307100615.GA17404@n2100.arm.linux.org.uk>
 <20120307171044.GE12083@atomide.com>
 <CAOesGMiNSyc9F+Wf5pXPG=hRAfnG6aMHtccLBwvekuB3HpyevQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:41766 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030205Ab2CGWpF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Mar 2012 17:45:05 -0500
Content-Disposition: inline
In-Reply-To: <CAOesGMiNSyc9F+Wf5pXPG=hRAfnG6aMHtccLBwvekuB3HpyevQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Olof Johansson <olof@lixom.net>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Ohad Ben-Cohen <ohad@wizery.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Olof Johansson <olof@lixom.net> [120307 13:46]:
> On Wed, Mar 7, 2012 at 9:10 AM, Tony Lindgren <tony@atomide.com> wrote:
> >
> > What I got queued up in fixes-non-critical-part2 should fix all those
> > errors and warnings.
> >
> > Arnd & Olof, I've posted one fix that should be applied to arm-soc tree
> > at [1]. I've also posted a request to revert one commit in arm-soc tree
> > at [2].
> >
> > As it seems that you did not apply those to arm-soc, please apply them,
> > or repull the following two branches ASAP:
> 
> Done (repulled the branches). Stephen Rothwell has not surfaced on irc
> yet, so hopefully this means it'll make it into today's linux-next.

Thanks!
 
> > Re-pull fixes-non-critical containing one revert:
> >
> > Revert "ARM: OMAP2+: Fix multiple randconfig errors with SOC_OMAP and SOC_OMAP_NOOP"
> >
> > git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap fixes-non-critical
> >
> > Re-pull cleanup again containing one fix:
> >
> > ARM: OMAP2+: Fix L4_EMU_34XX_BASE error after iomap changes
> >
> > git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap cleanup
> >
> > Note that the second one I just pushed, however the patch is known to
> > work for the build errors after merging arm-soc with Russell's changes.
> 
> Looks like you pasted the wrong subject above -- the mail below
> contains the patch that you added though so it looked OK to me (the
> subject above was the previous top-of-branch before you added the last
> one).

Oops, sorry about that. The end result looks right.
 
> > Arnd & Olof, for future, how you want to handle urgent issues like this?
> 
> Personally I missed the requests since they ended up in the chain of
> replies and I didn't notice them, my mistake. A separate email
> requesting pulls or patch application it to arm@kernel.org would
> reduce the risk of that happening (Flagging the subject with [URGENT]
> wouldn't hurt).

OK thanks, will do that next time if there's something urgent.

I'll send a pull request shortly for fixes-non-critical-part2 that
should sort out the remaining issues.

Regards,

Tony
