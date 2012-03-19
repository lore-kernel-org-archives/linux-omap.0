From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [GIT PULL] OMAP DSS for v3.4
Date: Mon, 19 Mar 2012 16:24:41 +0000
Message-ID: <201203191624.42020.arnd@arndb.de>
References: <1332154865.2144.57.camel@deskari>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:53820 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1162081Ab2CSQYu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 19 Mar 2012 12:24:50 -0400
In-Reply-To: <1332154865.2144.57.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, linux-omap@vger.kernel.org, linux-fbdev <linux-fbdev@vger.kernel.org>

On Monday 19 March 2012, Tomi Valkeinen wrote:
> Here are the changes for OMAP DSS driver for v3.4.
> 
> There's an issue with the dss driver that appears on arm-soc/for-next
> branch, which I'm still solving
> (http://marc.info/?l=linux-omap&amp;m=133214966902577&amp;w=2). I hope to get
> fix for that ready and merged for -rc1, but I'm not sure if I can make
> it in time, so I wanted to sent this pull request already.
> 
> Arnd, as discussed before, you can also merge this branch to solve the
> conflicts between arm-soc and omapdss trees.
> 
> Note that this is the first pull request I've sent with a branch that I
> have not been rebasing, so please check that the branch looks sane.

Thanks Tomi,

I've looked at the specific conflicts again, and it seems that the only
conflicting commit in arm-soc is 2e3ee9f45b "ARM: OMAP1: Move most of
plat/io.h into local iomap.h". I'm planning to send that one very early,
as soon as Russell has his first set up patches merged, so I don't
actually have to resolve the conflict here unless Florian is also
there early.

Florian, if I end up being faster than you, feel free to pull the
omap/cleanup branch from git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git
if you want to get a conflict resolution using the minimum set of patches
from upstream. Alternatively, pulling "cleanup" from 
git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap should give you
the same.

	Arnd
