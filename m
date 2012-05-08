From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2] ARM: OMAP: WiLink platform data for the PandaBoard
Date: Tue, 8 May 2012 14:56:31 -0700
Message-ID: <20120508215629.GI5088@atomide.com>
References: <1331074504-22683-1-git-send-email-mgherzan@gmail.com>
 <4F648A3B.7020003@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:47408 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751757Ab2EHV4d (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 May 2012 17:56:33 -0400
Content-Disposition: inline
In-Reply-To: <4F648A3B.7020003@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mircea Gherzan <mgherzan@gmail.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Mircea Gherzan <mgherzan@gmail.com> [120317 06:00]:
> Hi Tony,
> 
> Am 06.03.2012 23:55, schrieb Mircea Gherzan:
> > The "uim" deamon requires sysfs entries that are filled in using
> > this platform data.
> > 
> > Signed-off-by: Mircea Gherzan <mgherzan@gmail.com>
> > ---
> >  arch/arm/mach-omap2/board-omap4panda.c |   14 ++++++++++++--
> >  include/linux/ti_wilink_st.h           |    2 ++
> >  2 files changed, 14 insertions(+), 2 deletions(-)
> 
> Gentle ping.

Thanks for patience, applying to board branch finally.

Tony
