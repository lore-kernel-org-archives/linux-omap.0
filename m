From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/5] capemgr: Beaglebone DT overlay based cape manager
Date: Mon, 7 Jan 2013 12:35:30 -0800
Message-ID: <20130107203529.GI14149@atomide.com>
References: <1357584666-17374-1-git-send-email-panto@antoniou-consulting.com>
 <1357584666-17374-2-git-send-email-panto@antoniou-consulting.com>
 <20130107200945.GF14149@atomide.com>
 <379B16EC-BFAA-4C27-8321-E7133C03368D@antoniou-consulting.com>
 <20130107202306.GH14149@atomide.com>
 <FA4D880E-833E-43D9-A399-0A5C260E83F2@antoniou-consulting.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:29442 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753321Ab3AGUfy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Jan 2013 15:35:54 -0500
Content-Disposition: inline
In-Reply-To: <FA4D880E-833E-43D9-A399-0A5C260E83F2@antoniou-consulting.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Pantelis Antoniou <panto@antoniou-consulting.com>
Cc: Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>, Rob Landley <rob@landley.net>, Jon Loeliger <jdl@jdl.com>, Stephen Warren <swarren@wwwdotorg.org>, David Gibson <david@gibson.dropbear.id.au>, Benoit Cousson <b-cousson@ti.com>, Mitch Bradley <wmb@firmworks.com>, Alan Tull <atull@altera.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Matt Porter <mporter@ti.com>, Russ Dill <Russ.Dill@ti.com>, Koen Kooi <koen@dominion.thruhere.net>, Joel A Fernandes <agnel.joel@gmail.com>, Rob Clark <robdclark@gmail.com>, Jason Kridner <jkridner@beagleboard.org>, Matt Ranostay <mranostay@gmail.com>

* Pantelis Antoniou <panto@antoniou-consulting.com> [130107 12:29]:
> On Jan 7, 2013, at 10:23 PM, Tony Lindgren wrote:
> > 
> > Well how about split it to an eeprom driver, and Linux generic
> > device loader parts?
> > 
> 
> All that's left is the eeprom driver (accessor) and calls to the 
> generic DT overlay constructs. 
>
> If you caught on the previous patchset about DT overlays it should be
> clear.
> 
> So it is split along those lines already.

Hmm I was thinking something like this:

drivers/base/device-loader.c
drivers/misc/eeprom/beaglebone-cape.c

Then you may be able to just load the configuration for it
from a .dts file and maybe no hardware specific glue is even
needed.

Regards,

Tony
