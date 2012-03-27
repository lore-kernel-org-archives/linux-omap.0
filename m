From: Igor Grinberg <grinberg@compulab.co.il>
Subject: Re: [PATCH 01/12] Remove odd gpmc_cfg/board_data redirection.
Date: Tue, 27 Mar 2012 17:45:24 +0200
Message-ID: <4F71E094.80008@compulab.co.il>
References: <1332494504-10251-1-git-send-email-Russ.Dill@ti.com> <1332494504-10251-2-git-send-email-Russ.Dill@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 50.23.254.54-static.reverse.softlayer.com ([50.23.254.54]:37311
	"EHLO softlayer.compulab.co.il" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755062Ab2C0Ppi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 27 Mar 2012 11:45:38 -0400
In-Reply-To: <1332494504-10251-2-git-send-email-Russ.Dill@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russ Dill <Russ.Dill@ti.com>
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Matt Porter <mporter@ti.com>, robert.marklund@stericsson.com, linus.walleij@linaro.org

Hi Russ,

Thanks for the patches.

Please, note:
* all OMAP patches that are "ready" for submission should have
  linux-arm-kernel@lists.infradead.org in Cc.
* Subject should be prefixed with: ARM: OMAP: ...

On 03/23/12 11:21, Russ Dill wrote:
> This seems to be a leftover from when gpmc-smsc911x.c was copied
> from gpmc-smc91x.c.
> 
> Signed-off-by: Russ Dill <russ.dill@ti.com>

Tested-by: Igor Grinberg <grinberg@compulab.co.il>


-- 
Regards,
Igor.
