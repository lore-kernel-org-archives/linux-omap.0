From: "Lopez Cruz, Misael" <x0052729@ti.com>
Subject: RE: [PATCH] ARM: OMAP3: Enable writing to XCCR and RCCR McBSP
 registers for OMAP 2430/34xx
Date: Thu, 18 Dec 2008 20:58:45 -0600
Message-ID: <2C7D3DF36ADFFC479B44490D912B616705A484AADA@dlee07.ent.ti.com>
References: <2C7D3DF36ADFFC479B44490D912B616705A484AAD4@dlee07.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:50609 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752090AbYLSC6y convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Dec 2008 21:58:54 -0500
In-Reply-To: <2C7D3DF36ADFFC479B44490D912B616705A484AAD4@dlee07.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Pandita, Vikram" <vikram.pandita@ti.com>, Jarkko Nikula <jarkko.nikula@nokia.com>

> This patch enables writing to McBSP Transmit Configuration 
> Control Register (XCCR) and Receive Configuration Control 
> Register (RCCR) for 2430/34xx platforms. It also adds XCCR, 
> RCCR entries in McBSP register configuration structure and 
> bit definitions for both registers.

McBSP changes are now in a separate patch as suggested by Tony and Jarkko.

> +	if (cpu_is_omap2430() || cpu_is_omap34xx()) {
> +		OMAP_MCBSP_WRITE(io_base, XCCR, config->xccr);
> +		OMAP_MCBSP_WRITE(io_base, RCCR, config->rccr);
> +	}

Changed to check for 2430 and 34xx platforms as pointed by Jarkko.

-Misa