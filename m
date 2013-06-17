From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL 6/6] omap5 data for v3.11 merge window
Date: Mon, 17 Jun 2013 03:37:20 -0700
Message-ID: <20130617103720.GM20992@atomide.com>
References: <pull-1371061475-206272>
 <E1Umpk1-0005eT-9P@merlin.infradead.org>
 <20130614213624.GE17326@quad.lixom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:52282 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754868Ab3FQKhX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 Jun 2013 06:37:23 -0400
Content-Disposition: inline
In-Reply-To: <20130614213624.GE17326@quad.lixom.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Olof Johansson <olof@lixom.net>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Olof Johansson <olof@lixom.net> [130614 14:42]:
> On Wed, Jun 12, 2013 at 11:24:35AM -0700, Tony Lindgren wrote:
> > The following changes since commit 317ddd256b9c24b0d78fa8018f80f1e495481a10:
> > 
> >   Linux 3.10-rc5 (2013-06-08 17:41:04 -0700)
> > 
> > are available in the git repository at:
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.11/omap5-signed
> > 
> > for you to fetch changes up to 6503a8e109a639760408f874c1251060d563942e:
> > 
> >   ARM: OMAP5: Remove unused include for ocp2scp (2013-06-09 21:17:15 -0700)
> 
> Pulled.

Thanks.
 
> >  25 files changed, 8982 insertions(+), 55 deletions(-)
> 
> Owwie.

This is already the squeezed down version with irq and dma data left
out like we also did for am33xx and omap4. Unfortunately getting things
moved to DT and to live under drivers will take a while, and we
decided to deal with moving clocks to drivers first so hwmod will
have to wait a bit.

Regards,

Tony
