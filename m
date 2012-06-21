From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] pinctrl: Add one-register-per-pin type device tree based
 pinctrl driver
Date: Thu, 21 Jun 2012 10:09:03 +0200
Message-ID: <CACRpkdbi1V+Y6cMSNX_Rk_ccjk35eB6c_EJbNY620QFS8F_KRQ@mail.gmail.com>
References: <20120611135826.GB12766@atomide.com>
	<4FDA6FCD.1020605@wwwdotorg.org>
	<20120615094938.GQ12766@atomide.com>
	<4FDB6000.5080703@wwwdotorg.org>
	<20120618055036.GU12766@atomide.com>
	<20120619135600.GX12766@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20120619135600.GX12766@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, Stephen Warren <swarren@nvidia.com>, Arnd Bergmann <arnd@arndb.de>
List-Id: linux-omap@vger.kernel.org

On Tue, Jun 19, 2012 at 3:56 PM, Tony Lindgren <tony@atomide.com> wrote:

> Below is the pinctrl-single patch updated with hopefully all the Stephen's
> comments addressed. The binding still needs to be looked at, see relevant
> parts of the discussion below.

I am happy with the code and the way it interacts with the pinctrl subsystem!

Now all I need to merge this is a few ACKs from select people, and
since this has a deep impact on the way device tree is used I would
*really* like for Grant or Rob to ACK it.

Yours,
Linus Walleij
