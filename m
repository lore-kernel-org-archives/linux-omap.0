From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] ARM: OMAP2+: fix some omap_device_build() calls that
 aren't compiled by default
Date: Tue, 12 Feb 2013 17:26:40 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1302121726110.29149@utopia.booyaka.com>
References: <alpine.DEB.2.00.1302120358130.14983@utopia.booyaka.com> <20130212171156.GH4801@atomide.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:40898 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932336Ab3BLR0l (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 12 Feb 2013 12:26:41 -0500
In-Reply-To: <20130212171156.GH4801@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Tue, 12 Feb 2013, Tony Lindgren wrote:

> Thanks, I'll apply this into omap-for-v3.9/pm-wfi as the breaking
> commit is already in arm-soc/for-next.

OK thanks.  Looks like I'll have one more fix for one of the commits in 
arm-soc/for-next; working on it now.


- Paul
