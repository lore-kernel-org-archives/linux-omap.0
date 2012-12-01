From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL 3/3] omap late multiplatform cleanup for v3.8 merge
 window
Date: Sat, 1 Dec 2012 10:33:59 -0800
Message-ID: <20121201183359.GS5312@atomide.com>
References: <50b4120b.d088e50a.742e.ffffd3d3SMTPIN_ADDED_MISSING@mx.google.com>
 <20121130065314.GB6899@quad.lixom.net>
 <20121130172643.GI5312@atomide.com>
 <CAOesGMgzPVsiVqSe30f2bGZ4MKOjA9+Usw3OqX8wFkrdD570mQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:61171 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752693Ab2LASeG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 1 Dec 2012 13:34:06 -0500
Content-Disposition: inline
In-Reply-To: <CAOesGMgzPVsiVqSe30f2bGZ4MKOjA9+Usw3OqX8wFkrdD570mQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Olof Johansson <olof@lixom.net>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

* Olof Johansson <olof@lixom.net> [121130 21:57]:
> On Fri, Nov 30, 2012 at 9:26 AM, Tony Lindgren <tony@atomide.com> wrote:
> >
> > BTW, note that "[GIT PULL] omap iommu clean-up dependency branch for
> > v3.8 merge window" is still pending it seems?
> 
> Done, thanks for the reminder.

OK thanks.
> 
> > The following changes since commit 2589d056122f6dcb405d411eae872aac8cf9da1b:
> >
> >   Merge tag 'tags/omap-for-v3.8/devel-prcm-signed' into omap-for-v3.8/cleanup-headers-prepare-multiplatform-v3 (2012-11-30 08:40:31 -0800)
> >
> > are available in the git repository at:
> >
> >
> >   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/tags/omap-for-v3.8/cleanup-multiplatform-no-clock-signed
> >
> 
> Pulled in, I had two minor conflicts to resolve resulting in two
> one-line differences in the diff stat (removed an empty line between
> some includes).
> 
> I ended up pulling this into next/pm2, since that's where the last of
> the prereqs was and we'll likely reshuffle some of those late branches
> before merging anyway.

OK thanks.

Regards,

Tony
