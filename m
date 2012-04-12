From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 08/12] arm: omap3: am35x: Fix clockdomain dependencies
Date: Wed, 11 Apr 2012 20:29:51 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1204112028560.29473@utopia.booyaka.com>
References: <1334171147-7517-1-git-send-email-mgreer@animalcreek.com> <1334171147-7517-9-git-send-email-mgreer@animalcreek.com> <alpine.DEB.2.00.1204111540060.29473@utopia.booyaka.com> <20120411215513.GA31197@animalcreek.com> <alpine.DEB.2.00.1204111555360.29473@utopia.booyaka.com>
 <20120411224911.GE31197@animalcreek.com> <alpine.DEB.2.00.1204111748540.29473@utopia.booyaka.com> <20120412022313.GN31197@animalcreek.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:36017 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752942Ab2DLC3w (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Apr 2012 22:29:52 -0400
In-Reply-To: <20120412022313.GN31197@animalcreek.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Mark A. Greer" <mgreer@animalcreek.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, khilman@ti.com

On Wed, 11 Apr 2012, Mark A. Greer wrote:

> Okay, I'll get rid of the commas (fwiw, gfx_sgx_3xxx_wkdeps[] has commas
> in k.o, the others don't).

Okay thanks, that's just an oversight in the mainline data.  If you're so 
inclined, feel free to clean that up in your patch...


- Paul
