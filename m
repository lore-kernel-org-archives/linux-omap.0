From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 05/12] Add dummy smsc911x regulators to cm-t35.
Date: Tue, 27 Mar 2012 10:28:20 -0700
Message-ID: <20120327172819.GQ9859@atomide.com>
References: <1332494504-10251-1-git-send-email-Russ.Dill@ti.com>
 <1332494504-10251-6-git-send-email-Russ.Dill@ti.com>
 <4F71E290.2050403@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:61434 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750978Ab2C0R20 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 27 Mar 2012 13:28:26 -0400
Content-Disposition: inline
In-Reply-To: <4F71E290.2050403@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Igor Grinberg <grinberg@compulab.co.il>
Cc: Russ Dill <Russ.Dill@ti.com>, linux-omap@vger.kernel.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Matt Porter <mporter@ti.com>, robert.marklund@stericsson.com, linus.walleij@linaro.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>

* Igor Grinberg <grinberg@compulab.co.il> [120327 08:56]:
> Hi Russ,
> 
> This patch works, but can we, please use the attached patch instead?

Hmm what's the difference here? Do you have some real controllable
regulator for one of the smsc911x instances?

Anyways, I take it that you have tested that both smsc911x interfaces
work now?

Regards,

Tony
