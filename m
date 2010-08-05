From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/3] OMAP3630: Add ES1.1 and ES1.2 detection
Date: Thu, 5 Aug 2010 12:36:22 +0300
Message-ID: <20100805093621.GW9881@atomide.com>
References: <20100804112916.25027.94640.stgit@baageli.muru.com>
 <20100804113307.25027.8630.stgit@baageli.muru.com>
 <4C59B92C.5060300@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:56616 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751301Ab0HEJgG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 5 Aug 2010 05:36:06 -0400
Content-Disposition: inline
In-Reply-To: <4C59B92C.5060300@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "G, Manjunath Kondaiah" <manjugk@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Gadiyar, Anand" <gadiyar@ti.com>

* Nishanth Menon <nm@ti.com> [100804 21:55]:
> Tony Lindgren had written, on 08/04/2010 06:33 AM, the following:
> >From: Anand Gadiyar <gadiyar@ti.com>
> >+		default:
> >+			omap_revision =  OMAP3630_REV_ES1_2;
> >+			omap_chip.oc |= CHIP_IS_OMAP3630ES1_2;
> >+			break;
> >+		}
> 
> we need to add a break here. to jump out of the main switch statement.
> currently with ES1.0 3630, it reports as 3630 ES1.2

Argh.. It's merged already, care to do another patch
to fix this?
 
> Tested and verified on SDP3630 with OMAP3630 ES1.0

OK, thanks.

Tony
