From: Igor Grinberg <grinberg@compulab.co.il>
Subject: Re: [PATCH 02/12] Fix possible stale smsc911x flags.
Date: Tue, 27 Mar 2012 17:47:33 +0200
Message-ID: <4F71E115.7070300@compulab.co.il>
References: <1332494504-10251-1-git-send-email-Russ.Dill@ti.com> <1332494504-10251-3-git-send-email-Russ.Dill@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 50.23.254.54-static.reverse.softlayer.com ([50.23.254.54]:37342
	"EHLO softlayer.compulab.co.il" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750956Ab2C0Prp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 27 Mar 2012 11:47:45 -0400
In-Reply-To: <1332494504-10251-3-git-send-email-Russ.Dill@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russ Dill <Russ.Dill@ti.com>
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Matt Porter <mporter@ti.com>, robert.marklund@stericsson.com, linus.walleij@linaro.org

On 03/23/12 11:21, Russ Dill wrote:
> If this function is called the first time with flags set, and the
> second time without flags set then the leftover flags from the first
> called will be used rather than the desired default flags.
> 
> Signed-off-by: Russ Dill <russ.dill@ti.com>

Tested-by: Igor Grinberg <grinberg@compulab.co.il>


-- 
Regards,
Igor.
