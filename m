From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/2] arm/dts: Cleanup regulator naming and remove @0,1..
Date: Fri, 24 Aug 2012 13:27:25 -0700
Message-ID: <20120824202725.GA1303@atomide.com>
References: <1343653940-16614-1-git-send-email-rnayak@ti.com>
 <1343653940-16614-3-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:16984 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933261Ab2HXU12 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 24 Aug 2012 16:27:28 -0400
Content-Disposition: inline
In-Reply-To: <1343653940-16614-3-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, rob.herring@calxeda.com, b-cousson@ti.com

* Rajendra Nayak <rnayak@ti.com> [120730 06:17]:
> regulators do not have a 'reg' property, hence the regulator@0,
> regulator@1 do not make sense. get rid of it.

Looks like this needs to be refreshed to apply. Care to
refresh against current devel-dt branch in case other
places need the same change?

Regards,

Tony
