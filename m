From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [linux-pm] [PATCH 02/11] PM: extend PM QoS with per-device
 wake-up constraints
Date: Sat, 6 Aug 2011 01:11:49 +0900
Message-ID: <20110805161147.GA3438@opensource.wolfsonmicro.com>
References: <1309446685-17502-1-git-send-email-j-pihet@ti.com>
 <201108030016.18174.rjw@sisk.pl>
 <20110804132426.GB14921@sirena.org.uk>
 <201108042115.30983.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:49052 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1756546Ab1HEQL5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Aug 2011 12:11:57 -0400
Content-Disposition: inline
In-Reply-To: <201108042115.30983.rjw@sisk.pl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Kevin Hilman <khilman@ti.com>, markgross@thegnar.org, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org, Jean Pihet <j-pihet@ti.com>

On Thu, Aug 04, 2011 at 09:15:30PM +0200, Rafael J. Wysocki wrote:
> On Thursday, August 04, 2011, Mark Brown wrote:

> > On the one hand that's true.  On the other hand that just seems like
> > going down a bad road where we have drivers that only work when run with
> > a magic userspace that may or may not be published which is just going

> First off, we're doing this already (user space can block runtime PM, for
> one example, because there are systems where runtime PM doesn't work
> although it works on other systems with analogous hardware and pretty
> much the same set of drivers).

Yeah, I've never been terribly convinced about that and for the things
that drivers need to manualy implement (like wake configuration) it's
widely ignored.

> Second, I think there are valid use cases in which user space _really_ knows
> better than the kernel.  I'm opposed to the idea that users shouldn't be given
> control of their systems, because they may not know what they're doing.

Do you have any examples of this that aren't better expressed in device
specific terms?  It's not that users don't know what they're doing, it's
that working around system integration and stability issues in userspace
isn't really progressing things well or helping with maintainability.
Generally if the user has sufficient access to be able to do anything
with this stuff they've got just as much access to the kernel as to
userspace.
