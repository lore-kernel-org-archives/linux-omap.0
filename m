From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v3] arm: omap: Add omap3_defconfig
Date: Tue, 1 Dec 2009 16:08:19 -0800
Message-ID: <20091202000819.GF4348@atomide.com>
References: <20091130033434.GA8762@lixom.net>
 <20091201031932.GA19917@lixom.net>
 <20091201200925.GA27331@lixom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:61358 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753329AbZLBAIW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 Dec 2009 19:08:22 -0500
Content-Disposition: inline
In-Reply-To: <20091201200925.GA27331@lixom.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Olof Johansson <olof@lixom.net>
Cc: linux-omap@vger.kernel.org, "Gadiyar, Anand" <gadiyar@ti.com>, "Pandita, Vikram" <vikram.pandita@ti.com>

Hi,

* Olof Johansson <olof@lixom.net> [091201 12:06]:
> Having one combined defconfig that is the superset of the individual
> defconfigs for OMAP3 platforms is useful for easily finding build
> errors. Not to mention convenient as a base if you want to boot several
> platforms with a single kernel image.

Good idea, that's what many people are already doing.

<snip> 
 
> Tony, I noticed linux-next doesn't build many of the OMAP defconfigs,
> and a handful of them won't build to date. I suggest adding this config,
> and I'll as Stephen Rothwell to add it as one of the configs that are
> tested (and build errors reported) for every release.
> 
> He's reluctant to add too many individual configs since it adds time to
> each cycle, but one more can surely be acceptable.

I've built tested the for-next patches, they compile just fine
except for the omap36xx patches which depend on an update to the
mach-types.

If you find some other omap related compile errors in for-next,
can you please post the errors to this list?

Regards,

Tony
