From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] Urgent omap timer fix for current merge window
Date: Tue, 7 May 2013 08:04:03 -0700
Message-ID: <20130507150402.GP28721@atomide.com>
References: <20130506234610.GK28721@atomide.com>
 <20130507120202.GK21614@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:24069 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751599Ab3EGPEJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 May 2013 11:04:09 -0400
Content-Disposition: inline
In-Reply-To: <20130507120202.GK21614@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [130507 05:07]:
> On Mon, May 06, 2013 at 04:46:11PM -0700, Tony Lindgren wrote:
> > Vaibhav Hiremath (1):
> >       ARM: OMAP2+: Fix mismerge for timer.c between ff931c82 and da4a686a
> 
> Neither your pull request subject nor the above summary line really
> sum up what the problem is - the real problem is "fix breakage causing
> OMAP to fail to boot".
> 
> I've just been chasing this problem and the descriptions given on this
> just suggest that it's a timer issue not a non-boot issue.

Oops yes sorry if the description was a bit unclear.

Regards,

Tony
