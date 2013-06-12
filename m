From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH V2 14/14] ARM: OMAP4: hwmod data: Clean up the data file
Date: Wed, 12 Jun 2013 06:54:54 -0700
Message-ID: <20130612135454.GS8164@atomide.com>
References: <1370606175-22599-1-git-send-email-r.sricharan@ti.com>
 <alpine.DEB.2.02.1306071230500.5589@utopia.booyaka.com>
 <20130607162927.GA3331@atomide.com>
 <20130607175005.GB3331@atomide.com>
 <51B5ACA6.2010101@iki.fi>
 <20130610141451.GE8164@atomide.com>
 <51B6D502.5010208@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:63381 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751483Ab3FLNy7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 12 Jun 2013 09:54:59 -0400
Content-Disposition: inline
In-Reply-To: <51B6D502.5010208@iki.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@iki.fi>
Cc: Paul Walmsley <paul@pwsan.com>, Sricharan R <r.sricharan@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, santosh.shilimkar@ti.com, rnayak@ti.com, b-cousson@ti.com, t-kristo@ti.com, ambresh@ti.com

* Tomi Valkeinen <tomi.valkeinen@iki.fi> [130611 00:49]:
> On 10/06/13 17:14, Tony Lindgren wrote:
> > * Tomi Valkeinen <tomi.valkeinen@iki.fi> [130610 03:44]:
> 
> >> DSS does not have DT bindings, and removing DSS from hwmod data will
> >> break DSS for omap4.
> > 
> > Ah that's right. Care to post a patch reverting the minimal parts that
> > you need for omap4 against omap-for-v3.11/cleanup?
> 
> This one adds back the DSS data.

OK thanks, applying into omap-for-v3.11/cleanup.

Regards,

Tony
