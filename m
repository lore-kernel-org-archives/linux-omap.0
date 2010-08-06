From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PM-SR][PATCH 01/12] omap3: voltage: cleanup pr_xxxx
Date: Fri, 6 Aug 2010 13:18:07 +0100
Message-ID: <20100806121807.GD31326@sirena.org.uk>
References: <1281047052-21346-1-git-send-email-nm@ti.com> <1281047052-21346-2-git-send-email-nm@ti.com> <5A47E75E594F054BAF48C5E4FC4B92AB032401CE69@dbde02.ent.ti.com> <4C5BED13.6080702@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:52012 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759367Ab0HFMSK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 6 Aug 2010 08:18:10 -0400
Content-Disposition: inline
In-Reply-To: <4C5BED13.6080702@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <menon.nishanth@gmail.com>
Cc: "Gopinath, Thara" <thara@ti.com>, "Menon, Nishanth" <nm@ti.com>, linux-omap <linux-omap@vger.kernel.org>, Kevin Hilman <khilman@deeprootsystems.com>

On Fri, Aug 06, 2010 at 06:08:03AM -0500, Nishanth Menon wrote:

> Well that is my motivation here. if driver reports a warning to kernel  
> syslog, well, I expect the log to contain the function name for me to  
> maintain faster.

That's really not the expectation for Linux log messages - the general
approach to find the source of a message is generally to just grep for
the message text which is usually very effective.
