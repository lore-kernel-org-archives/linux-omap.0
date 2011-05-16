From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH v2] ARM: omap4: i2c reset regs postidle
Date: Mon, 16 May 2011 19:16:05 +0200
Message-ID: <4DD15BD5.9010303@ti.com>
References: <4DD0DC9C.5020300@linaro.org> <1305537524-24753-1-git-send-email-j.weitzel@phytec.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:57554 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752391Ab1EPRQX (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 16 May 2011 13:16:23 -0400
In-Reply-To: <1305537524-24753-1-git-send-email-j.weitzel@phytec.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jan Weitzel <j.weitzel@phytec.de>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "andy.green@linaro.org" <andy.green@linaro.org>, "patches@linaro.org" <patches@linaro.org>, "andy@warmcat.com" <andy@warmcat.com>, "tony@atomide.com" <tony@atomide.com>, "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "ben-linux@fluff.org" <ben-linux@fluff.org>

Hi Jan,

On 5/16/2011 11:18 AM, Jan Weitzel wrote:
> Without OMAP_I2C_FLAG_RESET_REGS_POSTIDLE I got i2c controller
> timeouts on each accsess after an NACK message.
> Taking this flag fix it.
>
> This patch is on top of the i2c feature implementation flags
> patches

Could you please give us more information and potentially provide a link 
to the patches you are referring to?
It will help us assessing the need for such flag in the hwmod data.

Please note that the changelog will stay forever in the GIT tree, so you 
should avoid using "the patch" or making reference to something that is 
not an existing commit id or email archive.
You should fix as well the typo.

Thanks,
Benoit

