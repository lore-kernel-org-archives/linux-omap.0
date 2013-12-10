From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] wl1251 platform data changes for v3.14
Date: Tue, 10 Dec 2013 09:29:59 -0800
Message-ID: <20131210172958.GI13171@atomide.com>
References: <52a69d42.0722440a.102e.ffffa0e3SMTPIN_ADDED_BROKEN@mx.google.com>
 <87bo0oae3j.fsf@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:24330 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753064Ab3LJRaG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Dec 2013 12:30:06 -0500
Content-Disposition: inline
In-Reply-To: <87bo0oae3j.fsf@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@linaro.org>
Cc: arm@kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

* Kevin Hilman <khilman@linaro.org> [131210 08:03]:
> Hi Tony,
> 
> Tony Lindgren <tony@atomide.com> writes:
> 
> > The following changes since commit 736e812636ea72be444b85fa7e92554967459069:
> >
> >   ARM: OMAP2+: Remove unused platform init code and headers (2013-12-08 14:15:46 -0800)
> >
> > are available in the git repository at:
> >
> >   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.14/omap3-board-removal-wl1251
> >
> > for you to fetch changes up to ce226391aec803a49b39c22d3385057c9db02f30:
> >
> >   Merge branch 'wl1251-pdata' into omap-for-v3.14/omap3-board-removal (2013-12-09 19:39:51 -0800)
> >
> > ----------------------------------------------------------------
> >
> > Minimal changes for the wl151 platform data that would otherwise
> > cause merge conflicts between the wireless tree and linux-omap
> > tree. This was discussed on the mailing lists here:
> >
> > http://www.spinics.net/lists/linux-omap/msg99906.html
> >
> > ----------------------------------------------------------------
> > Luciano Coelho (1):
> >       wl1251: split wl251 platform data to a separate structure
> >
> > Sebastian Reichel (1):
> >       wl1251: move power GPIO handling into the driver
> >
> > Tony Lindgren (1):
> >       Merge branch 'wl1251-pdata' into omap-for-v3.14/omap3-board-removal
> >
> >  drivers/net/wireless/ti/wilink_platform_data.c | 37 +++++++++++++++++++++-----
> >  drivers/net/wireless/ti/wl1251/sdio.c          | 31 ++++++++++++++-------
> >  drivers/net/wireless/ti/wl1251/spi.c           | 35 +++++++++++++++---------
> >  drivers/net/wireless/ti/wl1251/wl1251.h        |  2 +-
> >  include/linux/wl12xx.h                         | 24 +++++++++++++++--
> >  5 files changed, 97 insertions(+), 32 deletions(-)
> 
> This was sent as a pull request to arm-soc, but looks like it should be
> going through the net tree.

Oh this was to merge in a shared branch between wireless tree and
linux-omap to avoid merge conflicts as agreed with John Linville,
see the link above.

But let's wait on this one too as it seems at least Russell needs
some more time to deal with the dropping of legacy booting.

Regards,

Tony
