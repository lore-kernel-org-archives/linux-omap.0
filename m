From: Igor Grinberg <grinberg@compulab.co.il>
Subject: Re: [PATCH 04/12] Remove regulator support from gmpc-smsc911x
Date: Tue, 27 Mar 2012 17:46:32 +0200
Message-ID: <4F71E0D8.20109@compulab.co.il>
References: <1332494504-10251-1-git-send-email-Russ.Dill@ti.com> <1332494504-10251-5-git-send-email-Russ.Dill@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 50.23.254.54-static.reverse.softlayer.com ([50.23.254.54]:37330
	"EHLO softlayer.compulab.co.il" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755131Ab2C0Pqo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 27 Mar 2012 11:46:44 -0400
In-Reply-To: <1332494504-10251-5-git-send-email-Russ.Dill@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russ Dill <Russ.Dill@ti.com>
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Matt Porter <mporter@ti.com>, robert.marklund@stericsson.com, linus.walleij@linaro.org

On 03/23/12 11:21, Russ Dill wrote:
> Adding in support for regulators here creates several headaches.
>  - Boards that declare their own regulator cannot use this function.
>  - Multiple calls to this function require special handling.
>  - Boards that declare id's other than '0' need special handling.
> 
> Now that there is a simple regulator_register_fixed, we can push
> this registration back into the board files.
> 
> Signed-off-by: Russ Dill <russ.dill@ti.com>

Tested-by: Igor Grinberg <grinberg@compulab.co.il>


-- 
Regards,
Igor.
