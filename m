From: "Mark A. Greer" <mgreer@animalcreek.com>
Subject: Re: [PATCH] arm: omap3: am35x: Register davinci_mdio before
 davinci_emac
Date: Thu, 19 Apr 2012 11:22:43 -0700
Message-ID: <20120419182243.GB14705@animalcreek.com>
References: <1334859578-14446-1-git-send-email-mgreer@animalcreek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail20.dotsterhost.com ([66.11.232.73]:41072 "EHLO
	mail20.dotsterhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756266Ab2DSSWp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 19 Apr 2012 14:22:45 -0400
Content-Disposition: inline
In-Reply-To: <1334859578-14446-1-git-send-email-mgreer@animalcreek.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Thu, Apr 19, 2012 at 11:19:38AM -0700, Mark A. Greer wrote:
> From: "Mark A. Greer" <mgreer@animalcreek.com>
> 
> Problem:
> --------
> When resuming from a Suspend-to-RAM event, the eth0 device
> (davinci emac/mdio) on am35xx boards wouldn't work and the
> following error message appeared on the console:
> 
> "net eth0: could not connect to phy davinci_mdio-0:00"

I'm sorry, please ignore.  This patch has already been pooh-pooh'd.

Mark
--
