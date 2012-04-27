From: "Mark A. Greer" <mgreer@animalcreek.com>
Subject: Re: [PATCH v2] arm: omap3: am35x: Fix clockdomain dependencies
Date: Fri, 27 Apr 2012 14:14:40 -0700
Message-ID: <20120427211440.GB19196@animalcreek.com>
References: <1334866606-8291-1-git-send-email-mgreer@animalcreek.com>
 <alpine.DEB.2.00.1204261656160.10308@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail20.dotsterhost.com ([66.11.232.73]:33723 "EHLO
	mail20.dotsterhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753156Ab2D0VOl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 27 Apr 2012 17:14:41 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1204261656160.10308@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, khilman@ti.com

On Thu, Apr 26, 2012 at 04:56:39PM -0600, Paul Walmsley wrote:
> On Thu, 19 Apr 2012, Mark A. Greer wrote:
> 
> > From: "Mark A. Greer" <mgreer@animalcreek.com>
> > 
> > The am35x family of SoCs do not have an IVA so
> > a parallel set of clockdomain dependencies are
> > required that are simililar to OMAP3 but without
> > any IVA dependencies.
> > 
> > Signed-off-by: Mark A. Greer <mgreer@animalcreek.com>
> 
> Thanks, queued for 3.5.

Thanks Paul.

FYI, I have a version rebased on top of Kevin's recent patch series
that renames OMAP3517 to AM35XX (among other things),
     "ARM: OMAP: remove IP checks from SoC family detection".

Would you like that one instead?

Mark
--
