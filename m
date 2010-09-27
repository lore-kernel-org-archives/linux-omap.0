From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 3/5] omap3: cm-t3517: add support for usb host.
Date: Mon, 27 Sep 2010 15:28:17 -0700
Message-ID: <20100927222817.GF16721@atomide.com>
References: <1285084993-27683-1-git-send-email-grinberg@compulab.co.il>
 <1285084993-27683-4-git-send-email-grinberg@compulab.co.il>
 <AANLkTin+canp9yrE-Jmv=n56dPFByZWU73uaRNBkruP6@mail.gmail.com>
 <4C99BD55.3070706@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:60413 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751752Ab0I0W2U (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 27 Sep 2010 18:28:20 -0400
Content-Disposition: inline
In-Reply-To: <4C99BD55.3070706@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Igor Grinberg <grinberg@compulab.co.il>
Cc: "Gadiyar, Anand" <gadiyar@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Igor Grinberg <grinberg@compulab.co.il> [100922 01:16]:
> 
> > It should be okay to execute this code independent of whether
> > the driver is built or not. The device registration can be unconditional
> > and if there is no driver present, we won't probe anyway.

The current patch looks OK to me, adding all of them into omap-for-linus.

Regards,

Tony
