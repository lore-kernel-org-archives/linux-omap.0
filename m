From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP3: igep0020: Set WIFI/BT GPIO pins in correct
 mux mode
Date: Wed, 7 Nov 2012 14:00:37 -0800
Message-ID: <20121107220036.GO6801@atomide.com>
References: <1351533073-5974-1-git-send-email-anders.j.hedlund@gmail.com>
 <CAFqH_53q8yTy=yBxDE=SFQ=j-ogy4yNF5KpNBsLd1OQ9dbA37g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:12073 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752377Ab2KGWAk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Nov 2012 17:00:40 -0500
Content-Disposition: inline
In-Reply-To: <CAFqH_53q8yTy=yBxDE=SFQ=j-ogy4yNF5KpNBsLd1OQ9dbA37g@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Enric Balletbo Serra <eballetbo@gmail.com>
Cc: Anders Hedlund <anders.j.hedlund@gmail.com>, linux-omap@vger.kernel.org, Jonas Zetterberg <jozz@jozz.se>, Javier Martinez Canillas <martinez.javier@gmail.com>, Matthias Brugger <mbrugger@iseebcn.com>

* Enric Balletbo Serra <eballetbo@gmail.com> [121029 11:33]:
> 
> Tony, after corrections, as this is a fix could be included ?  Or we
> need to wait to the next merge window.
> 
> The problem is, with recent u-boot these pins are not muxed because
> u-boot sets only the minimum required for uboot functionality and
> kernel boot. In kernel these pins must be muxed in order to get the
> wifi and bluetooth work.

OK I'll add it to omap-for-v3.7-rc4/fixes-part2 with updated description
for the regression. Will also move the maintainers entry there from
the board branch.

Regards,

Tony
