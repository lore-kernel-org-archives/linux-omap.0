From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 00/19] ARM: OMAP3+: SmartReflex: bugfixes
Date: Tue, 31 Jan 2012 09:08:30 -0800
Message-ID: <20120131170830.GJ9339@atomide.com>
References: <1328003912-11709-1-git-send-email-j-pihet@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:60467 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752477Ab2AaRIe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 31 Jan 2012 12:08:34 -0500
Content-Disposition: inline
In-Reply-To: <1328003912-11709-1-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, balbi@ti.com, nm@ti.com, Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, Jean Pihet <j-pihet@ti.com>

* Jean Pihet <jean.pihet@newoldbits.com> [120131 01:28]:
> Integrate the latest SmartReflex bufixes from Felipe Balbi [1] and
> Nishant Menon [2], plus misc bugfixes.

We should move this to live under drivers somewhere. So
I'd like to see just minimal cleanup in the current location,
then move it to drivers before further patching.

Is this the minimal cleanup needed before doing that, or
what's your plan regarding moving it to drivers?

Cheers,

Tony
