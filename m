From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [GIT PULL] omap fixes for v3.4-rc6
Date: Wed, 09 May 2012 13:05:25 +0200
Message-ID: <1673508.aX9Ao89479@avalon>
References: <20120507223632.GP5088@atomide.com> <CAOesGMjHEy0Rz+ow7J3BuUtt3h3SjU+6gG=PPGTu3tMNZXy6nQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from perceval.ideasonboard.com ([95.142.166.194]:47127 "EHLO
	perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756691Ab2EILFY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 May 2012 07:05:24 -0400
In-Reply-To: <CAOesGMjHEy0Rz+ow7J3BuUtt3h3SjU+6gG=PPGTu3tMNZXy6nQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Olof Johansson <olof@lixom.net>
Cc: Tony Lindgren <tony@atomide.com>, Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, ebutera@users.berlios.de

Hi Olof,

On Tuesday 08 May 2012 23:48:06 Olof Johansson wrote:
> Hi,
> 
> On Mon, May 7, 2012 at 3:36 PM, Tony Lindgren <tony@atomide.com> wrote:
> > The following changes since commit 
69964ea4c7b68c9399f7977aa5b9aa6539a6a98a:
> [..]
> 
> > Enrico Butera (1):
> >      ARM: OMAP: igep0020: fix smsc911x dummy regulator id
> 
> Hmm. Picking 40 without any kind of comment in the code isn't doing
> any favors for future readers. Seems like 1 would be free on this
> board, from the rest of the board file to judge (one other
> reg-fixed-regulator platform device)?
> 
> Please either comment why you picked 40 (i.e. it's a random number),
> or change it to something a little less random like 1. :)
> 
> > Laurent Pinchart (1):
> >      ARM: OMAP: igep0020: Specify the VPLL2 regulator unconditionally
> 
> Is this a regression? I don't see any recent changes regarding this,
> so it's hard to tell. If not then I'd rather hold off for the merge
> window given that we're at -rc6.

It's not a regression, I'm fine with holding off until the v3.5 merge window.

-- 
Regards,

Laurent Pinchart

