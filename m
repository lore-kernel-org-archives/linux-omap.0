From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH V3 2/2]OMAP: Disable internal I2C pull-ups in OMAP3630
Date: Wed, 9 Jun 2010 15:23:37 +0300
Message-ID: <20100609122336.GD32208@atomide.com>
References: <1267211687-23551-1-git-send-email-m-sonasath@ti.com>
 <CD8CC2B65FEE304DA95744A5472698F202D3F744A2@dlee06.ent.ti.com>
 <20100608100437.GP15515@atomide.com>
 <13B9B4C6EF24D648824FF11BE896716203BB6EAF57@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:60761 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751446Ab0FIMXh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 Jun 2010 08:23:37 -0400
Content-Disposition: inline
In-Reply-To: <13B9B4C6EF24D648824FF11BE896716203BB6EAF57@dlee02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Woodruff, Richard" <r-woodruff2@ti.com>
Cc: "Sonasath, Moiz" <m-sonasath@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Pais, Allen" <allen.pais@ti.com>, "Pandita, Vikram" <vikram.pandita@ti.com>

* Woodruff, Richard <r-woodruff2@ti.com> [100609 02:24]:
> 
> > Sorry for the delay, here's some more info on this issue. So it looks
> > like starting with 3630 there are dedicated pull-up for all the I2C buses.
> > And the pull values are configurable with software.
> 
> Even 3430 claimed to have this controllable in CONGROL.CONTROL_DEVCONF1[12,13,14]

Hmm OK, that needs to be verified then.

Regards,

Tony
