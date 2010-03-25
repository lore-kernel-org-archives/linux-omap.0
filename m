From: "Kanigeri, Hari" <h-kanigeri2@ti.com>
Subject: RE: PATCH] OMAP3: add mailbox initialization for 3630
Date: Thu, 25 Mar 2010 17:55:37 -0500
Message-ID: <8F7AF80515AF0D4D93307E594F3CB40E4AB211C7@dlee03.ent.ti.com>
References: <496565EC904933469F292DDA3F1663E602CADC33F9@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:33350 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750933Ab0CYWzn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Mar 2010 18:55:43 -0400
In-Reply-To: <496565EC904933469F292DDA3F1663E602CADC33F9@dlee06.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Guzman Lugo, Fernando" <x0095840@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Doyu Hiroshi (Nokia-D/Helsinki)" <hiroshi.doyu@nokia.com>, "Palande Ameya (Nokia-D/Helsinki)" <ameya.palande@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>

Fernando,

> +	if (cpu_is_omap2420() || cpu_is_omap3430() ||
> +				cpu_is_omap3630() || cpu_is_omap44xx()) 

looks like this check is applied to all OMAPS. Can we just remove this check ?

Thank you,
Best regards,
Hari
