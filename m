From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 4/6] omap2+: Add struct omap_device_board_data and
 allow omap_device_build initialize pads to mux
Date: Wed, 22 Dec 2010 18:49:33 -0800
Message-ID: <20101223024933.GI7771@atomide.com>
References: <20101203004040.31687.9476.stgit@baageli.muru.com>
 <20101203004526.31687.72682.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:13607 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751880Ab0LWCti (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 22 Dec 2010 21:49:38 -0500
Content-Disposition: inline
In-Reply-To: <20101203004526.31687.72682.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [101202 16:35]:
> This way board specific pads can be initialized automatically.
> Note that this does not currently handle the multiple hwmod case.

This one can now be dropped. As Paul pointed out the relationship
to omap_device needs more thinking. So let's populated the hwmod
mux info from each platform device init code for now.

Regards,

Tony
