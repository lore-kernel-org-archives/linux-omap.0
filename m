From: "Kanigeri, Hari" <h-kanigeri2@ti.com>
Subject: RE: [PATCH v2 08/17] omap: mailbox: only compile for configured
 archs
Date: Fri, 14 May 2010 16:27:22 -0500
Message-ID: <8F7AF80515AF0D4D93307E594F3CB40E4BBC5C8A@dlee03.ent.ti.com>
References: <1273849310-32169-1-git-send-email-felipe.contreras@gmail.com>
 <1273849310-32169-9-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:46956 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753724Ab0ENV1h convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 May 2010 17:27:37 -0400
In-Reply-To: <1273849310-32169-9-git-send-email-felipe.contreras@gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>, linux-omap <linux-omap@vger.kernel.org>
Cc: linux-arm <linux-arm-kernel@lists.infradead.org>, Hiroshi Doyu <hiroshi.doyu@nokia.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>

> 
> -	if (cpu_is_omap3430()) {
> +	if (false);

-- Is this statement needed ?

> +#if defined(CONFIG_ARCH_OMAP3430)
> +	else if (cpu_is_omap3430()) {
>  		list = omap3_mboxes;
> 
>  		list[0]->irq = res[1].start;

Thank you,
Best regards,
Hari
  	
