From: Florian Vaussard <florian.vaussard@epfl.ch>
Subject: Re: [PATCH 0/2] ARM: omap/dts: Add support for Gumstix Overo with
 Tobi expansion
Date: Mon, 10 Sep 2012 14:53:40 +0200
Message-ID: <504DE2D4.8030705@epfl.ch>
References: <1346429172-5902-1-git-send-email-florian.vaussard@epfl.ch> <20120906205227.GM1303@atomide.com> <504DB202.5050500@epfl.ch> <504DD128.1000803@ti.com>
Reply-To: florian.vaussard@epfl.ch
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp0.epfl.ch ([128.178.224.219]:37980 "HELO smtp0.epfl.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757856Ab2IJMxo (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 10 Sep 2012 08:53:44 -0400
In-Reply-To: <504DD128.1000803@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>, Steve Sakoman <steve@sakoman.com>, Philippe Retornaz <philippe.retornaz@epfl.ch>, linux-arm-kernel@lists.infradead.org

>
> Patches looks good to me. I just adding them right now in my for_3.7/dts tree.
>
> I've just slightly changed the subjects:
>
> Documentation: dt: Update the OMAP documentation with Overo/Toby
> ARM: dts: OMAP3: Add support for Gumstix Overo with Tobi expansion board
>
> If you want to give it a try, here is the branch that contains all the DTS series I
> already pulled. It includes your gpio-twl4030 patches as well.
>
> git://git.kernel.org/pub/scm/linux/kernel/git/bcousson/linux-omap-dt.git for_3.7/dts

Boot as expected on Gumstix Overo with Tobi expansion board.

I will submit a patch to support the blue LED connected to the TWL4030, 
as the DTS support was merged in your branch.

And of course I will continue on getting features to work with 
devicetree for the Overo.

Regards,
Florian
