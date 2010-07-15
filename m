From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [RFC][PATCH 1/1] ARM: Add initial hibernation support
Date: Thu, 15 Jul 2010 09:41:18 +0100
Message-ID: <20100715084118.GB26212@n2100.arm.linux.org.uk>
References: <1277908081-17195-1-git-send-email-Hiroshi.DOYU@nokia.com> <1277908081-17195-2-git-send-email-Hiroshi.DOYU@nokia.com> <20100714132255.GB3103@ucw.cz> <20100715.083450.193689911.Hiroshi.DOYU@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:51974 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932643Ab0GOIl5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 15 Jul 2010 04:41:57 -0400
Content-Disposition: inline
In-Reply-To: <20100715.083450.193689911.Hiroshi.DOYU@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: linux-arm-kernel@lists.infradead.org, pavel@ucw.cz, khilman@deeprootsystems.com, teerth@ti.com, linux-pm@lists.linux-foundation.org, Yoshiya.Hirase@nokia.com, linux-omap@vger.kernel.org

On Thu, Jul 15, 2010 at 08:34:50AM +0300, Hiroshi DOYU wrote:
> Russell, would it be possible to put this into your next merge queue?

I think it needs quite a bit of rework - I certainly don't like all
those CP15 register accesses there - that's asking for lots of ifdefs
to spring up as more CPUs are supported.

Eg, what about ensuring that state such as iWMMXt on PXA CPUs is
properly restored?

We already have code which knows what needs to be saved across a
power-off transition - its what we use for our normal suspend/resume
functionality, so we should look at re-using that code for hibernate
as well.  We really don't want to be maintaining two sets of code
doing the same thing.
