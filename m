From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 3/3] ARM: omap2plus_defconfig: Enable n900 modem as
 loadable modules
Date: Tue, 17 Mar 2015 10:32:44 -0700
Message-ID: <20150317173243.GF31346@atomide.com>
References: <1426536003-7077-1-git-send-email-tony@atomide.com>
 <1426536003-7077-4-git-send-email-tony@atomide.com>
 <20150317110000.GA1115@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:38132 "EHLO muru.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753892AbbCQRha (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 17 Mar 2015 13:37:30 -0400
Content-Disposition: inline
In-Reply-To: <20150317110000.GA1115@earth>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Sebastian Reichel <sre@kernel.org> [150317 04:00]:
> Hi Tony,
> 
> On Mon, Mar 16, 2015 at 01:00:03PM -0700, Tony Lindgren wrote:
> > Enable n900 modem as loadable modules.
> 
> Acked-By: Sebastian Reichel <sre@kernel.org>
> 
> > [...]
> > +CONFIG_HSI_CHAR=m
> > [...]
> 
> I think this one should be disabled by default. It's only needed by
> very few people (it exposes the hsi bus to userspace, like i2c-dev
> driver does for i2c).

OK will disable thanks.

Tony
