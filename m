From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 00/10] OMAP clock/powerdomain/SDRC patches for
	post-2.6.30
Date: Mon, 1 Jun 2009 18:08:56 +0100
Message-ID: <20090601170856.GF16580@n2100.arm.linux.org.uk>
References: <20090526220517.25381.75976.stgit@localhost.localdomain> <20090601165623.GB4825@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:33234 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752811AbZFARJI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 1 Jun 2009 13:09:08 -0400
Content-Disposition: inline
In-Reply-To: <20090601165623.GB4825@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Paul Walmsley <paul@pwsan.com>, linux-arm-kernel@lists.arm.linux.org.uk, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org

On Mon, Jun 01, 2009 at 09:56:24AM -0700, Tony Lindgren wrote:
> * Paul Walmsley <paul@pwsan.com> [090526 15:27]:
> > Hello Russell,
> > 
> > here is the next set of OMAP clock patches for review for the
> > post-2.6.30 merge window.  They apply on top of the previous set
> > ("OMAP clock/SDRC patches on v2.6.30-rc5").  If you're happy with
> > these patches, Tony will queue them up into his for-next branch.
> 
> Looks like Russell now has all the omap for-next merged to his
> devel branch. Only this series is missing and the omap4 SMP patches.

This series I've avoided looking at due to lack of time.  I only just
got around to sorting through your patches from the last two weeks
last Thursday/Friday, and I've spent Sunday evening and today boot
testing and debugging what's been merged on my LDP platform.

It'll be a week or so before I look at OMAP again.
