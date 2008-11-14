From: David Brownell <david-b@pacbell.net>
Subject: Re: [patch 2.6.28-rc3-omap 0/4] twl4030 regulator support
Date: Thu, 13 Nov 2008 16:16:42 -0800
Message-ID: <200811131616.43078.david-b@pacbell.net>
References: <200811111756.20719.david-b@pacbell.net> <20081113223211.GN3106@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp118.sbc.mail.sp1.yahoo.com ([69.147.64.91]:22759 "HELO
	smtp118.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753116AbYKNATE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 13 Nov 2008 19:19:04 -0500
In-Reply-To: <20081113223211.GN3106@atomide.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org

On Thursday 13 November 2008, Tony Lindgren wrote:
> Nice! Do you want to wait a bit before converting HSMMC to avoid
> adding extra dependencies to get that driver merged upstream first?

That would seem simplest, yes.


> BTW, your first patch in this series does not apply, can you please
> refresh? I just pushed a bunch of patches from you, can you also
> please check I'm not missing any of your patches?

That's because you merged the RFT version of that first patch.
Revert that, then try again with this series.

- dave
 


