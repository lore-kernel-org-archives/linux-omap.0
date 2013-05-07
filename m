From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [GIT PULL] Urgent omap timer fix for current merge window
Date: Tue, 7 May 2013 13:02:02 +0100
Message-ID: <20130507120202.GK21614@n2100.arm.linux.org.uk>
References: <20130506234610.GK28721@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:45749 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757117Ab3EGMCR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 May 2013 08:02:17 -0400
Content-Disposition: inline
In-Reply-To: <20130506234610.GK28721@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Mon, May 06, 2013 at 04:46:11PM -0700, Tony Lindgren wrote:
> Vaibhav Hiremath (1):
>       ARM: OMAP2+: Fix mismerge for timer.c between ff931c82 and da4a686a

Neither your pull request subject nor the above summary line really
sum up what the problem is - the real problem is "fix breakage causing
OMAP to fail to boot".

I've just been chasing this problem and the descriptions given on this
just suggest that it's a timer issue not a non-boot issue.
