From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCHv2 0/5] wl1251 device tree support
Date: Fri, 17 Jan 2014 09:44:16 -0800
Message-ID: <20140117174415.GG7993@atomide.com>
References: <1382890469-25286-1-git-send-email-sre@debian.org>
 <1386289336-26704-1-git-send-email-sre@debian.org>
 <20140106225709.GA23070@earth.universe>
 <20140117014514.GA604@earth.universe>
 <20140117150127.GA15145@tuxdriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:45489 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752816AbaAQRoZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 Jan 2014 12:44:25 -0500
Content-Disposition: inline
In-Reply-To: <20140117150127.GA15145@tuxdriver.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "John W. Linville" <linville@tuxdriver.com>
Cc: linux-wireless@vger.kernel.org, linux-omap@vger.kernel.org

* John W. Linville <linville@tuxdriver.com> [140117 07:17]:
> On Fri, Jan 17, 2014 at 02:45:15AM +0100, Sebastian Reichel wrote:
> > On Mon, Jan 06, 2014 at 11:57:09PM +0100, Sebastian Reichel wrote:
> > > Hi John,
> > > 
> > > > The following patchset adds device tree support to
> > > > the spi variant of the wl1251 driver.
> > > >
> > > > Luciano Coelho (1):
> > > >   wl1251: split wl251 platform data to a separate structure
> > > > 
> > > > Sebastian Reichel (4):
> > > >   wl1251: move power GPIO handling into the driver
> > > >   wl1251: spi: add vio regulator support
> > > >   wl1251: spi: add device tree support
> > > >   Documentation: dt: wireless: Add wl1251
> > > 
> > > What's the status of this patchset? Tony prepared an immutable
> > > branch for patches 1+2 [0]. I think the other patches are also ok
> > > (at least there were no more complains from the DT binding
> > > maintainers). It would be nice to have wl1251 DT support in 3.14.
> > > 
> > > [0] http://www.spinics.net/lists/linux-omap/msg101165.html
> > > 
> > > -- Sebastian
> > 
> > ping? I can't see it on wireless-next.
> 
> I can't pull it because the branch is based on a later source than
> that of wireless-next.

Hmm I thought v3.13-rc1 was the base we agreed on the immutable branch.
Care to explain what the issue is merging it in?

AFAIK merging it fast forwards your branch to v3.13-rc1 and then
you just need to do the pull request against v3.13-rc1.

Regards,

Tony
