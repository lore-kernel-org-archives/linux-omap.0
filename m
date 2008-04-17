From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 1/2] ARM: OMAP: CLKFW: Initial debugfs support for omap clock framework
Date: Thu, 17 Apr 2008 12:14:35 -0700
Message-ID: <200804171214.35936.david-b@pacbell.net>
References: <alpine.DEB.1.00.0804170952270.3689@utopia.booyaka.com> <alpine.DEB.1.00.0804171243340.8530@utopia.booyaka.com> <20080417.215723.241260895.Hiroshi.DOYU@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp118.sbc.mail.sp1.yahoo.com ([69.147.64.91]:32454 "HELO
	smtp118.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1755086AbYDQTOk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 17 Apr 2008 15:14:40 -0400
In-Reply-To: <20080417.215723.241260895.Hiroshi.DOYU@nokia.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: paul@pwsan.com, linux-omap@vger.kernel.org

On Thursday 17 April 2008, Hiroshi DOYU wrote:
> For "set_parent", would it be possible to do that by using
> "debugfs_rename()"?

Could be.  What happens if you try it?


> And if there will be a little possibility that sysfs attribute can be
> used by userland in the future, keeping sysfs instead of debugfs
> doesn't seem not so illegal, does it?

I'm unaware of any laws passed in any country on that topic.  ;)

I happen to think that the clock tree is sensitive enough
that it should not be managed from userspace in production
systems.  (Except possibly through driver-specific APIs which
ensure the right rules are followed.)  Too easy to break things
otherwise.

- Dave

