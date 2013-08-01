From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCHv4 03/33] CLK: OMAP4: Add DPLL clock support
Date: Thu, 1 Aug 2013 13:59:49 +0530
Message-ID: <51FA1C7D.5060403@ti.com>
References: <1374564028-11352-1-git-send-email-t-kristo@ti.com> <1374564028-11352-4-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:54303 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751744Ab3HAIa0 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 1 Aug 2013 04:30:26 -0400
In-Reply-To: <1374564028-11352-4-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, khilman@linaro.org, tony@atomide.com, mturquette@linaro.org, nm@ti.com, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org

Tero,

On Tuesday 23 July 2013 12:49 PM, Tero Kristo wrote:
> +	dd->control_reg = of_iomap(node, 0);
> +	dd->idlest_reg = of_iomap(node, 1);
> +	dd->autoidle_reg = of_iomap(node, 2);
> +	dd->mult_div1_reg = of_iomap(node, 3);
> +
[]...
> +	reg = of_iomap(node, 0);

Doing an of_iomap() for every single clock register seems like an overkill
and might have performance penalties at boot.

regards,
Rajendra



